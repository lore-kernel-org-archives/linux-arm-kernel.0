From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 18 Jul 2018 15:19:21 +0200
Subject: [PATCH] clk: Add functions to get optional clocks
In-Reply-To: <20180718130228.GG17271@n2100.armlinux.org.uk>
References: <1531918658-32278-1-git-send-email-phil.edworthy@renesas.com>
 <20180718130228.GG17271@n2100.armlinux.org.uk>
Message-ID: <CAMuHMdUjzVBXn-goAwbTBULfo=HrJEY6eBae4w7Z6qA-gScUUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Wed, Jul 18, 2018 at 3:02 PM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Wed, Jul 18, 2018 at 01:57:38PM +0100, Phil Edworthy wrote:
> > Behaves the same as (devm_)clk_get except where there is no clock
> > producer. In this case, instead of returning -ENOENT, the function
> > returns NULL. This makes error checking simpler and allows
> > clk_prepare_enable, etc to be called on the returned reference
> > without additional checks.
>
> How does this work with non-DT systems, where looking a clock up which
> isn't yet registered with clkdev returns -ENOENT ?
>
> (clkdev doesn't know when all clocks are registered with it.)

Good question.

I guess all drivers trying to handle optional clocks this way are already broken
on non-DT systems where clocks may be registered late...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
