From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 21 Jan 2015 11:05:44 +0100
Subject: [PATCH 1/5] ARM: sa1100: add platform functions to handle PWER
 settings
In-Reply-To: <1421316574-10022-1-git-send-email-dbaryshkov@gmail.com>
References: <1421316574-10022-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <CACRpkdYww-6HbmM9uViyB6ZRp2MQnkTYz-7ZxAVN_GsRTNqaoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 15, 2015 at 11:09 AM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:

> PWER settings logically belongs neither to GPIO nor to system IRQ code.
> Add special functions to handle PWER (for GPIO and for system IRQs)
> from platform code.
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

> diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
(...)
> +int sa11x0_gpio_set_wake(unsigned int gpio, unsigned int on)
(...)
> +int sa11x0_sc_set_wake(unsigned int irq, unsigned int on)

Why are these two functions not added to any .h file?

Did you miss to commit something or are there compile
warnings about this?

Yours,
Linus Walleij
