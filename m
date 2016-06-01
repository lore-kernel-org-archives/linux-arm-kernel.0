From: horms@verge.net.au (Simon Horman)
Date: Wed, 1 Jun 2016 10:18:13 +0900
Subject: [PATCH 10/13] ARM: dts: r8a7792: add IRQC support
In-Reply-To: <3573091.BUvyGW3hVt@wasted.cogentembedded.com>
References: <13205049.n7pM8utpHF@wasted.cogentembedded.com>
 <3573091.BUvyGW3hVt@wasted.cogentembedded.com>
Message-ID: <20160601011813.GJ20527@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 01, 2016 at 01:29:05AM +0300, Sergei Shtylyov wrote:
> Describe the IRQC interrupt controller in the R8A7792 device tree.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
>  arch/arm/boot/dts/r8a7792.dtsi |   13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> Index: renesas/arch/arm/boot/dts/r8a7792.dtsi
> ===================================================================
> --- renesas.orig/arch/arm/boot/dts/r8a7792.dtsi
> +++ renesas/arch/arm/boot/dts/r8a7792.dtsi
> @@ -62,6 +62,19 @@
>  			      IRQ_TYPE_LEVEL_HIGH)>;
>  	};
>  
> +	irqc: interrupt-controller at e61c0000 {

Could you consider using irqc0 as the node name for consistency with the
DT of other R-Car Gen2 SoCs?

What follows looks correct to me.

> +		compatible = "renesas,irqc-r8a7792", "renesas,irqc";
> +		#interrupt-cells = <2>;
> +		interrupt-controller;
> +		reg = <0 0xe61c0000 0 0x200>;
> +		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp4_clks R8A7792_CLK_IRQC>;
> +		power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
> +	};
> +
>  	timer {
>  		compatible = "arm,armv7-timer";
>  		interrupts = <GIC_PPI 13
> 
