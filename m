From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 6 Mar 2015 10:35:50 +0100
Subject: [PATCH v2 10/18] dt-bindings: Document the STM32 pin controller
In-Reply-To: <1424455277-29983-11-git-send-email-mcoquelin.stm32@gmail.com>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1424455277-29983-11-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <CACRpkdZOz99bttSpTNQiazcLb1ts-YQyuhp4Kpevgq4mV8N6sw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I saw this other thing:

On Fri, Feb 20, 2015 at 7:01 PM, Maxime Coquelin
<mcoquelin.stm32@gmail.com> wrote:

> This adds documentation of device tree bindings for the
> STM32 pin controller.
>
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
(...)
> +- altmode : Should be mode or alternate function number associated this pin, as
> +described in the datasheet (IN, OUT, ALT0...ALT15, ANALOG)

We can now describe muxing (altmodes etc) in two ways as described
in the generic bindings in
Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt

This is done by strings combining a function with N groups.

We are also discussing having a single config number setting up
all and keeping down the size of the DTB (which
is close to what you're doing here). Please take part in that
discussion to standardize such bindings. Sascha Hauer and
others are involved, don't know the exact topic right now but
it involved using a single "pinmux" parameter in the device treel.

All agree on using the standardized pin config bindings henceforth
so start by migrating to these.

Yours,
Linus Walleij
