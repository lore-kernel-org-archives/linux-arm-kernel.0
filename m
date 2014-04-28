From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon, 28 Apr 2014 14:53:44 +0800
Subject: [PATCH v4 06/14] ARM: mcpm: support 4 clusters
In-Reply-To: <1398668032-8335-1-git-send-email-haojian.zhuang@linaro.org>
References: <1398668032-8335-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1398668032-8335-7-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the CONFIG_MCPM_QUAD_CLUSTER configuration to enlarge cluster number
from 2 to 4.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/Kconfig            | 6 ++++++
 arch/arm/include/asm/mcpm.h | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5ef96ea..58e995d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1572,6 +1572,12 @@ config MCPM
 	  for (multi-)cluster based systems, such as big.LITTLE based
 	  systems.
 
+config MCPM_QUAD_CLUSTER
+	bool "Enable Quad clusters in MCPM"
+	depends on MCPM
+	help
+	  This option enables quad clusters in MCPM.
+
 config BIG_LITTLE
 	bool "big.LITTLE support (Experimental)"
 	depends on CPU_V7 && SMP
diff --git a/arch/arm/include/asm/mcpm.h b/arch/arm/include/asm/mcpm.h
index 608516e..fc8d70d 100644
--- a/arch/arm/include/asm/mcpm.h
+++ b/arch/arm/include/asm/mcpm.h
@@ -20,7 +20,12 @@
  * to consider dynamic allocation.
  */
 #define MAX_CPUS_PER_CLUSTER	4
+
+#ifdef CONFIG_MCPM_QUAD_CLUSTER
+#define MAX_NR_CLUSTERS		4
+#else
 #define MAX_NR_CLUSTERS		2
+#endif
 
 #ifndef __ASSEMBLY__
 
-- 
1.9.1
