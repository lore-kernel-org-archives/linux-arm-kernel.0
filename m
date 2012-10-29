From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 29 Oct 2012 13:07:39 +0300
Subject: [PATCH 2/5] ARM: PXA: Zipit Z2: Add USB host and device support
In-Reply-To: <508E4F7F.7010607@gmail.com>
References: <1351438555-4668-1-git-send-email-anarsoul@gmail.com>
 <1351438555-4668-2-git-send-email-anarsoul@gmail.com>
 <201210282259.46491.marex@denx.de>
 <CA+E=qVftf+A=U5CEvkFia4LMYgeU6iF5WpKPS3FVkf1d3rABFQ@mail.gmail.com>
 <CACTFLAOwUsWbqK-R1OLNfNTnkp7Mo3hFwu78dFKT8i8goTgdKw@mail.gmail.com>
 <CA+E=qVeup8QzqAiURzEfG8a2vp_rBJ-by8FORLEzSCfkxiyjtQ@mail.gmail.com>
 <508E4F7F.7010607@gmail.com>
Message-ID: <CA+E=qVcnacT8L5GkqTxdowKt2KkoEWMhd3+XBk6nKsEEDtWecg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 29, 2012 at 12:42 PM, Daniel Mack <zonque@gmail.com> wrote:
> On 29.10.2012 10:33, Vasily Khoruzhick wrote:
>> On Mon, Oct 29, 2012 at 1:58 AM, Daniel Mack <zonque@gmail.com> wrote:
>>>> Any volunteers? :) It requires huge amount of work,
>>>
>>> Well, it's actually quite straight forward. With the changes that got merged
>>> to 3.7, pxa3xx platforms boot, and I also ported some pxa specific
>>> peripheral drivers that should work for both 2xx and 3xx. Adding CPU support
>>> for 27x should also just be a matter of some extra lines.
>>>
>>> So I would clearly say you should give the DT approach a try first and see
>>> which bits are missing. And I would vote for not taking any new features for
>>> the legacy board support files but just bugfixes.
>>
>> Fair enough, I'll resend series without USB stuff (so it'll contain
>> only bugfixes)
>
> I rather wanted to encourage you to work on the PXA2xx DT stuff :)

I'm not refusing to work on PXA2xx DT stuff, just want to get bugfixes in place,
some of them are serious enough (like fixing oops on poweroff)

> Please have a quick look at arch/arm/mach-pxa/pxa-dt.c - what it takes
> for basic 270 support is just copying the logic that is there already
> for the 3xx models.

Sure, but I need to get DT-capable bootloader working on Z2 in first
place, right?

> Some parts like the uart, host-mode usb, mmc, gpio-leds, gpio-keys, i2c
> etc are already finished and should work instantly. What's missing is
> the spi controller and the display, but maybe you can help getting these
> done?

What about libertas? I still don't understand how DT handles platform-specific
callbacks like set_power(). And what about pm_power_off hook?

Regards
Vasily
