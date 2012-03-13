From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Mar 2012 16:13:10 +0000
Subject: [PATCH v3 05/12] ARM: EXYNOS: add support uart for EXYNOS4 and
 EXYNOS5
In-Reply-To: <1331652643-12626-6-git-send-email-kgene.kim@samsung.com>
References: <1331652643-12626-1-git-send-email-kgene.kim@samsung.com>
 <1331652643-12626-6-git-send-email-kgene.kim@samsung.com>
Message-ID: <201203131613.10620.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 March 2012, Kukjin Kim wrote:
> Actually, the base address of uart is different between EXYNOS4
> and EXYNOS5 and this patch enables to support uart for EXYNOS4
> and EXYNOS5 SoCs at runtime.

Can you explain why this patch is still needed? The exynos5250_dt_map_io
function does not call s3c24xx_init_uarts() at all, so it seems that most
of this patch just adds dead code that would only be needed for the non-dt
case.

	Arnd
