From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 14 Jun 2016 15:10:52 +0200
Subject: Boot failure on emev2/kzm9d (was: Re: [PATCH v2 11/11] mm/slab:
 lockless decision to grow cache)
In-Reply-To: <CAMuHMdXC=zEjbZADE5wELjOq_kBiFNewpdUrMCe8d3Utu98h8A@mail.gmail.com>
References: <CAMuHMdXC=zEjbZADE5wELjOq_kBiFNewpdUrMCe8d3Utu98h8A@mail.gmail.com>
Message-ID: <CAMuHMdXEjxWY=0Vuu=aHupexVg1hERPnUromk-2sCjwbDn8H1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonsoo,

On Mon, Jun 13, 2016 at 9:43 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Tue, Apr 12, 2016 at 6:51 AM,  <js1304@gmail.com> wrote:
>> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>> To check whther free objects exist or not precisely, we need to grab a
>> lock.  But, accuracy isn't that important because race window would be
>> even small and if there is too much free object, cache reaper would reap
>> it.  So, this patch makes the check for free object exisistence not to
>> hold a lock.  This will reduce lock contention in heavily allocation case.

>> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>
> I've bisected a boot failure (no output at all) in v4.7-rc2 on emev2/kzm9d
> (Renesas dual Cortex A9) to this patch, which is upstream commit
> 801faf0db8947e01877920e848a4d338dd7a99e7.

BTW, when disabling SMP, the problem goes away.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
