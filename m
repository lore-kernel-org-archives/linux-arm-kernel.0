From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 26 Dec 2017 16:56:54 +0800
Subject: [PATCH] ARM: dts: ls1021a: add nodes for on-chip ram
In-Reply-To: <1513870698-31264-1-git-send-email-rasmus.villemoes@prevas.dk>
References: <1513870698-31264-1-git-send-email-rasmus.villemoes@prevas.dk>
Message-ID: <20171226085653.GL23070@X250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 21, 2017 at 04:38:18PM +0100, Rasmus Villemoes wrote:
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

Empty commit log is not welcomed.

> ---
>  arch/arm/boot/dts/ls1021a.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
> index bd6622f10046..6f53e6aefb63 100644
> --- a/arch/arm/boot/dts/ls1021a.dtsi
> +++ b/arch/arm/boot/dts/ls1021a.dtsi
> @@ -748,5 +748,21 @@
>  					<0000 0 0 3 &gic GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
>  					<0000 0 0 4 &gic GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
>  		};
> +
> +		ocram1: sram at 10000000 {
> +			compatible = "mmio-sram";
> +			reg = <0x0 0x10000000 0x0 0x10000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0x0 0x0 0x10000000 0x10000>;
> +		};
> +
> +		ocram2: sram at 10010000 {
> +			compatible = "mmio-sram";
> +			reg = <0x0 0x10010000 0x0 0x10000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0x0 0x0 0x10010000 0x10000>;
> +		};

Why split one continuous sram into two nodes?

Shawn

>  	};
>  };
> -- 
> 2.7.4
> 
