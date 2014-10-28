From: wangzhou.bry@gmail.com (Zhou Wang)
Date: Tue, 28 Oct 2014 16:06:39 +0800
Subject: [PATCH v1] mtd: hisilicon: add device tree node for NAND controller
Message-ID: <1414483599-9470-1-git-send-email-wangzhou.bry@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds dts support for NAND flash controller of Hisilicon Soc Hip04

Changes in v1:
- Move partition and other board related information into board dts file:
  hip04-d01.dts

Signed-off-by: Zhou Wang <wangzhou.bry@gmail.com>
---
 arch/arm/boot/dts/hip04-d01.dts |   26 ++++++++++++++++++++++++++
 arch/arm/boot/dts/hip04.dtsi    |    7 +++++++
 2 files changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/hip04-d01.dts b/arch/arm/boot/dts/hip04-d01.dts
index 40a9e33..0f69a1d 100644
--- a/arch/arm/boot/dts/hip04-d01.dts
+++ b/arch/arm/boot/dts/hip04-d01.dts
@@ -28,5 +28,31 @@
 		uart0: uart at 4007000 {
 			status = "ok";
 		};
+
+		nand: nand at 4020000 {
+			nand-bus-width = <8>;
+			nand-ecc-mode = "none";
+			hisi,nand-ecc-bits = <0>;
+
+			partition at 0 {
+				label = "nand_text";
+				reg = <0x00000000 0x00400000>;
+			};
+
+			partition at 00400000 {
+				label = "nand_monitor";
+				reg = <0x00400000 0x00400000>;
+			};
+
+			partition at 00800000 {
+				label = "nand_kernel";
+				reg = <0x00800000 0x00800000>;
+			};
+
+			partition at 01000000 {
+				label = "nand_fs";
+				reg = <0x01000000 0x1f000000>;
+			};
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/hip04.dtsi b/arch/arm/boot/dts/hip04.dtsi
index 93b6c90..267d7f2 100644
--- a/arch/arm/boot/dts/hip04.dtsi
+++ b/arch/arm/boot/dts/hip04.dtsi
@@ -263,5 +263,12 @@
 			interrupts = <0 372 4>;
 		};
 
+		nand: nand at 4020000 {
+			compatible = "hisilicon,504-nfc";
+			reg = <0x4020000 0x10000>, <0x5000000 0x1000>;
+			interrupts = <0 379 4>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
 	};
 };
-- 
1.7.9.5
