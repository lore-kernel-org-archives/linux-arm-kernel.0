From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 4 Dec 2012 16:30:28 +0800
Subject: [PATCH 2/5] ARM: PXA: Zipit Z2: Add USB host and device support
In-Reply-To: <CA+E=qVfMbfh4Zx54HHbpcYPsPJiEx3T24Tv-8oaaOYK7F1CzYg@mail.gmail.com>
References: <1351438555-4668-1-git-send-email-anarsoul@gmail.com>
 <1351438555-4668-2-git-send-email-anarsoul@gmail.com>
 <201210282259.46491.marex@denx.de>
 <CA+E=qVftf+A=U5CEvkFia4LMYgeU6iF5WpKPS3FVkf1d3rABFQ@mail.gmail.com>
 <CACTFLAOwUsWbqK-R1OLNfNTnkp7Mo3hFwu78dFKT8i8goTgdKw@mail.gmail.com>
 <CA+E=qVeup8QzqAiURzEfG8a2vp_rBJ-by8FORLEzSCfkxiyjtQ@mail.gmail.com>
 <508E4F7F.7010607@gmail.com>
 <CA+E=qVcnacT8L5GkqTxdowKt2KkoEWMhd3+XBk6nKsEEDtWecg@mail.gmail.com>
 <508E5DFB.3060002@gmail.com>
 <CA+E=qVcRM834_JFZskL7DEJQ10YsYexCeY3CE67fjJk4_WJLUw@mail.gmail.com>
 <508E61E7.7090502@gmail.com>
 <CA+E=qVcJ=WLJwS49zgb_=6or7Me3LLGQtBbfzBtS-p+U6Tw-pQ@mail.gmail.com>
 <508E651A.5070009@gmail.com>
 <CA+E=qVchrOXAL+cPD0-bZKSAjgyjoEFEqajva+SPtJBPOVGE=w@mail.gmail.com>
 <509032F6.1050301@gmail.com>
 <CAN1soZyAuo4UUze9yWKTOqwJ0TC4cf+uywWo1Ypbrcq0+zez0g@mail.gmail.com>
 <CA+E=qVfi8Ko4SDDi92jRLjQ4bKtqHkhq4N7QtbiU1k7bPbWjig@mail.gmail.com>
 <CA+E=qVfMbfh4Zx54HHbpcYPsPJiEx3T24Tv-8oaaOYK7F1CzYg@mail.gmail.com>
Message-ID: <CAN1soZy-L1o3LLv85+xWEVg--PqNqvX5GVL3P-iZqWobPDOVnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 6, 2012 at 1:31 AM, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> On Sat, Nov 3, 2012 at 12:29 AM, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>
>>>
>>> I prefer to use pinctrl-single driver instead. I'm updating mmp
>>> pinctrol driver to
>>> pinctrl-single driver framework. You can find them in mailist. I'm submitting
>>> a third round in these days.
>>>
>>> Regards
>>> Haojian
>>
>> OK, one more question:
>>
>> On PXA2xx GPIO and PINMUX are not separate blocks. Each pin can be
>> either input or output and have 4 modes (gpio + 3 alternate functions)
>> == 8 states , so we have: gpio in, gpio out, 3 alt in, 3 alt out.
>> To control pin mode one should write to GPDR (direction register) and
>> GAFR (alternate function register). pxa-gpio driver controls both of
>> those registers, so does pxa2xx-mfp.
>>
>> I'm not sure what to do in this case. Should I move code controlling
>> GPDR and GAFR into some pinctrl-pxa2xx driver, and modify pxa-gpio
>> driver to use it?
>>
>> Regards
>> Vasily
>
> Daniel, Haojian, any suggestion?
>
> I'm stuck at the moment, and have no idea how to handle it...
> pinmux/gpio are connected in hardware
> and I don't see a way to handle them with 2 separate drivers (gpio and
> pinmux) in software...
>
> Regards
> Vasily

I checked the PXA25x spec. pinmux functions are contained in gpio registers.

It doesn't matter. You can still you pinmux register. You only need to control
GAFP in pinmux driver.
