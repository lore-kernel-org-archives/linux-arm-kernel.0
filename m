From: horms@verge.net.au (Simon Horman)
Date: Fri, 24 Aug 2018 11:03:20 +0200
Subject: [PATCH 4/5] arm64: dts: renesas: r8a774a1: Add Ethernet AVB node
In-Reply-To: <1535014731-64472-5-git-send-email-biju.das@bp.renesas.com>
References: <1535014731-64472-1-git-send-email-biju.das@bp.renesas.com>
 <1535014731-64472-5-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20180824090320.ib7zt4ae6kacjzlu@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 23, 2018 at 09:58:50AM +0100, Biju Das wrote:
> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> 
> This patch adds the SoC specific part of the Ethernet AVB
> device tree node.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> ---
>  arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 45 +++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
> index 15d7785..b771211 100644
> --- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
> @@ -350,6 +350,51 @@
>  			dma-channels = <16>;
>  		};
>  
> +		avb: ethernet at e6800000 {
> +			compatible = "renesas,etheravb-r8a774a1",
> +				     "renesas,etheravb-rcar-gen3";
> +			reg = <0 0xe6800000 0 0x800>;

Should a region, <0 0xe6a00000 0 0x10000>, also be added
here to describe the suggested space for descriptors?

Otherwise the patch looks good to me.

> +			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "ch0", "ch1", "ch2", "ch3",
> +					  "ch4", "ch5", "ch6", "ch7",
> +					  "ch8", "ch9", "ch10", "ch11",
> +					  "ch12", "ch13", "ch14", "ch15",
> +					  "ch16", "ch17", "ch18", "ch19",
> +					  "ch20", "ch21", "ch22", "ch23",
> +					  "ch24";
> +			clocks = <&cpg CPG_MOD 812>;
> +			power-domains = <&sysc 32>;
> +			resets = <&cpg 812>;
> +			phy-mode = "rgmii";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
>  		scif0: serial at e6e60000 {
>  			compatible = "renesas,scif-r8a774a1",
>  				     "renesas,rcar-gen3-scif", "renesas,scif";
> -- 
> 2.7.4
> 
