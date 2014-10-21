From: kaixu.xia@linaro.org (Xia Kaixu)
Date: Tue, 21 Oct 2014 22:11:34 +0800
Subject: [PATCH 4/4] ARM: allow errata and XIP options to be enabled without
 ARCH_MULTIPLATFORM_STRICT
In-Reply-To: <1413900694-29571-1-git-send-email-kaixu.xia@linaro.org>
References: <1413900694-29571-1-git-send-email-kaixu.xia@linaro.org>
Message-ID: <1413900694-29571-5-git-send-email-kaixu.xia@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the ARCH_MULTIPLATFORM_STRICT option, it becomes much easier to 
enable the ERRATA options when we know at configuration time that we
don't care about the generic case. The previous configuration makes
XIP_KERNEL option fundamentally non-MULTIPLATFORM, but it's still
valid to select it when building for !ARCH_MULTIPLATFORM_STRICT and
selecting only the one machine that you want to run on.

So allow ARM_ERRATA and XIP_KERNEL options to be enabled without
ARCH_MULTIPLATFORM_STRICT.

Signed-off-by: Xia Kaixu <kaixu.xia@linaro.org>
---
 arch/arm/Kconfig | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 50762cc..14d0dce 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1091,7 +1091,7 @@ config ARM_ERRATA_430973
 config ARM_ERRATA_458693
 	bool "ARM errata: Processor deadlock when a false hazard is created"
 	depends on CPU_V7
-	depends on !ARCH_MULTIPLATFORM
+	depends on !ARCH_MULTIPLATFORM_STRICT
 	help
 	  This option enables the workaround for the 458693 Cortex-A8 (r2p0)
 	  erratum. For very specific sequences of memory operations, it is
@@ -1105,7 +1105,7 @@ config ARM_ERRATA_458693
 config ARM_ERRATA_460075
 	bool "ARM errata: Data written to the L2 cache can be overwritten with stale data"
 	depends on CPU_V7
-	depends on !ARCH_MULTIPLATFORM
+	depends on !ARCH_MULTIPLATFORM_STRICT
 	help
 	  This option enables the workaround for the 460075 Cortex-A8 (r2p0)
 	  erratum. Any asynchronous access to the L2 cache may encounter a
@@ -1118,7 +1118,7 @@ config ARM_ERRATA_460075
 config ARM_ERRATA_742230
 	bool "ARM errata: DMB operation may be faulty"
 	depends on CPU_V7 && SMP
-	depends on !ARCH_MULTIPLATFORM
+	depends on !ARCH_MULTIPLATFORM_STRICT
 	help
 	  This option enables the workaround for the 742230 Cortex-A9
 	  (r1p0..r2p2) erratum. Under rare circumstances, a DMB instruction
@@ -1131,7 +1131,7 @@ config ARM_ERRATA_742230
 config ARM_ERRATA_742231
 	bool "ARM errata: Incorrect hazard handling in the SCU may lead to data corruption"
 	depends on CPU_V7 && SMP
-	depends on !ARCH_MULTIPLATFORM
+	depends on !ARCH_MULTIPLATFORM_STRICT
 	help
 	  This option enables the workaround for the 742231 Cortex-A9
 	  (r2p0..r2p2) erratum. Under certain conditions, specific to the
@@ -1168,7 +1168,7 @@ config ARM_ERRATA_720789
 config ARM_ERRATA_743622
 	bool "ARM errata: Faulty hazard checking in the Store Buffer may lead to data corruption"
 	depends on CPU_V7
-	depends on !ARCH_MULTIPLATFORM
+	depends on !ARCH_MULTIPLATFORM_STRICT
 	help
 	  This option enables the workaround for the 743622 Cortex-A9
 	  (r2p*) erratum. Under very rare conditions, a faulty
@@ -1182,7 +1182,7 @@ config ARM_ERRATA_743622
 config ARM_ERRATA_751472
 	bool "ARM errata: Interrupted ICIALLUIS may prevent completion of broadcasted operation"
 	depends on CPU_V7
-	depends on !ARCH_MULTIPLATFORM
+	depends on !ARCH_MULTIPLATFORM_STRICT
 	help
 	  This option enables the workaround for the 751472 Cortex-A9 (prior
 	  to r3p0) erratum. An interrupted ICIALLUIS operation may prevent the
@@ -1987,7 +1987,7 @@ endchoice
 
 config XIP_KERNEL
 	bool "Kernel Execute-In-Place from ROM"
-	depends on !ARM_LPAE && !ARCH_MULTIPLATFORM
+	depends on !ARM_LPAE && !ARCH_MULTIPLATFORM_STRICT
 	help
 	  Execute-In-Place allows the kernel to run from non-volatile storage
 	  directly addressable by the CPU, such as NOR flash. This saves RAM
-- 
2.1.1
