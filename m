From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Mon, 9 Mar 2015 18:00:13 +0100
Subject: [PATCH v2 04/18] clocksource: Add ARM System timer driver
In-Reply-To: <CACRpkdYnj0vTBVEEDp4isznRZ+KQuC2h+VViZr=Pt8VtEOWP-A@mail.gmail.com>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1424455277-29983-5-git-send-email-mcoquelin.stm32@gmail.com>
 <CACRpkdYnj0vTBVEEDp4isznRZ+KQuC2h+VViZr=Pt8VtEOWP-A@mail.gmail.com>
Message-ID: <CALszF6B1NV4193+az0Aep+C5R+=kn0a2HyyzU1HtfD_HnWCnRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-03-09 16:50 GMT+01:00 Linus Walleij <linus.walleij@linaro.org>:
> On Fri, Feb 20, 2015 at 7:01 PM, Maxime Coquelin
> <mcoquelin.stm32@gmail.com> wrote:
>
>> This patch adds clocksource support for ARMv7-M's System timer,
>> also known as SysTick.
>>
>> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> (...)
>> +       /* If no clock found, try to get clock-frequency property */
>> +       if (!rate) {
>> +               ret = of_property_read_u32(np, "clock-frequency", &rate);
>> +               if (ret)
>> +                       goto out_unmap;
>> +       }
>
> If this driver is only used for this one system, and if on this one system
> the clk subsystem will provide the clock rate, then there is no need
> to include this hackaround property.
>
> Alternatively there is no point including reading the frequency from
> the clk subsystem for this one system.
>
> So which one is it?

In the first version, the "clock-frequency" property handling was not here.
Rob Herring advised me to add its support, as it could be used by
simple systems not selecting CCF.

So, I don't have the name of a system where it could be useful, but I
think Rob's request make sense.

Note that I tested using the clock-frequency property before sending.

Best regards,
Maxime
>
> Yours,
> Linus Walleij
