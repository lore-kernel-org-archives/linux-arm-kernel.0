From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 15 Feb 2013 10:06:18 +0100
Subject: [PATCH v8 04/12] pinctrl: verify whether gpio chip overlapps range
In-Reply-To: <CAD6h2NTSqMB8EQKdzZJHm3jN5eS=7TTejHNLQSNjWGSqqeS=dA@mail.gmail.com>
References: <1360602659-4774-1-git-send-email-haojian.zhuang@linaro.org>
 <1360602659-4774-5-git-send-email-haojian.zhuang@linaro.org>
 <CACRpkdaU2mWQa3qMmLKmxF5zxTq40zD30KyxdotagjjWUvopzg@mail.gmail.com>
 <CAD6h2NTSqMB8EQKdzZJHm3jN5eS=7TTejHNLQSNjWGSqqeS=dA@mail.gmail.com>
Message-ID: <CACRpkdYWSq2rqhLWcjGSKiUa2+ujChg64r1EWeRSJKhHvSy6uA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 14, 2013 at 6:01 PM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:
> On 14 February 2013 23:23, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Mon, Feb 11, 2013 at 6:10 PM, Haojian Zhuang
>> <haojian.zhuang@linaro.org> wrote:
>>
>>>  /**
>>> + * pinctrl_overlapped_gpio_range() - check if the GPIO chip of a certain GPIO
>>> + * pin is overlapped with gpio range.
>>> + * @gpio: gpio pin to check taken from the global GPIO pin space
>>> + *
>>> + * This function is complement of pinctrl_match_gpio_range(). If the return
>>> + * value of pinctrl_match_gpio_range() is NULL, this function could be used
>>> + * to check whether pinctrl device is ready or not. Maybe some GPIO pins
>>> + * don't have back-end pinctrl interface.
>>> + * If the return value is true, it means that pinctrl device is ready & the
>>> + * certain GPIO pin doesn't have back-end pinctrl device. If the return value
>>> + * is false, it means that pinctrl device may not be ready.
>>> + */
>>> +static bool pinctrl_overlapped_gpio_range(unsigned gpio)
>>
>> The name of this function confuses me, can we name it something
>> like:
>>
>> pinctrl_gpio_is_in_some_chip_but_no_range()
>>
>> Which is actually what you test, right?
>>
> How about pinctrl_match_gpio_range_exclude_some_pins()?

Actually I get ever more confused by this patch, I just don't understand
it. :-(

Something will need to be expanded on here or I will be unable to
maintaine the code, sorry for being a slow learner...

By the way:
Nowaday the recommended practice is to register a GPIO chip,
then add ranges using gpiochip_add_pin_range() in the non-DT
case. Doesn't that create a race window when the above code will
not behave as expected, e.g. between registration of the gpio
chip, the pin controller and the ranges? I guess the code assumes
that *all* initialization is complete?

Yours,
Linus Walleij
