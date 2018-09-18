From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 18 Sep 2018 12:52:26 +0200
Subject: [PATCH] ARM: dts: xilinx: Fix I2C and SPI bus warnings
In-Reply-To: <20180913181245.25484-15-robh@kernel.org>
References: <20180913181245.25484-15-robh@kernel.org>
Message-ID: <807013e3-b4c0-3a54-5464-15e7bed4e187@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13.9.2018 20:12, Rob Herring wrote:
> dtc has new checks for I2C and SPI buses. Fix the warnings in node names
> and unit-addresses.
> 
> arch/arm/boot/dts/zynq-zc702.dtb: Warning (i2c_bus_reg): /amba/i2c at e0004000/i2c-mux at 74/i2c at 7/hwmon at 52: I2C bus unit address format error, expected "34"
> arch/arm/boot/dts/zynq-zc702.dtb: Warning (i2c_bus_reg): /amba/i2c at e0004000/i2c-mux at 74/i2c at 7/hwmon at 53: I2C bus unit address format error, expected "35"
> arch/arm/boot/dts/zynq-zc702.dtb: Warning (i2c_bus_reg): /amba/i2c at e0004000/i2c-mux at 74/i2c at 7/hwmon at 54: I2C bus unit address format error, expected "36"
> arch/arm/boot/dts/zynq-zc770-xm013.dtb: Warning (spi_bus_reg): /amba/spi at e0006000/eeprom at 0: SPI bus unit address format error, expected "2"
> arch/arm/boot/dts/zynq-zc770-xm010.dtb: Warning (spi_bus_reg): /amba/spi at e0007000/flash at 0: SPI bus unit address format error, expected "1"
> 
> Cc: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Please apply to the sub-arch tree. The dtc changes haven't landed, but 
> will for 4.20.
> 
>  arch/arm/boot/dts/zynq-zc702.dts       | 12 ++++++------
>  arch/arm/boot/dts/zynq-zc770-xm010.dts |  2 +-
>  arch/arm/boot/dts/zynq-zc770-xm013.dts |  2 +-
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
> index cc5a3dc2b4a0..27cd6cb52f1b 100644
> --- a/arch/arm/boot/dts/zynq-zc702.dts
> +++ b/arch/arm/boot/dts/zynq-zc702.dts
> @@ -174,17 +174,17 @@
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			reg = <7>;
> -			hwmon at 52 {
> +			hwmon at 34 {
>  				compatible = "ti,ucd9248";
> -				reg = <52>;
> +				reg = <0x34>;
>  			};
> -			hwmon at 53 {
> +			hwmon at 35 {
>  				compatible = "ti,ucd9248";
> -				reg = <53>;
> +				reg = <0x35>;
>  			};
> -			hwmon at 54 {
> +			hwmon at 36 {
>  				compatible = "ti,ucd9248";
> -				reg = <54>;
> +				reg = <0x36>;
>  			};
>  		};
>  	};
> diff --git a/arch/arm/boot/dts/zynq-zc770-xm010.dts b/arch/arm/boot/dts/zynq-zc770-xm010.dts
> index 0e1bfdd3421f..0dd352289a45 100644
> --- a/arch/arm/boot/dts/zynq-zc770-xm010.dts
> +++ b/arch/arm/boot/dts/zynq-zc770-xm010.dts
> @@ -68,7 +68,7 @@
>  	status = "okay";
>  	num-cs = <4>;
>  	is-decoded-cs = <0>;
> -	flash at 0 {
> +	flash at 1 {
>  		compatible = "sst25wf080", "jedec,spi-nor";
>  		reg = <1>;
>  		spi-max-frequency = <1000000>;
> diff --git a/arch/arm/boot/dts/zynq-zc770-xm013.dts b/arch/arm/boot/dts/zynq-zc770-xm013.dts
> index 651913f1afa2..4ae2c85df3a0 100644
> --- a/arch/arm/boot/dts/zynq-zc770-xm013.dts
> +++ b/arch/arm/boot/dts/zynq-zc770-xm013.dts
> @@ -62,7 +62,7 @@
>  	status = "okay";
>  	num-cs = <4>;
>  	is-decoded-cs = <0>;
> -	eeprom: eeprom at 0 {
> +	eeprom: eeprom at 2 {
>  		at25,byte-len = <8192>;
>  		at25,addr-mode = <2>;
>  		at25,page-size = <32>;
> 

Applied. All checked.

Thanks,
Michal
