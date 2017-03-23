From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 23 Mar 2017 11:28:55 +0100
Subject: [PATCH 3/6] pinctrl: armada-37xx: Add gpio support
In-Reply-To: <874lylfrw5.fsf@free-electrons.com>
References: <20161222172501.16121-1-gregory.clement@free-electrons.com>
 <20161222172501.16121-4-gregory.clement@free-electrons.com>
 <CACRpkdY_68=5oBN3TLs_ohc0gc2=yiG3qizg7MGh4F7Z+-ZzSg@mail.gmail.com>
 <874lylfrw5.fsf@free-electrons.com>
Message-ID: <CACRpkdZm9rBN==TrLFw=dMvwnu5URis4eQAG5j8OiSm=1c3EZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 12:54 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
>  On ven., d?c. 30 2016, Linus Walleij <linus.walleij@linaro.org> wrote:

>>> +       mask = BIT(offset);
>>> +
>>> +       regmap_read(info->regmap, reg, &val);
>>>
>>> +       return (val & mask) == 0;
>>
>> Use this:
>>
>> return !(val & mask);
>
> done but I could tou explain the advantage of doing it?

The other controllers do it so makes the code easier to
perceptualize.

>>> +       ret = gpiochip_add_pin_range(&info->gpio_chip, dev_name(dev), 0,
>>> +                                    pinbase, info->data->nr_pins);
>>> +       if (ret)
>>> +               return ret;
>>
>> Why do you do this?
>>
>> Why not just put the ranges into the device tree? We already support
>> this in the gpiolib core and it is helpful.
>>
>> See Documentation/devicetree/bindings/gpio/gpio.txt
>> and other DTS files for gpio-ranges.
>
> Following your review, I tried to use it but it didn't work for
> me. When the second pin controller was probed then there was collision
> for the gpio number. I tried several combination without any luck.

That sounds like a bug. Are you using dynamic GPIO number
assignments?

Yours,
Linus Walleij
