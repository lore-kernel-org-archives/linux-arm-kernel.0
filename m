From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 4 Feb 2015 19:40:09 +0100
Subject: [PATCH v2 2/5] ARM: shmobile: r8a7740: Migrate to generic l2c OF
 initialization
In-Reply-To: <2328848.sGW6KXzxun@wuerfel>
References: <1423059315-28519-1-git-send-email-geert+renesas@glider.be>
 <3598552.qKIyokxIlF@wuerfel>
 <CAMuHMdU-GahSaQj6v2Yhmxsj8gmt1sbwrPfqm=ydMCc=uDcenA@mail.gmail.com>
 <2328848.sGW6KXzxun@wuerfel>
Message-ID: <CAMuHMdVX1xn01HcV=E2bC+bmLppKYCbyCxq2QBkssN_mmcYzLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wed, Feb 4, 2015 at 7:33 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 04 February 2015 18:04:57 Geert Uytterhoeven wrote:
>> On Wed, Feb 4, 2015 at 5:36 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Wednesday 04 February 2015 15:43:43 Geert Uytterhoeven wrote:
>> >>
>> >> Indeed. Note that I only try to preserve the register value before and after
>> >> migrating to generic l2c OF initialization. I did read (part of) the pl310
>> >> documentation, but it's still not clear to me if we really need
>> >> L2C_AUX_CTRL_SHARED_OVERRIDE. Perhaps this was just copied from
>> >> somewhere else without much afterthought?
>> >
>> > Have you checked what the hardware/bootloader actually sets in that bit?
>>
>> Yes, it boots with 0x02040000, i.e. L2C_AUX_CTRL_SHARED_OVERRIDE
>> (bit 22) is not set.
>>
>> After the l2c driver is finished with it, it contains 0x46440001.
>
> I see. I guess someone understand the effect of this flag.
> Does it make a difference on the machine you are looking at?

Nope. I booted it without, too. No obvious differences.

> I've read the spec at http://infocenter.arm.com/help/topic/com.arm.doc.ddi0246a/DDI0246A_l2cc_pl310_r0p0_trm.pdf
> on the topic but couldn't make sense of it to understand whether a
> particular setting might be required for specific hardware or might
> be a performance optimization.

Thanks! Ah, so I'm not alone...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
