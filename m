From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 29 Nov 2013 21:29:37 +0100
Subject: [PATCH v7] gpio: Add MOXA ART GPIO driver
In-Reply-To: <1385723494-8033-1-git-send-email-jonas.jensen@gmail.com>
References: <1385651945-22355-1-git-send-email-jonas.jensen@gmail.com>
 <1385723494-8033-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <CACRpkdZbLJh-qDtEhA1Q4X9ABDtv5XTtd9-CkF2LTwzKnDbguA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 29, 2013 at 12:11 PM, Jonas Jensen <jonas.jensen@gmail.com> wrote:

> Add GPIO driver for MOXA ART SoCs.
>
> Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>

OK this v6 version is looking *really good* so I have
applied it, couldn't hesitate.

> +static struct gpio_chip moxart_template_chip = {
> +       .label                  = "moxart-gpio",
> +       .request                = moxart_gpio_request,
> +       .free                   = moxart_gpio_free,
> +       .direction_input        = moxart_gpio_direction_input,
> +       .direction_output       = moxart_gpio_direction_output,
> +       .set                    = moxart_gpio_set,
> +       .get                    = moxart_gpio_get,
> +       .base                   = 0,
> +       .ngpio                  = 32,
> +       .can_sleep              = 0,
> +};

No need to initialized unused fields to zero, that is by
default. But no big deal.

> +static const struct of_device_id moxart_gpio_match[] = {
> +       { .compatible = "moxa,moxart-gpio" },
> +       { }
> +};

This vendor prefix does not exist in
Documentation/devicetree/bindings/vendor-prefixes.txt
Please send a follow-up patch adding it and I can merge
that through the GPIO tree as well.

Yours,
Linus Walleij
