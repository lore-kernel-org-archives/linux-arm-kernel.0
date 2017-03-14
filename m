From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 14 Mar 2017 19:10:28 +0200
Subject: [PATCH v2 3/3] arm64: exynos: Enable Exynos PMU and PM domains drivers
In-Reply-To: <20170314171028.20337-1-krzk@kernel.org>
References: <20170314171028.20337-1-krzk@kernel.org>
Message-ID: <20170314171028.20337-4-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable EXYNOS_PM_DOMAINS because recently Exynos5433 got support for
Power Management domains.  The Exynos5433 pinctrl driver requires
EXYNOS_PMU to get the syscon-regmap for PMU address space.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 arch/arm64/Kconfig.platforms | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 129cc5ae4091..9cdaecd3e583 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -54,6 +54,8 @@ config ARCH_BRCMSTB
 config ARCH_EXYNOS
 	bool "ARMv8 based Samsung Exynos SoC family"
 	select COMMON_CLK_SAMSUNG
+	select EXYNOS_PM_DOMAINS if PM_GENERIC_DOMAINS
+	select EXYNOS_PMU
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	select HAVE_S3C_RTC if RTC_CLASS
 	select PINCTRL
-- 
2.9.3
