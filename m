From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 30 Dec 2016 09:01:22 +0100
Subject: [PATCH 5/6] ARM: dts: TS-4600: add NBUS support
In-Reply-To: <20161214231237.17496-6-sebastien.bourdelin@savoirfairelinux.com>
References: <20161214231237.17496-1-sebastien.bourdelin@savoirfairelinux.com>
 <20161214231237.17496-6-sebastien.bourdelin@savoirfairelinux.com>
Message-ID: <CACRpkdbLnDEo-7k1rsD6NT6U165CHjTyZwT9eqv+w7MVHYgNEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 15, 2016 at 12:12 AM, Sebastien Bourdelin
<sebastien.bourdelin@savoirfairelinux.com> wrote:

> This commit enables the NBUS on the TS-4600, using the ts-nbus driver.
>
> Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>

> +       nbus {
> +               compatible = "technologic,ts-nbus", "simple-bus";
> +               pinctrl-0 = <&nbus_pins>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               pwms = <&pwm 2 83>;
> +               data-gpios   = <&gpio0 0 GPIO_ACTIVE_HIGH
> +                               &gpio0 1 GPIO_ACTIVE_HIGH
> +                               &gpio0 2 GPIO_ACTIVE_HIGH
> +                               &gpio0 3 GPIO_ACTIVE_HIGH
> +                               &gpio0 4 GPIO_ACTIVE_HIGH
> +                               &gpio0 5 GPIO_ACTIVE_HIGH
> +                               &gpio0 6 GPIO_ACTIVE_HIGH
> +                               &gpio0 7 GPIO_ACTIVE_HIGH>;
> +               csn-gpios    = <&gpio0 16 GPIO_ACTIVE_HIGH>;
> +               txrx-gpios   = <&gpio0 24 GPIO_ACTIVE_HIGH>;
> +               strobe-gpios = <&gpio0 25 GPIO_ACTIVE_HIGH>;
> +               ale-gpios    = <&gpio0 26 GPIO_ACTIVE_HIGH>;
> +               rdy-gpios    = <&gpio0 21 GPIO_ACTIVE_HIGH>;

devm_gpiod_get(&pdev->dev, "csn", GPIOD_OUT_HIGH); etc will get these
from the spawned
platform device.

Yours,
Linus Walleij
