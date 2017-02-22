From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 22 Feb 2017 03:29:28 +0100
Subject: [PATCH v2 8/8] ARM64: dts: marvell: iap140-andromeda-box-edge: Add
 uart0 clock
In-Reply-To: <20170222022929.10540-1-afaerber@suse.de>
References: <20170222022929.10540-1-afaerber@suse.de>
Message-ID: <20170222022929.10540-9-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use a fixed clock to enable ttyS0 output.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v1 -> v2: unchanged
 
 arch/arm64/boot/dts/marvell/iap140-andromeda-box-edge.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/iap140-andromeda-box-edge.dts b/arch/arm64/boot/dts/marvell/iap140-andromeda-box-edge.dts
index 0b0b150..15ad0f3 100644
--- a/arch/arm64/boot/dts/marvell/iap140-andromeda-box-edge.dts
+++ b/arch/arm64/boot/dts/marvell/iap140-andromeda-box-edge.dts
@@ -63,6 +63,12 @@
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x40000000>;
 	};
+
+	uart0_clk: uart0-clk {
+		compatible = "fixed-clock";
+		clock-frequency = <14740000>;
+		#clock-cells = <0>;
+	};
 };
 
 &pmx {
@@ -77,4 +83,5 @@
 
 &uart0 {
 	status = "okay";
+	clocks = <&uart0_clk>;
 };
-- 
2.10.2
