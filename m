From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Thu, 2 Jun 2011 12:57:41 +0200
Subject: [PATCH v3 2/3] Move s3c24xx_irq_syscore_ops to plat-s3c24xx/irq.c
In-Reply-To: <201106021254.57644.heiko@sntech.de>
References: <201106021254.57644.heiko@sntech.de>
Message-ID: <201106021257.41445.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

s3c24xx_irq_syscore_ops was only defined for s3c2410 cpus leading
to compile errors on for example 2412 and 2416.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c2410/irq.c |    5 -----
 arch/arm/plat-s3c24xx/irq.c |    6 ++++++
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-s3c2410/irq.c b/arch/arm/mach-s3c2410/irq.c
index 2854129..4428695 100644
--- a/arch/arm/mach-s3c2410/irq.c
+++ b/arch/arm/mach-s3c2410/irq.c
@@ -27,8 +27,3 @@
 
 #include <plat/cpu.h>
 #include <plat/pm.h>
-
-struct syscore_ops s3c24xx_irq_syscore_ops = {
-	.suspend	= s3c24xx_irq_suspend,
-	.resume		= s3c24xx_irq_resume,
-};
diff --git a/arch/arm/plat-s3c24xx/irq.c b/arch/arm/plat-s3c24xx/irq.c
index 9aee7e1..fc8c5f8 100644
--- a/arch/arm/plat-s3c24xx/irq.c
+++ b/arch/arm/plat-s3c24xx/irq.c
@@ -23,6 +23,7 @@
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/sysdev.h>
+#include <linux/syscore_ops.h>
 
 #include <asm/irq.h>
 #include <asm/mach/irq.h>
@@ -668,3 +669,8 @@ void __init s3c24xx_init_irq(void)
 
 	irqdbf("s3c2410: registered interrupt handlers\n");
 }
+
+struct syscore_ops s3c24xx_irq_syscore_ops = {
+	.suspend	= s3c24xx_irq_suspend,
+	.resume		= s3c24xx_irq_resume,
+};
-- 
1.7.1
