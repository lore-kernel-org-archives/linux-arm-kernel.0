From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 06 Jan 2015 22:47:39 +0100
Subject: [PATCH v2 7/7] ARM: mvebu: Add Armada 385 Access Point Development
 Board support
In-Reply-To: <1420558100-4700-8-git-send-email-maxime.ripard@free-electrons.com>
References: <1420558100-4700-1-git-send-email-maxime.ripard@free-electrons.com>
 <1420558100-4700-8-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <54AC57FB.8000003@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,
[...]
> +				spi-flash at 0 {
> +					#address-cells = <1>;
> +					#size-cells = <1>;
> +					compatible = "st,m25p128";
> +					reg = <0>; /* Chip select 0 */
> +					spi-max-frequency = <108000000>;

The SPI flahs used on the AP board is the same that the one used on the GP board:
M25P128-VMF6P and the maximum frequency it can handle is 50MHz.

[...]

> +
> +			mdio at 72004 {
> +				pinctrl-names = <&mdio_pins>;
> +
> +				phy0: ethernet-phy at 0 {
Why don't you use the PHY address after the '@' ?
Here I expected something like
phy0: ethernet-phy at 1 {

> +					reg = <1>;
> +				};
> +
> +				phy1: ethernet-phy at 1 {
and here:
phy0: ethernet-phy at 6 {
> +					reg = <6>;
> +				};
> +
> +				phy2: ethernet-phy at 2 {
and here:
phy0: ethernet-phy at 4 {
> +					reg = <4>;
> +				};
> +			};


Thanks,

Gregory



-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
