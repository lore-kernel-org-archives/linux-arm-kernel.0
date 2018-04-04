From: tony@atomide.com (Tony Lindgren)
Date: Wed, 4 Apr 2018 10:12:22 -0700
Subject: [PATCH] ARM: omap2: fix am43xx build without L2X0
In-Reply-To: <20180404102550.3692501-1-arnd@arndb.de>
References: <20180404102550.3692501-1-arnd@arndb.de>
Message-ID: <20180404171222.GH5700@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [180404 10:27]:
> When CONFIG_CACHE_L2X0 is disabled, the am43xx specific suspend
> implemnentation fails to link:
> 
> arch/arm/mach-omap2/sleep43xx.o: In function `get_l2cache_base':
> (.text+0x180): undefined reference to `omap4_get_l2cache_base'
> 
> This adds an #ifdef protection around the code, like we do for am44xx.
> 
> Fixes: 41d37e61372f ("ARM: OMAP2+: Introduce low-level suspend code for AM43XX")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, looks OK to me:

Acked-by: Tony Lindgren <tony@atomide.com>
