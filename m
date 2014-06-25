From: tthayer@altera.com (tthayer at altera.com)
Date: Wed, 25 Jun 2014 16:15:26 -0500
Subject: [PATCHv7 2/3] devicetree: Addition of the Altera SDRAM EDAC. 
In-Reply-To: <1403730927-16163-1-git-send-email-tthayer@altera.com>
References: <1403730927-16163-1-git-send-email-tthayer@altera.com>
Message-ID: <1403730927-16163-3-git-send-email-tthayer@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@altera.com>

Add the Altera SDRAM EDAC bindings and device tree changes to the Altera SoC project.

Signed-off-by: Thor Thayer <tthayer@altera.com>
---
v2: Changes to SoC EDAC source code.

v3: Fix typo in device tree documentation.

v4,v5: No changes - bump version for consistency.

v6: Assign ECC registers in SDRAM controller to EDAC

v7: Fix SDRAM EDAC base address.
---
 .../bindings/arm/altera/socfpga-sdram-edac.txt     |   15 +++++++++++++++
 arch/arm/boot/dts/socfpga.dtsi                     |    6 ++++++
 2 files changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt

diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt
new file mode 100644
index 0000000..d68e033
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt
@@ -0,0 +1,15 @@
+Altera SOCFPGA SDRAM Error Detection & Correction [EDAC]
+
+Required properties:
+- compatible : should contain "altr,sdram-edac";
+- reg : should contain the ECC register range in sdram
+        controller (address and length).
+- interrupts : Should contain the SDRAM ECC IRQ in the
+	appropriate format for the IRQ controller.
+
+Example:
+	sdramedac at ffc2502c {
+		compatible = "altr,sdram-edac";
+		reg = <0xffc2502c 0x28>;
+		interrupts = <0 39 4>;
+	};
diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 310292e..da0785d 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -687,6 +687,12 @@
 			reg = <0xffc25000 0x4>;
 		};
 
+		sdramedac at ffc2502c {
+			compatible = "altr,sdram-edac";
+			reg = <0xffc2502c 0x28>;
+			interrupts = <0 39 4>;
+		};
+
 		rst: rstmgr at ffd05000 {
 			compatible = "altr,rst-mgr";
 			reg = <0xffd05000 0x1000>;
-- 
1.7.9.5
