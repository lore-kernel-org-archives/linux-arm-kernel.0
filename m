From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 30 Mar 2017 14:58:15 +0200
Subject: [PATCH v2 0/4] clk: renesas: Add support for R-Car H3 ES2.0
In-Reply-To: <1489425153-22623-1-git-send-email-geert+renesas@glider.be>
References: <1489425153-22623-1-git-send-email-geert+renesas@glider.be>
Message-ID: <CAMuHMdXtaGWoafQMyRZqVm0Pg0oBO+554HujK=QFnR+kS7YJbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 13, 2017 at 6:12 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> This patch series adds clock support for R-Car H3 ES2.0, which differs
> from ES1.x in several areas.
>
> The goal is twofold:
>   1. Support both the ES1.x and ES2.0 SoC revisions in a single binary
>      for now,
>   2. Make it clear which code supports ES1.x, so it can easily be
>      identified and removed later, when production SoCs are deemed
>      ubiquitous.
>
> This is achieved by:
>   - Updating the clock tables for the latest revision (ES2.0), but not
>     removing clocks that only exist on earlier revisions (ES1.x),
>   - Detecting the SoC revision at runtime using the new
>     soc_device_match() API, and fixing up the clocks tables to match the
>     actual SoC revision, by:
>       - NULLifying core and module clocks of modules that do not exist,
>       - Reparenting module clocks that have a different parent on ES1.x.
>
> Changes compared to v1:
>   - Update of various module clocks as per datasheet update,
>   - Add support for RCLK on R-Car H3 ES2.0.
>
> For testers, this series and its dependencies are available in the
> topic/r8a7795es2-clk-v2 branch of my renesas-drivers git repository at
> git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git.
> An integration branch for testing on the R-Car H3 ES2.0 based Salvator-X
> development board is provided as topic/r8a7795es2-integration.
>
> This has been tested on Salvator-X with R-Car H3 ES1.0, ES1.1, and ES2.0
> SoCs.
>
> I plan to queue this up in clk-renesas-for-v4.12.

Queued in clk-renesas-for-v4.12.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
