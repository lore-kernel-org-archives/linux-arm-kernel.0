From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 25 Jan 2013 11:01:25 +0100
Subject: [PATCH 05/10] gpio: pxa: remove gpio_type
In-Reply-To: <1358929554-32265-6-git-send-email-haojian.zhuang@linaro.org>
References: <1358929554-32265-1-git-send-email-haojian.zhuang@linaro.org>
 <1358929554-32265-6-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkdYj3Bm0GKhdvcmvwu4mz3YLTnyaOWjGT7qt2atbZ_x2EA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 23, 2013 at 9:25 AM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> Since gpio_type is used to check whether gafr register is valid. So
> move it into platform data.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

(...)

> +++ b/drivers/gpio/gpio-pxa.c
> @@ -72,6 +72,7 @@ struct pxa_gpio_chip {
>         void __iomem    *regbase;
>         unsigned int    irq_base;
>         unsigned int    inverted;
> +       unsigned int    gafr;
>         char label[10];

Also looks like some kind of a bool.

Yours,
Linus Walleij
