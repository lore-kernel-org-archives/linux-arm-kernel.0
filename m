From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 12 Mar 2014 11:39:55 +0100
Subject: [PATCH 5/5] ARM: shmobile: r8a7790: add IIC(B) cores to dtsi
In-Reply-To: <1394573078-20767-6-git-send-email-wsa@the-dreams.de>
References: <1394573078-20767-1-git-send-email-wsa@the-dreams.de>
 <1394573078-20767-6-git-send-email-wsa@the-dreams.de>
Message-ID: <1722114.RHS5FXLvLd@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

Thank you for the patch.

On Tuesday 11 March 2014 22:24:38 Wolfram Sang wrote:
> From: Wolfram Sang <wsa@sang-engineering.com>
> 
> Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
> ---
>  arch/arm/boot/dts/r8a7790.dtsi | 44 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> index 9e15fb9858e7..5b357480d8bf 100644
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> @@ -24,6 +24,10 @@
>  		i2c1 = &i2c1;
>  		i2c2 = &i2c2;
>  		i2c3 = &i2c3;
> +		i2c4 = &i2c4;
> +		i2c5 = &i2c5;
> +		i2c6 = &i2c6;
> +		i2c7 = &i2c7;
>  		spi0 = &qspi;
>  		spi1 = &msiof0;
>  		spi2 = &msiof1;
> @@ -236,6 +240,46 @@
>  		status = "disabled";
>  	};
> 
> +	i2c4: i2c at e6500000 {

As for the other patches, iic0-iic3 ?

> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "renesas,iic-r8a7790", "renesas,rmobile-iic";
> +		reg = <0 0xe6500000 0 0x425>;
> +		interrupts = <0 174 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp3_clks R8A7790_CLK_IIC0>;
> +		status = "disabled";
> +	};
> +
> +	i2c5: i2c at e6510000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "renesas,iic-r8a7790", "renesas,rmobile-iic";
> +		reg = <0 0xe6510000 0 0x425>;
> +		interrupts = <0 175 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp3_clks R8A7790_CLK_IIC1>;
> +		status = "disabled";
> +	};
> +
> +	i2c6: i2c at e6520000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "renesas,iic-r8a7790", "renesas,rmobile-iic";
> +		reg = <0 0xe6520000 0 0x425>;
> +		interrupts = <0 176 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp3_clks R8A7790_CLK_IIC2>;
> +		status = "disabled";
> +	};
> +
> +	i2c7: i2c at e60b0000 {
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
