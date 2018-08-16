From: sean.wang@mediatek.com (Sean Wang)
Date: Thu, 16 Aug 2018 16:07:46 +0800
Subject: [PATCH 3/5] arm64: dts: mt7622: fix ram size for rfb1
In-Reply-To: <3be2ef51a1dffed93538d256273bdecfc59cdea5.1534130854.git.ryder.lee@mediatek.com>
References: <68c4ca0158518d6bf50f2f7becfcb87ff3ce158a.1534130854.git.ryder.lee@mediatek.com>
 <3be2ef51a1dffed93538d256273bdecfc59cdea5.1534130854.git.ryder.lee@mediatek.com>
Message-ID: <1534406866.31978.47.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-08-15 at 13:18 +0800, Ryder Lee wrote:
> Fix ram size and sort nodes in alphabetical order.
> 

The size of the ram should be selective range from 512 megabytes to 2
gigabytes depending on what the specific application is being run on the
Soc and I actually thought 512 megabytes should be the better value for
the base of rfb1, so 

Acked-by: Sean Wang <sean.wang@mediatek.com>

> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts | 196 +++++++++++++--------------
>  1 file changed, 98 insertions(+), 98 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
> index b783764..033d7d1 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
> @@ -51,7 +51,7 @@
>  	};
>  
>  	memory {
> -		reg = <0 0x40000000 0 0x3F000000>;
> +		reg = <0 0x40000000 0 0x20000000>;
>  	};
>  
>  	reg_1p8v: regulator-1p8v {
> @@ -81,6 +81,103 @@
>  	};
>  };
>  
> +&bch {
> +	status = "disabled";
> +};
> +
> +&btif {
> +	status = "okay";
> +};
> +
> +&cir {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&irrx_pins>;
> +	status = "okay";
> +};
> +
> +&eth {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&eth_pins>;
> +	status = "okay";
> +
> +	gmac1: mac at 1 {
> +		compatible = "mediatek,eth-mac";
> +		reg = <1>;
> +		phy-handle = <&phy5>;
> +	};
> +
> +	mdio-bus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		phy5: ethernet-phy at 5 {
> +			reg = <5>;
> +			phy-mode = "sgmii";
> +		};
> +	};
> +};
> +
> +&i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1_pins>;
> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c2_pins>;
> +	status = "okay";
> +};
> +
> +&mmc0 {
> +	pinctrl-names = "default", "state_uhs";
> +	pinctrl-0 = <&emmc_pins_default>;
> +	pinctrl-1 = <&emmc_pins_uhs>;
> +	status = "okay";
> +	bus-width = <8>;
> +	max-frequency = <50000000>;
> +	cap-mmc-highspeed;
> +	mmc-hs200-1_8v;
> +	vmmc-supply = <&reg_3p3v>;
> +	vqmmc-supply = <&reg_1p8v>;
> +	assigned-clocks = <&topckgen CLK_TOP_MSDC30_0_SEL>;
> +	assigned-clock-parents = <&topckgen CLK_TOP_UNIV48M>;
> +	non-removable;
> +};
> +
> +&mmc1 {
> +	pinctrl-names = "default", "state_uhs";
> +	pinctrl-0 = <&sd0_pins_default>;
> +	pinctrl-1 = <&sd0_pins_uhs>;
> +	status = "okay";
> +	bus-width = <4>;
> +	max-frequency = <50000000>;
> +	cap-sd-highspeed;
> +	r_smpl = <1>;
> +	cd-gpios = <&pio 81 GPIO_ACTIVE_LOW>;
> +	vmmc-supply = <&reg_3p3v>;
> +	vqmmc-supply = <&reg_3p3v>;
> +	assigned-clocks = <&topckgen CLK_TOP_MSDC30_1_SEL>;
> +	assigned-clock-parents = <&topckgen CLK_TOP_UNIV48M>;
> +};
> +
> +&nandc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&parallel_nand_pins>;
> +	status = "disabled";
> +};
> +
> +&nor_flash {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi_nor_pins>;
> +	status = "disabled";
> +
> +	flash at 0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +	};
> +};
> +
>  &pcie {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pcie0_pins>;
> @@ -344,103 +441,6 @@
>  	};
>  };
>  
> -&bch {
> -	status = "disabled";
> -};
> -
> -&btif {
> -	status = "okay";
> -};
> -
> -&cir {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&irrx_pins>;
> -	status = "okay";
> -};
> -
> -&eth {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&eth_pins>;
> -	status = "okay";
> -
> -	gmac1: mac at 1 {
> -		compatible = "mediatek,eth-mac";
> -		reg = <1>;
> -		phy-handle = <&phy5>;
> -	};
> -
> -	mdio-bus {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		phy5: ethernet-phy at 5 {
> -			reg = <5>;
> -			phy-mode = "sgmii";
> -		};
> -	};
> -};
> -
> -&i2c1 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&i2c1_pins>;
> -	status = "okay";
> -};
> -
> -&i2c2 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&i2c2_pins>;
> -	status = "okay";
> -};
> -
> -&mmc0 {
> -	pinctrl-names = "default", "state_uhs";
> -	pinctrl-0 = <&emmc_pins_default>;
> -	pinctrl-1 = <&emmc_pins_uhs>;
> -	status = "okay";
> -	bus-width = <8>;
> -	max-frequency = <50000000>;
> -	cap-mmc-highspeed;
> -	mmc-hs200-1_8v;
> -	vmmc-supply = <&reg_3p3v>;
> -	vqmmc-supply = <&reg_1p8v>;
> -	assigned-clocks = <&topckgen CLK_TOP_MSDC30_0_SEL>;
> -	assigned-clock-parents = <&topckgen CLK_TOP_UNIV48M>;
> -	non-removable;
> -};
> -
> -&mmc1 {
> -	pinctrl-names = "default", "state_uhs";
> -	pinctrl-0 = <&sd0_pins_default>;
> -	pinctrl-1 = <&sd0_pins_uhs>;
> -	status = "okay";
> -	bus-width = <4>;
> -	max-frequency = <50000000>;
> -	cap-sd-highspeed;
> -	r_smpl = <1>;
> -	cd-gpios = <&pio 81 GPIO_ACTIVE_LOW>;
> -	vmmc-supply = <&reg_3p3v>;
> -	vqmmc-supply = <&reg_3p3v>;
> -	assigned-clocks = <&topckgen CLK_TOP_MSDC30_1_SEL>;
> -	assigned-clock-parents = <&topckgen CLK_TOP_UNIV48M>;
> -};
> -
> -&nandc {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&parallel_nand_pins>;
> -	status = "disabled";
> -};
> -
> -&nor_flash {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&spi_nor_pins>;
> -	status = "disabled";
> -
> -	flash at 0 {
> -		compatible = "jedec,spi-nor";
> -		reg = <0>;
> -	};
> -};
> -
>  &pwm {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pwm7_pins>;
