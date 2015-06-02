From: atull@opensource.altera.com (Alan Tull)
Date: Tue, 2 Jun 2015 13:35:39 -0500
Subject: [PATCHv6 2/2] ARM: socfpga: dts: add sdram controller dt binding doc
In-Reply-To: <1433270139-7042-1-git-send-email-atull@opensource.altera.com>
References: <1433270139-7042-1-git-send-email-atull@opensource.altera.com>
Message-ID: <1433270139-7042-3-git-send-email-atull@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add binding doc for Altera SOCFPGA SDRAM controller.

Signed-off-by: Alan Tull <atull@opensource.altera.com>
---
v4: Add bindings doc
v5: No change for v5
v6: No change for v6
---
 .../arm/altera/socfpga-sdram-controller.txt        |   12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-sdram-controller.txt

diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-controller.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-controller.txt
new file mode 100644
index 0000000..77ca635
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-controller.txt
@@ -0,0 +1,12 @@
+Altera SOCFPGA SDRAM Controller
+
+Required properties:
+- compatible : Should contain "altr,sdr-ctl" and "syscon".
+  syscon is required by the Altera SOCFPGA SDRAM EDAC.
+- reg : Should contain 1 register range (address and length)
+
+Example:
+	sdr: sdr at ffc25000 {
+		compatible = "altr,sdr-ctl", "syscon";
+		reg = <0xffc25000 0x1000>;
+	};
-- 
1.7.9.5
