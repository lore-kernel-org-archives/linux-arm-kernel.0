From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 30 Dec 2016 10:07:01 +0100
Subject: [PATCH v7 3/5] ARM: dts: stm32: Add I2C1 support for STM32F429 SoC
In-Reply-To: <CAOAejn1zHMFNiGc-wVbbkC1-JFzG3sjnnUJogtCp9EeAkWsV5A@mail.gmail.com>
References: <1482413704-17531-1-git-send-email-cedric.madianga@gmail.com>
 <1482413704-17531-4-git-send-email-cedric.madianga@gmail.com>
 <20161222191103.vzmfhnrtrzw2ivwa@pengutronix.de>
 <CAOAejn1zHMFNiGc-wVbbkC1-JFzG3sjnnUJogtCp9EeAkWsV5A@mail.gmail.com>
Message-ID: <CACRpkdaNyL2iV+risLudW=O55w81-AuEZhMwRu9NLdXpnC2r1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 23, 2016 at 2:09 PM, M'boumba Cedric Madianga
<cedric.madianga@gmail.com> wrote:
> 2016-12-22 20:11 GMT+01:00 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
>> On Thu, Dec 22, 2016 at 02:35:02PM +0100, M'boumba Cedric Madianga wrote:
>>> @@ -337,6 +350,16 @@
>>>                                       slew-rate = <2>;
>>>                               };
>>>                       };
>>> +
>>> +                     i2c1_pins_b: i2c1 at 0 {
>>> +                             pins1 {
>>> +                                     pinmux = <STM32F429_PB9_FUNC_I2C1_SDA>;
>>> +                                     drive-open-drain;
>>> +                             };
>>> +                             pins2 {
>>> +                                     pinmux = <STM32F429_PB6_FUNC_I2C1_SCL>;
>>> +                             };
>>
>> the second doesn't need the open-drain property? Why?
>
> I thought that open-drain was only needed for SDA line.
> But after double-checking I2C specification, it seems that SDA and SCL
> lines need open-drain or open-collector to perform the wired-AND
> function.

I think I2C SDA/SCL must be open drain by definition.

It also requires pull-up resistors, I guess you have these mounted on the board
so you do not need pull-up from the pin controller?

Yours,
Linus Walleij
