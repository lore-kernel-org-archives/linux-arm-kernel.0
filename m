From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 31 May 2017 19:42:44 +0200
Subject: [PATCH] pinctrl: samsung: Fix missing object for S5Pv210
Message-ID: <20170531174244.31861-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While splitting Samsung pinctrl drivers per ARMv7 and ARMv8
architectures, the necessary CONFIG_PINCTRL_EXYNOS_ARM is not selected
when building for S5Pv210 family of SoCs thus pinctrl was missing there
entirely.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Fixes: 16340fd6dbc1 ("pinctrl: samsung: Split Exynos drivers per ARMv7 and ARMv8")

Fixed commit is in my tree but already applied and sitting in next for
some time. This should be squashed though.
---
 drivers/pinctrl/samsung/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/samsung/Kconfig b/drivers/pinctrl/samsung/Kconfig
index c33ee6293c30..0357f9701eb9 100644
--- a/drivers/pinctrl/samsung/Kconfig
+++ b/drivers/pinctrl/samsung/Kconfig
@@ -10,7 +10,7 @@ config PINCTRL_EXYNOS
 	bool "Pinctrl driver data for Samsung EXYNOS SoCs other than 5440"
 	depends on OF && GPIOLIB && (ARCH_EXYNOS || ARCH_S5PV210)
 	select PINCTRL_SAMSUNG
-	select PINCTRL_EXYNOS_ARM if ARM && ARCH_EXYNOS
+	select PINCTRL_EXYNOS_ARM if ARM && (ARCH_EXYNOS || ARCH_S5PV210)
 	select PINCTRL_EXYNOS_ARM64 if ARM64 && ARCH_EXYNOS
 
 config PINCTRL_EXYNOS_ARM
-- 
2.9.3
