From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 26 May 2011 17:25:18 -0600
Subject: [PATCH 0/4] Move U300 and Nomadik GPIO drivers v2
In-Reply-To: <1306271192-28911-1-git-send-email-linus.walleij@stericsson.com>
References: <1306271192-28911-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20110526232518.GA1384@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 24, 2011 at 11:06:32PM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This is a rebase of the earlier patch set, due to updates
> pulled in to Torvalds tree conflicting with earlier movement
> patches.
> 
> I also used -M so we can see what is happening, yay!

Applied whole series, plus the kconfig fixup.  Thanks.

g.

> 
> Linus Walleij (2):
>   gpio: move U300 GPIO driver to drivers/gpio
>   gpio: move Nomadik GPIO driver to drivers/gpio
> 
> Rabin Vincent (1):
>   gpio/nomadik: show all pins in debug
> 
> Rickard Andersson (1):
>   gpio/nomadik: add function to read GPIO pull down status
> 
>  arch/arm/mach-u300/Makefile                        |    2 +-
>  arch/arm/plat-nomadik/Kconfig                      |    5 --
>  arch/arm/plat-nomadik/Makefile                     |    1 -
>  arch/arm/plat-nomadik/include/plat/gpio.h          |    2 +
>  drivers/gpio/Makefile                              |    2 +
>  .../gpio.c => drivers/gpio/gpio-nomadik.c          |   65 +++++++++++++++++---
>  .../mach-u300/gpio.c => drivers/gpio/gpio-u300.c   |    0
>  7 files changed, 62 insertions(+), 15 deletions(-)
>  rename arch/arm/plat-nomadik/gpio.c => drivers/gpio/gpio-nomadik.c (95%)
>  rename arch/arm/mach-u300/gpio.c => drivers/gpio/gpio-u300.c (100%)
> 
> -- 
> 1.7.3.2
> 
