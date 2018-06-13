From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 13 Jun 2018 13:21:34 +0200
Subject: [PATCH V5] ARM: shmobile: Rework the PMIC IRQ line quirk
In-Reply-To: <20180613110647.ygg66nu36pcf6kpn@verge.net.au>
References: <20180611121513.9673-1-marek.vasut+renesas@gmail.com>
 <20180613110647.ygg66nu36pcf6kpn@verge.net.au>
Message-ID: <CAMuHMdUsBNU-1y+_UfX6GKSC11pOB_BUhPKO-axUiO+BfgqVmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Wed, Jun 13, 2018 at 1:06 PM Simon Horman <horms@verge.net.au> wrote:
> On Mon, Jun 11, 2018 at 02:15:13PM +0200, Marek Vasut wrote:
> > Rather than hard-coding the quirk topology, which stopped scaling,
> > parse the information from DT. The code looks for all compatible
> > PMICs -- da9063 and da9210 -- and checks if their IRQ line is tied
> > to the same pin. If so, the code sends a matching sequence to the
> > PMIC to deassert the IRQ.
> >
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > Cc: Simon Horman <horms+renesas@verge.net.au>
> > Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Cc: linux-renesas-soc at vger.kernel.org
> > Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Tested-by: Geert Uytterhoeven <geert+renesas@glider.be> (on Koelsch)
>
> This looks fine to me but I will wait to see if there are other reviews
> before applying.
>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

Note that applying it now will break gose, as its DTS doesn't describe all
regulators yet.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
