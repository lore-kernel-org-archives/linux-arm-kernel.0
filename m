From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 02 Feb 2016 16:06:17 +0900
Subject: [PATCH] drivers: soc: samsung: Enable COMPILE_TEST
Message-ID: <1454396777-20034-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Get some build coverage of Exynos SROM controller and PMU drivers. The
PMU driver depends on asm/cputype.h so its compilation is limited to ARM
architectures.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---
The SROM driver was compile-tested on x86, x86_64, ppc64, arm, arm64 and
mips. The PMU driver on arm and arm64.
---
 drivers/soc/samsung/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
index 895f16934b75..e5c11ac88a38 100644
--- a/drivers/soc/samsung/Kconfig
+++ b/drivers/soc/samsung/Kconfig
@@ -1,17 +1,17 @@
 #
 # SAMSUNG SoC drivers
 #
-menu "Samsung SOC driver support"
+menuconfig SOC_SAMSUNG
+	bool "Samsung SoC driver support" if COMPILE_TEST
 
-config SOC_SAMSUNG
-	bool
+if SOC_SAMSUNG
 
 config EXYNOS_SROM
-	bool
-	depends on ARM && ARCH_EXYNOS
+	bool "Exynos SROM controller driver" if COMPILE_TEST
+	depends on (ARM && ARCH_EXYNOS) || COMPILE_TEST
 
 config EXYNOS_PMU
-	bool
-	depends on ARM && ARCH_EXYNOS
+	bool "Exynos PMU controller driver" if COMPILE_TEST
+	depends on (ARM && ARCH_EXYNOS) || ((ARM || ARM64) && COMPILE_TEST)
 
-endmenu
+endif
-- 
1.9.1
