From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Wed, 13 May 2015 16:49:47 -0500
Subject: [PATCH 4/4] dts, altera: Arria10 SDRAM EDAC DTS additions.
In-Reply-To: <1431553787-27741-1-git-send-email-tthayer@opensource.altera.com>
References: <1431553787-27741-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1431553787-27741-5-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

Support for the Arria10 SDRAM EDAC is added to the device tree.
Update the bindings document for the new match string.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
 .../bindings/arm/altera/socfpga-sdram-edac.txt     |    2 +-
 arch/arm/boot/dts/socfpga_arria10.dtsi             |   11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt
index d0ce01d..f5ad0ff 100644
--- a/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt
+++ b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt
@@ -2,7 +2,7 @@ Altera SOCFPGA SDRAM Error Detection & Correction [EDAC]
 The EDAC accesses a range of registers in the SDRAM controller.
 
 Required properties:
-- compatible : should contain "altr,sdram-edac";
+- compatible : should contain "altr,sdram-edac" or "altr,sdram-edac-a10"
 - altr,sdr-syscon : phandle of the sdr module
 - interrupts : Should contain the SDRAM ECC IRQ in the
 	appropriate format for the IRQ controller.
diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index e121661..70da147 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -524,6 +524,17 @@
 			status = "disabled";
 		};
 
+		sdr: sdr at ffc25000 {
+			compatible = "syscon";
+			reg = <0xffcfb100 0x80>;
+		};
+
+		sdramedac {
+			compatible = "altr,sdram-edac-a10";
+			altr,sdr-syscon = <&sdr>;
+			interrupts = <0 2 4>, <0 0 4>;
+		};
+
 		L2: l2-cache at fffff000 {
 			compatible = "arm,pl310-cache";
 			reg = <0xfffff000 0x1000>;
-- 
1.7.9.5
