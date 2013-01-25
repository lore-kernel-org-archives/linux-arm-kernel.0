From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 25 Jan 2013 10:59:49 +0100
Subject: [PATCH 04/10] gpio: pxa: use platform data for gpio inverted
In-Reply-To: <1358929554-32265-5-git-send-email-haojian.zhuang@linaro.org>
References: <1358929554-32265-1-git-send-email-haojian.zhuang@linaro.org>
 <1358929554-32265-5-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkdYH9u3q7OFKk01-RGX4mFXzxF8AHxa2Tm=8bj=atBzGnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 23, 2013 at 9:25 AM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> Avoid to judge whether gpio is inverted by identifying cpu in gpio
> driver. Move this into platform data of gpio driver.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

(...)
> +++ b/drivers/gpio/gpio-pxa.c
> @@ -71,6 +71,7 @@ struct pxa_gpio_chip {
>         struct gpio_chip chip;
>         void __iomem    *regbase;
>         unsigned int    irq_base;
> +       unsigned int    inverted;
>         char label[10];

I would use bool for this.

(No big deal, but if you want to nitpick..)

Yours,
Linus Walleij
