From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 29 Dec 2014 22:23:44 +0100
Subject: [PATCH] ARM: shmobile: r8a7791: add ADSP clocks
In-Reply-To: <54A1BABF.5070208@cogentembedded.com>
References: <1937156.Ii2YrGkOFy@wasted.cogentembedded.com>
 <CAMuHMdUqC5v-d95Sk2NewSE-EBKS49vn7jPKpixF2djg6NOmVw@mail.gmail.com>
 <54A1BABF.5070208@cogentembedded.com>
Message-ID: <CAMuHMdWwx3So77Zuz7JrpJbBZe2oKN3YnkZL3m0gUCHZGu6SEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Mon, Dec 29, 2014 at 9:34 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 12/29/2014 11:24 PM, Geert Uytterhoeven wrote:
>
>>> --- renesas.orig/include/dt-bindings/clock/r8a7791-clock.h
>>> +++ renesas/include/dt-bindings/clock/r8a7791-clock.h
>
>
>>> -#define R8A7791_CLK_RCAN               9
>>> +#define R8A7791_CLK_ADSP               9
>>> +#define R8A7791_CLK_RCAN               10
>
>> R8A7791_CLK_RCAN is changed?
>
>    Yes. It shouldn't be?

All definitions in include/dt-bindings/ are part of the DT ABI, and cannot be
changed without breaking the DT binding.

Hence when adding new entries, they must be added at the end of the list,
using a new available value.

Apart from that, what happens if you boot a new DTS on a kernel with an old
clk-rcar-gen2 driver that doesn't know about the new CPG clock?
Does it just fail to initialize and find that single clock, or does
the whole CPG
driver fail?
I wanted to check that after seeing the RCAN CPG patch, but haven't gotten to it
yet due to Xmas and NY holidays.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
