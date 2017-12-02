From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 2 Dec 2017 16:55:48 +0100
Subject: [PATCH v4 03/10] dt-bindings: gpio: gpio-axp209: add pinctrl
 features
In-Reply-To: <7fdc42fd2d3572069292ebe1376bb446beb4d8a9.1512135804.git-series.quentin.schulz@free-electrons.com>
References: <cover.3ff63fdf302c6bda02ea7d160ad2aa5afee0899d.1512135804.git-series.quentin.schulz@free-electrons.com>
 <7fdc42fd2d3572069292ebe1376bb446beb4d8a9.1512135804.git-series.quentin.schulz@free-electrons.com>
Message-ID: <CACRpkdZ4P2U1tk3G8JD5a8X+hNzigTHzJFBBumzf2Rgp8ojB_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 1, 2017 at 2:44 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:

> The X-Powers AXP209 has 3 GPIOs. GPIO0/1 can each act either as a GPIO,
> an ADC or a LDO regulator. GPIO2 can only act as a GPIO.
>
> This adds the pinctrl features to the driver so GPIO0/1 can be used as
> ADC or LDO regulator.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-by: Rob Herring <robh@kernel.org>

Please add a reference to the generic pinctrl bindings and state that you
use them and how.

pinctrl/pinctrl-bindings.txt

> +The GPIOs can be muxed to other functions and therefore, must be a subnode of
> +axp_gpio.
> +
> +Example:
> +
> +&axp_gpio {
> +       gpio0_adc: gpio0-adc {
> +               pins = "GPIO0";
> +               function = "adc";
> +       };
> +};

So write explicitly that this driver employs the per-pin muxing pattern.

Yours,
Linus Walleij
