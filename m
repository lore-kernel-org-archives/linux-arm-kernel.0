From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 28 Jul 2015 09:03:55 +0000
Subject: [PATCH 01/10] ARM: dts: atlas7: add lost jpeg node
In-Reply-To: <1438074244-18708-1-git-send-email-21cnbao@gmail.com>
References: <1438074244-18708-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1438074244-18708-2-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Lily.Li" <Lily.Li@csr.com>

this patch adds lost jpeg node, and also fix the ranges of its
parent node.

Signed-off-by: Lily.Li <Lily.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/atlas7.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/atlas7.dtsi b/arch/arm/boot/dts/atlas7.dtsi
index 3e21311..d590b82 100644
--- a/arch/arm/boot/dts/atlas7.dtsi
+++ b/arch/arm/boot/dts/atlas7.dtsi
@@ -1350,6 +1350,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x16000000 0x16000000 0x00200000>,
+				<0x17000000 0x17000000 0x10000>,
 				<0x17020000 0x17020000 0x1000>,
 				<0x17030000 0x17030000 0x1000>,
 				<0x17040000 0x17040000 0x1000>,
@@ -1416,6 +1417,14 @@
 				bus-width = <8>;
 			};
 
+			jpeg at 17000000 {
+				compatible = "sirf,atlas7-jpeg";
+				reg = <0x17000000 0x10000>;
+				interrupts = <0 72 0>,
+					<0 73 0>;
+				clocks = <&car 103>;
+			};
+
 			usb0: usb at 17060000 {
 				cell-index = <0>;
 				compatible = "sirf,atlas7-usb";
-- 
1.9.1
