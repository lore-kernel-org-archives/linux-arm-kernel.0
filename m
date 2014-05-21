From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 21 May 2014 17:50:35 +0200
Subject: [PATCH v3] clk: shmobile: Add R8A7740-specific clock support
In-Reply-To: <1768296.AYVfH6xHtk@avalon>
References: <1400682086-5705-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1768296.AYVfH6xHtk@avalon>
Message-ID: <CAMuHMdUNpgn1ciHsvqWtEyn0RugxQTaCV+ki=S=5hUbmCjA6tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Wed, May 21, 2014 at 5:41 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> +cpg_clocks: cpg_clocks at e6150000 {
>> +        compatible = "renesas,r8a7740-cpg-clocks";
>> +        reg = <0xe6150000 0x10000>;
>
> This range covers the MSTP registers. Unlike other Renesas SoCs with CCF
> support in mainline, the MSTP registers are in the middle of the CPG address
> space here, which is quite problematic.

This is also the case for R-Car Gen2?!?

                /* Special CPG clocks */
                cpg_clocks: cpg_clocks at e6150000 {
                        compatible = "renesas,r8a7791-cpg-clocks",
                                     "renesas,rcar-gen2-cpg-clocks";
                        reg = <0 0xe6150000 0 0x1000>;

                mstp0_clks: mstp0_clks at e6150130 {
                        compatible = "renesas,r8a7791-mstp-clocks",
"renesas,cpg-mstp-clocks";
                        reg = <0 0xe6150130 0 4>, <0 0xe6150030 0 4>;

Or perhaps I am misunderstanding what you mean?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
