From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Aug 2015 17:00:57 +0200
Subject: [PATCH 7/9] ARM: dts: sun5i: add SPI pins on A13 and A10s
In-Reply-To: <90730047894f6ec84cd70062a27b7085c2016260.1440080122.git.hramrach@gmail.com>
References: <cover.1440080122.git.hramrach@gmail.com>
 <90730047894f6ec84cd70062a27b7085c2016260.1440080122.git.hramrach@gmail.com>
Message-ID: <20150820150057.GY30520@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 20, 2015 at 02:19:47PM -0000, Michal Suchanek wrote:
> According to datasheet some pins are available on A10s only while others
> are shared with A13.
> 
> Signed-off-by: Michal Suchanek <hramrach@gmail.com>
> ---
> This time add all spi pins and make the CS pins separate as is seen with
> current sun4i DTs
> ---
>  arch/arm/boot/dts/sun5i-a10s.dtsi | 21 +++++++++++++++++
>  arch/arm/boot/dts/sun5i.dtsi      | 49 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 70 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
> index f11efb7..d9610fa 100644
> --- a/arch/arm/boot/dts/sun5i-a10s.dtsi
> +++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
> @@ -201,6 +201,27 @@
>  		allwinner,drive = <SUN4I_PINCTRL_30_MA>;
>  		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>  	};
> +
> +	spi1_cs1_pins_a: spi1_cs1 at 0 {
> +		allwinner,pins = "PG13";
> +		allwinner,function = "spi1";
> +		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +	};
> +
> +	spi2_pins_a: spi2 at 0 {
> +		allwinner,pins = "PB12", "PB13", "PB14";
> +		allwinner,function = "spi1";
> +		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +	};
> +
> +	spi2_cs0_pins_a: spi2_cs0 at 0 {
> +		allwinner,pins = "PB11";
> +		allwinner,function = "spi1";
> +		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +	};

spi2 nodes with spi1 function ??? How can that even work?

>  };
>  
>  &sram_a {
> diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
> index 54b0978..7d32d49 100644
> --- a/arch/arm/boot/dts/sun5i.dtsi
> +++ b/arch/arm/boot/dts/sun5i.dtsi
> @@ -516,6 +516,55 @@
>  				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
>  				allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
>  			};
> +
> +			spi0_pins_a: spi0 at 0 {
> +				allwinner,pins = "PC00", "PC01", "PC02";
> +				allwinner,function = "spi0";
> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +			};
> +
> +			spi0_cs0_pins_a: spi0_cs0 at 0 {
> +				allwinner,pins = "PC03";
> +				allwinner,function = "spi0";
> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +			};
> +
> +			spi1_pins_a: spi1 at 0 {
> +				allwinner,pins = "PG10", "PG11", "PG12";
> +				allwinner,function = "spi1";
> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +			};
> +
> +			spi1_cs0_pins_a: spi1_cs0 at 0 {
> +				allwinner,pins = "PG09";
> +				allwinner,function = "spi1";
> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +			};
> +
> +			spi2_pins_b: spi2 at 1 {
> +				allwinner,pins = "PE01", "PE02", "PE03";
> +				allwinner,function = "spi2";
> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +			};
> +
> +			spi2_cs0_pins_b: spi2_cs1 at 1 {
> +				allwinner,pins = "PE00";
> +				allwinner,function = "spi2";
> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +			};
> +
> +			spi2_cs1_pins_a: spi2_cs1 at 0 {
> +				allwinner,pins = "PB10";
> +				allwinner,function = "spi2";
> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +			};

Please only add the pins you intend to use.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150820/04bcd02f/attachment.sig>
