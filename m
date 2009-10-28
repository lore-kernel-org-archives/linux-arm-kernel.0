From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 28 Oct 2009 12:15:50 +0000
Subject: [PATCH 09/12] ARM: S3C2440: mini2440: Fix missing
	CONFIG_S3C_DEV_USB_HOST
In-Reply-To: <1256732153-22027-1-git-send-email-ben-linux@fluff.org>
References: <1256732153-22027-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1256732153-22027-9-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix missing select of S3C_DEV_USB_HOST when building for mini2440
only. Fixes the following error:

built-in.o: undefined reference to `s3c_device_usb`

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c2440/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2440/Kconfig b/arch/arm/mach-s3c2440/Kconfig
index d7bba91..a8b69d7 100644
--- a/arch/arm/mach-s3c2440/Kconfig
+++ b/arch/arm/mach-s3c2440/Kconfig
@@ -103,6 +103,7 @@ config MACH_MINI2440
 	select LEDS_TRIGGER_BACKLIGHT
 	select SND_S3C24XX_SOC_S3C24XX_UDA134X
 	select S3C_DEV_NAND
+	select S3C_DEV_USB_HOST
 	help
 	  Say Y here to select support for the MINI2440. Is a 10cm x 10cm board
 	  available via various sources. It can come with a 3.5" or 7" touch LCD.
-- 
1.6.3.3
