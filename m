From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Fri, 31 Oct 2014 13:35:18 +0400
Subject: [PATCH 14/15] gpio: locomo: implement per-pin irq handling
In-Reply-To: <CACRpkdamVriR9kJSeY=LVAx7ADukT8+GpqmNH9YMnL3OKUk8iw@mail.gmail.com>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
 <1414454528-24240-15-git-send-email-dbaryshkov@gmail.com>
 <CACRpkdamVriR9kJSeY=LVAx7ADukT8+GpqmNH9YMnL3OKUk8iw@mail.gmail.com>
Message-ID: <CALT56yM7yp7N04BSk9GZOObLSxaKepy5njRHQHOe3-bRSX3yQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-10-31 11:00 GMT+03:00 Linus Walleij <linus.walleij@linaro.org>:
> On Tue, Oct 28, 2014 at 1:02 AM, Dmitry Eremin-Solenikov
> <dbaryshkov@gmail.com> wrote:
>
>> LoCoMo has a possibility to generate per-GPIO edge irqs. Support for
>> that was there in old locomo driver, got 'cleaned up' during old driver
>> IRQ cascading cleanup and is now reimplemented. It is expected that
>> SL-5500 (collie) will use locomo gpio irqs for mmc detection irq.
>>
>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>
> Please don't use open-coded IRQ handling like this, we are moving
> away from that.
>
> In Kconfig,
>
> select GPIOLIB_IRQCHIP
>
> and look at the other drivers selecting this for inspiration. There
> is even some documentation in Documentation/gpio/driver.txt
>
> You will find that it cuts down a lot of overhead from your driver
> and does everything in the right way in a central place.

Thanks, I will take a look.
[Skipped the rest of the comments mostly dedicated to gpiolib_irqchip].


-- 
With best wishes
Dmitry
