From: sha@pengutronix.de (Sascha Hauer)
Date: Mon, 2 Jul 2012 10:06:41 +0200
Subject: [PATCH 1/2] arm: imx: enable flexcan on imx25, imx35, imx53, imx6q
In-Reply-To: <4FF153A0.3030404@pengutronix.de>
References: <1341175565-13218-1-git-send-email-mkl@pengutronix.de>
 <1341175565-13218-2-git-send-email-mkl@pengutronix.de>
 <20120702075054.GF2698@pengutronix.de>
 <4FF153A0.3030404@pengutronix.de>
Message-ID: <20120702080641.GG2698@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 02, 2012 at 09:54:08AM +0200, Marc Kleine-Budde wrote:
> On 07/02/2012 09:50 AM, Sascha Hauer wrote:
> > On Sun, Jul 01, 2012 at 10:46:04PM +0200, Marc Kleine-Budde wrote:
> >> Cc: Sascha Hauer <sha@pengutronix.de>
> >> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> >> ---
> >>  arch/arm/mach-imx/Kconfig |    4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> >> index eff4db5..c296851 100644
> >> --- a/arch/arm/mach-imx/Kconfig
> >> +++ b/arch/arm/mach-imx/Kconfig
> >> @@ -52,6 +52,7 @@ config SOC_IMX25
> >>  	select ARCH_MX25
> >>  	select COMMON_CLK
> >>  	select CPU_ARM926T
> >> +	select HAVE_CAN_FLEXCAN if CAN
> > 
> > Do we need the 'if CAN' here? It seems yes, since HAVE_CAN_FLEXCAN is
> > inside the "CAN Device Drivers" menu which depends on CAN. Shouldn't the
> > HAVE_CAN_FLECAN be outside the menu?
> 
> Yes, we can move the HAVE_CAN_FLEXCAN outside of that menu, but it still
> depends on CONFIG_NET.

Ok, then we have no choice. I just asked because it seems unnatural that
the presence of a hardware device depends on config options.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
