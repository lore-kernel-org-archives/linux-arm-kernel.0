From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 09 May 2012 03:34:47 +0530
Subject: [PATCH 03/10] ARM: Samsung: Remove spi hardware controller information
 from platform data
In-Reply-To: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
References: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1336514694-22393-4-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the spi hardware controller information moved to spi driver data,
this information can be removed from the spi platform data.

Cc: Jaswinder Singh <jaswinder.singh@linaro.org>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos/setup-spi.c                 |   25 ----------------------
 arch/arm/mach-s3c24xx/setup-spi.c                |    8 -------
 arch/arm/mach-s3c64xx/setup-spi.c                |   13 -----------
 arch/arm/mach-s5p64x0/setup-spi.c                |   16 --------------
 arch/arm/mach-s5pc100/setup-spi.c                |   22 -------------------
 arch/arm/mach-s5pv210/setup-spi.c                |   15 -------------
 arch/arm/plat-samsung/include/plat/s3c64xx-spi.h |   15 -------------
 7 files changed, 0 insertions(+), 114 deletions(-)

diff --git a/arch/arm/mach-exynos/setup-spi.c b/arch/arm/mach-exynos/setup-spi.c
index 833ff40..a71ec4d 100644
--- a/arch/arm/mach-exynos/setup-spi.c
+++ b/arch/arm/mach-exynos/setup-spi.c
@@ -12,17 +12,8 @@
 #include <linux/platform_device.h>
 
 #include <plat/gpio-cfg.h>
-#include <plat/s3c64xx-spi.h>
 
 #ifdef CONFIG_S3C64XX_DEV_SPI0
