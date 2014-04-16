From: Li.Xiubo@freescale.com (Li.Xiubo at freescale.com)
Date: Wed, 16 Apr 2014 09:38:33 +0000
Subject: [RFC][PATCH 1/3] ARM: dts: vf610: Add Freescale FlexTimer
 Module timer node.
In-Reply-To: <534E4873.5070308@linaro.org>
References: <1397614787-8300-1-git-send-email-Li.Xiubo@freescale.com>
 <1397614787-8300-2-git-send-email-Li.Xiubo@freescale.com>
 <534E4873.5070308@linaro.org>
Message-ID: <ac0038bd2f9142119cfe5843afbf78e9@DM2PR03MB509.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Subject: Re: [RFC][PATCH 1/3] ARM: dts: vf610: Add Freescale FlexTimer Module
> timer node.
> 
> On 04/16/2014 04:19 AM, Xiubo Li wrote:
> > Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Jingchang Lu <b35083@freescale.com>
> 
> That deserves a patch description and an update of the documentation.
>

Yes, I'll add this.


Thanks,

BRs
Xiubo

 
> Thanks
>    -- Daniel
> 
> > ---
> >   arch/arm/boot/dts/vf610.dtsi | 13 +++++++++++++
> >   1 file changed, 13 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
> > index 107e2c0..c3a276f 100644
> > --- a/arch/arm/boot/dts/vf610.dtsi
> > +++ b/arch/arm/boot/dts/vf610.dtsi
> > @@ -153,6 +153,19 @@
> >   				clock-names = "pit";
> >   			};
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
> >   			wdog at 4003e000 {
> >   				compatible = "fsl,vf610-wdt", "fsl,imx21-wdt";
> >   				reg = <0x4003e000 0x1000>;
> >
> 
> 
> --
>   <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 
> 
