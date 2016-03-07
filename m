From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Mon, 7 Mar 2016 13:43:07 -0600
Subject: [PATCHv2 11/11] ARM: dts: Add Altera Arria10 L2 Cache EDAC devicetree
 entry
In-Reply-To: <1457379787-8327-1-git-send-email-tthayer@opensource.altera.com>
References: <1457379787-8327-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1457379787-8327-12-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

Add the device tree entries needed to support the Altera L2
cache EDAC on the Arria10 chip.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
v2 Match register value (l2-ecc at ffd06010)
---
 arch/arm/boot/dts/socfpga_arria10.dtsi |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index cce9e50..44aeb3f 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -599,6 +599,20 @@
 			reg = <0xffe00000 0x40000>;
 		};
 
+		eccmgr: eccmgr at ffd06090 {
+			compatible = "altr,socfpga-ecc-manager";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			l2-ecc at ffd06010 {
+				compatible = "altr,socfpga-a10-l2-ecc";
+				reg = <0xffd06010 0x4>;
+				interrupts = <0 2 IRQ_TYPE_LEVEL_HIGH>,
+					     <0 0 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
 		rst: rstmgr at ffd05000 {
 			#reset-cells = <1>;
 			compatible = "altr,rst-mgr";
-- 
1.7.9.5