-struct s3c64xx_spi_info s3c64xx_spi0_pdata __initdata = {
-	.fifo_lvl_mask	= 0x1ff,
-	.rx_lvl_offset	= 15,
-	.high_speed	= 1,
-	.clk_from_cmu	= true,
-	.tx_st_done	= 25,
-};
-
 int s3c64xx_spi0_cfg_gpio(struct platform_device *dev)
 {
 	s3c_gpio_cfgpin(EXYNOS4_GPB(0), S3C_GPIO_SFN(2));
@@ -34,14 +25,6 @@ int s3c64xx_spi0_cfg_gpio(struct platform_device *dev)
 #endif
 
 #ifdef CONFIG_S3C64XX_DEV_SPI1
-struct s3c64xx_spi_info s3c64xx_spi1_pdata __initdata = {
-	.fifo_lvl_mask	= 0x7f,
-	.rx_lvl_offset	= 15,
-	.high_speed	= 1,
-	.clk_from_cmu	= true,
-	.tx_st_done	= 25,
-};
-
 int s3c64xx_spi1_cfg_gpio(struct platform_device *dev)
 {
 	s3c_gpio_cfgpin(EXYNOS4_GPB(4), S3C_GPIO_SFN(2));
@@ -53,14 +36,6 @@ int s3c64xx_spi1_cfg_gpio(struct platform_device *dev)
 #endif
 
 #ifdef CONFIG_S3C64XX_DEV_SPI2
-struct s3c64xx_spi_info s3c64xx_spi2_pdata __initdata = {
-	.fifo_lvl_mask	= 0x7f,
-	.rx_lvl_offset	= 15,
-	.high_speed	= 1,
-	.clk_from_cmu	= true,
-	.tx_st_done	= 25,
-};
-
 int s3c64xx_spi2_cfg_gpio(struct platform_device *dev)
 {
 	s3c_gpio_cfgpin(EXYNOS4_GPC1(1), S3C_GPIO_SFN(5));
diff --git a/arch/arm/mach-s3c24xx/setup-spi.c b/arch/arm/mach-s3c24xx/setup-spi.c
index 5712c85..42abe15 100644
--- a/arch/arm/mach-s3c24xx/setup-spi.c
+++ b/arch/arm/mach-s3c24xx/setup-spi.c
@@ -13,19 +13,11 @@
 #include <linux/platform_device.h>
 
 #include <plat/gpio-cfg.h>
-#include <plat/s3c64xx-spi.h>
 
 #include <mach/hardware.h>
 #include <mach/regs-gpio.h>
 
 #ifdef CONFIG_S3C64XX_DEV_SPI0
-struct s3c64xx_spi_info s3c64xx_spi0_pdata __initdata = {
-	.fifo_lvl_mask	= 0x7f,
-	.rx_lvl_offset	= 13,
-	.tx_st_done	= 21,
-	.high_speed	= 1,
-};
-
 int s3c64xx_spi0_cfg_gpio(struct platform_device *pdev)
 {
 	/* enable hsspi bit in misccr */
diff --git a/arch/arm/mach-s3c64xx/setup-spi.c b/arch/arm/mach-s3c64xx/setup-spi.c
index d9592ad..ff999d9 100644
--- a/arch/arm/mach-s3c64xx/setup-spi.c
+++ b/arch/arm/mach-s3c64xx/setup-spi.c
@@ -12,15 +12,8 @@
 #include <linux/platform_device.h>
 
 #include <plat/gpio-cfg.h>
-#include <plat/s3c64xx-spi.h>
 
 #ifdef CONFIG_S3C64XX_DEV_SPI0
-struct s3c64xx_spi_info s3c64xx_spi0_pdata __initdata = {
-	.fifo_lvl_mask	= 0x7f,
-	.rx_lvl_offset	= 13,
-	.tx_st_done	= 21,
-};
-
 int s3c64xx_spi0_cfg_gpio(struct platform_device *dev)
 {
 	s3c_gpio_cfgall_range(S3C64XX_GPC(0), 3,
@@ -30,12 +23,6 @@ int s3c64xx_spi0_cfg_gpio(struct platform_device *dev)
 #endif
 
 #ifdef CONFIG_S3C64XX_DEV_SPI1
-struct s3c64xx_spi_info s3c64xx_spi1_pdata __initdata = {
-	.fifo_lvl_mask	= 0x7f,
-	.rx_lvl_offset	= 13,
-	.tx_st_done	= 21,
-};
-
 int s3c64xx_spi1_cfg_gpio(struct platform_device *dev)
 {
 	s3c_gpio_cfgall_range(S3C64XX_GPC(4), 3,
diff --git a/arch/arm/mach-s5p64x0/setup-spi.c b/arch/arm/mach-s5p64x0/setup-spi.c
index e9b8412..1cf84b5 100644
--- a/arch/arm/mach-s5p64x0/setup-spi.c
+++ b/arch/arm/mach-s5p64x0/setup-spi.c
@@ -10,19 +10,9 @@
 
 #include <linux/gpio.h>
 #include <linux/platform_device.h>
-#include <linux/io.h>
-
 #include <plat/gpio-cfg.h>
-#include <plat/cpu.h>
-#include <plat/s3c64xx-spi.h>
 
 #ifdef CONFIG_S3C64XX_DEV_SPI0
-struct s3c64xx_spi_info s3c64xx_spi0_pdata __initdata = {
-	.fifo_lvl_mask	= 0x1ff,
-	.rx_lvl_offset	= 15,
-	.tx_st_done	= 25,
-};
-
 int s3c64xx_spi0_cfg_gpio(struct platform_device *dev)
 {
 	if (soc_is_s5p6450())
@@ -36,12 +26,6 @@ int s3c64xx_spi0_cfg_gpio(struct platform_device *dev)
 #endif
 
 #ifdef CONFIG_S3C64XX_DEV_SPI1
-struct s3c64xx_spi_info s3c64xx_spi1_pdata __initdata = {
-	.fifo_lvl_mask	= 0x7f,
-	.rx_lvl_offset	= 15,
-	.tx_st_done	= 25,
-};
-
 int s3c64xx_spi1_cfg_gpio(struct platform_device *dev)
 {
 	if (soc_is_s5p6450())
diff --git a/arch/arm/mach-s5pc100/setup-spi.c b/arch/arm/mach-s5pc100/setup-spi.c
index 431a6f7..4b42718 100644
--- a/arch/arm/mach-s5pc100/setup-spi.c
+++ b/arch/arm/mach-s5pc100/setup-spi.c
@@ -12,16 +12,8 @@
 #include <linux/platform_device.h>
 
 #include <plat/gpio-cfg.h>
-#include <plat/s3c64xx-spi.h>
 
 #ifdef CONFIG_S3C64XX_DEV_SPI0
-struct s3c64xx_spi_info s3c64xx_spi0_pdata __initdata = {
-	.fifo_lvl_mask	= 0x7f,
-	.rx_lvl_offset	= 13,
-	.high_speed	= 1,
-	.tx_st_done	= 21,
-};
-
 int s3c64xx_spi0_cfg_gpio(struct platform_device *dev)
 {
 	s3c_gpio_cfgall_range(S5PC100_GPB(0), 3,
@@ -31,13 +23,6 @@ int s3c64xx_spi0_cfg_gpio(struct platform_device *dev)
 #endif
 
 #ifdef CONFIG_S3C64XX_DEV_SPI1
-struct s3c64xx_spi_info s3c64xx_spi1_pdata __initdata = {
-	.fifo_lvl_mask	= 0x7f,
-	.rx_lvl_offset	= 13,
-	.high_speed	= 1,
-	.tx_st_done	= 21,
-};
-
 int s3c64xx_spi1_cfg_gpio(struct platform_device *dev)
 {
 	s3c_gpio_cfgall_range(S5PC100_GPB(4), 3,
@@ -47,13 +32,6 @@ int s3c64xx_spi1_cfg_gpio(struct platform_device *dev)
 #endif
 
 #ifdef CONFIG_S3C64XX_DEV_SPI2
-struct s3c64xx_spi_info s3c64xx_spi2_pdata __initdata = {
-	.fifo_lvl_mask	= 0x7f,
-	.rx_lvl_offset	= 13,
-	.high_speed	= 1,
-	.tx_st_done	= 21,
-};
-
 int s3c64xx_spi2_cfg_gpio(struct platform_device *dev)
 {
 	s3c_gpio_cfgpin(S5PC100_GPG3(0), S3C_GPIO_SFN(3));
diff --git a/arch/arm/mach-s5pv210/setup-spi.c b/arch/arm/mach-s5pv210/setup-spi.c
index f43c504..2cd66a6 100644
--- a/arch/arm/mach-s5pv210/setup-spi.c
+++ b/arch/arm/mach-s5pv210/setup-spi.c
@@ -12,16 +12,8 @@
 #include <linux/platform_device.h>
 
 #include <plat/gpio-cfg.h>
-#include <plat/s3c64xx-spi.h>
 
 #ifdef CONFIG_S3C64XX_DEV_SPI0
-struct s3c64xx_spi_info s3c64xx_spi0_pdata = {
-	.fifo_lvl_mask	= 0x1ff,
-	.rx_lvl_offset	= 15,
-	.high_speed	= 1,
-	.tx_st_done	= 25,
-};
-
 int s3c64xx_spi0_cfg_gpio(struct platform_device *dev)
 {
 	s3c_gpio_cfgpin(S5PV210_GPB(0), S3C_GPIO_SFN(2));
@@ -33,13 +25,6 @@ int s3c64xx_spi0_cfg_gpio(struct platform_device *dev)
 #endif
 
 #ifdef CONFIG_S3C64XX_DEV_SPI1
-struct s3c64xx_spi_info s3c64xx_spi1_pdata = {
-	.fifo_lvl_mask	= 0x7f,
-	.rx_lvl_offset	= 15,
-	.high_speed	= 1,
-	.tx_st_done	= 25,
-};
-
 int s3c64xx_spi1_cfg_gpio(struct platform_device *dev)
 {
 	s3c_gpio_cfgpin(S5PV210_GPB(4), S3C_GPIO_SFN(2));
diff --git a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
index fa95e9a..4e9b9c3 100644
--- a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
+++ b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
@@ -33,28 +33,13 @@ struct s3c64xx_spi_csinfo {
 /**
  * struct s3c64xx_spi_info - SPI Controller defining structure
  * @src_clk_nr: Clock source index for the CLK_CFG[SPI_CLKSEL] field.
- * @clk_from_cmu: If the SPI clock/prescalar control block is present
- *     by the platform's clock-management-unit and not in SPI controller.
  * @num_cs: Number of CS this controller emulates.
  * @cfg_gpio: Configure pins for this SPI controller.
- * @fifo_lvl_mask: All tx fifo_lvl fields start at offset-6
- * @rx_lvl_offset: Depends on tx fifo_lvl field and bus number
- * @high_speed: If the controller supports HIGH_SPEED_EN bit
- * @tx_st_done: Depends on tx fifo_lvl field
  */
 struct s3c64xx_spi_info {
 	int src_clk_nr;
-	bool clk_from_cmu;
-
 	int num_cs;
-
 	int (*cfg_gpio)(struct platform_device *pdev);
-
-	/* Following two fields are for future compatibility */
-	int fifo_lvl_mask;
-	int rx_lvl_offset;
-	int high_speed;
-	int tx_st_done;
 };
 
 /**
-- 
1.6.6.rc2
