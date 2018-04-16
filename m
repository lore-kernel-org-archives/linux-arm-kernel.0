From: anson.huang@nxp.com (Anson Huang)
Date: Mon, 16 Apr 2018 08:25:48 +0000
Subject: [PATCH] ARM: dts: imx7d-sdb: add gpio key support
In-Reply-To: <AM3PR04MB306ED8D196C18858B5B368480D70@AM3PR04MB306.eurprd04.prod.outlook.com>
References: <1521190471-25242-1-git-send-email-Anson.Huang@nxp.com>
 <AM3PR04MB306ED8D196C18858B5B368480D70@AM3PR04MB306.eurprd04.prod.outlook.com>
Message-ID: <AM3PR04MB1315677CAB91C4236AFAB03EF5B00@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping...

Anson Huang
Best Regards!


> -----Original Message-----
> From: A.s. Dong
> Sent: Friday, March 16, 2018 6:28 PM
> To: Anson Huang <anson.huang@nxp.com>; shawnguo at kernel.org;
> kernel at pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>;
> robh+dt at kernel.org; mark.rutland at arm.com; linux at armlinux.org.uk
> Cc: dl-linux-imx <linux-imx@nxp.com>; linux-arm-kernel at lists.infradead.org;
> devicetree at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: RE: [PATCH] ARM: dts: imx7d-sdb: add gpio key support
> 
> > -----Original Message-----
> > From: Anson Huang [mailto:Anson.Huang at nxp.com]
> > Sent: Friday, March 16, 2018 4:55 PM
> > To: shawnguo at kernel.org; kernel at pengutronix.de; Fabio Estevam
> > <fabio.estevam@nxp.com>; robh+dt at kernel.org; mark.rutland at arm.com;
> > linux at armlinux.org.uk
> > Cc: dl-linux-imx <linux-imx@nxp.com>;
> > linux-arm-kernel at lists.infradead.org;
> > devicetree at vger.kernel.org; linux-kernel at vger.kernel.org
> > Subject: [PATCH] ARM: dts: imx7d-sdb: add gpio key support
> >
> > Add support for imx7d-sdb board's gpio keys:
> >
> > S1(FUNC1): KEY_VOLUMEUP
> > S3(FUNC2): KEY_VOLUMEDOWN
> >
> 
> Acked-by: Dong Aisheng <aisheng.dong@nxp.com>
> 
> Regards
> Dong Aisheng
> 
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> >  arch/arm/boot/dts/imx7d-sdb.dts | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/imx7d-sdb.dts
> > b/arch/arm/boot/dts/imx7d- sdb.dts index 7f241af..e47b5b2 100644
> > --- a/arch/arm/boot/dts/imx7d-sdb.dts
> > +++ b/arch/arm/boot/dts/imx7d-sdb.dts
> > @@ -52,6 +52,24 @@
> >  		reg = <0x80000000 0x80000000>;
> >  	};
> >
> > +	gpio-keys {
> > +		compatible = "gpio-keys";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_gpio_keys>;
> > +
> > +		volume-up {
> > +			label = "Volume Up";
> > +			gpios = <&gpio5 11 GPIO_ACTIVE_LOW>;
> > +			linux,code = <KEY_VOLUMEUP>;
> > +		};
> > +
> > +		volume-down {
> > +			label = "Volume Down";
> > +			gpios = <&gpio5 10 GPIO_ACTIVE_LOW>;
> > +			linux,code = <KEY_VOLUMEDOWN>;
> > +		};
> > +	};
> > +
> >  	spi4 {
> >  		compatible = "spi-gpio";
> >  		pinctrl-names = "default";
> > @@ -519,6 +537,12 @@
> >  			>;
> >  		};
> >
> > +		pinctrl_gpio_keys: gpio_keysgrp {
> > +			fsl,pins = <
> > +				MX7D_PAD_SD2_RESET_B__GPIO5_IO11
> > 	0x59
> > +				MX7D_PAD_SD2_WP__GPIO5_IO10
> > 	0x59
> > +			>;
> > +		};
> >
> >  		pinctrl_hog: hoggrp {
> >  			fsl,pins = <
> > --
> > 2.7.4
