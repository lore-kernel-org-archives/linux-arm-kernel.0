From: jnair@caviumnetworks.com (Jayachandran C)
Date: Thu,  9 Feb 2017 19:12:56 +0000
Subject: [PATCH v4 3/5] arm64: dts: add device tree for ARCH_THUNDER2
In-Reply-To: <CAK8P3a07eo0htv_y6H_aHvAaeo5two3vQTaySuFXpG+dzYguUQ@mail.gmail.com>
References: <CAK8P3a07eo0htv_y6H_aHvAaeo5two3vQTaySuFXpG+dzYguUQ@mail.gmail.com>
Message-ID: <1486667576-8122-1-git-send-email-jnair@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a device tree file for boards using the Cavium's ThunderX2 CN99XX
ARM64 processors. The SoC is compatible with the discontinued Broadcom
Vulcan ARM64 SoC.

Update the Makefile to build the thunder-99xx.dtb when ARCH_THUNDER2
option is selected.

Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
---

Patches 1,2,5 of this series have been applied, sending this with
suggested changes to compat string.

v3->v4
 * compat ID updated to follow convention.

 arch/arm64/boot/dts/cavium/Makefile         |  1 +
 arch/arm64/boot/dts/cavium/thunder-99xx.dts | 34 +++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100644 arch/arm64/boot/dts/cavium/thunder-99xx.dts

diff --git a/arch/arm64/boot/dts/cavium/Makefile b/arch/arm64/boot/dts/cavium/Makefile
index e34f89d..557c8be 100644
--- a/arch/arm64/boot/dts/cavium/Makefile
+++ b/arch/arm64/boot/dts/cavium/Makefile
@@ -1,4 +1,5 @@
 dtb-$(CONFIG_ARCH_THUNDER) += thunder-88xx.dtb
+dtb-$(CONFIG_ARCH_THUNDER2) += thunder-99xx.dtb
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/cavium/thunder-99xx.dts b/arch/arm64/boot/dts/cavium/thunder-99xx.dts
new file mode 100644
index 0000000..6d6e8af
--- /dev/null
+++ b/arch/arm64/boot/dts/cavium/thunder-99xx.dts
@@ -0,0 +1,34 @@
+/*
+ * dts file for Cavium ThunderX2 CN99XX based Evaluation Boards
+ *
+ * Copyright (c) 2017 Cavium Inc.
+ * Copyright (c) 2013-2016 Broadcom
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+/dts-v1/;
+
+#include "../broadcom/vulcan.dtsi"
+
+/ {
+	model = "Cavium ThunderX2 CN99XX";
+	compatible = "cavium,thunderx2-cn9900", "brcm,vulcan-soc";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x80000000 0x0 0x80000000>,  /* 2G @ 2G  */
+		      <0x00000008 0x80000000 0x0 0x80000000>;  /* 2G @ 34G */
+	};
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
-- 
2.7.4
