From: Haibo.Chen@freescale.com (Chen Bough)
Date: Tue, 28 Jul 2015 08:50:39 +0000
Subject: [PATCH 5/5] ARM: dts: imx6ul-14x14-evk.dts: add tsc support
In-Reply-To: <20150727141259.GO12927@tiger>
References: <1437996407-27266-1-git-send-email-haibo.chen@freescale.com>
 <1437996407-27266-6-git-send-email-haibo.chen@freescale.com>
 <20150727141259.GO12927@tiger>
Message-ID: <BY1PR03MB1388B543998289A17C7B31A99A8D0@BY1PR03MB1388.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: Monday, July 27, 2015 10:13 PM
> To: Chen Haibo-B51421
> Cc: robh+dt at kernel.org; pawel.moll at arm.com; mark.rutland at arm.com;
> ijc+devicetree at hellion.org.uk; galak at codeaurora.org;
> kernel at pengutronix.de; linux at arm.linux.org.uk; dmitry.torokhov at gmail.com;
> devicetree at vger.kernel.org; sbranden at broadcom.com; arnd at arndb.de;
> mchehab at osg.samsung.com; christian.gmeiner at gmail.com;
> scott.liu at emc.com.tw; linux-kernel at vger.kernel.org; hdegoede at redhat.com;
> jonathar at broadcom.com; benjamin.tissoires at redhat.com;
> hans.verkuil at cisco.com; hadess at hadess.net; linux-input at vger.kernel.org;
> geert at linux-m68k.org; sebastien.szymanski at armadeus.com;
> mamlinav at gmail.com; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 5/5] ARM: dts: imx6ul-14x14-evk.dts: add tsc support
> 
> On Mon, Jul 27, 2015 at 07:26:47PM +0800, Haibo Chen wrote:
> > Add touch screen surpport for i.MX6UL-EVK board.
> >
> > Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
> > ---
> >  arch/arm/boot/dts/imx6ul-14x14-evk.dts | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dts
> b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
> > index 61b41ee..323d32d 100644
> > --- a/arch/arm/boot/dts/imx6ul-14x14-evk.dts
> > +++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
> > @@ -44,6 +44,15 @@
> >  	soc-supply = <&reg_soc>;
> >  };
> >
> > +&tsc {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_tsc>;
> > +	status = "okay";
> 
> We generally have "status" at the bottom of the property list.
> 
> Shawn
>
 
[haibo] Yes, it's my negligence, I will amend this.

> > +	xnur-gpio = <&gpio1 3 0>;
> > +	measure_delay_time = <0xffff>;
> > +	pre_charge_time = <0xfff>;
> > +};
> > +
> >  &uart1 {
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&pinctrl_uart1>;
> > @@ -212,6 +221,15 @@
> >  		>;
> >  	};
> >
> > +	pinctrl_tsc: tscgrp {
> > +		fsl,pins = <
> > +			MX6UL_PAD_GPIO1_IO01__GPIO1_IO01		0xb0
> > +			MX6UL_PAD_GPIO1_IO02__GPIO1_IO02		0xb0
> > +			MX6UL_PAD_GPIO1_IO03__GPIO1_IO03		0xb0
> > +			MX6UL_PAD_GPIO1_IO04__GPIO1_IO04		0xb0
> > +		>;
> > +	};
> > +
> >  	pinctrl_uart1: uart1grp {
> >  		fsl,pins = <
> >  			MX6UL_PAD_UART1_TX_DATA__UART1_DCE_TX 0x1b0b1
> > --
> > 1.9.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
