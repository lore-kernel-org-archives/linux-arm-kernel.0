From: tony@atomide.com (Tony Lindgren)
Date: Mon, 5 May 2014 12:56:38 -0700
Subject: [PATCH v2] ARM: dts: OMAP5: add pmu node
In-Reply-To: <1395243953-11856-1-git-send-email-nathan_lynch@mentor.com>
References: <1395243953-11856-1-git-send-email-nathan_lynch@mentor.com>
Message-ID: <20140505195638.GG25949@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nathan Lynch <nathan_lynch@mentor.com> [140319 08:50]:
> Expose the PMU on OMAP5.
> 
> Tested with perf on OMAP5 uEVM.
> 
> Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>

Applying into omap-for-v3.16/dt thanks.

Tony

> ---
> 
> Changes since v1:
> - Use symbolic constants.
> 
>  arch/arm/boot/dts/omap5.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index a72813a9663e..ccb38944c85a 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -76,6 +76,12 @@
>  			     <GIC_PPI 10 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>;
>  	};
>  
> +	pmu {
> +		compatible = "arm,cortex-a15-pmu";
> +		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
>  	gic: interrupt-controller at 48211000 {
>  		compatible = "arm,cortex-a15-gic";
>  		interrupt-controller;
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
