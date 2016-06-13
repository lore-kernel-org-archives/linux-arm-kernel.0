From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Mon, 13 Jun 2016 16:19:12 -0500
Subject: [PATCHv3 7/7] ARM: dts: Add Arria10 Ethernet EDAC devicetree entry
In-Reply-To: <1465852752-11018-1-git-send-email-tthayer@opensource.altera.com>
References: <1465852752-11018-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1465852752-11018-8-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

Add the device tree entries needed to support the Altera Ethernet
FIFO buffer EDAC on the Arria10 chip.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
v2  No change
v3  Add interrupts for SBERR and DBERR.
---
 arch/arm/boot/dts/socfpga_arria10.dtsi |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index 21f6c3c..5cf4dc5 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -628,6 +628,22 @@
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH>,
 					     <33 IRQ_TYPE_LEVEL_HIGH>;
 			};
+
+			emac0-rx-ecc at ff8c0800 {
+				compatible = "altr,socfpga-eth-mac-ecc";
+				reg = <0xff8c0800 0x400>;
+				parent = <&gmac0>;
+				interrupts = <4 IRQ_TYPE_LEVEL_HIGH>,
+					     <36 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			emac0-tx-ecc at ff8c0c00 {
+				compatible = "altr,socfpga-eth-mac-ecc";
+				reg = <0xff8c0c00 0x400>;
+				parent = <&gmac0>;
+				interrupts = <5 IRQ_TYPE_LEVEL_HIGH>,
+					     <37 IRQ_TYPE_LEVEL_HIGH>;
+			};
 		};
 
 		rst: rstmgr at ffd05000 {
-- 
1.7.9.5
