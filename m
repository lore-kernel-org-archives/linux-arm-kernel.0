From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 5 Nov 2018 10:05:47 +0100
Subject: [PATCHv2] ARM: dts: sun8i-h3: Add dts for the Mapleboard MP130
In-Reply-To: <20181030221430.wu5cxicyf4ub2boa@earth.li>
References: <20181030221430.wu5cxicyf4ub2boa@earth.li>
Message-ID: <20181105090547.yuiblwnnpffykilg@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 30, 2018 at 10:14:30PM +0000, Jonathan McDowell wrote:
> +	r_gpio_keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +
> +		power {
> +			label = "mp130:power";

That was my mistake, but it was correct in your first version.

> +&pio {
> +	leds_pio: led_pins {
> +		pins = "PA15";
> +		function = "gpio_out";
> +	};
> +};
> +
> +&r_pio {
> +	leds_r_pio: led_pins {
> +		pins = "PL10";
> +		function = "gpio_out";
> +	};
> +
> +	sw_r_pio: key_pins {
> +		pins = "PL3", "PL4";
> +		function = "gpio_in";
> +	};
> +};

You don't need these nodes at all.

I've fixed both issues and applied your patch for 4.21

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181105/1f527203/attachment.sig>
