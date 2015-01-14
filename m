From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Wed, 14 Jan 2015 13:36:07 +0400
Subject: [PATCH 1/5] ARM: sa1100: split irq handling for low GPIOs
In-Reply-To: <CACRpkdavZdZuYxLW-i4BJM0hFqt73n7AhrSzUynBsuDNj5HKGg@mail.gmail.com>
References: <1419242740-20219-1-git-send-email-dbaryshkov@gmail.com>
 <CACRpkdavZdZuYxLW-i4BJM0hFqt73n7AhrSzUynBsuDNj5HKGg@mail.gmail.com>
Message-ID: <CALT56yPez2DAgh_2hy10W5h+v2u3dNq4CZufoAfxTWagMZ1uiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-01-14 12:35 GMT+03:00 Linus Walleij <linus.walleij@linaro.org>:
> On Mon, Dec 22, 2014 at 11:05 AM, Dmitry Eremin-Solenikov
> <dbaryshkov@gmail.com> wrote:
>
>> Low GPIO pins use an interrupt in SC interrupts space. However it's
>> possible to handle them as if all the GPIO interrupts are instead tied
>> to single GPIO handler, which later decodes GEDR register and
>> chain-calls next IRQ handler. So split first 11 interrupts into system
>> part (IRQ_GPIO0_SC - IRQ_GPIO10_SC) which work exactly like the rest of
>> system controller interrupts and real GPIO interrupts
>> (IRQ_GPIO0..IRQ_GPIO10). A single handler sa1100_gpio_handler then
>> decodes and calls next handler.
>>
>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>
> I applied all 5 patches and tested on the Compaq iPAQ H3600
> with some GPIO lines with IRQs and all work as before.
>
> Tested-by: Linus Walleij <linus.walleij@linaro.org>
> for all 5 patches.

Thank you!

-- 
With best wishes
Dmitry
