From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Mon, 15 Sep 2014 16:36:27 +0200
Subject: [PATCH] ARM: dts: Add Maxim 77693 PMIC to the Trats2 board
In-Reply-To: <1410523386-10581-1-git-send-email-k.kozlowski@samsung.com>
References: <1410523386-10581-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <CABxcv=mYWDVwOWbvV4xy+xS5tQUrCexCT_LD7hgUO2d3FPe56w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On Fri, Sep 12, 2014 at 2:03 PM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> +       i2c_max77693: i2c-gpio-1 {
> +               compatible = "i2c-gpio";
> +               gpios = <&gpm2 0 0>, <&gpm2 1 0 >;

Can you please include <dt-bindings/gpio/gpio.h> and use
GPIO_ACTIVE_HIGH instead of 0 here for the type/level flags?

> +               i2c-gpio,delay-us = <2>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               status = "okay";
> +
> +               max77693 at 66 {
> +                       compatible = "maxim,max77693";
> +                       interrupt-parent = <&gpx1>;
> +                       interrupts = <5 2>;
> +                       reg = <0x66>;
> +
> +                       regulators {
> +                               esafeout1_reg: esafeout at 1 {
> +                                       regulator-compatible = "ESAFEOUT1";

According to Documentation/devicetree/bindings/regulator/regulator.txt,
the "regulator-compatible" DT property has been deprecated in favor of
just using the regulator node's name.

> +                                       regulator-name = "ESAFEOUT1";
> +                               };
> +                               esafeout2_reg: esafeout at 2 {
> +                                       regulator-compatible = "ESAFEOUT2";
> +                                       regulator-name = "ESAFEOUT2";
> +                               };
> +                               charger_reg: charger at 0 {
> +                                       regulator-compatible = "CHARGER";
> +                                       regulator-name = "CHARGER";
> +                                       regulator-min-microamp = <60000>;
> +                                       regulator-max-microamp = <2580000>;
> +                               };
> +                       };
> +               };
> +       };
> +
>         mmc at 12550000 {
>                 num-slots = <1>;
>                 supports-highspeed;
>

Once those two issues are addressed, feel free to add my

Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
