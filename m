From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 26 May 2014 17:12:10 +0200
Subject: [PATCH] ARM: iop13xx: fix msi support with sparse IRQ
Message-ID: <12285212.fBJyVfk69p@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

patch 37ebbcff7837 ("arm: iop13xx: Use sparse irqs for MSI") moved
iop13xx over to sparse IRQ support, but this broke the build for the
msi.c file, which now has to include mach/irqs.h itself.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Grant Likely <grant.likely@linaro.org>

diff --git a/arch/arm/mach-iop13xx/msi.c b/arch/arm/mach-iop13xx/msi.c
index 655072d..e7730cf 100644
--- a/arch/arm/mach-iop13xx/msi.c
+++ b/arch/arm/mach-iop13xx/msi.c
@@ -23,6 +23,7 @@
 #include <linux/msi.h>
 #include <asm/mach/irq.h>
 #include <asm/irq.h>
+#include <mach/irqs.h>
 
 /* IMIPR0 CP6 R8 Page 1
  */
