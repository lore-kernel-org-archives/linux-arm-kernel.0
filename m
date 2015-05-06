From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Wed, 6 May 2015 19:42:33 +0300
Subject: [PATCH v2 08/17] gpio: locomo: implement per-pin irq handling
In-Reply-To: <CACRpkdZt+rjzVSqXE6MDaY5S9gezeTu+2QWu31xKsg08TpXibw@mail.gmail.com>
References: <1430178954-11138-1-git-send-email-dbaryshkov@gmail.com>
 <1430178954-11138-9-git-send-email-dbaryshkov@gmail.com>
 <CACRpkdZt+rjzVSqXE6MDaY5S9gezeTu+2QWu31xKsg08TpXibw@mail.gmail.com>
Message-ID: <CALT56yNJutWTW5zsos+=Uh+BDvO4o_tqBEj+H621TncVK6eD_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-06 17:15 GMT+03:00 Linus Walleij <linus.walleij@linaro.org>:
> On Tue, Apr 28, 2015 at 1:55 AM, Dmitry Eremin-Solenikov
> <dbaryshkov@gmail.com> wrote:
>
>> LoCoMo has a possibility to generate per-GPIO edge irqs. Support for
>> that was there in old locomo driver, got 'cleaned up' during old driver
>> IRQ cascading cleanup and is now reimplemented. It is expected that
>> SL-5500 (collie) will use locomo gpio irqs for mmc detection irq.
>>
>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for review of the patches.

> Assume this will also go through MFD.
>
>> +       irq_set_chained_handler(lg->irq, NULL);
>> +       irq_set_handler_data(lg->irq, NULL);
>
> Why is this needed? If the GPIOLIB_IRQCHIP code in
> gpiolib.c is not doing this then maybe it's the core code that
> needs fixing rather than having this in the driver.

I have skimmed through the rest of drivers using
gpiochip_set_chained_irqchip(). Indeed none of the drivers NULL
the chained handled and handler data. However I couldn't locate
the code where they would be cleared.

Should I still send the patch fixing the GPIOLIB_IRQCHIP?

>
> Yours,
> Linus Walleij



-- 
With best wishes
Dmitry
