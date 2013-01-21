From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon, 21 Jan 2013 23:24:11 +0800
Subject: [PATCH v7 03/15] gpio: use pinctrl device name for add range
In-Reply-To: <CACRpkdZoW0Pa9nMJin8_V+0_XVND4-hU=_SLkVEpskSfiYcyvg@mail.gmail.com>
References: <1358494279-16503-1-git-send-email-haojian.zhuang@linaro.org>
 <1358494279-16503-4-git-send-email-haojian.zhuang@linaro.org>
 <CACRpkdZoW0Pa9nMJin8_V+0_XVND4-hU=_SLkVEpskSfiYcyvg@mail.gmail.com>
Message-ID: <CAD6h2NRx160MHWn8zK06ZNxZZf9uvq6fZMQ-RtceB29TBteUUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 January 2013 22:20, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Jan 18, 2013 at 8:31 AM, Haojian Zhuang
> <haojian.zhuang@linaro.org> wrote:
>
>> gpiochip_add_pin_range() needs pinctrl device name as parameter.
>> Currently the parameter is pinctrl description name. So fix it.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>> ---
>>  drivers/gpio/gpiolib-of.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
>> index d542a14..25b1dbe 100644
>> --- a/drivers/gpio/gpiolib-of.c
>> +++ b/drivers/gpio/gpiolib-of.c
>> @@ -250,7 +250,7 @@ static void of_gpiochip_add_pin_range(struct gpio_chip *chip)
>>                  * on the same GPIO chip.
>>                  */
>>                 ret = gpiochip_add_pin_range(chip,
>> -                                            pinctrl_dev_get_name(pctldev),
>> +                                            pinctrl_dev_get_devname(pctldev),
>>                                              0, /* offset in gpiochip */
>>                                              pinspec.args[0],
>>                                              pinspec.args[1]);
>
> Hm looks like the right thing to do!
>
> Patch applied.
>
> It must be such that everyone using this so far has just
> set the name to be identical to the device name.
>
> Maybe we should just drop the name in the descriptor
> if it's causing problems like this?
>
> Yours,
> Linus Walleij

It seems that dropping the name won't impact any problem.
I'll try to drop it in new patches.

Regards
Haojian
