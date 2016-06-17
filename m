From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 17 Jun 2016 18:19:58 +0200
Subject: [PATCH v4 03/13] soc: renesas: rcar-sysc: Make rcar_sysc_init()
 init the PM domains
In-Reply-To: <CAO3366zM=x5HSOMZ6WqEhTr5piQQdSV6vnr7qE48c=Bvm612LQ@mail.gmail.com>
References: <1466072862-28030-1-git-send-email-geert+renesas@glider.be>
 <1466072862-28030-4-git-send-email-geert+renesas@glider.be>
 <CAO3366zM=x5HSOMZ6WqEhTr5piQQdSV6vnr7qE48c=Bvm612LQ@mail.gmail.com>
Message-ID: <CAMuHMdXm63mXvhAmjcNg-jLavB0s5Vsq1Jg49Zaxv2Q2MptpmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulrich,

On Fri, Jun 17, 2016 at 5:57 PM, Ulrich Hecht <ulrich.hecht@gmail.com> wrote:
>> --- a/drivers/soc/renesas/rcar-sysc.c
>> +++ b/drivers/soc/renesas/rcar-sysc.c
>> @@ -164,15 +164,6 @@ static bool rcar_sysc_power_is_off(const struct rcar_sysc_ch *sysc_ch)
>>         return false;
>>  }
>>
>> -void __iomem *rcar_sysc_init(phys_addr_t base)
>> -{
>> -       rcar_sysc_base = ioremap_nocache(base, PAGE_SIZE);
>> -       if (!rcar_sysc_base)
>> -               panic("unable to ioremap R-Car SYSC hardware block\n");
>
> Is this check no longer necessary?

If this failed (out of memory) this early in the boot process, we're gonna die
anyway.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
