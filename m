From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 Sep 2016 10:57:27 +0200
Subject: [PATCH 1/3] dt-bindings: Add a binding for the RPi firmware GPIO
 driver.
In-Reply-To: <20160919161314.25858-1-eric@anholt.net>
References: <20160919161314.25858-1-eric@anholt.net>
Message-ID: <CACRpkdb-hRjD+FmyZ4SKurp94V=HR3L90OLNc-6eUKuy9AK_Rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2016 at 6:13 PM, Eric Anholt <eric@anholt.net> wrote:

> The RPi firmware exposes all of the board's GPIO lines through
> property calls.  Linux chooses to control most lines directly through
> the pinctrl driver, but for the FXL6408 GPIO expander on the Pi3, we
> need to access them through the firmware.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>

Aha

> +++ b/Documentation/devicetree/bindings/gpio/gpio-raspberrypi-firmware.txt
> @@ -0,0 +1,22 @@
> +Raspberry Pi power domain driver

Really? :)

> +Required properties:
> +
> +- compatible:          Should be "raspberrypi,firmware-gpio"

Usually this is vendor,compat, is the vendors name "raspberrypi"?

> +- gpio-controller:     Marks the device node as a gpio controller
> +- #gpio-cells:         Should be <2> for GPIO number and flags
> +- ngpios:              Number of GPIO lines to control.  See gpio.txt

Is this ever anything else than 8? Else omit it and hardcode
8 in the driver instead.

> +- firmware:            Reference to the RPi firmware device node

Reference the DT binding for this.

> +- raspberrypi,firmware-gpio-offset:
> +                       Number the firmware uses for the first GPIO line
> +                         controlled by this driver

Does this differ between different instances of this hardware or
can it just be open coded in the driver instead?

Yours,
Linus Walleij
