From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 21 Jan 2012 13:36:14 +0900
Subject: [PATCH 3/7] ARM: S3C64XX: use static declaration when it is not used
 in other files
Message-ID: <010b01ccd7f6$35abf410$a103dc30$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c64xx/common.c |    2 +-
 arch/arm/mach-s3c64xx/common.h |    2 --
 arch/arm/mach-s3c64xx/irq-pm.c |    2 +-
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/common.c b/arch/arm/mach-s3c64xx/common.c
index 4a7394d..bee7dcd 100644
--- a/arch/arm/mach-s3c64xx/common.c
+++ b/arch/arm/mach-s3c64xx/common.c
@@ -49,7 +49,7 @@
 
 /* uart registration process */
 
-void __init s3c64xx_init_uarts(struct s3c2410_uartcfg *cfg, int no)
+static void __init s3c64xx_init_uarts(struct s3c2410_uartcfg *cfg, int no)
 {
 	s3c24xx_init_uartdevs("s3c6400-uart", s3c64xx_uart_resources, cfg, no);
 }
diff --git a/arch/arm/mach-s3c64xx/common.h b/arch/arm/mach-s3c64xx/common.h
index 5eb9c9a..7a10be6 100644
--- a/arch/arm/mach-s3c64xx/common.h
+++ b/arch/arm/mach-s3c64xx/common.h
@@ -25,8 +25,6 @@ void s3c64xx_setup_clocks(void);
 
 void s3c64xx_restart(char mode, const char *cmd);
 
-extern struct syscore_ops s3c64xx_irq_syscore_ops;
-
 #ifdef CONFIG_CPU_S3C6400
 
 extern  int s3c6400_init(void);
diff --git a/arch/arm/mach-s3c64xx/irq-pm.c b/arch/arm/mach-s3c64xx/irq-pm.c
index 8bec61e..0c7e1d9 100644
--- a/arch/arm/mach-s3c64xx/irq-pm.c
+++ b/arch/arm/mach-s3c64xx/irq-pm.c
@@ -96,7 +96,7 @@ static void s3c64xx_irq_pm_resume(void)
 	S3C_PMDBG("%s: IRQ configuration restored\n", __func__);
 }
 
-struct syscore_ops s3c64xx_irq_syscore_ops = {
+static struct syscore_ops s3c64xx_irq_syscore_ops = {
 	.suspend = s3c64xx_irq_pm_suspend,
 	.resume	 = s3c64xx_irq_pm_resume,
 };
-- 
1.7.1
