From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon,  7 Feb 2011 02:51:56 +0100
Subject: [PATCH 04/09] ARM: s3c2440: gta02: Select missing S3C_DEV_USB_HOST
In-Reply-To: <1297043521-21903-1-git-send-email-lars@metafoo.de>
References: <1297043521-21903-1-git-send-email-lars@metafoo.de>
Message-ID: <1297043521-21903-4-git-send-email-lars@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gta02 mach file references the ohci device.
So we need to select S3C_DEV_USB_HOST to have the device available.

This fixes the following linker errors:
	arch/arm/mach-s3c2440/built-in.o: In function `gta02_machine_init':
	mach-gta02.c:(.init.text+0x370): undefined reference to `s3c_ohci_set_platdata'
	arch/arm/mach-s3c2440/built-in.o:(.init.data+0xac): undefined reference to `s3c_device_ohci'

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/arm/mach-s3c2440/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2440/Kconfig b/arch/arm/mach-s3c2440/Kconfig
index a0cb258..50825a3 100644
--- a/arch/arm/mach-s3c2440/Kconfig
+++ b/arch/arm/mach-s3c2440/Kconfig
@@ -99,6 +99,7 @@ config MACH_NEO1973_GTA02
 	select POWER_SUPPLY
 	select MACH_NEO1973
 	select S3C2410_PWM
+	select S3C_DEV_USB_HOST
 	help
 	   Say Y here if you are using the Openmoko GTA02 / Freerunner GSM Phone
 
-- 
1.7.2.3
