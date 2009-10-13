From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 13 Oct 2009 10:11:21 +0200
Subject: [PATCH 16/17] SMDKC100: add SDHCI controllers 0, 1 and 2 support
In-Reply-To: <1255421482-26455-16-git-send-email-m.szyprowski@samsung.com>
References: <1255421482-26455-1-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-2-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-3-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-4-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-5-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-6-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-7-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-8-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-9-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-10-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-11-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-12-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-13-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-14-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-15-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-16-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1255421482-26455-17-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add required machine definitions for SDHCI controller 0, 1 and 2. SMDKC100
has 2 SDHCI/MMC ports. Port 1 is directly connected to controller 0. Port
1 can be conntected to controler 1 or 2, depending on jumper setup.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mach-s5pc100/Kconfig         |    4 ++++
 arch/arm/mach-s5pc100/mach-smdkc100.c |    3 +++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pc100/Kconfig b/arch/arm/mach-s5pc100/Kconfig
index 21b1821..0dd2b8c 100644
--- a/arch/arm/mach-s5pc100/Kconfig
+++ b/arch/arm/mach-s5pc100/Kconfig
@@ -25,8 +25,12 @@ config MACH_SMDKC100
 	select CPU_S5PC100
 	select S3C_DEV_FB
 	select S3C_DEV_I2C1
+	select S3C_DEV_HSMMC
+	select S3C_DEV_HSMMC1
+	select S3C_DEV_HSMMC2
 	select S5PC1XX_SETUP_I2C0
 	select S5PC1XX_SETUP_I2C1
 	select S5PC1XX_SETUP_FB_24BPP
+	select S5PC100_SETUP_SDHCI
 	help
 	  Machine support for the Samsung SMDKC100
diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-s5pc100/mach-smdkc100.c
index 2c0119f..8dee48e 100644
--- a/arch/arm/mach-s5pc100/mach-smdkc100.c
+++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
@@ -147,6 +147,9 @@ static struct platform_device *smdkc100_devices[] __initdata = {
 	&s3c_device_i2c0,
 	&s3c_device_i2c1,
 	&s3c_device_fb,
+	&s3c_device_hsmmc0,
+	&s3c_device_hsmmc1,
+	&s3c_device_hsmmc2,
 	&smdkc100_lcd_powerdev,
 };
 
-- 
1.6.4
