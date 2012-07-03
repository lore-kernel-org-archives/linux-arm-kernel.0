From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 3 Jul 2012 12:17:44 +0200
Subject: [PATCH 1/2] ARM: imx6q-sabrelite.dts: Add watchdog support
In-Reply-To: <20120703030337.GD22106@S2101-09.ap.freescale.net>
References: <1341258627-3469-1-git-send-email-festevam@gmail.com>
 <20120703030337.GD22106@S2101-09.ap.freescale.net>
Message-ID: <20120703101744.GW2698@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 03, 2012 at 11:03:39AM +0800, Shawn Guo wrote:
> On Mon, Jul 02, 2012 at 04:50:26PM -0300, Fabio Estevam wrote:
> > From: Fabio Estevam <fabio.estevam@freescale.com>
> > 
> > Add watchdog support.
> > 
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> > ---
> >  arch/arm/boot/dts/imx6q-sabrelite.dts |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
> > index e0ec929..99581a0 100644
> > --- a/arch/arm/boot/dts/imx6q-sabrelite.dts
> > +++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
> > @@ -42,6 +42,9 @@
> >  				};
> >  			};
> >  
> > +			wdog at 020bc000 { /* WDOG1 */
> > +				status = "okay";
> > +			};
> 
> I'm wondering if it makes more sense to have wdog, rtc, such completely
> soc internal stuff always enabled in <soc>.dtsi.

+1 for the watchdog

I'm not so sure about the rtc though, since one important component of
the RTC is not completely internal to the SoC: the battery.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
