From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 15 Sep 2017 21:00:13 +0200
Subject: [PATCH 10/11] arm64: dts: renesas: initial Eagle board device tree
In-Reply-To: <323063a2-1256-fa25-b91c-4c726ab277a2@cogentembedded.com>
References: <20170912210543.810219167@cogentembedded.com>
 <d6f9d5ef-4864-3ffb-9406-acd65bff10aa@cogentembedded.com>
 <5c680bad-39c8-a6c7-ee2a-6a2e72c33026@cogentembedded.com>
 <CAMuHMdU+DYBCu1bKLh_VjuSR-cSfjwPQuAxTsaU2JW-3d-5QUw@mail.gmail.com>
 <323063a2-1256-fa25-b91c-4c726ab277a2@cogentembedded.com>
Message-ID: <CAMuHMdVUJb+QXtBqSX4La-GFS60dj2S2WkSte_kiDm7NXVxEoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Fri, Sep 15, 2017 at 8:53 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 09/15/2017 09:44 PM, Geert Uytterhoeven wrote:
>>>>      Forgot to specify SCIF_CLK -- it's populated.
>>>
>>>     Unfortunately, the kernel hangs after ttySC0 is registered if I
>>> specify
>>> this frequency...
>>
>> Is the crystal populated?
>
>    It should be, with 14.7456MHz chrystal. But it's connected to SCIF_CLK_B
> pin -- perhaps that's the problem...
>
>> When doing initial bringup of the remote Eagle I have access to, the SCIF
>> registers didn't indicate SCIF_CLK was being used from U-Boot, while it
>> is used on R-Car Gen2 boards that have it populated.
>
>    Perhaps PFC is just not configured properly?

Plausible.
As there's no PFC driver yet (at least I haven't seen one ;-), you can try
configuring the PFC to use SCIF_CLK_B by writing to the registers
from the U-Boot prompt...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
