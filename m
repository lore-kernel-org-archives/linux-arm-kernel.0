From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 09 May 2012 03:34:48 +0530
Subject: [PATCH 04/10] ARM: Samsung: Remove pdev pointer paremeter from spi
 gpio setup functions
In-Reply-To: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
References: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1336514694-22393-5-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform data pointer that is passed to the spi gpio setup functions
is not used. Hence, this paremeter is removed from all the spi gpio setup
functions.

Cc: Jaswinder Singh <jaswinder.singh@linaro.org>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos/setup-spi.c                 |    8 +++-----
 arch/arm/mach-s3c24xx/setup-spi.c                |    2 +-
 arch/arm/mach-s3c64xx/setup-spi.c                |    6 ++----
 arch/arm/mach-s5p64x0/setup-spi.c                |    5 ++---
 arch/arm/mach-s5pc100/setup-spi.c                |    8 +++-----
 arch/arm/mach-s5pv210/setup-spi.c                |    6 ++----
 arch/arm/plat-samsung/include/plat/s3c64xx-spi.h |    8 ++++----
 7 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-exynos/setup-spi.c b/arch/arm/mach-exynos/setup-spi.c
index a71ec4d..4999829 100644
--- a/arch/arm/mach-exynos/setup-spi.c
+++ b/arch/arm/mach-exynos/setup-spi.c
@@ -9,12 +9,10 @@
  */
 
 #include <linux/gpio.h>
-#include <linux/platform_device.h>
-
 #include <plat/gpio-cfg.h>
 
 #ifdef CONFIG_S3C64XX_DEV_SPI0
