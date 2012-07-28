From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 28 Jul 2012 16:44:54 +0800
Subject: [PATCH] ARM: mxs: enable ocotp on imx23 and imx28
In-Reply-To: <1342993697-25875-1-git-send-email-mkl@pengutronix.de>
References: <1342993697-25875-1-git-send-email-mkl@pengutronix.de>
Message-ID: <20120728084451.GC2128@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 22, 2012 at 11:48:17PM +0200, Marc Kleine-Budde wrote:
> This patch adds ocotp support to imx23 and imx28, a dt-only kernel fails
> to link with this error message otherwise:
> 
> arch/arm/mach-mxs/mach-mxs.c:169: undefined reference to `mxs_get_ocotp'
> 
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> Hello Shawn,
> 
> this applies to your "mxs/dt-for-3.6" tree. According to the datasheet
> both processors have a ocotp unit. Hope it alright to select the OCOTP
> on both imx23 and imx28.
> 
I prefer to remove MXS_OCOTP completely and always build in ocotp.c,
as we are on the way to remove those board files, the users of the
Kconfig symbol.

-- 
Regards,
Shawn
