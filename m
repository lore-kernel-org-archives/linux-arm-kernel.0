From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Mon,  6 Jan 2014 14:32:54 +0530
Subject: [PATCH 1/2] ARM: Exynos: Use generic uncompress.h
Message-ID: <1388998975-32362-1-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As a pre-requisite step towards enabling multi-platform support
for Exynos, enable it to use generic uncompress.h instead of the
one provided in machine code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 arch/arm/Kconfig.debug |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index e6c313ec5ece..de379a93c8ba 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1131,7 +1131,7 @@ config DEBUG_UART_8250_FLOW_CONTROL
 
 config DEBUG_UNCOMPRESS
 	bool
-	depends on ARCH_MULTIPLATFORM || ARCH_MSM
+	depends on ARCH_MULTIPLATFORM || ARCH_MSM || ARCH_EXYNOS
 	default y if DEBUG_LL && !DEBUG_OMAP2PLUS_UART && \
 		     (!DEBUG_TEGRA_UART || !ZBOOT_ROM)
 	help
@@ -1147,7 +1147,8 @@ config DEBUG_UNCOMPRESS
 
 config UNCOMPRESS_INCLUDE
 	string
-	default "debug/uncompress.h" if ARCH_MULTIPLATFORM || ARCH_MSM
+	default "debug/uncompress.h" if ARCH_MULTIPLATFORM || ARCH_MSM || \
+					ARCH_EXYNOS
 	default "mach/uncompress.h"
 
 config EARLY_PRINTK
-- 
1.7.9.5
