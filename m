From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 10 May 2016 16:30:54 +0200
Subject: [PATCH] arm64: exynos: Select SOC specific drivers
Message-ID: <1462890654-8787-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recently some Exynos drivers were moved from arm/mach-exynos to
drivers/soc. Building the directory depends on SOC_SAMSUNG Kconfig
option so we want it also on ARMv8 platforms, even though none of the
drivers support ARMv8 SoCs.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 54967ffd14c1..735eed65ee0a 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -35,6 +35,7 @@ config ARCH_EXYNOS
 	select HAVE_S3C_RTC if RTC_CLASS
 	select PINCTRL
 	select PINCTRL_EXYNOS
+	select SOC_SAMSUNG
 	help
 	  This enables support for ARMv8 based Samsung Exynos SoC family.
 
-- 
1.9.1
