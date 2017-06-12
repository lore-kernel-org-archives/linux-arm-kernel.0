From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Mon, 12 Jun 2017 15:07:38 +0900
Subject: [PATCH v2 1/2] arm64: dts: uniphier: add support for LD11 Global board
In-Reply-To: <1497247659-1610-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1497247659-1610-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <1497247659-1610-2-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add initial device tree support for LD11 Global board.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm64/boot/dts/socionext/Makefile             |  1 +
 .../boot/dts/socionext/uniphier-ld11-global.dts    | 70 ++++++++++++++++++++++
 2 files changed, 71 insertions(+)
 create mode 100644 arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts

diff --git a/arch/arm64/boot/dts/socionext/Makefile b/arch/arm64/boot/dts/socionext/Makefile
index 5538598..8d07ee3 100644
--- a/arch/arm64/boot/dts/socionext/Makefile
+++ b/arch/arm64/boot/dts/socionext/Makefile
@@ -1,4 +1,5 @@
 dtb-$(CONFIG_ARCH_UNIPHIER) += \
+	uniphier-ld11-global.dtb \
 	uniphier-ld11-ref.dtb \
 	uniphier-ld20-ref.dtb
 
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
new file mode 100644
index 0000000..1153570
--- /dev/null
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
@@ -0,0 +1,70 @@
+/*
+ * Device Tree Source for UniPhier LD11 Global Board
+ *
+ * Copyright (C) 2016-2017 Socionext Inc.
+ *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
+ *           Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ */
+
+/dts-v1/;
+/include/ "uniphier-ld11.dtsi"
+
+/ {
+	model = "UniPhier LD11 Global Board (REF_LD11_GP)";
+	compatible = "socionext,uniphier-ld11-global",
+		     "socionext,uniphier-ld11";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	aliases {
+		serial0 = &serial0;
+		serial1 = &serial1;
+		serial2 = &serial2;
+		serial3 = &serial3;
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c4 = &i2c4;
+		i2c5 = &i2c5;
+	};
+
+	memory at 80000000 {
+		device_type = "memory";
+		reg = <0 0x80000000 0 0x40000000>;
+	};
+};
+
+&serial0 {
+	status = "okay";
+};
+
+&serial1 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+
+	eeprom at 50 {
+		compatible = "st,24c64", "atmel,24c64";
+		reg = <0x50>;
+		pagesize = <32>;
+	};
+};
+
+&usb0 {
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+};
+
+&usb2 {
+	status = "okay";
+};
-- 
2.7.4
