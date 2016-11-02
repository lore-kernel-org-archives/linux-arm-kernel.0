From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 2 Nov 2016 09:09:15 +0100
Subject: [PATCH v4 20/23] ARM: shmobile: rcar-gen2: Stop passing mode pins
 state to clock driver
In-Reply-To: <722d91fe-574a-8613-34ff-d44be19157be@cogentembedded.com>
References: <1477055857-17936-1-git-send-email-geert+renesas@glider.be>
 <1477055857-17936-21-git-send-email-geert+renesas@glider.be>
 <722d91fe-574a-8613-34ff-d44be19157be@cogentembedded.com>
Message-ID: <CAMuHMdVdY6c3C+zLAhBCVvxmWD-HhTOis7rU-+_iFQkER3t3fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 1, 2016 at 2:35 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
>> --- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
>> +++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
>
> [...]
>>
>> @@ -130,7 +129,7 @@ void __init rcar_gen2_timer_init(void)
>>         iounmap(base);
>>  #endif /* CONFIG_ARM_ARCH_TIMER */
>>
>> -       rcar_gen2_clocks_init(mode);
>> +       of_clk_init(NULL);
>>         clocksource_probe();
>>  }
>>
>
>   This hunk no longer applies to devel.

Indeed, but I can't update it, as we can't have all mach-shmobile changes in
the clock tree. So Simon will have to resolve the conflict later.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
