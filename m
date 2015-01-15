From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 15 Jan 2015 17:19:08 +0100
Subject: [PATCH 3/3] ARM: dts: rockchip: add dts for ChipSPARK Rayeager
 PX2 board
In-Reply-To: <1421289659-16627-4-git-send-email-naobsd@gmail.com>
References: <1421289659-16627-1-git-send-email-naobsd@gmail.com>
 <1421289659-16627-4-git-send-email-naobsd@gmail.com>
Message-ID: <2706590.Kkspa3JYVn@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

again, please add a small commit message and reorder nodes as described in the 
previous patch, some more stuff inline

Am Donnerstag, 15. Januar 2015, 11:40:59 schrieb FUKAUMI Naoki:
> Signed-off-by: FUKAUMI Naoki <naobsd@gmail.com>
> ---

[...]

> +
> +	vsys: vsys-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vsys";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vcc_otg: usb-otg-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio0 5 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&otg_drv>;
> +		regulator-name = "vcc_otg";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;

missing vin-supply

> +	};
> +
> +	vcc_host: usb-host-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio0 6 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&host_drv>;
> +		regulator-name = "host-pwr";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;

missing vin-supply

> +	};
> +
> +	vcc_sata: sata-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio4 22 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&sata_pwr>;
> +		regulator-name = "usb_5v";

why is it named "usb_5v"?

> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;

missing vin-supply

> +	};
> +

[...]

> +&emmc {
> +	broken-cd;
> +	bus-width = <8>;
> +	cap-mmc-highspeed;
> +	disable-wp;
> +	non-removable;
> +	num-slots = <1>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&emmc_clk>, <&emmc_cmd>, <&emmc_rst>;
> +	status = "okay";
> +	vmmc-supply = <&vcc_emmc>;
> +	vqmmc-supply = <&vcc_emmc>;

I checked the public schematics and surprisingly this is actually correct ... 
but still very strange :-)

> +};

[...]

> +&i2c0 {
> +	status = "okay";
> +	clock-frequency = <400000>;
> +
> +	ak8963: ak8963 at d {

please use two chars for the address, i.e. ak8963 at 0d, same for the reg below

> +		compatible = "asahi-kasei,ak8975";
> +		reg = <0xd>;
> +		interrupt-parent = <&gpio4>;
> +		interrupts = <17 IRQ_TYPE_EDGE_RISING>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&comp_int>;
> +	};
> +
> +	mma8452: mma8452 at 1d {
> +		compatible = "fsl,mma8452";
> +		reg = <0x1d>;
> +		interrupt-parent = <&gpio4>;
> +		interrupts = <16 IRQ_TYPE_EDGE_RISING>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gsensor_int>;
> +	};
> +};


Heiko
