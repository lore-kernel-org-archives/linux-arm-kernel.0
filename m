From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 25 Oct 2015 11:39:15 +0100
Subject: Build regressions/improvements in v4.3-rc7
In-Reply-To: <CAMuHMdX9X8SRCA4K++LvRz1sK3Ewyj5wKbvrdAy06L6v2XTduA@mail.gmail.com>
References: <1445767971-22415-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdX9X8SRCA4K++LvRz1sK3Ewyj5wKbvrdAy06L6v2XTduA@mail.gmail.com>
Message-ID: <CAMuHMdUkNad7-zHSEfy__rPXKV2t0_7O+MtHiW1hUN=t30KWoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 25, 2015 at 11:18 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Sun, Oct 25, 2015 at 11:12 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> JFYI, when comparing v4.3-rc7[1] to v4.3-rc6[3], the summaries are:
>>   - build errors: +12/-4

>   + /home/kisskb/slave/src/arch/arm/kernel/patch.c: error: 'L_PTE_DIRTY' undeclared (first use in this function):  => 39:2
>   + /home/kisskb/slave/src/arch/arm/kernel/patch.c: error: 'L_PTE_MT_WRITEBACK' undeclared (first use in this function):  => 39:2
>   + /home/kisskb/slave/src/arch/arm/kernel/patch.c: error: 'L_PTE_PRESENT' undeclared (first use in this function):  => 39:2
>   + /home/kisskb/slave/src/arch/arm/kernel/patch.c: error: 'L_PTE_XN' undeclared (first use in this function):  => 39:2
>   + /home/kisskb/slave/src/arch/arm/kernel/patch.c: error: 'L_PTE_YOUNG' undeclared (first use in this function):  => 39:2

Caused by:

commit ab0615e2d6fb074764a3e4d05f1326fa2fdb4627
Author: Rabin Vincent <rabin@rab.in>
Date:   Thu Apr 24 23:28:57 2014 +0200

    arm: use fixmap for text patching when text is RO

Should the call to set_fixmap() in arch/arm/kernel/patch.c
just be protected by #ifdef CONFIG_MMU?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
