From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 25 May 2013 19:17:49 +0800
Subject: clock framework: Don't disable a clock already enabled by boot
 loader?
In-Reply-To: <51A0655C.4020309@gmail.com>
References: <519F60CA.6090302@de.bosch.com>
 <20130524230021.GF31135@pengutronix.de>
 <51A05351.7000501@gmail.com>
 <20130525065434.GA7782@S2101-09.ap.freescale.net>
 <51A0655C.4020309@gmail.com>
Message-ID: <20130525111747.GC7782@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 25, 2013 at 09:16:44AM +0200, Dirk Behme wrote:
> Yes, I know ;) But this is slightly different: In the end it
> disables the complete clk_disable_unused() call, i.e. for all unused
> clocks.
> 
> I'd like to set the flag CLK_IGNORE_UNUSED for just one clock. I.e.
> I want to set a flag for an i.MX6 clock, and I want to set it only
> for one clock.
> 
> What's the preferred way to do this?

I do not like the idea to set CLK_IGNORE_UNUSED in clock driver on clk
basis.  If the clk is needed by some driver, why cannot the driver
enable it using clk API?  Or if the clk is some fundamental one that
does not clearly belong to particular IP block and no driver wants to
manage it, we may want to not implement it in clock driver at all and
just leave it to bootloader to set it up for once.

Shawn
