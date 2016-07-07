From: jon.mason@broadcom.com (Jon Mason)
Date: Thu,  7 Jul 2016 19:08:58 -0400
Subject: [PATCH v2 6/6] dt-bindings: net: bgmac: add bindings documentation
 for bgmac
In-Reply-To: <1467932938-21819-1-git-send-email-jon.mason@broadcom.com>
References: <1467932938-21819-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <1467932938-21819-7-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jon Mason <jon.mason@broadcom.com>
---
 .../devicetree/bindings/net/brcm,amac.txt          | 24 ++++++++++++++++++++++
 .../devicetree/bindings/net/brcm,bgmac-nsp.txt     | 24 ++++++++++++++++++++++
 2 files changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/brcm,amac.txt
 create mode 100644 Documentation/devicetree/bindings/net/brcm,bgmac-nsp.txt

diff --git a/Documentation/devicetree/bindings/net/brcm,amac.txt b/Documentation/devicetree/bindings/net/brcm,amac.txt
new file mode 100644
index 0000000..ba5ecc1
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/brcm,amac.txt
@@ -0,0 +1,24 @@
+Broadcom AMAC Ethernet Controller Device Tree Bindings
+-------------------------------------------------------------
+
+Required properties:
+ - compatible:	"brcm,amac" or "brcm,nsp-amac"
+ - reg:		Address and length of the GMAC registers,
+		Address and length of the GMAC IDM registers
+ - reg-names:	Names of the registers.  Must have both "amac_base" and
+		"idm_base"
+ - interrupts:	Interrupt number
+
+Optional properties:
+- mac-address:	See ethernet.txt file in the same directory
+
+Examples:
+
+amac0: ethernet at 18022000 {
+	compatible = "brcm,nsp-amac";
+	reg = <0x18022000 0x1000>,
+	      <0x18110000 0x1000>;
+	reg-names = "amac_base", "idm_base";
+	interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
+	status = "disabled";
+};
diff --git a/Documentation/devicetree/bindings/net/brcm,bgmac-nsp.txt b/Documentation/devicetree/bindings/net/brcm,bgmac-nsp.txt
new file mode 100644
index 0000000..022946c
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/brcm,bgmac-nsp.txt
@@ -0,0 +1,24 @@
+Broadcom GMAC Ethernet Controller Device Tree Bindings
+-------------------------------------------------------------
+
+Required properties:
+ - compatible:	"brcm,bgmac-nsp"
+ - reg:		Address and length of the GMAC registers,
+		Address and length of the GMAC IDM registers
+ - reg-names:	Names of the registers.  Must have both "gmac_base" and
+		"idm_base"
+ - interrupts:	Interrupt number
+
+Optional properties:
+- mac-address:	See ethernet.txt file in the same directory
+
+Examples:
+
+gmac0: ethernet at 18022000 {
+	compatible = "brcm,bgmac-nsp";
+	reg = <0x18022000 0x1000>,
+	      <0x18110000 0x1000>;
+	reg-names = "gmac_base", "idm_base";
+	interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
+	status = "disabled";
+};
-- 
1.9.1
