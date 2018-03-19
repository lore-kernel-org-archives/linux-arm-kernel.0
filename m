From: aford173@gmail.com (Adam Ford)
Date: Mon, 19 Mar 2018 11:21:22 -0500
Subject: [PATCH] ARM: dts: da850-evm: Enable usb_phy, usb0 and usb1
Message-ID: <1521476482-23335-1-git-send-email-aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The EVM kit has two USB ports.  This patch will enable both
when booting with device tree.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index c755079..cc77735 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -304,6 +304,18 @@
 	};
 };
 
+&usb_phy {
+	status = "okay";
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
 &vpif {
 	pinctrl-names = "default";
 	pinctrl-0 = <&vpif_capture_pins>, <&vpif_display_pins>;
-- 
2.7.4
