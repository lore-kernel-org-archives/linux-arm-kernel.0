From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Mon,  1 Dec 2014 10:42:32 -0800
Subject: [PATCH] ARM: zynq: DT: Add USB to device tree
Message-ID: <1417459352-23401-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add USB nodes to zc702, zc706 and zed device trees.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 arch/arm/boot/dts/zynq-7000.dtsi | 22 +++++++++++++++++++++-
 arch/arm/boot/dts/zynq-zc702.dts | 11 +++++++++++
 arch/arm/boot/dts/zynq-zc706.dts | 10 ++++++++++
 arch/arm/boot/dts/zynq-zed.dts   | 10 ++++++++++
 4 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index ce2ef5bec4f2..9ed60938f301 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -315,6 +315,26 @@
 			clocks = <&clkc 4>;
 		};
 
+		usb0: usb at e0002000 {
+			compatible = "xlnx,zynq-usb-2.20a", "chipidea,usb2";
+			status = "disabled";
+			clocks = <&clkc 28>;
+			interrupt-parent = <&intc>;
+			interrupts = <0 21 4>;
+			reg = <0xe0002000 0x1000>;
+			phy_type = "ulpi";
+		};
+
+		usb1: usb at e0003000 {
+			compatible = "xlnx,zynq-usb-2.20a", "chipidea,usb2";
+			status = "disabled";
+			clocks = <&clkc 29>;
+			interrupt-parent = <&intc>;
+			interrupts = <0 44 4>;
+			reg = <0xe0003000 0x1000>;
+			phy_type = "ulpi";
+		};
+
 		watchdog0: watchdog at f8005000 {
 			clocks = <&clkc 45>;
 			compatible = "xlnx,zynq-wdt-r1p2";
@@ -324,6 +344,6 @@
 			reg = <0xf8005000 0x1000>;
 			reset = <0>;
 			timeout-sec = <10>;
-		};
+		} ;
 	};
 };
diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
index 94e2cda6f9b6..690d2b6bbada 100644
--- a/arch/arm/boot/dts/zynq-zc702.dts
+++ b/arch/arm/boot/dts/zynq-zc702.dts
@@ -36,6 +36,11 @@
 			linux,default-trigger = "heartbeat";
 		};
 	};
+
+	usb_phy0: usb-phy at 0 {
+		compatible = "usb-nop-xceiv";
+		#phy-cells = <0>;
+	};
 };
 
 &can0 {
@@ -135,3 +140,9 @@
 &uart1 {
 	status = "okay";
 };
+
+&usb0 {
+	status = "okay";
+	dr_mode = "host";
+	usb-phy = <&usb_phy0>;
+};
diff --git a/arch/arm/boot/dts/zynq-zc706.dts b/arch/arm/boot/dts/zynq-zc706.dts
index a8bbdfbc7093..e383c0a3f314 100644
--- a/arch/arm/boot/dts/zynq-zc706.dts
+++ b/arch/arm/boot/dts/zynq-zc706.dts
@@ -27,6 +27,10 @@
 		bootargs = "console=ttyPS0,115200 earlyprintk";
 	};
 
+	usb_phy0: usb-phy at 0 {
+		compatible = "usb-nop-xceiv";
+		#phy-cells = <0>;
+	};
 };
 
 &gem0 {
@@ -114,3 +118,9 @@
 &uart1 {
 	status = "okay";
 };
+
+&usb0 {
+	status = "okay";
+	dr_mode = "host";
+	usb-phy = <&usb_phy0>;
+};
diff --git a/arch/arm/boot/dts/zynq-zed.dts b/arch/arm/boot/dts/zynq-zed.dts
index 697779a353ed..b08ae18ad854 100644
--- a/arch/arm/boot/dts/zynq-zed.dts
+++ b/arch/arm/boot/dts/zynq-zed.dts
@@ -27,6 +27,10 @@
 		bootargs = "console=ttyPS0,115200 earlyprintk";
 	};
 
+	usb_phy0: usb-phy at 0 {
+		compatible = "usb-nop-xceiv";
+		#phy-cells = <0>;
+	};
 };
 
 &gem0 {
@@ -46,3 +50,9 @@
 &uart1 {
 	status = "okay";
 };
+
+&usb0 {
+	status = "okay";
+	dr_mode = "host";
+	usb-phy = <&usb_phy0>;
+};
-- 
2.2.0.1.g9ee0458
