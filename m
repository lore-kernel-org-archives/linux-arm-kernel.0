From: olof@lixom.net (Olof Johansson)
Date: Tue, 11 Sep 2012 22:41:17 -0700
Subject: [PATCH] watchdog: ks8695: sink registers into driver
In-Reply-To: <CACRpkdafmJ+CbaK=PtVwd6pGyBH8U8w-OV+QLWop=_NgyTCisw@mail.gmail.com>
References: <1347342495-6990-1-git-send-email-linus.walleij@linaro.org>
 <20120911104959.GF27604@spo001.leaseweb.com>
 <CACRpkdafmJ+CbaK=PtVwd6pGyBH8U8w-OV+QLWop=_NgyTCisw@mail.gmail.com>
Message-ID: <CAOesGMgpgdG5YR2NAqO4vrc+Eo1HX2b+Gf=PpAdD20uB2_Pryg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2012 at 10:52 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Tue, Sep 11, 2012 at 12:49 PM, Wim Van Sebroeck <wim@iguana.be> wrote:
>
>> Hi Linus,
>>> Commit 70adc3f32adc2fb90b0107c020678588e4cf9f51
>>> "ARM: ks8695: merge the timer header into the timer driver"
>>> accidentally broke the ks8695 watchdog since it was using
>>> the timer registers in watchdog mode.
>>>
>>> Perform the same operation here: push the registers down
>>> into the driver, so it is self-contained, and we can keep
>>> depopulating the <mach/*> namespace.
>>>
>>> Reported-by: Olof Johansson <olof@lixom.net>
>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>> ---
>>> Requesting an ACK from the watchdog maintainer so we can
>>> merge this through the ARM SoC tree where the regression
>>> was introduced.
>>>
>>> And yes, the drive needs to take resources and ioremap(),
>>> but that is another patch.
>>
>> Acked-by: Wim Van Sebroeck <wim@iguana.be>
>
> Thanks, Olof/Arnd: can you pick this single patch to the
> ks8695/timer branch?

Done, thanks for the follow-up.

-Olof
