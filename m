From: tthayer@altera.com (tthayer at altera.com)
Date: Mon, 5 May 2014 17:52:16 -0500
Subject: [PATCHv3 2/3] dts: socfpga: Add bindings for Altera SoC SDRAM EDAC
In-Reply-To: <1399330337-16748-1-git-send-email-tthayer@altera.com>
References: <1399330337-16748-1-git-send-email-tthayer@altera.com>
Message-ID: <1399330337-16748-3-git-send-email-tthayer@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@altera.com>

Addition of the Altera SDRAM EDAC bindings and device
tree changes to the Altera SoC project.
---
v2: Changes to SoC EDAC source code.

v3: Fix typo in device tree documentation.

Signed-off-by: Thor Thayer <tthayer@altera.com>
---
 .../bindings/arm/altera/socfpga-sdram-edac.txt     |   12 ++++++++++++
 arch/arm/boot/dts/socfpga.dtsi                     |    5 +++++
 2 files changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt

diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt
new file mode 100644
index 0000000..431e98b
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt
@@ -0,0 +1,12 @@
+Altera SOCFPGA SDRAM Error Detection & Correction [EDAC]
+
+Required properties:
+- compatible : should contain "altr,sdram-edac";
+- interrupts : Should contain the SDRAM ECC IRQ in the
+	appropriate format for the IRQ controller.
+
+Example:
+	sdramedac at 0 {
+		compatible = "altr,sdram-edac";
+		interrupts = <0 39 4>;
+	};
diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 6ce912e..a0ea69b 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -681,6 +681,11 @@
 			reg = <0xffc25000 0x1000>;
 		};
 
+		sdramedac at 0 {
+			compatible = "altr,sdram-edac";
+			interrupts = <0 39 4>;
+		};
+
 		rstmgr at ffd05000 {
 			compatible = "altr,rst-mgr";
 			reg = <0xffd05000 0x1000>;
-- 
1.7.9.5
