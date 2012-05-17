From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 17 May 2012 17:38:32 -0600
Subject: [PATCH 0/9] ux500/Nomadik GPIO and pins update
In-Reply-To: <1335172440-27470-1-git-send-email-linus.walleij@stericsson.com>
References: <1335172440-27470-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20120517233832.E67E43E062C@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 23 Apr 2012 11:14:00 +0200, Linus Walleij <linus.walleij@stericsson.com> wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This is basically an update and sync of Nomadik and ux500 GPIO
> development.
> 
> If you wonder why I introduce a deviant pin configuration path
> not using the pin config subsystem it is because I want to build
> atop of this work which I know works. It will be switched over
> to pinctrl in later patch sets on top of this.
> 
> This is *almost* orthogonal to other ux500 development, but
> there *might* be conflicts with Lee Jones' Device Tree work,
> so I will try to create a separate orthogonal ux500 GPIO branch
> for this stuff.
> 
> Linus Walleij (4):
>   gpio/nomadik: use typesafe __io_address()
>   plat-nomadik: new sleep mode pincfg macros
>   ARM: ux500: remove a bunch of internal pull-ups
>   ARM: ux500: update pin handling
> 
> Rabin Vincent (5):
>   gpio/nomadik: don't set SLPM to 1 for non-wakeup pins
>   gpio/nomadik: cache [rf]w?imsc
>   gpio/nomadik: fix spurious interrupts with SKE
>   gpio/nomadik: support low EMI mode
>   ARM: ux500: implement pin API

for the whole series:

Acked-by: Grant Likely <grant.likely@secretlab.ca>

g.

> 
>  arch/arm/mach-ux500/Makefile                      |    2 +-
>  arch/arm/mach-ux500/board-mop500-pins.c           |  394 ++++++++++++++++-----
>  arch/arm/mach-ux500/board-mop500.h                |    4 +
>  arch/arm/mach-ux500/pins-db8500.h                 |   72 ++--
>  arch/arm/mach-ux500/pins.c                        |   88 +++++
>  arch/arm/mach-ux500/pins.h                        |   46 +++
>  arch/arm/plat-nomadik/include/plat/gpio-nomadik.h |    1 +
>  arch/arm/plat-nomadik/include/plat/pincfg.h       |   19 +
>  drivers/gpio/gpio-nomadik.c                       |  129 +++++--
>  9 files changed, 591 insertions(+), 164 deletions(-)
>  create mode 100644 arch/arm/mach-ux500/pins.c
>  create mode 100644 arch/arm/mach-ux500/pins.h
> 
> -- 
> 1.7.9.2
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
