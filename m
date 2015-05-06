From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 6 May 2015 16:15:54 +0200
Subject: [PATCH v2 08/17] gpio: locomo: implement per-pin irq handling
In-Reply-To: <1430178954-11138-9-git-send-email-dbaryshkov@gmail.com>
References: <1430178954-11138-1-git-send-email-dbaryshkov@gmail.com>
 <1430178954-11138-9-git-send-email-dbaryshkov@gmail.com>
Message-ID: <CACRpkdZt+rjzVSqXE6MDaY5S9gezeTu+2QWu31xKsg08TpXibw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 28, 2015 at 1:55 AM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:

> LoCoMo has a possibility to generate per-GPIO edge irqs. Support for
> that was there in old locomo driver, got 'cleaned up' during old driver
> IRQ cascading cleanup and is now reimplemented. It is expected that
> SL-5500 (collie) will use locomo gpio irqs for mmc detection irq.
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Assume this will also go through MFD.

> +       irq_set_chained_handler(lg->irq, NULL);
> +       irq_set_handler_data(lg->irq, NULL);

Why is this needed? If the GPIOLIB_IRQCHIP code in
gpiolib.c is not doing this then maybe it's the core code that
needs fixing rather than having this in the driver.

Yours,
Linus Walleij
