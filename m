From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 26 Oct 2015 14:41:38 +0100
Subject: [PATCH v2 8/9] ARM: dts: Add leds support to STM32F429 Discovery
 board
In-Reply-To: <1445102604-11502-9-git-send-email-mcoquelin.stm32@gmail.com>
References: <1445102604-11502-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1445102604-11502-9-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <CACRpkdYjq9XqKM4imYsaa_HBopS7uFnbb6gf=hRZHGC4baafAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 17, 2015 at 7:23 PM, Maxime Coquelin
<mcoquelin.stm32@gmail.com> wrote:

> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
(...)
> +       leds {
> +               compatible = "gpio-leds";
> +               red {
> +                       gpios = <&gpiog 14 0>;
> +               };
> +               green {
> +                       gpios = <&gpiog 13 0>;
> +               };

I suggest you add labels to these LEDs.

label = "red-LED"
label = "green-LED"

This make things so much easier in sysfs.

Usually people also want to add a default linux,trigger to these,
like linux,default-trigger = "heartbeat"; but whatever you prefer.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
