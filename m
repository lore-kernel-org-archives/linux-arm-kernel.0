From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 29 May 2014 11:38:27 +0200
Subject: [PATCH v2] ARM: realview: basic device tree implementation
In-Reply-To: <6096979.7R8fyMRDdE@wuerfel>
References: <1399586896-16906-1-git-send-email-linus.walleij@linaro.org>
 <5057707.jNCXlqf9dH@wuerfel>
 <CACRpkdZX=UFhMfUn68hA+s2FLGRYy_dmjRng_fHtAQEhah0oRA@mail.gmail.com>
 <6096979.7R8fyMRDdE@wuerfel>
Message-ID: <CACRpkdajvFMwmW=KUE_eb2g9BNA_KPsWJQLp1Vda09qUDUU-9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 22, 2014 at 10:35 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 22 May 2014 20:52:38 Linus Walleij wrote:
>> On Thu, May 22, 2014 at 5:49 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Thursday 22 May 2014 15:45:03 Catalin Marinas wrote:
>>
>> >> Anyway, I don't think we have any streaming DMA used on these RealView
>> >> boards.
>> >
>> > Yes, I think that is correct. MMCI, SSP and serial could all use
>> > DMA but are not configured to do it.
>>
>> PB1176 has no working DMA (borked DMA hardware), the PB11MPCore
>> actually has working DMA but only on UART TX and maybe AACI
>> (haven't tested) no clue about the Cortex boards PBA8 and PBX though.
>
> I don't see any DMA data passed to the pl011 driver for PB11MPCore
> or any other realview board, so even if it works, we don't use it.

No I was more saying it works in theory... and we actually have
patches to enable it for e.g. memcpy on Versatile and PB11MP
that I floated at times, Russell also experimented around with it.

> The AACI driver doesn't seem to support DMA.

Nope, but the hardware does.

> PBA8 and PBX don't need the hack because they don't have a broken
> l2x0.

True!

Yours,
Linus Walleij
