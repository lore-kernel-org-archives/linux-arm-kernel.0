From: Dongsheng.Wang@freescale.com (Dongsheng.Wang at freescale.com)
Date: Wed, 16 Apr 2014 04:00:59 +0000
Subject: [RFC][PATCH 1/3] ARM: dts: vf610: Add Freescale FlexTimer
 Module timer node.
In-Reply-To: <1397614787-8300-2-git-send-email-Li.Xiubo@freescale.com>
References: <1397614787-8300-1-git-send-email-Li.Xiubo@freescale.com>
 <1397614787-8300-2-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <a7aeb70fae2c480198b413f581f76846@BN1PR03MB188.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Xiubo Li [mailto:Li.Xiubo at freescale.com]
> Sent: Wednesday, April 16, 2014 10:20 AM
> To: daniel.lezcano at linaro.org; tglx at linutronix.de; shawn.guo at linaro.org; Lu
> Jingchang-B35083; Jin Zhengxiong-R64188; Wang Dongsheng-B40534
> Cc: devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; Xiubo Li-B47053
> Subject: [RFC][PATCH 1/3] ARM: dts: vf610: Add Freescale FlexTimer Module timer
> node.
> 
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Jingchang Lu <b35083@freescale.com>
> ---
>  arch/arm/boot/dts/vf610.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
> index 107e2c0..c3a276f 100644
> --- a/arch/arm/boot/dts/vf610.dtsi
> +++ b/arch/arm/boot/dts/vf610.dtsi
> @@ -153,6 +153,19 @@
>  				clock-names = "pit";
>  			};
> 
> +			ftm0: ftm at 40038000 {
> +				compatible = "fsl,vf610-ftm-timer";
> +				reg = <0x40038000 0x2000>;
> +				interrupts = <0 42 IRQ_TYPE_LEVEL_HIGH>;
> +				clock-names = "ftm0", "ftm1",
> +					"ftm0_counter_en", "ftm1_counter_en";
> +				clocks = <&clks VF610_CLK_FTM0>,
> +					<&clks VF610_CLK_FTM1>,
> +					<&clks VF610_CLK_FTM0_EXT_FIX_EN>,
> +					<&clks VF610_CLK_FTM1_EXT_FIX_EN>;
> +				status = "disabled";
> +			};
> +

They need to be separated. ftm0, ftm1.

>  			wdog at 4003e000 {
>  				compatible = "fsl,vf610-wdt", "fsl,imx21-wdt";
>  				reg = <0x4003e000 0x1000>;
> --
> 1.8.4
> 
