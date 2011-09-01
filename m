From: b-cousson@ti.com (Benoit Cousson)
Date: Thu, 1 Sep 2011 19:25:09 +0200
Subject: [PATCH 4/7] arm/dts: omap3-beagle: Include the generic omap3.dtsi
In-Reply-To: <1314897912-18178-1-git-send-email-b-cousson@ti.com>
References: <1314897912-18178-1-git-send-email-b-cousson@ti.com>
Message-ID: <1314897912-18178-5-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update OMAP3 beagleboard DTS file to use the omap3.dtsi
SoC file.
Add a default bootargs line to allow a boot from RAMDISK
Add memory node information.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: G, Manjunath Kondaiah <manjugk@ti.com>
---
 arch/arm/boot/dts/omap3-beagle.dts |   26 ++++++++++++++++++++++++--
 1 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index 4439466..da13ec7 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -1,7 +1,29 @@
+/*
+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
 /dts-v1/;
-/include/ "skeleton.dtsi"
+
+/include/ "omap3.dtsi"
 
 / {
 	model = "TI OMAP3 BeagleBoard";
-	compatible = "ti,omap3-beagle";
+	compatible = "ti,omap3-beagle", "ti,omap3430", "ti,omap3";
+
+	/*
+	 * Since the initial device tree board file does not create any
+	 * devices (MMC, network...), the only way to boot is to provide a
+	 * ramdisk.
+	 */
+	chosen {
+		bootargs = "root=/dev/ram0 rw console=ttyO2,115200n8 initrd=0x81600000,20M ramdisk_size=20480 no_console_suspend debug earlyprintk";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>; /* 512 MB */
+	};
 };
-- 
1.7.0.4
