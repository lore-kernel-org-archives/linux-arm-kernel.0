From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 5 Sep 2017 13:09:17 +0200
Subject: [PATCH v8] arm64: allwinner: h5: add NanoPi NEO Plus2 DT support
In-Reply-To: <20170904143014.46904-1-antony@phenome.org>
References: <20170824231716.2623-1-antony@phenome.org>
 <20170904143014.46904-1-antony@phenome.org>
Message-ID: <20170905110917.pjf22akyqiytx3iu@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antony,

Almost good, I'm sorry I missed a few things before.

On Mon, Sep 04, 2017 at 04:30:14PM +0200, Antony Antony wrote:
> +&mmc1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc1_pins_a>;
> +	vmmc-supply = <&reg_vcc3v3>;
> +	vqmmc-supply = <&reg_vcc3v3>;
> +	mmc-pwrseq = <&wifi_pwrseq>;
> +	bus-width = <4>;
> +	non-removable;
> +	status = "okay";

Please add a new line here.

> +	brcmf: wifi at 1 {
> +		reg = <1>;
> +		compatible = "brcm";

This should be the actual compatible, not just the vendor.

> +	};
> +};
> +
> +&mmc2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc2_8bit_pins>;
> +	vmmc-supply = <&reg_vcc3v3>;
> +	bus-width = <8>;
> +	non-removable;
> +	cap-mmc-hw-reset;
> +	boot_device = <0>;

that property should still be removed.

> +&r_pio {
> +	leds_r_npi: led_pins at 0 {
> +		pins = "PL10";
> +		function = "gpio_out";
> +	};
> +
> +	vdd_cpux_r_npi: regulator_pins at 0 {
> +		allwinner,pins = "PL6";
> +		allwinner,function = "gpio_out";
> +		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +	};
> +};

And these must be left out.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170905/29fa07d0/attachment.sig>
