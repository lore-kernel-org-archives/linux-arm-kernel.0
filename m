From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed,  6 Jan 2010 10:31:45 -0800
Subject: [PATCH 03/35] davinci: move DDR2 controller defines to memory.h
In-Reply-To: <1262802737-6601-3-git-send-email-khilman@deeprootsystems.com>
References: <1262802737-6601-1-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-2-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-3-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1262802737-6601-4-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

Move defintions of DDR2 controller registers to memory.h
from cpuidle.c. The motivation behind the change is to be
able to use these defintions in assembly code that puts
DDR2 in self-refresh and enables the SoC to enter suspend
state.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/cpuidle.c             |    5 +----
 arch/arm/mach-davinci/include/mach/memory.h |    4 ++++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/cpuidle.c b/arch/arm/mach-davinci/cpuidle.c
index 97a90f3..beda3b5 100644
--- a/arch/arm/mach-davinci/cpuidle.c
+++ b/arch/arm/mach-davinci/cpuidle.c
@@ -19,6 +19,7 @@
 #include <asm/proc-fns.h>
 
 #include <mach/cpuidle.h>
+#include <mach/memory.h>
 
 #define DAVINCI_CPUIDLE_MAX_STATES	2
 
@@ -39,10 +40,6 @@ static struct cpuidle_driver davinci_idle_driver = {
 static DEFINE_PER_CPU(struct cpuidle_device, davinci_cpuidle_device);
 static void __iomem *ddr2_reg_base;
 
-#define DDR2_SDRCR_OFFSET	0xc
-#define DDR2_SRPD_BIT		BIT(23)
-#define DDR2_LPMODEN_BIT	BIT(31)
-
 static void davinci_save_ddr_power(int enter, bool pdown)
 {
 	u32 val;
diff --git a/arch/arm/mach-davinci/include/mach/memory.h b/arch/arm/mach-davinci/include/mach/memory.h
index 80309ae..7aeaf46 100644
--- a/arch/arm/mach-davinci/include/mach/memory.h
+++ b/arch/arm/mach-davinci/include/mach/memory.h
@@ -31,6 +31,10 @@
 #define PHYS_OFFSET DAVINCI_DDR_BASE
 #endif
 
+#define DDR2_SDRCR_OFFSET	0xc
+#define DDR2_SRPD_BIT		BIT(23)
+#define DDR2_LPMODEN_BIT	BIT(31)
+
 /*
  * Increase size of DMA-consistent memory region
  */
-- 
1.6.6.rc2.1.g42108
