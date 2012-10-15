From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 15 Oct 2012 14:10:15 +0000
Subject: [PATCH 2/2] Documentation: Describe Device Tree bindings for GPIO
 Regulator driver
In-Reply-To: <1350307020-5910-2-git-send-email-lee.jones@linaro.org>
References: <1350307020-5910-1-git-send-email-lee.jones@linaro.org>
 <1350307020-5910-2-git-send-email-lee.jones@linaro.org>
Message-ID: <201210151410.16516.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 15 October 2012, Lee Jones wrote:
> diff --git a/Documentation/devicetree/bindings/regulator/gpio-regulator.txt b/Documentation/devicetree/bindings/regulator/gpio-regulator.txt
> new file mode 100644
> index 0000000..5f77ee0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/gpio-regulator.txt
> @@ -0,0 +1,25 @@
> +GPIO controlled regulators
> +
> +Required properties:
> +- compatible            : Must be "regulator-gpio".
> +
> +Optional properties:
> +- gpio-enable           : GPIO to use to enable/disable the regulator.
> +- startup-delay-us      : Startup time in microseconds.
> +- enable-active-high    : Polarity of GPIO is active high (default is low).
> +
> +Any property defined as part of the core regulator binding defined in
> +regulator.txt can also be used.
> +
> +Example:
> +
> +       mmciv: gpio-regulator {
> +               compatible = "regulator-gpio";
> +               regulator-name = "mmci-gpio-supply";
> +               regulator-min-microvolt = <1800000>;
> +               regulator-max-microvolt = <2600000>;
> +               gpio = <&gpio0 24 0x4>;
> +               startup-delay-us = <100000>;
> +               enable-active-high;
> +               regulator-boot-on;
> +       };

The example doesn't match the documentation for the name of the gpio property
("gpio" vs. "gpio-enable"). I think the convention is to use "gpios".

Shouldn't this property be mandatory? I think there is little point in
defining a gpio-regulator without a gpio line attached to it.

Finally, the "enable-active-high" looks redundant, as that is something
that is normally encoded in the "gpios" property.

	Arnd
