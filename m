From: yang.shi@linaro.org (Yang Shi)
Date: Mon, 18 Apr 2016 11:16:14 -0700
Subject: [PATCH] arm64: Kconfig: remove redundant
 HAVE_ARCH_TRANSPARENT_HUGEPAGE definition
Message-ID: <1461003374-5412-1-git-send-email-yang.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HAVE_ARCH_TRANSPARENT_HUGEPAGE has been defined in arch/Kconfig already,
the ARM64 version is identical with it and the default value is Y. So remove
the redundant definition and just select it under CONFIG_ARM64.

Signed-off-by: Yang Shi <yang.shi@linaro.org>
---
 arch/arm64/Kconfig | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e5de825..496c1b4 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -98,6 +98,7 @@ config ARM64
 	select SYSCTL_EXCEPTION_TRACE
 	select HAVE_CONTEXT_TRACKING
 	select HAVE_ARM_SMCCC
+	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	help
 	  ARM 64-bit (AArch64) Linux support.
 
@@ -580,9 +581,6 @@ config SYS_SUPPORTS_HUGETLBFS
 config ARCH_WANT_HUGE_PMD_SHARE
 	def_bool y if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
 
-config HAVE_ARCH_TRANSPARENT_HUGEPAGE
-	def_bool y
-
 config ARCH_HAS_CACHE_LINE_SIZE
 	def_bool y
 
-- 
2.0.2
