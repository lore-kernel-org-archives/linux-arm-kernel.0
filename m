From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 23 Jul 2010 18:21:22 +0200
Subject: [PATCH v3 7/8] ARM: S5PC100: enable FIMC on SMDKC100
In-Reply-To: <1279902083-21250-1-git-send-email-s.nawrocki@samsung.com>
References: <1279902083-21250-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1279902083-21250-8-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for FIMC on Samsung SMDKC100 board.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mach-s5pc100/Kconfig         |    3 +++
 arch/arm/mach-s5pc100/mach-smdkc100.c |    4 ++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pc100/Kconfig b/arch/arm/mach-s5pc100/Kconfig
index cd7f4e9..6cc254c 100644
--- a/arch/arm/mach-s5pc100/Kconfig
+++ b/arch/arm/mach-s5pc100/Kconfig
@@ -65,6 +65,9 @@ config MACH_SMDKC100
 	select S5PC100_SETUP_IDE
 	select S5PC100_SETUP_KEYPAD
 	select S5PC100_SETUP_SDHCI
+	select S5P_DEV_FIMC0
+	select S5P_DEV_FIMC1
+	select S5P_DEV_FIMC2
 	help
 	  Machine support for the Samsung SMDKC100
 
diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-s5pc100/mach-smdkc100.c
index a00dd09..53ea3c2 100644
--- a/arch/arm/mach-s5pc100/mach-smdkc100.c
+++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
@@ -47,6 +47,7 @@
 #include <plat/adc.h>
 #include <plat/keypad.h>
 #include <plat/ts.h>
+#include <plat/fimc.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define S5PC100_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -192,6 +193,9 @@ static struct platform_device *smdkc100_devices[] __initdata = {
 	&s5pc100_device_iis0,
 	&samsung_device_keypad,
 	&s5pc100_device_ac97,
+	&s5p_device_fimc0,
+	&s5p_device_fimc1,
+	&s5p_device_fimc2,
 };
 
 static struct s3c2410_ts_mach_info s3c_ts_platform __initdata = {
-- 
1.7.2
