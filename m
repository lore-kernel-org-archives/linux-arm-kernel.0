From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 06 Jun 2014 08:50:04 +0200
Subject: [PATCH 2/4] ARM: mach-s5p: get rid of all <mach/gpio.h> headers
In-Reply-To: <4544212.mqY6dSouMv@wuerfel>
References: <1401888838-3126-1-git-send-email-linus.walleij@linaro.org>
 <1401888838-3126-3-git-send-email-linus.walleij@linaro.org>
 <4544212.mqY6dSouMv@wuerfel>
Message-ID: <4393612.d5qsoYg5L1@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 June 2014 15:58:28 Arnd Bergmann wrote:
> On Wednesday 04 June 2014 15:33:56 Linus Walleij wrote:
> > This renames all the local <mach/gpio.h> headers in the S5P platforms
> > to <mach/gpio-samsung.h> indicating a scope local to this platform,
> > and cuts the implicit inclusion of <mach/gpio.h> from <linux/gpio.h>
> > by removing the use of NEED_MACH_GPIO_H from all S5P variants.
> > 
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > 
> 
> Hmm, this patch will obviously clash with the removal of S5p64xx
> and s5pc100. It shouldn't be hard to resolve the conflict when we
> merge both into arm-soc/next/cleanup, but maybe there is a way to
> avoid it?

Nevermind, given how happy everyone is to see this gone, let's go
ahead with your current version, and let us handle the conflict in
arm-soc when we merge both patch sets.

	Arnd
