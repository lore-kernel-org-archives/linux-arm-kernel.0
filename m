From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 19 Nov 2014 17:07:52 +0100
Subject: [PATCH 0/3] PM / Domains: Add initial PM clock support to genpd
In-Reply-To: <1416405638-18812-1-git-send-email-ulf.hansson@linaro.org>
References: <1416405638-18812-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CAMuHMdUKWNSTYCAcusOpk31=Y6g5-SqKck5HaHZvgBOaYQrK3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

On Wed, Nov 19, 2014 at 3:00 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> It's quite common for PM domains to use PM clocks. Typically from SOC specific
> code, the per device PM clock list is created and pm_clk_suspend|resume() are
> invoked to handle clock gating/ungating.
>
> A step towards consolidation is to integrate PM clock support into genpd, which
> is what this patchset does.

Thanks, this sounds like a good idea.

> In this initial step, the calls to the pm_clk_suspend|resume() are handled
> within genpd, but the per device PM clock list still needs to be created from
> SOC specific code. It seems reasonable to have gendp to handle that as well, but

s/gendp/genpd/

> that left to future patchsets to address.

If/when genpd will handle the clock creation, perhaps the flag can just
be replaced by a pointer to a list of clocks?
Or do you have other uses in mind for adding the flags field now?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
