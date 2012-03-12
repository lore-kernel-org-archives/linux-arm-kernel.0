From: uri.y@variscite.com (Uri Yosef)
Date: Mon, 12 Mar 2012 12:20:29 +0200
Subject: [PATCH]: arm/dts: OMAP4: Add Variscite OMAP4 System-On-Modeule support
Message-ID: <1331547629-17556-1-git-send-email-uri.y@variscite.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Uri yosef <uri.y@variscite.com>

 Hi Tony,

 This patch add device tree support for Variscite OMAP4 System-On-Modeule.

 Regards,
 Uri Yosef

---
 arch/arm/boot/dts/omap4-var_som.dts |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap4-var_som.dts

diff --git a/arch/arm/boot/dts/omap4-var_som.dts b/arch/arm/boot/dts/omap4-var_som.dts
new file mode 100644
index 0000000..e352f38
--- /dev/null
+++ b/arch/arm/boot/dts/omap4-var_som.dts
@@ -0,0 +1,29 @@
+/*
+ * Copyright (C) 2012 Variscite Ltd. - http://www.variscite.com
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
+	model = "Variscite OMAP4 SOM";
+	compatible = "var,omap4-var_som", "ti,omap4430", "ti,omap4";
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
1.7.5.4
