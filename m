From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 30 Dec 2014 01:13:17 +0300
Subject: [PATCH] ARM: shmobile: r8a7791: add ADSP clocks
In-Reply-To: <CAMuHMdWwx3So77Zuz7JrpJbBZe2oKN3YnkZL3m0gUCHZGu6SEg@mail.gmail.com>
References: <1937156.Ii2YrGkOFy@wasted.cogentembedded.com>	<CAMuHMdUqC5v-d95Sk2NewSE-EBKS49vn7jPKpixF2djg6NOmVw@mail.gmail.com>	<54A1BABF.5070208@cogentembedded.com>
 <CAMuHMdWwx3So77Zuz7JrpJbBZe2oKN3YnkZL3m0gUCHZGu6SEg@mail.gmail.com>
Message-ID: <54A1D1FD.7010006@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/30/2014 12:23 AM, Geert Uytterhoeven wrote:

>>>> --- renesas.orig/include/dt-bindings/clock/r8a7791-clock.h
>>>> +++ renesas/include/dt-bindings/clock/r8a7791-clock.h

>>>> -#define R8A7791_CLK_RCAN               9
>>>> +#define R8A7791_CLK_ADSP               9
>>>> +#define R8A7791_CLK_RCAN               10

>>> R8A7791_CLK_RCAN is changed?

>>     Yes. It shouldn't be?

> All definitions in include/dt-bindings/ are part of the DT ABI, and cannot be
> changed without breaking the DT binding.

> Hence when adding new entries, they must be added at the end of the list,
> using a new available value.

    Oh, OK...

> Apart from that, what happens if you boot a new DTS on a kernel with an old
> clk-rcar-gen2 driver that doesn't know about the new CPG clock?
> Does it just fail to initialize and find that single clock,

    Yes, exactly. The driver will cuss loudly but will continue to work.

> or does the whole CPG driver fail?

    No.

> I wanted to check that after seeing the RCAN CPG patch, but haven't gotten to it
> yet due to Xmas and NY holidays.

    No holidays yet here. There will be long holidays starting from January 1st...

> Gr{oetje,eeting}s,
>                          Geert

WBR, Sergei
