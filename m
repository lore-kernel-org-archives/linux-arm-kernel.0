From: bpringlemeir@nbsps.com (Bill Pringlemeir)
Date: Wed,  8 Jan 2014 18:07:19 -0500
Subject: [RFC 3/5] mtd:fsl_nfc: Add device tree documentation.
In-Reply-To: <1389222441-4322-1-git-send-email-bpringlemeir@nbsps.com>
References: <87siupheou.fsf@nbsps.com>
 <1389222441-4322-1-git-send-email-bpringlemeir@nbsps.com>
Message-ID: <1389222441-4322-4-git-send-email-bpringlemeir@nbsps.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Bill Pringlemeir <bpringlemeir@nbsps.com>
---
 Documentation/devicetree/bindings/mtd/fsl-nfc.txt | 25 +++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/fsl-nfc.txt

diff --git a/Documentation/devicetree/bindings/mtd/fsl-nfc.txt b/Documentation/devicetree/bindings/mtd/fsl-nfc.txt
new file mode 100644
index 0000000..1d339b1
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/fsl-nfc.txt
@@ -0,0 +1,25 @@
+* Freescale's NFC (nand flash controller)
+
+Required properties:
+- compatible : "fsl,XXX-nfc"
+- reg : Address range of the mtd chip
+- interrupts: Should contain the STMMAC interrupts
+- nand-bus-width: see nand.txt
+- nand-ecc-mode: see nand.txt
+- nand-on-flash-bbt: see nand.txt
+- clock-frequency : Optional clock rate to NFC in Hz
+- #address-cells, #size-cells : Must be present if the device has sub-nodes
+  representing partitions.
+
+Example:
+
+	nfc: nand at 400e0000 {
+		compatible = "fsl,vf610-nfc";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x400e0000 0x4000>;
+		interrupts = <0 83 0x04>;
+		clocks = <&clks VF610_CLK_NFC>;
+		clock-names = "nfc";
+		clock-frequency = <33000000>;
+	};
-- 
1.8.0.2
