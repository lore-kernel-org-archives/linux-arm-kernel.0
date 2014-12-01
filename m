From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 1 Dec 2014 10:35:10 +0100
Subject: [PATCH V3 0/3] PM / Domains: Add initial PM clock support to genpd
In-Reply-To: <1417163403-7070-1-git-send-email-ulf.hansson@linaro.org>
References: <1417163403-7070-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CAMuHMdXEP2oU60CsavpHZw5y+uw9e8eHRyY4OQcYbhdML5_R5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 28, 2014 at 9:30 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Changes in v3:
>         -Fixed comments from Rafael for patch 1.
>         -Change name of define, affects all patches.
>
> Changes in v2:
>         -Small fixes in patch 1.
>
>
> It's quite common for PM domains to use PM clocks. Typically from SOC specific
> code, the per device PM clock list is created and pm_clk_suspend|resume() are
> invoked to handle clock gating/ungating.
>
> A step towards consolidation is to integrate PM clock support into genpd, which
> is what this patchset does.
>
> In this initial step, the calls to the pm_clk_suspend|resume() are handled
> within genpd, but the per device PM clock list still needs to be created from
> SOC specific code. It seems reasonable to have gendp to handle that as well, but
> that left to future patchsets to address.
>
> It's not every users of genpd that are keen on using PM clocks thus we need
> to provide this a configuration option for genpd.
>
> In patch 2 and patch 3, we convert some of the SH-MOBILE SOCs to start using the
> new PM clock support in genpd.
>
>
> Ulf Hansson (3):
>   PM / Domains: Initial PM clock support for genpd
>   ARM: shmobile: Convert to genpd flags for PM clocks for r8a7779
>   ARM: shmobile: Convert to genpd flags for PM clocks for R-mobile
>
>  arch/arm/mach-shmobile/pm-r8a7779.c | 3 +--
>  arch/arm/mach-shmobile/pm-rmobile.c | 3 +--
>  drivers/base/power/domain.c         | 7 +++++++
>  include/linux/pm_domain.h           | 4 ++++
>  4 files changed, 13 insertions(+), 4 deletions(-)

For the series:

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
