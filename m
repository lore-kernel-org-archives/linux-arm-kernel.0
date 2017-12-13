From: horms@verge.net.au (Simon Horman)
Date: Wed, 13 Dec 2017 09:38:29 +0100
Subject: [PATCH 2/3] ARM: dts: r8a7743: Add CMT SoC specific support
In-Reply-To: <1513104579-6333-3-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1513104579-6333-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1513104579-6333-3-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <20171213083829.ptdeggbon3szmko4@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 12, 2017 at 06:49:38PM +0000, Fabrizio Castro wrote:
> Add CMT[01] support to SoC DT.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> ---
>  arch/arm/boot/dts/r8a7743.dtsi | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)

I was expecting the cmt nodes to be "disabled" in the SoC file
and then enabled selectively in board files. Am I missing something?

Otherwise this patch looks good to me.

> diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
> index 59860c8..0e2834a 100644
> --- a/arch/arm/boot/dts/r8a7743.dtsi
> +++ b/arch/arm/boot/dts/r8a7743.dtsi
> @@ -262,6 +262,36 @@
>  						  IRQ_TYPE_LEVEL_LOW)>;
>  		};
>  
> +		cmt0: timer at ffca0000 {
> +			compatible = "renesas,r8a7743-cmt0",
> +				     "renesas,rcar-gen2-cmt0";
> +			reg = <0 0xffca0000 0 0x1004>;
> +			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 124>;
> +			clock-names = "fck";
> +			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
> +			resets = <&cpg 124>;
> +		};
> +
> +		cmt1: timer at e6130000 {
> +			compatible = "renesas,r8a7743-cmt1",
> +				     "renesas,rcar-gen2-cmt1";
> +			reg = <0 0xe6130000 0 0x1004>;
> +			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 329>;
> +			clock-names = "fck";
> +			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
> +			resets = <&cpg 329>;
> +		};
> +
>  		cpg: clock-controller at e6150000 {
>  			compatible = "renesas,r8a7743-cpg-mssr";
>  			reg = <0 0xe6150000 0 0x1000>;
> -- 
> 2.7.4
> 
