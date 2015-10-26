From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 26 Oct 2015 14:35:42 +0100
Subject: [PATCH 6/9] pinctrl: Add IRQ support to STM32 gpios
In-Reply-To: <1445102638-11575-7-git-send-email-mcoquelin.stm32@gmail.com>
References: <1445102638-11575-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1445102638-11575-7-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <CACRpkdbQcF8-hR7BP88i5GOrY8QNfxy21ANLgxuaHabzcvrKVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 17, 2015 at 7:23 PM, Maxime Coquelin
<mcoquelin.stm32@gmail.com> wrote:

> This patch adds IRQ support to STM32 gpios.
>
> The EXTI controller has 16 lines dedicated to GPIOs.
> EXTI line n can be connected to only line n of one of the GPIO ports, for
> example EXTI0 can be connected to either PA0, or PB0, or PC0...
> This port selection is done by specifying the port number into System
> Config registers.
>
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>

(...)
> +static int stm32_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
> +{
> +       struct stm32_pinctrl *pctl = dev_get_drvdata(chip->dev);
> +       struct stm32_gpio_bank *bank = gpio_chip_to_bank(chip);
> +       unsigned int virq;

I don't like when these IRQs are called "virtual" (virq), becuase all
Linux IRQs are equally virtual. It's just coincidence that sometimes
the Linux IRQ and the hardware IRQ is the same.

Just name it "irq".

Yours,
Linus Walleij
