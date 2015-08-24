From: Haibo.Chen@freescale.com (Chen Bough)
Date: Mon, 24 Aug 2015 08:34:07 +0000
Subject: [PATCH v2 2/5] Documentation: Detail permitted DT properties for
 the imx6ul_tsc
In-Reply-To: <20150821092725.GB706@pengutronix.de>
References: <1438077521-12857-1-git-send-email-haibo.chen@freescale.com>
 <1438077521-12857-3-git-send-email-haibo.chen@freescale.com>
 <20150819055434.GF11161@pengutronix.de>
 <BY1PR03MB1388BBEF576297D76E7E3F839A650@BY1PR03MB1388.namprd03.prod.outlook.com>
 <20150821092725.GB706@pengutronix.de>
Message-ID: <BY1PR03MB13889F047C4E1440D2F7554C9A620@BY1PR03MB1388.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Markus Pargmann [mailto:mpa at pengutronix.de]
> Sent: Friday, August 21, 2015 5:27 PM
> To: Chen Haibo-B51421
> Cc: robh+dt at kernel.org; pawel.moll at arm.com; mark.rutland at arm.com;
> ijc+devicetree at hellion.org.uk; galak at codeaurora.org; shawnguo at kernel.org;
> kernel at pengutronix.de; linux at arm.linux.org.uk; dmitry.torokhov at gmail.com;
> devicetree at vger.kernel.org; sbranden at broadcom.com; arnd at arndb.de;
> mchehab at osg.samsung.com; christian.gmeiner at gmail.com;
> scott.liu at emc.com.tw; linux-kernel at vger.kernel.org; hdegoede at redhat.com;
> jonathar at broadcom.com; benjamin.tissoires at redhat.com;
> hans.verkuil at cisco.com; hadess at hadess.net; linux-input at vger.kernel.org;
> geert at linux-m68k.org; sebastien.szymanski at armadeus.com;
> mamlinav at gmail.com; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v2 2/5] Documentation: Detail permitted DT properties
> for the imx6ul_tsc
> 
> On Fri, Aug 21, 2015 at 08:30:16AM +0000, Chen Bough wrote:
> > Hi Markus,
> >
> > > -----Original Message-----
> > > From: Markus Pargmann [mailto:mpa at pengutronix.de]
> > > Sent: Wednesday, August 19, 2015 1:55 PM
> > > To: Chen Haibo-B51421
> > > Cc: robh+dt at kernel.org; pawel.moll at arm.com; mark.rutland at arm.com;
> > > ijc+devicetree at hellion.org.uk; galak at codeaurora.org;
> > > ijc+shawnguo at kernel.org;
> > > kernel at pengutronix.de; linux at arm.linux.org.uk;
> > > dmitry.torokhov at gmail.com; devicetree at vger.kernel.org;
> > > sbranden at broadcom.com; arnd at arndb.de; mchehab at osg.samsung.com;
> > > christian.gmeiner at gmail.com; scott.liu at emc.com.tw;
> > > linux-kernel at vger.kernel.org; hdegoede at redhat.com;
> > > jonathar at broadcom.com; benjamin.tissoires at redhat.com;
> > > hans.verkuil at cisco.com; hadess at hadess.net;
> > > linux-input at vger.kernel.org; geert at linux-m68k.org;
> > > sebastien.szymanski at armadeus.com; mamlinav at gmail.com;
> > > linux-arm-kernel at lists.infradead.org
> > > Subject: Re: [PATCH v2 2/5] Documentation: Detail permitted DT
> > > properties for the imx6ul_tsc
> > >
> > > Hi,
> > >
> > > On Tue, Jul 28, 2015 at 05:58:38PM +0800, Haibo Chen wrote:
> > > > Here we apply required documentation for the imx6ul touch screen
> > > > controller driver which describe available properties and how to
> > > > use them.
> > > >
> > > > Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
> > > > ---
> > > >  .../bindings/input/touchscreen/imx6ul_tsc.txt      | 36
> > > ++++++++++++++++++++++
> > > >  1 file changed, 36 insertions(+)
> > > >  create mode 100644
> > > > Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
> > > >
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.t
> > > > xt
> > > > b/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.t
> > > > xt
> > > > new file mode 100644
> > > > index 0000000..ac41c32
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/input/touchscreen/imx6ul_t
> > > > +++ sc.t
> > > > +++ xt
> > > > @@ -0,0 +1,36 @@
> > > > +* Freescale i.MX6UL Touch Controller
> > > > +
> > > > +Required properties:
> > > > +- compatible: must be "fsl,imx6ul-tsc".
> > > > +- reg: this touch controller address and the ADC2 address.
> > >
> > > This suggests that this driver is using a unit ADC2. Which also
> > > means that there are more than one ADC which are probably identical?
> > >
> > > Shouldn't these ADCs be properly described by their own device nodes
> > > instead of these two register ranges, two interrupts and two clocks?
> > >
> > > Is 'ADC2' usable without tsc? Then ADC1/ADC2 should perhaps get a
> > > proper IIO driver.
> >
> > For i.MX6UL, there are two ADC. ADC1 is a normal ADC, and ADC2 can
> > only works for TSC, the channels of ADC2 are connected to TSC
> > directly. TSC and ADC2 should work together as a touch screen
> controller.
> 
> But as I understand these are two different units. Wouldn't it be better
> to abstract it that way in the DT?

