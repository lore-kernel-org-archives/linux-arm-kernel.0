From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 26 Apr 2017 12:28:25 +0200
Subject: [PATCH v4 7/7] ARM64: dts: marvell: armada37xx: add pinctrl
 definition
In-Reply-To: <7b07bd69cd506effa716c41f8ec3dda7a7c6c563.1491405475.git-series.gregory.clement@free-electrons.com>
 (Gregory CLEMENT's message of "Wed, 5 Apr 2017 17:18:08 +0200")
References: <cover.65d0e6796fecf1fe6c5d07b981160b54dc9b4acd.1491405475.git-series.gregory.clement@free-electrons.com>
 <cover.65d0e6796fecf1fe6c5d07b981160b54dc9b4acd.1491405475.git-series.gregory.clement@free-electrons.com>
 <7b07bd69cd506effa716c41f8ec3dda7a7c6c563.1491405475.git-series.gregory.clement@free-electrons.com>
Message-ID: <87mvb38nue.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
 
 On mer., avril 05 2017, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Start to populate the device tree of the Armada 37xx with the pincontrol
> configuration used on the board providing a dts.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Applied on mvebu/dt64

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-3720-db.dts |  8 +++++-
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi   | 31 +++++++++++++++++++-
>  2 files changed, 39 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-db.dts b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
> index 86602c907a61..e749c5727490 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-db.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
> @@ -63,6 +63,8 @@
>  };
>  
>  &i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1_pins>;
>  	status = "okay";
>  };
>  
> @@ -73,6 +75,8 @@
>  
>  &spi0 {
>  	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi_quad_pins>;
>  
>  	m25p80 at 0 {
>  		compatible = "jedec,spi-nor";
> @@ -103,6 +107,8 @@
>  
>  /* Exported on the micro USB connector CON32 through an FTDI */
>  &uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart1_pins>;
>  	status = "okay";
>  };
>  
> @@ -128,6 +134,8 @@
>  };
>  
>  &eth0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&rgmii_pins>;
>  	phy-mode = "rgmii-id";
>  	phy = <&phy0>;
>  	status = "okay";
> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> index c02b13479458..2ac25f54d01d 100644
> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> @@ -186,6 +186,31 @@
>  					clock-output-names = "xtal";
>  					#clock-cells = <0>;
>  				};
> +
> +				spi_quad_pins: spi-quad-pins {
> +					groups = "spi_quad";
> +					function = "spi";
> +				};
> +
> +				i2c1_pins: i2c1-pins {
> +					groups = "i2c1";
> +					function = "i2c";
> +				};
> +
> +				i2c2_pins: i2c2-pins {
> +					groups = "i2c2";
> +					function = "i2c";
> +				};
> +
> +				uart1_pins: uart1-pins {
> +					groups = "uart1";
> +					function = "uart";
> +				};
> +
> +				uart2_pins: uart2-pins {
> +					groups = "uart2";
> +					function = "uart";
> +				};
>  			};
>  
>  			pinctrl_sb: pinctrl-sb at 18800 {
> @@ -203,6 +228,12 @@
>  					<GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
>  					<GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
>  				};
> +
> +				rgmii_pins: mii-pins {
> +					groups = "rgmii";
> +					function = "mii";
> +				};
> +
>  			};
>  
>  			eth0: ethernet at 30000 {
> -- 
> git-series 0.9.1

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
