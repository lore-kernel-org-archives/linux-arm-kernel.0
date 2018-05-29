From: horms@verge.net.au (Simon Horman)
Date: Tue, 29 May 2018 14:05:04 +0100
Subject: [PATCH 1/2] arm64: dts: renesas: r8a77980: add I2C support
In-Reply-To: <3675b19f-b800-172f-9472-c47a37760fa9@cogentembedded.com>
References: <e9c94553-be9d-0eec-a1ee-1713bb97fbab@cogentembedded.com>
 <3675b19f-b800-172f-9472-c47a37760fa9@cogentembedded.com>
Message-ID: <20180529130504.lpkpgads7lfomois@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 28, 2018 at 11:13:08PM +0300, Sergei Shtylyov wrote:
> Define the generic R8A77980 parts of the I2C[0-5] device node.
> 
> Based on the original (and large) patch by Vladimir Barinov.
> 
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
>  arch/arm64/boot/dts/renesas/r8a77980.dtsi |  111 ++++++++++++++++++++++++++++++
>  1 file changed, 111 insertions(+)
> 
> Index: renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
> ===================================================================
> --- renesas.orig/arch/arm64/boot/dts/renesas/r8a77980.dtsi
> +++ renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
> @@ -16,6 +16,15 @@
>  	#address-cells = <2>;
>  	#size-cells = <2>;
>  
> +	aliases {
> +		i2c0 = &i2c0;
> +		i2c1 = &i2c1;
> +		i2c2 = &i2c2;
> +		i2c3 = &i2c3;
> +		i2c4 = &i2c4;
> +		i2c5 = &i2c5;
> +	};
> +
>  	cpus {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> @@ -135,6 +144,108 @@
>  			#power-domain-cells = <1>;
>  		};
>  
> +		i2c0: i2c at e6500000 {
> +			compatible = "renesas,i2c-r8a77980",
> +				     "renesas,rcar-gen3-i2c";
> +			reg = <0 0xe6500000 0 0x40>;
> +			interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 931>;
> +			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
> +			resets = <&cpg 931>;
> +			dmas = <&dmac1 0x91>, <&dmac1 0x90>,
> +			       <&dmac2 0x91>, <&dmac2 0x90>;
> +			dma-names = "tx", "rx", "tx", "rx";
> +			i2c-scl-internal-delay-ns = <6>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c1: i2c at e6508000 {
> +			compatible = "renesas,i2c-r8a77980",
> +				     "renesas,rcar-gen3-i2c";
> +			reg = <0 0xe6508000 0 0x40>;
> +			interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 930>;
> +			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
> +			resets = <&cpg 930>;
> +			dmas = <&dmac1 0x93>, <&dmac1 0x92>,
> +			       <&dmac2 0x93>, <&dmac2 0x92>;
> +			dma-names = "tx", "rx", "tx", "rx";
> +			i2c-scl-internal-delay-ns = <6>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c2: i2c at e6510000 {
> +			compatible = "renesas,i2c-r8a77980",
> +				     "renesas,rcar-gen3-i2c";
> +			reg = <0 0xe6510000 0 0x40>;
> +			interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 929>;
> +			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
> +			resets = <&cpg 929>;
> +			dmas = <&dmac1 0x95>, <&dmac1 0x94>,
> +			       <&dmac2 0x95>, <&dmac2 0x94>;
> +			dma-names = "tx", "rx", "tx", "rx";
> +			i2c-scl-internal-delay-ns = <6>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c3: i2c at e66d0000 {
> +			compatible = "renesas,i2c-r8a77980",
> +				     "renesas,rcar-gen3-i2c";
> +			reg = <0 0xe66d0000 0 0x40>;
> +			interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 928>;
> +			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
> +			resets = <&cpg 928>;
> +			dmas = <&dmac1 0x97>, <&dmac1 0x96>,
> +			       <&dmac2 0x97>, <&dmac2 0x96>;
> +			dma-names = "tx", "rx", "tx", "rx";
> +			i2c-scl-internal-delay-ns = <6>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};

DMA for i2c3 and i2c4  seems unclear in v0.80 and v1.00 of the User's Manual.
Although what is described here does match v0.55E of the User's Manual.
Have you been able to confirm what is correct here?

Other than that this patch looks fine to me.

> +
> +		i2c4: i2c at e66d8000 {
> +			compatible = "renesas,i2c-r8a77980",
> +				     "renesas,rcar-gen3-i2c";
> +			reg = <0 0xe66d8000 0 0x40>;
> +			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 927>;
> +			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
> +			resets = <&cpg 927>;
> +			dmas = <&dmac1 0x99>, <&dmac1 0x98>,
> +			       <&dmac2 0x99>, <&dmac2 0x98>;
> +			dma-names = "tx", "rx", "tx", "rx";
> +			i2c-scl-internal-delay-ns = <6>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c5: i2c at e66e0000 {
> +			compatible = "renesas,i2c-r8a77980",
> +				     "renesas,rcar-gen3-i2c";
> +			reg = <0 0xe66e0000 0 0x40>;
> +			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 919>;
> +			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
> +			resets = <&cpg 919>;
> +			dmas = <&dmac1 0x9b>, <&dmac1 0x9a>,
> +			       <&dmac2 0x9b>, <&dmac2 0x9a>;
> +			dma-names = "tx", "rx", "tx", "rx";
> +			i2c-scl-internal-delay-ns = <6>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
>  		hscif0: serial at e6540000 {
>  			compatible = "renesas,hscif-r8a77980",
>  				     "renesas,rcar-gen3-hscif",
> 
