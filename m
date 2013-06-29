From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sat, 29 Jun 2013 10:34:27 +0200
Subject: [PATCH] of: Specify initrd location using 64-bit
In-Reply-To: <51CE1F92.3070802@ti.com>
References: <1371775956-16453-1-git-send-email-santosh.shilimkar@ti.com>
 <51C4171C.9050908@linutronix.de> <51C48B5A.2040404@ti.com>
 <51CCA67C.2010803@gmail.com>
 <CACxGe6vOH0sCFVVXrYqD3dbYdOvithVu7-d1cvy5885i8x_Myw@mail.gmail.com>
 <20130628134931.GD21034@game.jcrosoft.org>
 <51CE1F92.3070802@ti.com>
Message-ID: <CAMuHMdWjaakS-hvor7Ftyr=g-iF2kbrLryn_+YFXDDN5tS_QOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 29, 2013 at 1:43 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
>>>>> Rob,
>>>>> Are you ok with phys_addr_t since your concern was about rest
>>>>> of the memory specific bits of the device-tree code use u64 ?
>>>>
>>>> No. I still think it should be u64 for same reasons I said originally.
>>>
>>> +1
>>>
>> +1
>>
>> fix type
>>
> Apart from waste of 32bit, what is the other concern you
> have ? I really want to converge on this patch because it
> has been a open ended discussion for quite some time. Does
> that really break any thing on x86 or your concern is more
> from semantics of the physical address.

As the "original reasons" were not in this thread, I had to search a bit.
I suppose you mean this one: https://lkml.org/lkml/2012/9/13/544 ?

Summarized:
| The address to load the initrd is decided by the bootloader/user and set
| at that point later in time.
| The dtb should not be tied to the kernel you are booting.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
