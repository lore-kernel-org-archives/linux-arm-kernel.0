From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 16 Aug 2016 19:50:23 +0200
Subject: [PATCH v2] ARM: Add missing newline terminators to kernel messages
In-Reply-To: <1471367313.4075.167.camel@perches.com>
References: <1471354832-18456-1-git-send-email-geert+renesas@glider.be>
 <1471367313.4075.167.camel@perches.com>
Message-ID: <CAMuHMdWQae93bbrvxGBpwsw5JGCF85+KF4xZDyi=QTJaT9pWbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joe,

On Tue, Aug 16, 2016 at 7:08 PM, Joe Perches <joe@perches.com> wrote:
> On Tue, 2016-08-16 at 15:40 +0200, Geert Uytterhoeven wrote:
>> Before commit 874f9c7da9a4acbc ("printk: create pr_<level> functions"),
>> pr_*() calls without a trailing newline characters would be printed with
>> a newline character appended, both on the console and in the output of
>> the dmesg command.
>
> Hey Geert.
>
> This doesn't apply to -next as the pr_notice/pr_cont below is
> properly changed to a single pr_notice.

In which -next?

Not in next-20160816, where the patch applies cleanly.
Also not in arm/for-next.

>> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
>
> []
>> @@ -1196,7 +1196,7 @@ void __init sanity_check_meminfo(void)
>>                               pr_notice("Truncating RAM at %pa-%pa",
>>                                         &block_start, &block_end);
>>                               block_end = vmalloc_limit;
>> -                             pr_cont(" to -%pa", &block_end);
>> +                             pr_cont(" to -%pa\n", &block_end);
>>                               memblock_remove(vmalloc_limit, overlap_size);
>>                               should_use_highmem = true;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
