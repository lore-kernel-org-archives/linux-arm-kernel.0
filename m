From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 17 Oct 2018 15:41:59 +0200
Subject: [PATCH v3 6/6] arm64: platform: Add enable Exynos Multi-Core Timer
 driver
In-Reply-To: <20181017134159.9656-1-m.szyprowski@samsung.com>
References: <20181017134159.9656-1-m.szyprowski@samsung.com>
 <CGME20181017134208eucas1p19c81d1ce9050be1b78e386d8a349f441@eucas1p1.samsung.com>
Message-ID: <20181017134159.9656-7-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Exynos SoCs enabling MCT driver is required even if ARM Architected
Timer driver is used to for managing timer hardware and clock source
events.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 51bc479334a4..7cc687580fad 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -62,6 +62,7 @@ config ARCH_BRCMSTB
 config ARCH_EXYNOS
 	bool "ARMv8 based Samsung Exynos SoC family"
 	select COMMON_CLK_SAMSUNG
+	select CLKSRC_EXYNOS_MCT
 	select EXYNOS_PM_DOMAINS if PM_GENERIC_DOMAINS
 	select EXYNOS_PMU
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
-- 
2.17.1