Since the ADC2 just work for TSC, no other use, why not bind ADC2 and TSC?
If separate, seems ADC2 can works as a normal ADC, but actually it can't.

Best regards,

Haibo

> 
> Best regards,
> 
> Markus
> 
> >
> > For ADC1, it share the driver vf610_adc.c (drivers/iio/adc/vf610_adc.c).
> >
> > Best Regards
> >
> > Haibo
> >
> > >
> > > Unfortunately I don't have the reference manual to have a look how
> > > this all works.
> > >
> > > Best regards,
> > >
> > > Markus
> > >
> > > > +- interrupts: the interrupt of this touch controller and ADC2.
> > > > +- clocks: the root clock of touch controller and ADC2.
> > > > +- clock-names; must be "tsc" and "adc".
> > > > +- xnur-gpio: the X- gpio this controller connect to.
> > > > +  This xnur-gpio returns to high once the finger leave the touch
> > > > +screen (The
> > > > +  last touch event the touch controller capture).
> > > > +
> > > > +Optional properties:
> > > > +- measure-delay-time: the value of measure delay time.
> > > > +  Before X-axis or Y-axis measurement, the screen need some time
> > > > +before
> > > > +  even potential distribution ready.
> > > > +  This value depends on the touch screen.
> > > > +- pre-charge-time: the touch screen need some time to precharge.
> > > > +  This value depends on the touch screen.
> > > > +
> > > > +Example:
> > > > +	tsc: tsc at 02040000 {
> > > > +		compatible = "fsl,imx6ul-tsc";
> > > > +		reg = <0x02040000 0x4000>, <0x0219c000 0x4000>;
> > > > +		interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> > > > +			     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
> > > > +		clocks = <&clks IMX6UL_CLK_IPG>,
> > > > +			 <&clks IMX6UL_CLK_ADC2>;
> > > > +		clock-names = "tsc", "adc";
> > > > +		pinctrl-names = "default";
> > > > +		pinctrl-0 = <&pinctrl_tsc>;
> > > > +		xnur-gpio = <&gpio1 3 GPIO_ACTIVE_HIGH>;
> > > > +		measure-delay-time = <0xfff>;
> > > > +		pre-charge-time = <0xffff>;
> > > > +		status = "okay";
> > > > +	};
> > > > --
> > > > 1.9.1
> > > >
> > > >
> > > >
> > >
> > > --
> > > Pengutronix e.K.                           |
> > > |
> > > Industrial Linux Solutions                 |
> http://www.pengutronix.de/
> > > |
> > > Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone:
> > > +49-5121-206917-0
> > > |
> > > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-
> 5555
> > > |
> 
> --
> Pengutronix e.K.                           |
> |
> Industrial Linux Solutions                 | http://www.pengutronix.de/
> |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0
> |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555
> |
