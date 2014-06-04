From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 04 Jun 2014 15:58:28 +0200
Subject: [PATCH 2/4] ARM: mach-s5p: get rid of all <mach/gpio.h> headers
In-Reply-To: <1401888838-3126-3-git-send-email-linus.walleij@linaro.org>
References: <1401888838-3126-1-git-send-email-linus.walleij@linaro.org>
 <1401888838-3126-3-git-send-email-linus.walleij@linaro.org>
Message-ID: <4544212.mqY6dSouMv@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 June 2014 15:33:56 Linus Walleij wrote:
> This renames all the local <mach/gpio.h> headers in the S5P platforms
> to <mach/gpio-samsung.h> indicating a scope local to this platform,
> and cuts the implicit inclusion of <mach/gpio.h> from <linux/gpio.h>
> by removing the use of NEED_MACH_GPIO_H from all S5P variants.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 

Hmm, this patch will obviously clash with the removal of S5p64xx
and s5pc100. It shouldn't be hard to resolve the conflict when we
merge both into arm-soc/next/cleanup, but maybe there is a way to
avoid it?

	Arnd
