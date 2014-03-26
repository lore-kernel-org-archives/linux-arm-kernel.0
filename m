From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 26 Mar 2014 15:05:34 +0100
Subject: [PATCH v2 5/5] ARM: shmobile: r8a7790: add IIC(B) cores to dtsi
In-Reply-To: <1395773789-17249-6-git-send-email-wsa@the-dreams.de>
References: <1395773789-17249-1-git-send-email-wsa@the-dreams.de>
 <1395773789-17249-6-git-send-email-wsa@the-dreams.de>
Message-ID: <3372432.uDFHLQLanr@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

Thank you for the patch.

On Tuesday 25 March 2014 19:56:29 Wolfram Sang wrote:
> From: Wolfram Sang <wsa@sang-engineering.com>
> 
> Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> Change since V1:
> 
> * renamed i2c4-7 to iic0-3
> 
>  arch/arm/boot/dts/r8a7790.dtsi | 44
> ++++++++++++++++++++++++++++++++++++++++++ 1 file changed, 44 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> index 21e6602c630b..b78d718479e0 100644
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> @@ -24,6 +24,10 @@
>  		i2c1 = &i2c1;
>  		i2c2 = &i2c2;
>  		i2c3 = &i2c3;
> +		i2c4 = &iic0;
> +		i2c5 = &iic1;
> +		i2c6 = &iic2;
> +		i2c7 = &iic3;
>  		spi0 = &qspi;
>  		spi1 = &msiof0;
>  		spi2 = &msiof1;
> @@ -236,6 +240,46 @@
>  		status = "disabled";
>  	};
> 
> +	iic0: i2c at e6500000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "renesas,iic-r8a7790", "renesas,rmobile-iic";
> +		reg = <0 0xe6500000 0 0x425>;
> +		interrupts = <0 174 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp3_clks R8A7790_CLK_IIC0>;
> +		status = "disabled";
> +	};
> +
> +	iic1: i2c at e6510000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "renesas,iic-r8a7790", "renesas,rmobile-iic";
> +		reg = <0 0xe6510000 0 0x425>;
> +		interrupts = <0 175 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp3_clks R8A7790_CLK_IIC1>;
> +		status = "disabled";
> +	};
> +
> +	iic2: i2c at e6520000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "renesas,iic-r8a7790", "renesas,rmobile-iic";
> +		reg = <0 0xe6520000 0 0x425>;
> +		interrupts = <0 176 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp3_clks R8A7790_CLK_IIC2>;
> +		status = "disabled";
> +	};
> +
> +	iic3: i2c at e60b0000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "renesas,iic-r8a7790", "renesas,rmobile-iic";
> +		reg = <0 0xe60b0000 0 0x425>;
> +		interrupts = <0 173 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp9_clks R8A7790_CLK_IICDVFS>;
> +		status = "disabled";
> +	};
> +
>  	mmcif0: mmcif at ee200000 {
>  		compatible = "renesas,mmcif-r8a7790", "renesas,sh-mmcif";
>  		reg = <0 0xee200000 0 0x80>;

-- 
Regards,

Laurent Pinchart
