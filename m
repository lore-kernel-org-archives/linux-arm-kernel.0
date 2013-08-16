From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 16 Aug 2013 14:51:22 +0200
Subject: [PATCH v3 2/3] ARM: bcm281xx: Device Tree bindings for GPIO driver
In-Reply-To: <1374870345-8276-3-git-send-email-markus.mayer@linaro.org>
References: <1374870345-8276-1-git-send-email-markus.mayer@linaro.org>
 <1374870345-8276-3-git-send-email-markus.mayer@linaro.org>
Message-ID: <CACRpkdbjtO_chMhrywXDbqztmuQv4abJpg-QVfuVZh9JGGdLaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 10:25 PM, Markus Mayer <markus.mayer@linaro.org> wrote:

> --- a/arch/arm/boot/dts/bcm11351.dtsi
> +++ b/arch/arm/boot/dts/bcm11351.dtsi
> @@ -63,6 +63,22 @@
>                 clock-frequency = <32768>;
>         };
>
> +       gpio: gpio at 35003000 {
> +               compatible = "brcm,kona-gpio";
> +               reg = <0x35003000 0x800>;
> +               interrupts =
> +                      <0x0 106 0x4
> +                       0x0 115 0x4
> +                       0x0 114 0x4
> +                       0x0 113 0x4
> +                       0x0 112 0x4
> +                       0x0 111 0x4>;
> +               #gpio-cells = <2>;
> +               #interrupt-cells = <2>;
> +               gpio-controller;
> +               interrupt-controller;
> +       };

Do this:

#include <dt-bindings//interrupt-controller/irq.h>
#include <dt-bindings/interrupt-controller/arm-gic.h>

Rewrite like this:

+               interrupts =
+                      <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH
+                       GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH

As you can see we can now understand the dts file.

Possibly this should also be done in the examples.

Yours,
Linus Walleij
