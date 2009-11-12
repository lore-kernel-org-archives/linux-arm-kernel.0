From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 12 Nov 2009 09:21:59 +0100
Subject: [PATCH 15/18] drivers: i2c: s3c2410-i2c also on S5PC1XX platform
In-Reply-To: <1258014122-18185-15-git-send-email-m.szyprowski@samsung.com>
References: <1258014122-18185-1-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-2-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-3-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-4-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-5-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-6-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-7-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-8-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-9-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-10-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-11-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-12-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-13-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-14-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-15-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1258014122-18185-16-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

From: Kyungmin Park <kyungmin.park@samsung.com>

Samsung S5PC100 SoC has I2C controllers directly compatible to the one
known from S3C24x0 SoCs. Enable support for s3c-i2c driver also on S5PC1xx
platform.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/i2c/busses/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 737335f..5b173f3 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -494,7 +494,7 @@ config I2C_PXA_SLAVE
 
 config I2C_S3C2410
 	tristate "S3C2410 I2C Driver"
-	depends on ARCH_S3C2410 || ARCH_S3C64XX
+	depends on ARCH_S3C2410 || ARCH_S3C64XX || ARCH_S5PC1XX
 	help
 	  Say Y here to include support for I2C controller in the
 	  Samsung S3C2410 based System-on-Chip devices.
-- 
1.6.5
