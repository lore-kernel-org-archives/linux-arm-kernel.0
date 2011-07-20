From: tony.lin@freescale.com (Tony Lin)
Date: Wed, 20 Jul 2011 19:08:25 +0800
Subject: [PATCH 6/7] add macro definitions according to ehci-mxc driver change
In-Reply-To: <1311160106-4898-1-git-send-email-tony.lin@freescale.com>
References: <1311160106-4898-1-git-send-email-tony.lin@freescale.com>
Message-ID: <1311160106-4898-7-git-send-email-tony.lin@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tony Lin <tony.lin@freescale.com>
---
 arch/arm/mach-mxs/include/mach/hardware.h |    2 ++
 arch/arm/mach-mxs/include/mach/mxs.h      |   12 +++++++++++-
 arch/arm/plat-mxc/include/mach/mxc.h      |    3 +++
 3 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mxs/include/mach/hardware.h b/arch/arm/mach-mxs/include/mach/hardware.h
index 53e89a0..affa72b 100644
--- a/arch/arm/mach-mxs/include/mach/hardware.h
+++ b/arch/arm/mach-mxs/include/mach/hardware.h
@@ -26,4 +26,6 @@
 #define IOMEM(addr)	((void __force __iomem *)(addr))
 #endif
 
+#include "mxs.h"
+
 #endif /* __MACH_MXS_HARDWARE_H__ */
diff --git a/arch/arm/mach-mxs/include/mach/mxs.h b/arch/arm/mach-mxs/include/mach/mxs.h
index 35a89dd..6e5928d 100644
--- a/arch/arm/mach-mxs/include/mach/mxs.h
+++ b/arch/arm/mach-mxs/include/mach/mxs.h
@@ -35,7 +35,17 @@
 		machine_is_mx28evk() ||					\
 		machine_is_tx28() ||					\
 		0)
-
+#define cpu_is_mx1()		(0)
+#define cpu_is_mx21()		(0)
+#define cpu_is_mx25()		(0)
+#define cpu_is_mx27()		(0)
+#define cpu_is_mx31()		(0)
+#define cpu_is_mx35()		(0)
+#define cpu_is_mx50()		(0)
+#define cpu_is_mx51()		(0)
+#define cpu_is_mx53()		(0)
+#define cpu_is_mx3()		(cpu_is_mx31() || cpu_is_mx35())
+#define cpu_is_mx2()		(cpu_is_mx21() || cpu_is_mx27())
 /*
  * IO addresses common to MXS-based
  */
diff --git a/arch/arm/plat-mxc/include/mach/mxc.h b/arch/arm/plat-mxc/include/mach/mxc.h
index 0987923..d4dbe9e 100644
--- a/arch/arm/plat-mxc/include/mach/mxc.h
+++ b/arch/arm/plat-mxc/include/mach/mxc.h
@@ -176,6 +176,9 @@ extern unsigned int __mxc_cpu_type;
 # define cpu_is_mx53()		(0)
 #endif
 
+# define cpu_is_mx23()		(0)
+# define cpu_is_mx28()		(0)
+
 #ifndef __ASSEMBLY__
 
 struct cpu_op {
-- 
1.7.0.4
