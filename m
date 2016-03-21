From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 21 Mar 2016 08:59:30 +0100
Subject: [PATCH v7] ARM: dts: sun8i: Add leds and switches on Orangepi
 Plus boards
In-Reply-To: <1458500102-11071-1-git-send-email-hdegoede@redhat.com>
References: <1458500102-11071-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20160321075930.GA30977@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Mar 20, 2016 at 07:55:02PM +0100, Hans de Goede wrote:
> From: Krzysztof Adamski <k@japko.eu>
> 
> OrangePi Plus board has two leds - green ("pwr") and red ("status")
> and two switches ("sw4" and "sw2"). This patch describes them in
> devicetree.
> 
> Signed-off-by: Krzysztof Adamski <k@japko.eu>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

An earlier version has already been sent for 4.6, please base your
changes on top of this one.

And there's a bunch of things I didn't catch at that time :/

> ---
> Changes in v6 (hdegoede):
> -Merge leds and r_leds nodes into one
> -Fix led labels to be in <board>:<colour>:<role> form
> -Alphabetically sort the added nodes
> -Add support for sw2 (this is the small reset-like button)
> Changes in v7 (hdegoede):
> -Use PL3 / PL4 in the pinctrl node, not PL03 / PL04
> ---
>  arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts | 63 ++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
> index a680b1f..9d8c038 100644
> --- a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
> +++ b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
> @@ -45,6 +45,7 @@
>  #include "sunxi-common-regulators.dtsi"
>  
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
>  #include <dt-bindings/pinctrl/sun4i-a10.h>
>  
>  / {
> @@ -59,6 +60,43 @@
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> +	gpio_keys {
> +		compatible = "gpio-keys";
> +		input-name = "sw4";

This is an undocumented (and apparently unused) property

> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&sw_r_opc>;
> +
> +		sw2 at 0 {

You shouldn't have a unit-address here

> +			label = "sw2";
> +			linux,code = <BTN_1>;
> +			gpios = <&r_pio 0 4 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		sw4 at 0 {

Ditto.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160321/90d11ec6/attachment-0001.sig>
