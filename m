From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 8 Mar 2012 20:14:55 +0800
Subject: [PATCH 1/3] drivers: base: add support for stmp-style devices
In-Reply-To: <1331159314-12022-2-git-send-email-w.sang@pengutronix.de>
References: <1331159314-12022-1-git-send-email-w.sang@pengutronix.de>
 <1331159314-12022-2-git-send-email-w.sang@pengutronix.de>
Message-ID: <20120308121452.GA2499@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 07, 2012 at 11:28:32PM +0100, Wolfram Sang wrote:
> MX23/28 use IP cores which follow a register layout I have first seen on
> STMP3xxx SoCs. In this layout, every register actually has four u32:
> 
>  1.) to store a value directly
>  2.) a SET register where every 1-bit sets the corresponding bit,
>      others are unaffected
>  3.) same with a CLR register
>  4.) same with a TOG (toggle) register
> 
> Also, the 2 MSBs in register 0 are always the same and can be used to reset
> the IP core.
> 
> All this is strictly speaking not mach-specific (but IP core specific) and,
> thus, doesn't need to be in mach-mxs/include. At least mx6 also uses IP cores
> following this stmp-style. So:
> 
> Introduce a stmp-style device, put the code and defines for that in a public
> place (drivers/base/), and let drivers for stmp-style devices select that code.
> To avoid regressions and ease reviewing, the actual code is simply copied from
> mach-mxs. It definately wants updates, but those need a seperate patch series.
> 
> Voila, mach dependency gone, reusable code introduced. Note that I didn't
> remove the duplicated code from mach-mxs yet, first the drivers have to be
> converted.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
