From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 21 Nov 2014 21:22:53 +0100
Subject: [PATCHv5 05/10] arm: mvebu: define and use common Armada 370 SPI
 pinctrl settings
In-Reply-To: <a0eb580b7cc0f7cf39f1a69f0cc5747bded66300.1416598537.git.arno@natisbad.org>
References: <cover.1416598536.git.arno@natisbad.org>
 <a0eb580b7cc0f7cf39f1a69f0cc5747bded66300.1416598537.git.arno@natisbad.org>
Message-ID: <20141121202253.GE20238@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud

> diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
> index 90e1286d414f..f1284ae0cddd 100644
> --- a/arch/arm/boot/dts/armada-370.dtsi
> +++ b/arch/arm/boot/dts/armada-370.dtsi
> @@ -197,6 +197,20 @@
>  				status = "disabled";
>  			};
>  
> +			/*
> +			 * Default SPI pinctrl setting, can be overwritten on
> +			 * board level if a different configuration is used.
> +			 */
> +			spi0: spi at 10600 {
> +				pinctrl-0 = <&spi0_pins1>;
> +				pinctrl-names = "default";
> +			};
> +
> +			spi1: spi at 10680 {
> +				pinctrl-0 = <&spi1_pins>;
> +				pinctrl-names = "default";
> +			};
> +

Again, ordering. It looks like these should be between l2-cache and i2c0.

       Andrew
