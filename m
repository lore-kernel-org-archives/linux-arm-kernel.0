From: rask@formelder.dk (Rask Ingemann Lambertsen)
Date: Sun, 26 Feb 2017 10:19:55 +0100
Subject: [PATCH v5 7/7] arm64: dts: sunxi: add support for the Orange Pi
 PC 2 board
In-Reply-To: <20170226011956.53581-8-icenowy@aosc.xyz>
References: <20170226011956.53581-1-icenowy@aosc.xyz>
 <20170226011956.53581-8-icenowy@aosc.xyz>
Message-ID: <20170226091955.h3f5pgk7elboxqym@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 26, 2017 at 09:19:56AM +0800, Icenowy Zheng wrote:
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
> new file mode 100644
> index 000000000000..79784cba806c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
[...]
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		pwr_led {
> +			label = "orangepi:green:pwr";
> +			gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>;
> +			default-state = "on";
> +		};
> +
> +		status_led {

IMHO, you don't need the '_led' suffix inside the 'leds' node, and then you
also avoid having underscores in the node names.

> +			label = "orangepi:red:status";
> +			gpios = <&pio 0 20 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
> +	r_gpio_keys {

Node names should not contain underscores. You can use hyphens instead. See
https://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg1122967.html
https://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg1145633.html

> +&mmc0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
> +	vmmc-supply = <&reg_vcc3v3>;
> +	bus-width = <4>;
> +	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
> +	cd-inverted;

You should be able to simplify those last two lines to just

cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */

(see the paragraph which begins with "*NOTE* on CD and WP polarity."
in 'Documentation/devicetree/bindings/mmc/mmc.txt'.)

-- 
Rask Ingemann Lambertsen
