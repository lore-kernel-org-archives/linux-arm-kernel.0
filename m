From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 26 Feb 2017 12:07:29 +0900
Subject: [PATCH] ARM: prima2: remove redundant select CPU_V7
Message-ID: <1488078449-3902-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARCH_ATLAS7 resides in "if ARCH_SIRF ... end", and ARCH_SIRF depends
on ARCH_MULTI_V7, which selects CPU_V7.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-prima2/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-prima2/Kconfig b/arch/arm/mach-prima2/Kconfig
index 85e874a..7426211 100644
--- a/arch/arm/mach-prima2/Kconfig
+++ b/arch/arm/mach-prima2/Kconfig
@@ -27,7 +27,6 @@ config ARCH_ATLAS7
 	bool "CSR SiRFSoC ATLAS7 ARM Cortex A7 Platform"
 	default y
 	select ARM_GIC
-	select CPU_V7
 	select ATLAS7_TIMER
 	select HAVE_ARM_SCU if SMP
 	select HAVE_SMP
-- 
2.7.4
