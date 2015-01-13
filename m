From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 13 Jan 2015 09:10:08 +0100
Subject: [GIT PULL] Renesas ARM Based SoC Fixes for v3.19
In-Reply-To: <cover.1421113695.git.horms+renesas@verge.net.au>
References: <cover.1421113695.git.horms+renesas@verge.net.au>
Message-ID: <CAMuHMdU2nrftSAxZgwrT5_WP5WkeisxDkuZcAa7zH0LQyQ89jg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 13, 2015 at 3:13 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
>
> Please consider these Renesas ARM based SoC fixes for v3.19.
>
> This pull request is based on the last round of SoC updates for v3.19,
> Fourth Round of Renesas ARM Based SoC Updates for v3.19, tagged as
> renesas-soc3-for-v3.19, merged into your next/soc branch and included in
> v3.19-rc1.
>
> * ARM: shmobile: r8a7740: Instantiate GIC from C board code in legacy builds

That's the description for the regression below.
Should have been: "Set .control_parent for all irqpin instances for sh73a0
SoC when booting using legacy C."

>   This fixes a long standing problem which has been present since
>   the sh73a0 SoC started using the INTC External IRQ pin driver.
>
>   The patch that introduced the problem is 341eb5465f67437a ("ARM:
>   shmobile: INTC External IRQ pin driver on sh73a0") which was included
>   in v3.10.
>
> * This fixes a regression in the r8a7740 SoC due to
>   9a1091ef0017c40a ("irqchip: gic: Support hierarchy irq domain.")
>   which was included in v3.18-rc2.

> ----------------------------------------------------------------
> Renesas ARM Based SoC Fixes for v3.19
>
> * Set .control_parent for all irqpin instances for sh73a0 SoC when booting
>   using legacy C
> * Instantiate GIC board for r8a7740 SoC when using legacy C

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
