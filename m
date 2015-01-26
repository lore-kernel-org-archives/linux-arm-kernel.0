From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 26 Jan 2015 18:45:24 +0100
Subject: [PATCH] ARM: shmobile: R-Car Gen2: CONFIG_COMMON_CLK is always set
In-Reply-To: <54C66EF9.10103@cogentembedded.com>
References: <1422289274-20605-1-git-send-email-geert+renesas@glider.be>
 <54C66EF9.10103@cogentembedded.com>
Message-ID: <CAMuHMdVkCSWNXTfozS9oSKLB8OtHY4NUjMf3nMtDDJ-s4Co3Qw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 26, 2015 at 5:44 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
>> diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c
>> b/arch/arm/mach-shmobile/setup-rcar-gen2.c
>> index e2b9bb46393d898d..aa3339258d9c0232 100644
>> --- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
>> +++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
>> @@ -51,9 +51,7 @@ u32 rcar_gen2_read_mode_pins(void)
>>
>>   void __init rcar_gen2_timer_init(void)
>>   {
>> -#if defined(CONFIG_ARM_ARCH_TIMER) || defined(CONFIG_COMMON_CLK)
>
>
>    Is CONFIG_ARM_ARCH_TIMER always defined too? I guess not...

Nope...

("x || true" == "true")

>>         u32 mode = rcar_gen2_read_mode_pins();
>> -#endif
>>   #ifdef CONFIG_ARM_ARCH_TIMER
>
>
>    ... or you would have removed this as well?

... and if it would, that could have been a separate change ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
