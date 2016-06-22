From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Wed, 22 Jun 2016 08:58:59 -0500
Subject: [PATCHv5 8/8] ARM: dts: Add Arria10 Ethernet EDAC devicetree entry
In-Reply-To: <1466603939-7526-1-git-send-email-tthayer@opensource.altera.com>
References: <1466603939-7526-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1466603939-7526-9-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

Add the device tree entries needed to support the Altera Ethernet
FIFO buffer EDAC on the Arria10 chip.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
v2  No change
v3  Add interrupts for SBERR and DBERR.
v4  No change
v5  Change "parent" phandle to "altr,ecc-parent"
---
 arch/arm/boot/dts/socfpga_arria10.dtsi |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index 21f6c3c..228f663 100644
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
+				altr,ecc-parent = <&gmac0>;
+				interrupts = <4 IRQ_TYPE_LEVEL_HIGH>,
+					     <36 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			emac0-tx-ecc at ff8c0c00 {
+				compatible = "altr,socfpga-eth-mac-ecc";
+				reg = <0xff8c0c00 0x400>;
+				altr,ecc-parent = <&gmac0>;
+				interrupts = <5 IRQ_TYPE_LEVEL_HIGH>,
+					     <37 IRQ_TYPE_LEVEL_HIGH>;
+			};
 		};
 
 		rst: rstmgr at ffd05000 {
-- 
1.7.9.5
