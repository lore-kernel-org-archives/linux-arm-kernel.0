From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue,  3 Nov 2009 14:42:10 +0000
Subject: [PATCH 7/9] SMDK6410: Allocate more GPIO space for WM1190-EV1
In-Reply-To: <1257259332-7867-6-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1257259332-7867-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1257259332-7867-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1257259332-7867-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1257259332-7867-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1257259332-7867-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1257259332-7867-6-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1257259332-7867-7-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The WM835x has some GPIOs on it, allocate some space so we can use
them with gpiolib.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c6410/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c6410/Kconfig b/arch/arm/mach-s3c6410/Kconfig
index b8c0332..162f456 100644
--- a/arch/arm/mach-s3c6410/Kconfig
+++ b/arch/arm/mach-s3c6410/Kconfig
@@ -75,6 +75,7 @@ config SMDK6410_WM1190_EV1
 	depends on MACH_SMDK6410
 	select REGULATOR
 	select REGULATOR_WM8350
+	select S3C24XX_GPIO_EXTRA64
 	select MFD_WM8350_I2C
 	select MFD_WM8350_CONFIG_MODE_0
 	select MFD_WM8350_CONFIG_MODE_3
-- 
1.6.5.2
