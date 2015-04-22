From: jonathar@broadcom.com (Jonathan Richardson)
Date: Wed, 22 Apr 2015 16:22:02 -0700
Subject: [PATCH 1/2] misc: Add DT binding for cygnus Digital Timing Engine
 (DTE) driver.
In-Reply-To: <1429744923-2007-1-git-send-email-jonathar@broadcom.com>
References: <1429744923-2007-1-git-send-email-jonathar@broadcom.com>
Message-ID: <1429744923-2007-2-git-send-email-jonathar@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reviewed-by: Scott Branden <sbranden@broadcom.com>
Tested-by: Scott Branden <sbranden@broadcom.com>
Signed-off-by: Jonathan Richardson <jonathar@broadcom.com>
---
 .../bindings/arm/bcm/brcm,cygnus-dte.txt           |   24 ++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,cygnus-dte.txt

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,cygnus-dte.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,cygnus-dte.txt
new file mode 100644
index 0000000..f30ca86
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,cygnus-dte.txt
@@ -0,0 +1,24 @@
+Broadcom Cygnus DTE Digital Timing Engine device tree bindings
+
+The DTE block allows for hardware timestamping of network packets,
+audio/video samples and/or GPIO inputs in a common adjustable time base.
+
+Required SoC Specific Properties:
+- compatible: should be "brcm,cygnus-dte"
+
+- reg: Requires two separate register sets
+	Base address of the Audio EAV Regsiters for DTE block and length of memory
+	mapped region.
+
+- interrupts: The DTE interrupt number to the cpu.
+
+Example:
+
+/ {
+	dte: dte at 0x180af000 {
+		compatible = "brcm,cygnus-dte";
+		reg = <0x180af000 0x1000>;
+		interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
+
+	};
+};
-- 
1.7.9.5
