From: embed3d@gmail.com (Philipp Rossak)
Date: Sun, 11 Feb 2018 23:15:02 +0100
Subject: [PATCH 1/3] arm: dts: sun6i: a31s: bpi-m2: update mmc supply nodes
In-Reply-To: <20180209175236.21215-2-embed3d@gmail.com>
References: <20180209175236.21215-1-embed3d@gmail.com>
 <20180209175236.21215-2-embed3d@gmail.com>
Message-ID: <1518387302.1342.3.camel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 09.02.2018, 18:52 +0100 schrieb Philipp Rossak:
> This patch updates the vmmc-supply properties on the mmc0 and mmc2
> node to use the allready existent regulators.
> We can now remove the sunxi-common-regulators.dtsi include since we
> don't need it anymore.
> 
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
> ?arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts | 5 ++---
> ?1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
> b/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
> index 51e6f1d21c32..a8d86211c8f3 100644
> --- a/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
> +++ b/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
> @@ -42,7 +42,6 @@
> ?
> ?/dts-v1/;
> ?#include "sun6i-a31s.dtsi"
> -#include "sunxi-common-regulators.dtsi"
> ?#include <dt-bindings/gpio/gpio.h>
> ?
> ?/ {
> @@ -118,7 +117,7 @@
> ?&mmc0 {
> ?	pinctrl-names = "default";
> ?	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_bpi_m2>;
> -	vmmc-supply = <&reg_vcc3v0>;
> +	vmmc-supply = <&reg_dcdc1>;
> ?	bus-width = <4>;
> ?	cd-gpios = <&pio 0 4 GPIO_ACTIVE_HIGH>; /* PA4 */
> ?	cd-inverted;
> @@ -132,7 +131,7 @@
> ?&mmc2 {
> ?	pinctrl-names = "default";
> ?	pinctrl-0 = <&mmc2_pins_a>;
> -	vmmc-supply = <&reg_vcc3v0>;
> +	vmmc-supply = <&reg_dcdc1>;
			^^
		this here is wrong! this should be &reg_aldo1
> ?	mmc-pwrseq = <&mmc2_pwrseq>;
> ?	bus-width = <4>;
> ?	non-removable;

Philipp
