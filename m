From: Robby.Cai@freescale.com (Robby.Cai at freescale.com)
Date: Mon, 26 Jan 2015 14:44:57 +0000
Subject: [PATCH] ARM: dts: imx6qdl: Adjust the brightness setting for LVDS
 panel
In-Reply-To: <1421941084.3084.45.camel@pengutronix.de>
References: <1421749355-23050-1-git-send-email-r63905@freescale.com>
 <20150120113837.GC2766@dragon> <1421941084.3084.45.camel@pengutronix.de>
Message-ID: <BLUPR03MB4059C6493E55DB26E8308E9F8350@BLUPR03MB405.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Philipp Zabel [mailto:p.zabel at pengutronix.de]
> Sent: Thursday, January 22, 2015 11:38 PM
> To: Shawn Guo
> Cc: Cai Robby-R63905; linux-pwm at vger.kernel.org; Eric Nelson; Tim Harvey;
> jg1.han at samsung.com; Troy Kisky; thierry.reding at gmail.com;
> kernel at pengutronix.de; lee.jones at linaro.org; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH] ARM: dts: imx6qdl: Adjust the brightness setting for
> LVDS panel
> 
> Am Dienstag, den 20.01.2015, 19:38 +0800 schrieb Shawn Guo:
> > Add LAKML and a few interested people.
> >
> > Shawn
> >
> > On Tue, Jan 20, 2015 at 06:22:35PM +0800, Robby Cai wrote:
> > > Hannstar XGA panel is used by default on i.MX6QDL Sabre Auto/Lite/SD
> > > or derived board.
> > >
> > > According to its data sheet [1],
> > > a) the dimming duty cycle is 20% - 100%.
> > > This patch changes the brightness-level from 20 to 100 with step 10
> > > to make it straight-forward.
> > > b) the typical dimming frequency is 20KHz.
> > > The previous setting is 200Hz. This patch corrects it.
> > >
> > > [1]
> > > http://boundarydevices.com/wp-content/uploads/2013/06/HSD100PXN1-A00
> > > -C11-1.0.pdf
> > >
> > > Signed-off-by: Robby Cai <r63905@freescale.com>
> > > ---
> > >  arch/arm/boot/dts/imx6qdl-gw52xx.dtsi     | 6 +++---
> > >  arch/arm/boot/dts/imx6qdl-gw53xx.dtsi     | 6 +++---
> > >  arch/arm/boot/dts/imx6qdl-gw54xx.dtsi     | 6 +++---
> > >  arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi | 6 +++---
> > > arch/arm/boot/dts/imx6qdl-sabreauto.dtsi  | 6 +++---
> > > arch/arm/boot/dts/imx6qdl-sabrelite.dtsi  | 6 +++---
> > >  arch/arm/boot/dts/imx6qdl-sabresd.dtsi    | 6 +++---
> > >  7 files changed, 21 insertions(+), 21 deletions(-)
> > >
> > > diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
> > > b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
> > > index b5756c2..33484d8 100644
> > > --- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
> > > +++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
> > > @@ -29,9 +29,9 @@
> > >
> > >  	backlight {
> > >  		compatible = "pwm-backlight";
> > > -		pwms = <&pwm4 0 5000000>;
> > > -		brightness-levels = <0 4 8 16 32 64 128 255>;
> > > -		default-brightness-level = <7>;
> > > +		pwms = <&pwm4 0 50000>;
> > > +		brightness-levels = <0 20 30 40 50 60 70 80 90 100>;
> > > +		default-brightness-level = <9>;
> 
> I notice that the intervals are changed from exponential to linear.
> Is this really wanted here?
> I expect that the new settings result in huge steps in perceived
> brightness at low levels and a nearly imperceptible change at the last
> step.
> 
> regards
> Philipp


No particular reason here. I understand your concern but seems there's no obvious rule.
How about add some interpolation, such as <0 52 64 96 128 160 192 224 255>
or even more, <0 52 64 80 96 112 128 144 160 176 192 208 224 240 255>

Regards,
Robby
