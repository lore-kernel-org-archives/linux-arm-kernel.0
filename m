From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Fri, 21 Sep 2018 12:52:07 +0200
Subject: [PATCH] ARM: dts: marvell: Fix SPI and I2C bus warnings
In-Reply-To: <20180913181245.25484-7-robh@kernel.org> (Rob Herring's message
 of "Thu, 13 Sep 2018 13:12:31 -0500")
References: <20180913181245.25484-7-robh@kernel.org>
Message-ID: <87lg7vi0mg.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,
 
 On jeu., sept. 13 2018, Rob Herring <robh@kernel.org> wrote:

> dtc has new checks for I2C and SPI buses. Fix the warnings in node names
> and unit-addresses.
>
> arch/arm/boot/dts/dove-cubox.dtb: Warning (i2c_bus_reg): /i2c-mux/i2c at 0/clock-generator: I2C bus unit address format error, expected "60"
> arch/arm/boot/dts/dove-cubox-es.dtb: Warning (i2c_bus_reg): /i2c-mux/i2c at 0/clock-generator: I2C bus unit address format error, expected "60"
> arch/arm/boot/dts/dove-cubox.dtb: Warning (spi_bus_bridge): /mbus/internal-regs/spi-ctrl at 10600: node name for SPI buses should be 'spi'
> arch/arm/boot/dts/dove-cubox-es.dtb: Warning (spi_bus_bridge): /mbus/internal-regs/spi-ctrl at 10600: node name for SPI buses should be 'spi'
> arch/arm/boot/dts/dove-dove-db.dtb: Warning (spi_bus_bridge): /mbus/internal-regs/spi-ctrl at 10600: node name for SPI buses should be 'spi'
> arch/arm/boot/dts/dove-sbc-a510.dtb: Warning (spi_bus_bridge): /mbus/internal-regs/spi-ctrl at 10600: node name for SPI buses should be 'spi'
> arch/arm/boot/dts/dove-sbc-a510.dtb: Warning (spi_bus_bridge): /mbus/internal-regs/spi-ctrl at 14600: node name for SPI buses should be 'spi'
> arch/arm/boot/dts/orion5x-kuroboxpro.dtb: Warning (i2c_bus_reg): /soc/internal-regs/i2c at 11000/rtc: I2C bus unit address format error, expected "32"
> arch/arm/boot/dts/orion5x-linkstation-lschl.dtb: Warning (i2c_bus_reg): /soc/internal-regs/i2c at 11000/rtc: I2C bus unit address format error, expected "32"
> arch/arm/boot/dts/orion5x-linkstation-lsgl.dtb: Warning (i2c_bus_reg): /soc/internal-regs/i2c at 11000/rtc: I2C bus unit address format error, expected "32"
> arch/arm/boot/dts/orion5x-linkstation-lswtgl.dtb: Warning (i2c_bus_reg): /soc/internal-regs/i2c at 11000/rtc: I2C bus unit address format error, expected "32"
>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Gregory Clement <gregory.clement@bootlin.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied on mvebu/dt

Thanks,

Gregory

> ---
> Please apply to the sub-arch tree. The dtc changes haven't landed, but 
> will for 4.20.
>
>  arch/arm/boot/dts/dove-cubox.dts           | 2 +-
>  arch/arm/boot/dts/dove.dtsi                | 6 +++---
>  arch/arm/boot/dts/orion5x-linkstation.dtsi | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/boot/dts/dove-cubox.dts b/arch/arm/boot/dts/dove-cubox.dts
> index 580e3cbcfbf7..3e1584e787ae 100644
> --- a/arch/arm/boot/dts/dove-cubox.dts
> +++ b/arch/arm/boot/dts/dove-cubox.dts
> @@ -87,7 +87,7 @@
>  	status = "okay";
>  	clock-frequency = <100000>;
>  
> -	si5351: clock-generator {
> +	si5351: clock-generator at 60 {
>  		compatible = "silabs,si5351a-msop";
>  		reg = <0x60>;
>  		#address-cells = <1>;
> diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
> index 4a0a5115b298..250ad0535e8c 100644
> --- a/arch/arm/boot/dts/dove.dtsi
> +++ b/arch/arm/boot/dts/dove.dtsi
> @@ -155,7 +155,7 @@
>  				  0xffffe000 MBUS_ID(0x03, 0x01) 0 0x0000800   /* CESA SRAM  2k */
>  				  0xfffff000 MBUS_ID(0x0d, 0x00) 0 0x0000800>; /* PMU  SRAM  2k */
>  
> -			spi0: spi-ctrl at 10600 {
> +			spi0: spi at 10600 {
>  				compatible = "marvell,orion-spi";
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> @@ -168,7 +168,7 @@
>  				status = "disabled";
>  			};
>  
> -			i2c: i2c-ctrl at 11000 {
> +			i2c: i2c at 11000 {
>  				compatible = "marvell,mv64xxx-i2c";
>  				reg = <0x11000 0x20>;
>  				#address-cells = <1>;
> @@ -218,7 +218,7 @@
>  				status = "disabled";
>  			};
>  
> -			spi1: spi-ctrl at 14600 {
> +			spi1: spi at 14600 {
>  				compatible = "marvell,orion-spi";
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> diff --git a/arch/arm/boot/dts/orion5x-linkstation.dtsi b/arch/arm/boot/dts/orion5x-linkstation.dtsi
> index ebd93df5d07a..b6c9b85951ea 100644
> --- a/arch/arm/boot/dts/orion5x-linkstation.dtsi
> +++ b/arch/arm/boot/dts/orion5x-linkstation.dtsi
> @@ -156,7 +156,7 @@
>  &i2c {
>  	status = "okay";
>  
> -	rtc {
> +	rtc at 32 {
>  		compatible = "ricoh,rs5c372a";
>  		reg = <0x32>;
>  	};
> -- 
> 2.17.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
