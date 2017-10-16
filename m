From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Mon, 16 Oct 2017 05:01:53 +0200
Subject: [PATCH 3/3] arm64: dts: realtek: Add MeLE V9
In-Reply-To: <20171016030153.11078-1-afaerber@suse.de>
References: <20171016030153.11078-1-afaerber@suse.de>
Message-ID: <20171016030153.11078-4-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an initial Device Tree for MeLE V9 Media Player.

Cc: meleservice at mele.cn
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm64/boot/dts/realtek/Makefile            |  1 +
 arch/arm64/boot/dts/realtek/rtd1295-mele-v9.dts | 31 +++++++++++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1295-mele-v9.dts

diff --git a/arch/arm64/boot/dts/realtek/Makefile b/arch/arm64/boot/dts/realtek/Makefile
index cf93f4db7a69..c0b36ba64a1e 100644
--- a/arch/arm64/boot/dts/realtek/Makefile
+++ b/arch/arm64/boot/dts/realtek/Makefile
@@ -1,5 +1,6 @@
 dtb-$(CONFIG_ARCH_REALTEK) += rtd1293-ds418j.dtb
 
+dtb-$(CONFIG_ARCH_REALTEK) += rtd1295-mele-v9.dtb
 dtb-$(CONFIG_ARCH_REALTEK) += rtd1295-probox2-ava.dtb
 dtb-$(CONFIG_ARCH_REALTEK) += rtd1295-zidoo-x9s.dtb
 
diff --git a/arch/arm64/boot/dts/realtek/rtd1295-mele-v9.dts b/arch/arm64/boot/dts/realtek/rtd1295-mele-v9.dts
new file mode 100644
index 000000000000..bd584e99fff9
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/rtd1295-mele-v9.dts
@@ -0,0 +1,31 @@
+/*
+ * Copyright (c) 2017 Andreas F?rber
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ */
+
+/dts-v1/;
+
+#include "rtd1295.dtsi"
+
+/ {
+	compatible = "mele,v9", "realtek,rtd1295";
+	model = "MeLE V9";
+
+	memory at 0 {
+		device_type = "memory";
+		reg = <0x0 0x80000000>;
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
+
+&uart0 {
+	status = "okay";
+};
-- 
2.13.6
