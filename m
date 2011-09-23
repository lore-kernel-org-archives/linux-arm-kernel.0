From: b-cousson@ti.com (Benoit Cousson)
Date: Fri, 23 Sep 2011 22:23:11 +0200
Subject: [PATCH 03/11] arm/dts: Add support for OMAP4 PandaBoard
In-Reply-To: <1316809399-19579-1-git-send-email-b-cousson@ti.com>
References: <1316809399-19579-1-git-send-email-b-cousson@ti.com>
Message-ID: <1316809399-19579-4-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on the original omap4-panda.dts file from Manju.
http://www.spinics.net/lists/linux-omap/msg55836.html

Add memory information and a default bootargs to allow
a boot from RAMDISK.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: G, Manjunath Kondaiah <manjugk@ti.com>
---
 arch/arm/boot/dts/omap4-panda.dts |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap4-panda.dts

diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
new file mode 100644
index 0000000..c702657
--- /dev/null
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -0,0 +1,29 @@
+/*
+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/dts-v1/;
+
+/include/ "omap4.dtsi"
+
+/ {
+	model = "TI OMAP4 PandaBoard";
+	compatible = "ti,omap4-panda", "ti,omap4430", "ti,omap4";
+
+	/*
+	 * Since the initial device tree board file does not create any
+	 * devices (MMC, network...), the only way to boot is to provide a
+	 * ramdisk.
+	 */
+	chosen {
+		bootargs = "root=/dev/ram0 rw console=ttyO2,115200n8 initrd=0x81600000,20M ramdisk_size=20480 no_console_suspend debug";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x40000000>; /* 1 GB */
+	};
+};
-- 
1.7.0.4
