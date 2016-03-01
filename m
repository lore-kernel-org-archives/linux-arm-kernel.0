From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Tue, 1 Mar 2016 10:38:21 -0600
Subject: [PATCH 5/5] ARM: dts: Add Altera Arria10 L2 Cache EDAC devicetree
 entry
In-Reply-To: <1456850301-22066-1-git-send-email-tthayer@opensource.altera.com>
References: <1456850301-22066-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1456850301-22066-5-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

Add the device tree entries needed to support the Altera L2
cache EDAC on the Arria10 chip.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
 arch/arm/boot/dts/socfpga_arria10.dtsi |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index cce9e50..e83e973 100644
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
+			l2-ecc at ffd06000 {
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
