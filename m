From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 29 Jun 2017 15:22:51 +0200
Subject: Clocks used by another OS/CPU
In-Reply-To: <b42a6818-4bc1-6556-5adf-c74a205b745b@de.bosch.com>
References: <CAMuHMdW9+CNTTOVO4SRRUxuz3ajLbY2j1uG8b_RpHX52NPwXrQ@mail.gmail.com>
 <b2328038-64ac-f7e0-d8a9-434f2f0b0300@de.bosch.com>
 <CAMuHMdVD3i0YhGCf-HSS+y+4SHvXi9sW3V4-ScQX=7R+DX=kEQ@mail.gmail.com>
 <b42a6818-4bc1-6556-5adf-c74a205b745b@de.bosch.com>
Message-ID: <CAMuHMdV7onyF3o0POVh0v0O-Zp_bmGK3zyadg1SHa4r6k-P_2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dirk,

On Thu, Jun 29, 2017 at 3:18 PM, Dirk Behme <dirk.behme@de.bosch.com> wrote:
> On 29.06.2017 13:18, Geert Uytterhoeven wrote:
>> On Thu, Jun 29, 2017 at 12:28 PM, Dirk Behme <dirk.behme@de.bosch.com>
>> wrote:
>>> On 29.06.2017 11:27, Geert Uytterhoeven wrote:
>>>> TL;DR: Clocks may be in use by another CPU not running Linux, while
>>>> Linux
>>>> disables them as being unused.

>>>> On r8a7795, there are several Cortex A cores running Linux, and a Cortex
>>>> R7
>>>> core which may run another OS.
>>>> This is an interesting issue, and relevant to other SoCs, too.

> First of all, just the clocks we know (*) are used by the R7 side *and* are
> disabled by the kernel (for a practical demo this are e.g. ~7 clocks).
>
> (*) Yes, this is board (and R7 software) related. And yes, this might result
> in board specific r8a7795_crit_mod_clks/r8a7795_crit_core_clks[] tables. So
> yes, most probably device tree would be an option. While there is
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/clk.c#n3402
>
> unfortunately
>
> a) its marked as "Do not use this function"
>
> and
>
> b) even if we would ignore (a) we couldn't figure how to use this for the
> RCar3 clocks (being no clock expert)

You cannot, as it only supports the legacy one-clock-per-node style.
You can use it on e.g. sd2_clk in arch/arm/boot/dts/r8a7791.dtsi, until R-Car
Gen2 is switched to the new CPG/MSSR driver.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
