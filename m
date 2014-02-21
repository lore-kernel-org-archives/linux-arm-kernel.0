From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 21 Feb 2014 16:50:02 +0100
Subject: [PATCH v2 2/2] phy: Select PHY_EXYNOS_DP_VIDEO by default for
 ARCH_EXYNOS
In-Reply-To: <1392997802-29050-1-git-send-email-s.nawrocki@samsung.com>
References: <1392997802-29050-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1392997802-29050-2-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of requiring user to figure out when PHY_EXYNOS_DP_VIDEO needs
to be selected select it by default for Exynos SoCs. Also enable it
when COMPILE_TEST is selected. If required the display port PHY driver
can be then disabled or compiled in as module.

Cc: Jingoo Han <jg1.han@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
Changes since first version:
 - use ARCH_EXYNOS instead of "ARCH_EXYNOS4 || ARCH_EXYNOS5"
 - add dependency on COMPILE_TEST
---
 drivers/phy/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index ebd455c..4218c99 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -57,6 +57,8 @@ config TWL4030_USB
 config PHY_EXYNOS_DP_VIDEO
 	tristate "EXYNOS SoC series Display Port PHY driver"
 	depends on OF
+	depends on ARCH_EXYNOS || COMPILE_TEST
+	default y
 	select GENERIC_PHY
 	help
 	  Support for Display Port PHY found on Samsung EXYNOS SoCs.
-- 
1.7.9.5
