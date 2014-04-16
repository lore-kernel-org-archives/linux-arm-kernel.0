From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Wed, 16 Apr 2014 12:20:26 +0200
Subject: [PATCH 0/4] pinctrl: sirf: switch to one gpiolib and
 gpiolib_irqchip helpers
In-Reply-To: <CAGsJ_4zZQRPS6RuP2FfJyB=eskuM6A4c0XFvEwrOS=SWuJ5+Cg@mail.gmail.com>
References: <1397544229-20545-1-git-send-email-21cnbao@gmail.com>
 <CABxcv=khupV0gpnCUOPeRON_v2wcRCNkL2Ao1B5dOB9-OB0wyQ@mail.gmail.com>
 <CAGsJ_4zZQRPS6RuP2FfJyB=eskuM6A4c0XFvEwrOS=SWuJ5+Cg@mail.gmail.com>
Message-ID: <CABxcv=n0nCvWgEAYkikZ17uSCu6TrDrFKyP3e3cBa7N9VaOJCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 12:05 PM, Barry Song <21cnbao@gmail.com> wrote:
> 2014-04-16 17:54 GMT+08:00 Javier Martinez Canillas <javier@dowhile0.org>:
>> Hello Barry,
>>
>> On Tue, Apr 15, 2014 at 8:43 AM, Barry Song <21cnbao@gmail.com> wrote:
>>> From: Barry Song <Baohua.Song@csr.com>
>>>
>>> This patchset depends on Linus Walleij's "pinctrl: sirf: rename inlined accessor".
>>> and "pinctrl: sirf: switch driver to use gpiolib irqchip helpers" is rebased
>>> from Linus Walleij's patch too.
>>>
>>> Barry Song (3):
>>>   pinctrl: sirf: wrap all gpio banks into one gpio_chip
>>>   gpio: make handler_data configurable while using gpiolib_irqchip
>>>   pinctrl: sirf: move to use irq_get_handler_data
>>> Linus Walleij (1):
>>>   pinctrl: sirf: switch driver to use gpiolib irqchip helpers
>>>
>>>  drivers/gpio/gpiolib.c              |   10 +-
>>>  drivers/pinctrl/Kconfig             |    1 +
>>>  drivers/pinctrl/sirf/pinctrl-sirf.c |  264 ++++++++++++-----------------------
>>>  include/linux/gpio/driver.h         |    2 +-
>>>  4 files changed, 97 insertions(+), 180 deletions(-)
>>>
>>> --
>>> 1.7.5.4
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-gpio" in
>>> the body of a message to majordomo at vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> Maybe you can first do the parameter change to
>> gpiochip_set_chained_irqchip() and then just convert to gpiolib
>> irqchip passing the struct sirfsoc_gpio_bank pointer instead of a
>> struct gpio_chip. I think there is no need to split PATCH 2 and PATCH
>> 4 but it is up to you.
>>
>
> Javier, thanks. the reason for splitting 2 and 4 is that i don't want
> to lose the contribution of Linus for "gpiolib irqchip helpers".
> otherwise, i will be the author of the merged patch.
>

Right, I didn't notice PATCH 2 was from Linus because it didn't have
his Signed-off-by but yours (although now I notice that it was sent
with him as the author).

AFAIK you can still squash both patches and in that case the
convention is to add the original author s-o-b and then explain your
contributions on top. i.e:

From: Linus Walleij <linus.walleij@linaro.org>

This switches the SiRF pinctrl driver over to using the gpiolib
irqchip helpers simplifying some of the code.

[Baohua.Song at csr.com: move to use irq_get_handler_data]
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

But it's also OK to have split in two patches, I just asked out of curiosity :-)

Best regards,
Javier

>
>> The series looks good to me:
>>
>> Reviewed-by: Javier Martinez Canillas <javier@dowhile0.org>
>
> -barry
