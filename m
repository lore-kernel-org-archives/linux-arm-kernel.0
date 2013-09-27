From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 27 Sep 2013 14:44:55 +0200
Subject: [PATCH] ARM: drop explicit selection of HAVE_CLK and CLKDEV_LOOKUP
In-Reply-To: <1380044515-3173-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1380044515-3173-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <CACRpkdZOSn0UuZkz2ZsKeG8u0j216BfrkUmO0Za74AYNKFNiiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 24, 2013 at 7:41 PM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:

> CLKDEV_LOOKUP selects HAVE_CLK and COMMON_CLK selects CLKDEV_LOOKUP. So
> all symbols that select at least two of these symbols can be simplified.
>
> For imx, omap2 and ux500 some rearrangements were necessary before the
> simplification.
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

>  arch/arm/mach-u300/Kconfig     |  1 -
>  arch/arm/mach-ux500/Kconfig    | 29 ++++++++++++-----------------

I am worried that the ux500 stuff may conflict with other stuff destined
for the ARM SoC tree, so if you coordinate with the ARM SoC folks:
Acked-by: Linus Walleij <linus.walleij@linaro.org> for these two.

Yours,
Linus Walleij
