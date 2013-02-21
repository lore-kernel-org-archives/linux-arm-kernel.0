From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 21 Feb 2013 20:15:27 +0100
Subject: [PATCH v3 11/12] gpio: pxa: discard irq base in pxa_gpio_chip
In-Reply-To: <1361164358-5845-12-git-send-email-haojian.zhuang@linaro.org>
References: <1361164358-5845-1-git-send-email-haojian.zhuang@linaro.org>
 <1361164358-5845-12-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkdYn7-G51w18OvOmScxFpP5bqiKZrwX_e=5tnP8XDKWH0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 18, 2013 at 6:12 AM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> Discard irq_base in struct pxa_gpio_chip. Use irq_domain instead.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
(...)
> +                       irq_base = 0;
> +               chips[i].domain = irq_domain_add_simple(pdev->dev.of_node,
> +                                                       gc->ngpio, irq_base,
> +                                                       &pxa_irq_domain_ops,
> +                                                       &chips[i]);
> +               if (!chips[i].domain)

Aha... so not at the end you fix it up :-)

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Maybe I can ACK all the others too then, if I know it will end up like
this. But I had a few other review comments.

Yours,
Linus Walleij