-int s3c64xx_spi0_cfg_gpio(struct platform_device *dev)
+int s3c64xx_spi0_cfg_gpio(void)
 {
 	s3c_gpio_cfgpin(EXYNOS4_GPB(0), S3C_GPIO_SFN(2));
 	s3c_gpio_setpull(EXYNOS4_GPB(0), S3C_GPIO_PULL_UP);
@@ -25,7 +23,7 @@ int s3c64xx_spi0_cfg_gpio(struct platform_device *dev)
 #endif
 
 #ifdef CONFIG_S3C64XX_DEV_SPI1
-int s3c64xx_spi1_cfg_gpio(struct platform_device *dev)
+int s3c64xx_spi1_cfg_gpio(void)
 {
 	s3c_gpio_cfgpin(EXYNOS4_GPB(4), S3C_GPIO_SFN(2));
 	s3c_gpio_setpull(EXYNOS4_GPB(4), S3C_GPIO_PULL_UP);
@@ -36,7 +34,7 @@ int s3c64xx_spi1_cfg_gpio(struct platform_device *dev)
 #endif
 
 #ifdef CONFIG_S3C64XX_DEV_SPI2
-int s3c64xx_spi2_cfg_gpio(struct platform_device *dev)
+int s3c64xx_spi2_cfg_gpio(void)
 {
 	s3c_gpio_cfgpin(EXYNOS4_GPC1(1), S3C_GPIO_SFN(5));
 	s3c_gpio_setpull(EXYNOS4_GPC1(1), S3C_GPIO_PULL_UP);
diff --git a/arch/arm/mach-s3c24xx/setup-spi.c b/arch/arm/mach-s3c24xx/setup-spi.c
index 42abe15..3d47e02 100644
--- a/arch/arm/mach-s3c24xx/setup-spi.c
+++ b/arch/arm/mach-s3c24xx/setup-spi.c
@@ -18,7 +18,7 @@
 #include <mach/regs-gpio.h>
 
 #ifdef CONFIG_S3C64XX_DEV_SPI0
-int s3c64xx_spi0_cfg_gpio(struct platform_device *pdev)
+int s3c64xx_spi0_cfg_gpio(void)
 {
 	/* enable hsspi bit in misccr */
 	s3c2410_modify_misccr(S3C2416_MISCCR_HSSPI_EN2, 1);
diff --git a/arch/arm/mach-s3c64xx/setup-spi.c b/arch/arm/mach-s3c64xx/setup-spi.c
index ff999d9..4dc5345 100644
--- a/arch/arm/mach-s3c64xx/setup-spi.c
+++ b/arch/arm/mach-s3c64xx/setup-spi.c
@@ -9,12 +9,10 @@
  */
 
 #include <linux/gpio.h>
-#include <linux/platform_device.h>
-
 #include <plat/gpio-cfg.h>
 
 #ifdef CONFIG_S3C64XX_DEV_SPI0
-int s3c64xx_spi0_cfg_gpio(struct platform_device *dev)
+int s3c64xx_spi0_cfg_gpio(void)
 {
 	s3c_gpio_cfgall_range(S3C64XX_GPC(0), 3,
 				S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
@@ -23,7 +21,7 @@ int s3c64xx_spi0_cfg_gpio(struct platform_device *dev)
 #endif
 
 #ifdef CONFIG_S3C64XX_DEV_SPI1
-int s3c64xx_spi1_cfg_gpio(struct platform_device *dev)
+int s3c64xx_spi1_cfg_gpio(void)
 {
 	s3c_gpio_cfgall_range(S3C64XX_GPC(4), 3,
 				S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
diff --git a/arch/arm/mach-s5p64x0/setup-spi.c b/arch/arm/mach-s5p64x0/setup-spi.c
index 1cf84b5..7664356 100644
--- a/arch/arm/mach-s5p64x0/setup-spi.c
+++ b/arch/arm/mach-s5p64x0/setup-spi.c
@@ -9,11 +9,10 @@
  */
 
 #include <linux/gpio.h>
-#include <linux/platform_device.h>
 #include <plat/gpio-cfg.h>
 
 #ifdef CONFIG_S3C64XX_DEV_SPI0
-int s3c64xx_spi0_cfg_gpio(struct platform_device *dev)
+int s3c64xx_spi0_cfg_gpio(void)
 {
 	if (soc_is_s5p6450())
 		s3c_gpio_cfgall_range(S5P6450_GPC(0), 3,
@@ -26,7 +25,7 @@ int s3c64xx_spi0_cfg_gpio(struct platform_device *dev)
 #endif
 
 #ifdef CONFIG_S3C64XX_DEV_SPI1
-int s3c64xx_spi1_cfg_gpio(struct platform_device *dev)
+int s3c64xx_spi1_cfg_gpio(void)
 {
 	if (soc_is_s5p6450())
 		s3c_gpio_cfgall_range(S5P6450_GPC(4), 3,
diff --git a/arch/arm/mach-s5pc100/setup-spi.c b/arch/arm/mach-s5pc100/setup-spi.c
index 4b42718..1835679 100644
--- a/arch/arm/mach-s5pc100/setup-spi.c
+++ b/arch/arm/mach-s5pc100/setup-spi.c
@@ -9,12 +9,10 @@
  */
 
 #include <linux/gpio.h>
-#include <linux/platform_device.h>
-
 #include <plat/gpio-cfg.h>
 
 #ifdef CONFIG_S3C64XX_DEV_SPI0
-int s3c64xx_spi0_cfg_gpio(struct platform_device *dev)
+int s3c64xx_spi0_cfg_gpio(void)
 {
 	s3c_gpio_cfgall_range(S5PC100_GPB(0), 3,
 				S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
@@ -23,7 +21,7 @@ int s3c64xx_spi0_cfg_gpio(struct platform_device *dev)
 #endif
 
 #ifdef CONFIG_S3C64XX_DEV_SPI1
-int s3c64xx_spi1_cfg_gpio(struct platform_device *dev)
+int s3c64xx_spi1_cfg_gpio(void)
 {
 	s3c_gpio_cfgall_range(S5PC100_GPB(4), 3,
 				S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
@@ -32,7 +30,7 @@ int s3c64xx_spi1_cfg_gpio(struct platform_device *dev)
 #endif
 
 #ifdef CONFIG_S3C64XX_DEV_SPI2
-int s3c64xx_spi2_cfg_gpio(struct platform_device *dev)
+int s3c64xx_spi2_cfg_gpio(void)
 {
 	s3c_gpio_cfgpin(S5PC100_GPG3(0), S3C_GPIO_SFN(3));
 	s3c_gpio_setpull(S5PC100_GPG3(0), S3C_GPIO_PULL_UP);
diff --git a/arch/arm/mach-s5pv210/setup-spi.c b/arch/arm/mach-s5pv210/setup-spi.c
index 2cd66a6..81aecc1 100644
--- a/arch/arm/mach-s5pv210/setup-spi.c
+++ b/arch/arm/mach-s5pv210/setup-spi.c
@@ -9,12 +9,10 @@
  */
 
 #include <linux/gpio.h>
-#include <linux/platform_device.h>
-
 #include <plat/gpio-cfg.h>
 
 #ifdef CONFIG_S3C64XX_DEV_SPI0
-int s3c64xx_spi0_cfg_gpio(struct platform_device *dev)
+int s3c64xx_spi0_cfg_gpio(void)
 {
 	s3c_gpio_cfgpin(S5PV210_GPB(0), S3C_GPIO_SFN(2));
 	s3c_gpio_setpull(S5PV210_GPB(0), S3C_GPIO_PULL_UP);
@@ -25,7 +23,7 @@ int s3c64xx_spi0_cfg_gpio(struct platform_device *dev)
 #endif
 
 #ifdef CONFIG_S3C64XX_DEV_SPI1
-int s3c64xx_spi1_cfg_gpio(struct platform_device *dev)
+int s3c64xx_spi1_cfg_gpio(void)
 {
 	s3c_gpio_cfgpin(S5PV210_GPB(4), S3C_GPIO_SFN(2));
 	s3c_gpio_setpull(S5PV210_GPB(4), S3C_GPIO_PULL_UP);
diff --git a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
index 4e9b9c3..89dbaee 100644
--- a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
+++ b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
@@ -39,7 +39,7 @@ struct s3c64xx_spi_csinfo {
 struct s3c64xx_spi_info {
 	int src_clk_nr;
 	int num_cs;
-	int (*cfg_gpio)(struct platform_device *pdev);
+	int (*cfg_gpio)(void);
 };
 
 /**
@@ -60,9 +60,9 @@ extern void s3c64xx_spi2_set_platdata(struct s3c64xx_spi_info *pd,
 				      int src_clk_nr, int num_cs);
 
 /* defined by architecture to configure gpio */
-extern int s3c64xx_spi0_cfg_gpio(struct platform_device *dev);
-extern int s3c64xx_spi1_cfg_gpio(struct platform_device *dev);
-extern int s3c64xx_spi2_cfg_gpio(struct platform_device *dev);
+extern int s3c64xx_spi0_cfg_gpio(void);
+extern int s3c64xx_spi1_cfg_gpio(void);
+extern int s3c64xx_spi2_cfg_gpio(void);
 
 extern struct s3c64xx_spi_info s3c64xx_spi0_pdata;
 extern struct s3c64xx_spi_info s3c64xx_spi1_pdata;
-- 
1.6.6.rc2
