From: Li.Xiubo@freescale.com (Li.Xiubo at freescale.com)
Date: Wed, 16 Apr 2014 06:08:45 +0000
Subject: [RFC][PATCH 1/3] ARM: dts: vf610: Add Freescale FlexTimer
 Module timer node.
In-Reply-To: <a7aeb70fae2c480198b413f581f76846@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1397614787-8300-1-git-send-email-Li.Xiubo@freescale.com>
 <1397614787-8300-2-git-send-email-Li.Xiubo@freescale.com>
 <a7aeb70fae2c480198b413f581f76846@BN1PR03MB188.namprd03.prod.outlook.com>
Message-ID: <42acfcd1b83143d38bda219a7854838d@DM2PR03MB509.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > --- a/arch/arm/boot/dts/vf610.dtsi
> > +++ b/arch/arm/boot/dts/vf610.dtsi
> > @@ -153,6 +153,19 @@
> >  				clock-names = "pit";
> >  			};
> >
> > +			ftm0: ftm at 40038000 {
> > +				compatible = "fsl,vf610-ftm-timer";
> > +				reg = <0x40038000 0x2000>;
> > +				interrupts = <0 42 IRQ_TYPE_LEVEL_HIGH>;
> > +				clock-names = "ftm0", "ftm1",
> > +					"ftm0_counter_en", "ftm1_counter_en";
> > +				clocks = <&clks VF610_CLK_FTM0>,
> > +					<&clks VF610_CLK_FTM1>,
> > +					<&clks VF610_CLK_FTM0_EXT_FIX_EN>,
> > +					<&clks VF610_CLK_FTM1_EXT_FIX_EN>;
> > +				status = "disabled";
> > +			};
> > +
> 
> They need to be separated. ftm0, ftm1.
> 

Well, if so the driver will adjust much more to and I do think one dts
Node is okey.

The dts patches of this series are just for testing and reference for
The timer driver on Vybrid-twr.

Thanks,

BRs
Xiubo

> >  			wdog at 4003e000 {
> >  				compatible = "fsl,vf610-wdt", "fsl,imx21-wdt";
> >  				reg = <0x4003e000 0x1000>;
> > --
> > 1.8.4
> >
