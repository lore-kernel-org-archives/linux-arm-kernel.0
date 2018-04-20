From: horms@verge.net.au (Simon Horman)
Date: Fri, 20 Apr 2018 11:58:57 +0200
Subject: [PATCH 1/2] arm64: dts: renesas: r8a77980: add MMC support
In-Reply-To: <aaa58189-2c27-e51f-1f97-3671c50a1479@cogentembedded.com>
References: <611daf1f-42a2-d463-0814-ebf762871018@cogentembedded.com>
 <aaa58189-2c27-e51f-1f97-3671c50a1479@cogentembedded.com>
Message-ID: <20180420095857.latofivdh3dnvu2z@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 14, 2018 at 10:27:04PM +0300, Sergei Shtylyov wrote:
> Define the generic R8A77980 part of the MMC0 (SDHI2) device node.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
>  arch/arm64/boot/dts/renesas/r8a77980.dtsi |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> Index: renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
> ===================================================================
> --- renesas.orig/arch/arm64/boot/dts/renesas/r8a77980.dtsi
> +++ renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
> @@ -371,6 +371,18 @@
>  			dma-channels = <16>;
>  		};
>  
> +		mmc0: mmc at ee140000 {

Please use sdhi2: sd at ee140000 for consistency with other SoCs
(I refereed to the r8a7795).

> +			compatible = "renesas,sdhi-r8a77980",
> +				     "renesas,rcar-gen3-sdhi";
> +			reg = <0 0xee140000 0 0x2000>;
> +			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 314>;
> +			power-domains = <&sysc 32>;
> +			resets = <&cpg 314>;
> +			max-frequency = <200000000>;
> +			status = "disabled";
> +		};
> +
>  		gic: interrupt-controller at f1010000 {
>  			compatible = "arm,gic-400";
>  			#interrupt-cells = <3>;
> 
