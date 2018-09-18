From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 18 Sep 2018 14:52:53 +0200
Subject: [PATCH V6] ARM: shmobile: Rework the PMIC IRQ line quirk
In-Reply-To: <20180918122340.5478-1-marek.vasut+renesas@gmail.com>
References: <20180918122340.5478-1-marek.vasut+renesas@gmail.com>
Message-ID: <CAMuHMdVOMZ+o4osu7zGJm3YBQ-Mxest1kkJGgiH53joW1i__jg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2018 at 2:23 PM Marek Vasut <marek.vasut@gmail.com> wrote:
> Rather than hard-coding the quirk topology, which stopped scaling,
> parse the information from DT. The code looks for all compatible
> PMICs -- da9063 and da9210 -- and checks if their IRQ line is tied
> to the same pin. If so, the code sends a matching sequence to the
> PMIC to deassert the IRQ.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: linux-renesas-soc at vger.kernel.org
> Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be> (on Koelsch)
> ---
> V2: - Replace the DT shared IRQ check loop with memcmp()
>     - Send the I2C message to deassert the IRQ line to all PMICs
>       in the list with shared IRQ line instead of just one
>     - Add comment that this works only in case all the PMICs are
>       on the same I2C bus
> V3: - Drop the addr = 0x00 init
>     - Drop reinit of argsa in rcar_gen2_regulator_quirk
> V4: - Squash regulator_quirk on single line
>     - Drop !np check in for_each_matching_node_and_match()
>     - Use argsa in of_irq_parse_one
> V5: - Check kzalloc failure
>     - Rename da...._msgs to da...._msg
>     - Don't reinit quirk->shared
> V6: - Skip invalid entries instead of aborting on them

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
