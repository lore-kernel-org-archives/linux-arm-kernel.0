From: tushar.behera@linaro.org (Tushar Behera)
Date: Mon,  3 Oct 2011 15:10:41 +0530
Subject: [PATCH] ARM: S3C2410: Remove section mismatch warning
Message-ID: <1317634841-23339-1-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some of the functions and structures did not have _init or __initdata
attributes, even though they were referenced from functions / structures
with those attribute, resulting in section mismatches.

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---

The patch is rebased on v3.1-rc8.

The patch has only been build tested, they are not boot tested on any
hardware.

 arch/arm/mach-s3c2410/usb-simtec.c |    2 +-
 arch/arm/mach-s3c2410/usb-simtec.h |    2 +-
 arch/arm/mach-s3c2416/irq.c        |    2 +-
 arch/arm/mach-s3c2440/clock.c      |    4 ++--
 arch/arm/mach-s3c2443/irq.c        |    2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-s3c2410/usb-simtec.c b/arch/arm/mach-s3c2410/usb-simtec.c
index 29bd3d9..3a1028c 100644
--- a/arch/arm/mach-s3c2410/usb-simtec.c
+++ b/arch/arm/mach-s3c2410/usb-simtec.c
@@ -104,7 +104,7 @@ static struct s3c2410_hcd_info usb_simtec_info __initdata = {
 };
 
 
-int usb_simtec_init(void)
+int __init usb_simtec_init(void)
 {
 	int ret;
 
diff --git a/arch/arm/mach-s3c2410/usb-simtec.h b/arch/arm/mach-s3c2410/usb-simtec.h
index 03842ed..43cc88f 100644
--- a/arch/arm/mach-s3c2410/usb-simtec.h
+++ b/arch/arm/mach-s3c2410/usb-simtec.h
@@ -12,5 +12,5 @@
  * published by the Free Software Foundation.
 */
 
-extern int usb_simtec_init(void);
+extern int __init usb_simtec_init(void);
 
diff --git a/arch/arm/mach-s3c2416/irq.c b/arch/arm/mach-s3c2416/irq.c
index 28ad20d..153cb2f 100644
--- a/arch/arm/mach-s3c2416/irq.c
+++ b/arch/arm/mach-s3c2416/irq.c
@@ -234,7 +234,7 @@ static int __init s3c2416_irq_add(struct sys_device *sysdev)
 	return 0;
 }
 
-static struct sysdev_driver s3c2416_irq_driver = {
+static struct sysdev_driver s3c2416_irq_driver __initdata = {
 	.add		= s3c2416_irq_add,
 };
 
diff --git a/arch/arm/mach-s3c2440/clock.c b/arch/arm/mach-s3c2440/clock.c
index f9e6bda..3b3bec5 100644
--- a/arch/arm/mach-s3c2440/clock.c
+++ b/arch/arm/mach-s3c2440/clock.c
@@ -108,7 +108,7 @@ static struct clk s3c2440_clk_ac97 = {
 	.ctrlbit	= S3C2440_CLKCON_CAMERA,
 };
 
-static int s3c2440_clk_add(struct sys_device *sysdev)
+static int __init s3c2440_clk_add(struct sys_device *sysdev)
 {
 	struct clk *clock_upll;
 	struct clk *clock_h;
@@ -137,7 +137,7 @@ static int s3c2440_clk_add(struct sys_device *sysdev)
 	return 0;
 }
 
-static struct sysdev_driver s3c2440_clk_driver = {
+static struct sysdev_driver s3c2440_clk_driver __initdata = {
 	.add	= s3c2440_clk_add,
 };
 
diff --git a/arch/arm/mach-s3c2443/irq.c b/arch/arm/mach-s3c2443/irq.c
index 83ecb11..1d483d9 100644
--- a/arch/arm/mach-s3c2443/irq.c
+++ b/arch/arm/mach-s3c2443/irq.c
@@ -265,7 +265,7 @@ static int __init s3c2443_irq_add(struct sys_device *sysdev)
 	return 0;
 }
 
-static struct sysdev_driver s3c2443_irq_driver = {
+static struct sysdev_driver s3c2443_irq_driver __initdata = {
 	.add		= s3c2443_irq_add,
 };
 
-- 
1.7.4.1
