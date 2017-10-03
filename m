From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 3 Oct 2017 20:11:59 +0200
Subject: [PATCH] ARM: head-common.S: Clear lr before jumping to
 start_kernel()
In-Reply-To: <nycvar.YSQ.7.76.1710031134140.5407@knanqh.ubzr>
References: <1507044184-27152-1-git-send-email-geert+renesas@glider.be>
 <nycvar.YSQ.7.76.1710031134140.5407@knanqh.ubzr>
Message-ID: <CAMuHMdWJKQb5JY+diH=7dqNuypkPUqBeOEPSLOrfrnbfh2siRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 3, 2017 at 5:37 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Tue, 3 Oct 2017, Geert Uytterhoeven wrote:
>
>> If CONFIG_DEBUG_LOCK_ALLOC=y, the kernel log is spammed with a few
>> hundred identical messages:
>>
>>     unwind: Unknown symbol address c0800300
>>     unwind: Index not found c0800300
>>
>> c0800300 is the return address from the last subroutine call (to
>> __memzero()) in __mmap_switched().  Apparently having this address in
>> the link register confuses the unwinder.
>>
>> To fix this, reset the link register to zero before jumping to
>> start_kernel().
>>
>> Fixes: 9520b1a1b5f7a348 ("ARM: head-common.S: speed up startup code")
>> Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Good! This fixes another similar case I had but I didn't come around to
> look at closely yet.
>
> Acked-by: Nicolas Pitre <nico@linaro.org>

Thanks!

> Please send it to RMK's patch system.

Done (I hope so ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
