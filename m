From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 5 Aug 2012 02:12:26 +0200
Subject: [PATCH v3 4/9] GPIO: gpio-pxa: simplify pxa_gpio_to_irq() and
 pxa_irq_to_chip()
In-Reply-To: <1343470061-16879-5-git-send-email-zonque@gmail.com>
References: <1343470061-16879-1-git-send-email-zonque@gmail.com>
 <1343470061-16879-5-git-send-email-zonque@gmail.com>
Message-ID: <CACRpkdaJhzzckg12uZrgweoOgC44VNb=0AEdp96AV2O0UM+AnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 28, 2012 at 12:07 PM, Daniel Mack <zonque@gmail.com> wrote:

> Simplify the code in gpio-pxa.c and make them based on irq_base.
> When not probed from devicetree, initialize irq_base from
> PXA_GPIO_TO_IRQ() or MMP_GPIO_TO_IRQ(), respectively, so the non-DT case
> still works.
>
> Only tested on PXA3xx.
>
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

OK:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

But:

> +#ifdef CONFIG_ARCH_PXA
> +               if (gpio_is_pxa_type(gpio_type))
> +                       irq_base = PXA_GPIO_TO_IRQ(0);
> +#endif
> +#ifdef CONFIG_ARCH_MMP
> +               if (gpio_is_mmp_type(gpio_type))
> +                       irq_base = MMP_GPIO_TO_IRQ(0);
> +#endif

Grrr. Can we think of a way to get rid of these #ifdef:s?

Yours,
Linus Walleij
