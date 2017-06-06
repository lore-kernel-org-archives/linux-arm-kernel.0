From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Tue, 06 Jun 2017 08:40:53 +0200
Subject: [PATCHv3 1/4] ARM: dts: socfpga: Add Altera I2C Controller to
 CycloneV
In-Reply-To: <1496447559-19782-2-git-send-email-thor.thayer@linux.intel.com>
References: <1496447559-19782-1-git-send-email-thor.thayer@linux.intel.com>
 <1496447559-19782-2-git-send-email-thor.thayer@linux.intel.com>
Message-ID: <73vao9vcsq.fsf@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi!

thor.thayer at linux.intel.com writes:

> From: Thor Thayer <thor.thayer@linux.intel.com>
>
> Add the Altera I2C Controller to the CycloneV SoCFPGA device tree.
>
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> ---
> v2  Remove altr, from fifo-size.
>     Rename compatible string to "altr,softip-i2c"
> v3  Add version to commpatible string "altr,softip-i2c-v1.0"
> ---
>  arch/arm/boot/dts/socfpga.dtsi               | 13 ++++++++++---
>  arch/arm/boot/dts/socfpga_cyclone5_socdk.dts | 28 +++++++++++++++++++++++++++-
>  2 files changed, 37 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> index b2674bd..d69c13d 100644
> --- a/arch/arm/boot/dts/socfpga.dtsi
> +++ b/arch/arm/boot/dts/socfpga.dtsi
> @@ -133,6 +133,13 @@
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  
> +					clk_0: clk_0 {
> +						compatible = "fixed-clock";
> +						#clock-cells = <0>;
> +						clock-frequency = <50000000>;
> +						clock-output-names = "clk_0-clk";
> +					};
> +
>  					osc1: osc1 {
>  						#clock-cells = <0>;
>  						compatible = "fixed-clock";
> @@ -529,11 +536,11 @@
>  				};
>  		};
>  
> -		fpga_bridge0: fpga_bridge at ff400000 {
> +		fpga_bridge0: fpga_bridge at ff200000 {
>  			compatible = "altr,socfpga-lwhps2fpga-bridge";
> -			reg = <0xff400000 0x100000>;
> +			reg = <0xff200000 0x00200000>;
>  			resets = <&rst LWHPS2FPGA_RESET>;
> -			clocks = <&l4_main_clk>;
> +			clocks = <&clk_0>;
>  		};
>

Why this change? This looks wrong and unrelated. The LWHPS2FPGA bridge
is at 0xff400000, so it is correct the way it is or not?

>  		fpga_bridge1: fpga_bridge at ff500000 {
> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
> index 155829f..f99576b 100644
> --- a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
> +++ b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
> @@ -68,6 +68,7 @@
>  		regulator-min-microvolt = <3300000>;
>  		regulator-max-microvolt = <3300000>;
>  	};
> +
>  };

???


(...)


Best regards,
Steffen

-- 
Pengutronix e.K.                           | Steffen Trumtrar            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
