From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 22 Apr 2013 23:10:34 +0200
Subject: [PATCH v2 2/3] ARM: EXYNOS: Fix support of Exynos4210 rev0 SoC
In-Reply-To: <1366036922-4103-3-git-send-email-t.figa@samsung.com>
References: <1366036922-4103-1-git-send-email-t.figa@samsung.com>
 <1366036922-4103-3-git-send-email-t.figa@samsung.com>
Message-ID: <201304222310.34775.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 15 April 2013, Tomasz Figa wrote:
> This patch extends exynos_init_time() function to handle Exynos4210 rev0
> SoC, which differs in availability of system timers and needs different
> clocksource initialization.
> 
> This makes it possible to use exynos_init_time() function as init_time
> callback for all Exynos-based boards, including Universal_C210, which
> originally had to use samsung_timer_init().
> 
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Note that it would be helpful to mention here that this is required for
the calling samsung_timer_init from the exynos4-dt.c file.

	Arnd
