From: robherring2@gmail.com (Rob Herring)
Date: Mon,  9 Jan 2012 16:45:43 -0600
Subject: [PATCH 3/6] ARM: vexpress: remove incorrect BSYM usage
In-Reply-To: <1326149146-19756-1-git-send-email-robherring2@gmail.com>
References: <1326149146-19756-1-git-send-email-robherring2@gmail.com>
Message-ID: <1326149146-19756-4-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

BSYM macro is only needed for assembly files and its usage in c files is
wrong, so remove it. The linker will correctly set bit 0 for Thumb2
kernels.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mach-vexpress/platsmp.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
index 2b5f7ac..124ffb1 100644
--- a/arch/arm/mach-vexpress/platsmp.c
+++ b/arch/arm/mach-vexpress/platsmp.c
@@ -13,8 +13,6 @@
 #include <linux/smp.h>
 #include <linux/io.h>
 
-#include <asm/unified.h>
-
 #include <mach/motherboard.h>
 #define V2M_PA_CS7 0x10000000
 
@@ -46,6 +44,6 @@ void __init platform_smp_prepare_cpus(unsigned int max_cpus)
 	 * secondary CPU branches to this address.
 	 */
 	writel(~0, MMIO_P2V(V2M_SYS_FLAGSCLR));
-	writel(BSYM(virt_to_phys(versatile_secondary_startup)),
+	writel(virt_to_phys(versatile_secondary_startup),
 		MMIO_P2V(V2M_SYS_FLAGSSET));
 }
-- 
1.7.5.4
