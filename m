From: michal.simek@xilinx.com (Michal Simek)
Date: Mon,  6 Oct 2014 13:44:24 +0200
Subject: [PATCH 1/3] ARM: zynq: Move common.h to generic location
Message-ID: <565908c2d70764e281d6a9b28d9599cea87823a3.1412595859.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

include/soc/zynq/ is the right location for this header
to be able to share information from this header with other
drivers which require it.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm/mach-zynq/common.c                       | 2 +-
 arch/arm/mach-zynq/hotplug.c                      | 2 +-
 arch/arm/mach-zynq/platsmp.c                      | 2 +-
 arch/arm/mach-zynq/slcr.c                         | 2 +-
 {arch/arm/mach-zynq => include/soc/zynq}/common.h | 0
 5 files changed, 4 insertions(+), 4 deletions(-)
 rename {arch/arm/mach-zynq => include/soc/zynq}/common.h (100%)

diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 31a6fa40ba37..ead1935aac79 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -42,7 +42,7 @@
 #include <asm/system_info.h>
 #include <asm/hardware/cache-l2x0.h>

-#include "common.h"
+#include <soc/zynq/common.h>

 #define ZYNQ_DEVCFG_MCTRL		0x80
 #define ZYNQ_DEVCFG_PS_VERSION_SHIFT	28
diff --git a/arch/arm/mach-zynq/hotplug.c b/arch/arm/mach-zynq/hotplug.c
index 5052c70326e4..95d74f68032a 100644
--- a/arch/arm/mach-zynq/hotplug.c
+++ b/arch/arm/mach-zynq/hotplug.c
@@ -16,7 +16,7 @@

 #include <asm/cacheflush.h>
 #include <asm/cp15.h>
-#include "common.h"
+#include <soc/zynq/common.h>

 static inline void zynq_cpu_enter_lowpower(void)
 {
diff --git a/arch/arm/mach-zynq/platsmp.c b/arch/arm/mach-zynq/platsmp.c
index abc82ef085c1..56581ccd7c14 100644
--- a/arch/arm/mach-zynq/platsmp.c
+++ b/arch/arm/mach-zynq/platsmp.c
@@ -25,7 +25,7 @@
 #include <asm/cacheflush.h>
 #include <asm/smp_scu.h>
 #include <linux/irqchip/arm-gic.h>
-#include "common.h"
+#include <soc/zynq/common.h>

 /*
  * Store number of cores in the system
diff --git a/arch/arm/mach-zynq/slcr.c b/arch/arm/mach-zynq/slcr.c
index c43a2d16e223..cb7c46165728 100644
--- a/arch/arm/mach-zynq/slcr.c
+++ b/arch/arm/mach-zynq/slcr.c
@@ -19,7 +19,7 @@
 #include <linux/of_address.h>
 #include <linux/regmap.h>
 #include <linux/clk/zynq.h>
-#include "common.h"
+#include <soc/zynq/common.h>

 /* register offsets */
 #define SLCR_UNLOCK_OFFSET		0x8   /* SCLR unlock register */
diff --git a/arch/arm/mach-zynq/common.h b/include/soc/zynq/common.h
similarity index 100%
rename from arch/arm/mach-zynq/common.h
rename to include/soc/zynq/common.h
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141006/32af7f7f/attachment-0001.sig>
