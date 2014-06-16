From: tony@atomide.com (Tony Lindgren)
Date: Mon, 16 Jun 2014 02:41:56 -0700
Subject: [PATCH 02/14] ARM: omap2: fix am43xx dependency on l2x0 cache
In-Reply-To: <1402675276-538682-3-git-send-email-arnd@arndb.de>
References: <1402675276-538682-1-git-send-email-arnd@arndb.de>
 <1402675276-538682-3-git-send-email-arnd@arndb.de>
Message-ID: <20140616094156.GA17845@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [140613 09:02]:
> Commit d941f86fad41b ("ARM: l2c: AM43x: add L2 cache support") enabled
> the L2 cache support for the am43xx SoC, but caused a build regression
> when the driver for that cache controller is disabled:
> 
> arch/arm/mach-omap2/built-in.o: In function `am43xx_init_early':
> :(.init.text+0xb20): undefined reference to `omap_l2_cache_init'
> 
> This did not happen for OMAP4, which has the same call, but enables
> the l2x0 driver unconditionally. We could do the same thing for
> am43xx, but it seems better to allow turning it off and make the
> code work in either case.
> 
> This adds an inline wrapper for omap_l2_cache_init for the disabled
> case, and removes the 'select' from OMAP4 so it becomes a user
> visible option.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-omap at vger.kernel.org

Acked-by: Tony Lindgren <tony@atomide.com>
