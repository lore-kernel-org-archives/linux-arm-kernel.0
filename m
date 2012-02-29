From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Feb 2012 19:28:49 +0000
Subject: [PATCH] ARM: ux500: solve some Kconfig mess
In-Reply-To: <1330536509-13590-1-git-send-email-linus.walleij@stericsson.com>
References: <1330536509-13590-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <201202291928.49516.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 February 2012, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> First rename the config option MACH_U8500 to MACH_MOP500
> because that is what it's obviously all about, this has
> confused me for the last time. Fix some whitespace in the
> process.
> 
> Since the machine descriptors for HREFv60 and snowball
> are clearly in the file board-mop500.c which only
> compiles if MACH_MOP500 (former MACH_U8500) is set,
> select this for the board variants and nothing else.
> 
> For the MOP500 variants the UIB (user interface board)
> is probed using I2C so select I2C and I2C_NOMADIK so
> we know that this probe will always be successful.

Looks good to me. One thing I still wonder about is whether
we should leave the UX500_SOC_DB5500 and UX500_SOC_DB8500
options user-visible. It would probably be simpler to just
select these whenever a board using them is enabled.


	Arnd
