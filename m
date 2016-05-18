From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Wed, 18 May 2016 15:40:25 +0000
Subject: [PATCH-V2 1/6] dt: bindings: add bcm2835-memory-controller
 documentation
In-Reply-To: <1463586030-2778-1-git-send-email-kernel@martin.sperl.org>
References: <1463586030-2778-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1463586030-2778-2-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Add memory controller dt-binding documentation for the
bcm2835 soc.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>

Changelog:
  V2 -> V3: added additional clock
	      (for the Controller internal PLL)
	    added clock-names
	    added additional register ranges for the
	      SDRAM Adress and Data PHY
	    added reg-names
---
 .../memory-controllers/brcm,bcm2835-sdram.txt      | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/brcm,bcm2835-sdram.txt

diff --git a/Documentation/devicetree/bindings/memory-controllers/brcm,bcm2835-sdram.txt b/Documentation/devicetree/bindings/memory-controllers/brcm,bcm2835-sdram.txt
new file mode 100644
index 0000000..5c4182f
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/brcm,bcm2835-sdram.txt
@@ -0,0 +1,30 @@
+Binding for SDRAM driver for BCM2835 SoCs.
+
+Required parameters:
+-------------------
+
+compatible : 	should be: "brcm,bcm2835-sdram"
+reg :		Address range of the register-set:
+		  * SD
+		  * APHY_CSR
+		  * DPHY_CSR
+reg-names :	Names of the register ranges:
+		  "sdram", "aphy_csr", "dphy_csr"
+clocks : 	Phandle of the clocks used by the sdram
+		  * low voltage clock
+		  * pll parent clock
+clock-names:	Names of the clocks:
+		  "low-voltage", "pll-parent"
+
+Example:
+
+memory-conroller at 7ee00000 {
+	compatible = "brcm,bcm2835-sdram";
+	reg = <0x7ee00000 0x18c>,
+	      <0x7ee06000 0x94>,
+	      <0x7ee07000 0x808>;
+	reg-names = "sdram", "aphy_csr", "dphy_csr";
+	clocks = <&clocks BCM2835_CLOCK_SDRAM>,
+		 <&clocks BCM2835_PLLD_CORE>;
+	clock-names = "low-voltage", "pll-parent";
+};
-- 
2.1.4
