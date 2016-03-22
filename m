From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 22 Mar 2016 11:18:37 +0100
Subject: [PATCH 00/13] ARM, arm64: dts: Remove unnecessary
 clock-output-names properties
In-Reply-To: <1458610840-15194-1-git-send-email-horms+renesas@verge.net.au>
References: <1458610840-15194-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdV7F==8cMr-CQgiBGC9NhnojNN-6d2Ph+uaHjtbCFW4pQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 22, 2016 at 2:40 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> this series updates the device trees of Renesas ARM based SoCs.
>
> * Fixed rate and fixed factor clocks do not require an
>   clock-output-names property.
> * Since 07705583e920fef6 ("clk: shmobile: div6: Make clock-output-names
>   optional") Renesas div6 clocks do not require a clock-output-names
>   property.
>
> In the above cases there is only one clock output and its name is taken
> from that of the clock node.
>
> Accordingly, remove the unnecessary clock-output-names properties and as
> necessary update the node names. The zb_clk is excluded from this rename
> as the MSTP clock driver (clk-mstp.c) explicitly looks for a clock
> named zb_clk for the r8a73a4 and sh73a0 SoCs.
>
> Based on renesas-devel-20160318-v4.5
>
> Simon Horman (13):
>   ARM: dts: r7s72100: Remove unnecessary clock-output-names properties
>   ARM: dts: r8a73a4: Remove unnecessary clock-output-names properties
>   ARM: dts: sh73a0: Remove unnecessary clock-output-names properties
>   ARM: dts: r8a7740: Remove unnecessary clock-output-names properties
>   ARM: dts: r8a7778: Remove unnecessary clock-output-names properties
>   ARM: dts: r8a7779: Remove unnecessary clock-output-names properties
>   ARM: dts: r8a7791: Remove unnecessary clock-output-names properties
>   ARM: dts: r8a7793: Remove unnecessary clock-output-names properties
>   ARM: dts: r8a7794: Remove unnecessary clock-output-names properties
>   ARM: dts: gose: Remove unnecessary clock-output-names properties
>   ARM: dts: koelsch: Remove unnecessary clock-output-names properties
>   ARM: dts: porter: Remove unnecessary clock-output-names properties
>   ARM: dts: lager: Remove unnecessary clock-output-names properties

For 1, 4-13:

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
