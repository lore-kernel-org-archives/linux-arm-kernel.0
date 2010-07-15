From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 15 Jul 2010 11:10:41 +0200
Subject: [PATCH 10/10 v2] ARM: S5PC100: enable FIMC on SMDKC100
In-Reply-To: <1279185041-6004-1-git-send-email-s.nawrocki@samsung.com>
References: <1279185041-6004-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1279185041-6004-11-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for FIMC on Samsung SMDKC100 board.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pc100/Kconfig         |    6 ++++++
 arch/arm/mach-s5pc100/mach-smdkc100.c |    9 +++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pc100/Kconfig b/arch/arm/mach-s5pc100/Kconfig
index 791270d..8839c07 100644
--- a/arch/arm/mach-s5pc100/Kconfig
+++ b/arch/arm/mach-s5pc100/Kconfig
@@ -63,6 +63,12 @@ config MACH_SMDKC100
 	select S5PC100_SETUP_FB_24BPP
 	select S5PC100_SETUP_I2C1
 	select S5PC100_SETUP_SDHCI
+	select S5P_DEV_FIMC0
+	select S5PC100_SETUP_FIMC0
+	select S5P_DEV_FIMC1
+	select S5PC100_SETUP_FIMC1
+	select S5P_DEV_FIMC2
+	select S5PC100_SETUP_FIMC2
 	help
 	  Machine support for the Samsung SMDKC100
 
diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-s5pc100/mach-smdkc100.c
index ce3fcde..262de8e 100644
--- a/arch/arm/mach-s5pc100/mach-smdkc100.c
+++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
@@ -42,6 +42,7 @@
 #include <plat/s5pc100.h>
 #include <plat/fb.h>
 #include <plat/iic.h>
+#include <plat/fimc.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define S5PC100_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -160,6 +161,9 @@ static struct platform_device *smdkc100_devices[] __initdata = {
 	&s5pc100_device_iis0,
 	&s5pc100_device_ac97,
 	&s3c_device_onenand,
+	&s5p_device_fimc0,
+	&s5p_device_fimc1,
+	&s5p_device_fimc2,
 };
 
 static void __init smdkc100_map_io(void)
@@ -179,6 +183,11 @@ static void __init smdkc100_machine_init(void)
 
 	s3c_fb_set_platdata(&smdkc100_lcd_pdata);
 
+	/* FIMC */
+	s5p_fimc0_set_platdata(NULL);
+	s5p_fimc1_set_platdata(NULL);
+	s5p_fimc2_set_platdata(NULL);
+
 	/* LCD init */
 	gpio_request(S5PC100_GPD(0), "GPD");
 	gpio_request(S5PC100_GPH0(6), "GPH0");
-- 
1.7.0.4
