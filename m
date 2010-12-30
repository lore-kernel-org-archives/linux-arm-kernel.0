From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 30 Dec 2010 12:56:05 +0800
Subject: [PATCH v3 4/8] arm: mx5: mx51/53 have different mxc_cpu_type
	definition
In-Reply-To: <1293684968-7338-3-git-send-email-richard.zhao@freescale.com>
References: <1293684968-7338-1-git-send-email-richard.zhao@freescale.com>
	<1293684968-7338-2-git-send-email-richard.zhao@freescale.com>
	<1293684968-7338-3-git-send-email-richard.zhao@freescale.com>
Message-ID: <1293684968-7338-4-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 arch/arm/plat-mxc/include/mach/mxc.h |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mxc.h b/arch/arm/plat-mxc/include/mach/mxc.h
index 4abbdd1..eca8f83 100644
--- a/arch/arm/plat-mxc/include/mach/mxc.h
+++ b/arch/arm/plat-mxc/include/mach/mxc.h
@@ -126,7 +126,7 @@ extern unsigned int __mxc_cpu_type;
 # define cpu_is_mx35()		(0)
 #endif
 
-#ifdef CONFIG_ARCH_MX5
+#ifdef CONFIG_ARCH_MX51
 # ifdef mxc_cpu_type
 #  undef mxc_cpu_type
 #  define mxc_cpu_type __mxc_cpu_type
@@ -134,11 +134,22 @@ extern unsigned int __mxc_cpu_type;
 #  define mxc_cpu_type MXC_CPU_MX51
 # endif
 # define cpu_is_mx51()		(mxc_cpu_type == MXC_CPU_MX51)
-# define cpu_is_mx53()		(mxc_cpu_type == MXC_CPU_MX53)
 #else
 # define cpu_is_mx51()		(0)
 #endif
 
+#ifdef CONFIG_ARCH_MX53
+# ifdef mxc_cpu_type
+#  undef mxc_cpu_type
+#  define mxc_cpu_type __mxc_cpu_type
+# else
+#  define mxc_cpu_type MXC_CPU_MX53
+# endif
+# define cpu_is_mx53()		(mxc_cpu_type == MXC_CPU_MX53)
+#else
+# define cpu_is_mx53()		(0)
+#endif
+
 #ifdef CONFIG_ARCH_MXC91231
 # ifdef mxc_cpu_type
 #  undef mxc_cpu_type
-- 
1.6.3.3
