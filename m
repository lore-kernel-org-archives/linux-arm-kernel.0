From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 21 Jul 2010 18:00:10 +0900
Subject: [PATCH 1/5] ARM: S3C64XX: Add RTC support for S3C64XX
In-Reply-To: <1279702814-14929-1-git-send-email-kgene.kim@samsung.com>
References: <1279702814-14929-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1279702814-14929-2-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Atul Dahiya <atul.dahiya@samsung.com>

This patch adds support for RTC for SMDK6410.

Signed-off-by: Atul Dahiya <atul.dahiya@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c64xx/Kconfig         |    1 +
 arch/arm/mach-s3c64xx/mach-smdk6410.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index f5a5972..e206504 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -96,6 +96,7 @@ config MACH_SMDK6410
 	select S3C_DEV_HSMMC1
 	select S3C_DEV_I2C1
 	select S3C_DEV_FB
+	select S3C_DEV_RTC
 	select SAMSUNG_DEV_TS
 	select S3C_DEV_USB_HOST
 	select S3C_DEV_USB_HSOTG
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index d9a0355..b3bfb68 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -265,6 +265,7 @@ static struct platform_device *smdk6410_devices[] __initdata = {
 
 	&smdk6410_smsc911x,
 	&s3c_device_adc,
+	&s3c_device_rtc,
 	&s3c_device_ts,
 	&s3c_device_wdt,
 };
-- 
1.6.2.5
