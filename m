From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 5 Jan 2015 09:52:37 +0100
Subject: [PATCH/RFC] ARM: shmobile: r8a7794: Add Audio DMAC, PWM and
 Thermal clocks to device tree
In-Reply-To: <8183635.VD1oYub01I@avalon>
References: <1418949573-24211-1-git-send-email-horms+renesas@verge.net.au>
 <8183635.VD1oYub01I@avalon>
Message-ID: <CAMuHMdXcVrSXd2YzKVQKBFyTwkrOhci0MGs8uA1yk+kX9LDQkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 5, 2015 at 9:30 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Friday 19 December 2014 09:39:33 Simon Horman wrote:
>> This is based on the MSTP5 clocks in the r8a7791 device tree.
>> The main difference being that the r8a7794 does not have an Audio DMAC1
>> clock.
>>
>> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>>
>> ---
>> Based on the renesas-devel-20141217-v3.18 tag of my renesas tree.
>>
>> N.B: The R-Car Gen2 v1.8.0 BSP uses zs_clk whereas this patch uses hp_clk
>>      as the parent clock for the Audio DMAC clock.
>>
>>      In that regard this patch follows the pattern used in mainline for the
>>      r8a7790 and r8a7791 SoCs.
>>
>>      The BSP's parent clock is consistent for the r8a7790, r8a7791, r8a7793
>>      and r8a7794 SoCs.
>
> Does this mean the BSP uses hp_clk for all Gen2 SoCs while mainline uses
> zs_clk ?

No, it's the other way around ;-)

> Can't we find out which one is correct ?

Which clock is used doesn't seem to be documented.
So either we have to check with the hardware guys, or measure the clock
in some way, either by hardware or software (e.g. what's the maximum
transfer rate
that works?).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
