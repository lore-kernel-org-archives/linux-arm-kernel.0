From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 23 Jan 2017 10:26:34 +0100
Subject: [PATCH 0/4] ARM/arm64: dts: renesas: Link ARM GIC to clock and
 clock domain
In-Reply-To: <20170123092330.GF31651@verge.net.au>
References: <1484657360-13101-1-git-send-email-geert+renesas@glider.be>
 <20170123092330.GF31651@verge.net.au>
Message-ID: <CAMuHMdVbr3gCMJpvcJbD0C4p8FikMM3s5zmjkVXNskhk7-P7Tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Mon, Jan 23, 2017 at 10:23 AM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, Jan 17, 2017 at 01:49:16PM +0100, Geert Uytterhoeven wrote:
>> This patch series improves the topology description in DT of the ARM GIC
>> on Renesas SoCs using the CPG/MSSR bindings (R-Car Gen3 and RZ/G).
>> It links the GIC to its module clock, and adds it to the SYSC "always
>> on" PM Domain.
>>
>> Note that currently the GIC-400 driver doesn't support module clocks nor
>> Runtime PM, so this must be handled as a critical clock.
>> As the CPG/MSSR driver, unlike the legacy MSTP driver, is already aware
>> of critical clocks, this series can be applied right now.
>
> does the note above imply that "[PATCH 0/2] clk: renesas: Use
> CLK_IS_CRITICAL to handle critical clocks" is a dependency of this series?

No, the note says (using different wording) that there is no such dependency.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
