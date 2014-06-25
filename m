From: tthayer@altera.com (tthayer at altera.com)
Date: Wed, 25 Jun 2014 16:15:25 -0500
Subject: [PATCHv7 1/3] devicetree: Addition of the Altera SDRAM Controller.
In-Reply-To: <1403730927-16163-1-git-send-email-tthayer@altera.com>
References: <1403730927-16163-1-git-send-email-tthayer@altera.com>
Message-ID: <1403730927-16163-2-git-send-email-tthayer@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@altera.com>

Add the Altera SDRAM controller bindings and device tree changes to the Altera SoC project.

Signed-off-by: Thor Thayer <tthayer@altera.com>
---
v2: Changes to SoC SDRAM EDAC code.

v3: Implement code suggestions for SDRAM EDAC code.

v4: Remove syscon from SDRAM controller bindings.

v5: No Change, bump version for consistency.

v6: Only map the ctrlcfg register as syscon.

v7: No change. Bump for consistency.
---
 .../bindings/arm/altera/socfpga-sdram.txt          |   11 +++++++++++
 arch/arm/boot/dts/socfpga.dtsi                     |    5 +++++
 2 files changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-sdram.txt

diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-sdram.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram.txt
new file mode 100644
index 0000000..5027026
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram.txt
@@ -0,0 +1,11 @@
+Altera SOCFPGA SDRAM Controller
+
+Required properties:
+- compatible : "altr,sdr-ctl";
+- reg : Should contain 1 register ranges(address and length)
+
+Example:
+	sdrctl at ffc25000 {
+		compatible = "altr,sdr-ctl";
+		reg = <0xffc25000 0x4>;
+	};
diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 4676f25..310292e 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -682,6 +682,11 @@
 			clocks = <&l4_sp_clk>;
 		};
 
+		sdrctl at ffc25000 {
+			compatible = "altr,sdr-ctl", "syscon";
+			reg = <0xffc25000 0x4>;
+		};
+
 		rst: rstmgr at ffd05000 {
 			compatible = "altr,rst-mgr";
 			reg = <0xffd05000 0x1000>;
-- 
1.7.9.5
