From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 13 Dec 2017 08:36:39 +0100
Subject: [PATCH v5 8/9] pinctrl: axp209: add support for AXP813 GPIOs
In-Reply-To: <96bc20e3-97ca-ae76-9e35-e6af644659c7@free-electrons.com>
References: <20171205144647.17594-1-quentin.schulz@free-electrons.com>
 <20171205144647.17594-9-quentin.schulz@free-electrons.com>
 <96bc20e3-97ca-ae76-9e35-e6af644659c7@free-electrons.com>
Message-ID: <CACRpkdY8_8BZ6HJV4qE_b9-Ln6TLK_m6DNUpgoh7x61F915nJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 8, 2017 at 2:41 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:

>> -     pctl->desc = &axp20x_data;
>> +     pctl->desc = (struct axp20x_pctrl_desc *)of_device_get_match_data(dev);
>>       pctl->regmap = axp20x->regmap;
>>       pctl->dev = &pdev->dev;
>>
>
> I am using pctl->desc before retrieving it, thus dereferencing from a
> null pointer.
>
> We just have to move
> pctl->chip.ngpio                = pctl->desc->npins;
> after
> pctl->desc = (struct axp20x_pctrl_desc *)of_device_get_match_data(dev);
>
> Linus, I guess that I should send a patch to fix this or is there an
> other way not to have to apply such a small and dumb patch?

Just send a patch based on my pin control tree "devel" branch or
linux-next, it's cool.

Things like this happens all the time.

Yours,
Linus Walleij
