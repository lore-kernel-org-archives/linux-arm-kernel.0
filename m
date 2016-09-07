From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 7 Sep 2016 22:20:52 +0200
Subject: [PATCH v2 00/10] pinctrl: exynos/samsung: Add header with values
 used for configuration
In-Reply-To: <1472714638-15676-1-git-send-email-k.kozlowski@samsung.com>
References: <1472714638-15676-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <CACRpkdZuRym=SuAiBA_UsNmKd7N5n9g=z=ZxwcEk7J0BcXDsFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have one comment though, if you're anyway making changes to all
the DTS files:

On Thu, Sep 1, 2016 at 9:23 AM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:

> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <0>;
> -               samsung,pin-drv = <0>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;

Nowadays we have standard bindings for this, see
Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt

Section "Generic pin multiplexing node content".

By patching the driver and bindings to accept also the standard
bindings with just function and pins and also adding support
for standard pin configurations like bias-disable
bias-pull-up with the old samsung,* bindings as a fallback
etc you can actually modernize the whole binding and
DTS looks to something simpler.

You will find that this is how newer platforms do it.

But it is admittedly a bigger project.

Yours,
Linus Walleij
