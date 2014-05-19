From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 19 May 2014 13:06:00 -0700
Subject: [PATCH RESEND v2 2/3] Documentation: devicetree: add Broadcom GISB
 arbiter bindings
In-Reply-To: <1400529962-9612-1-git-send-email-f.fainelli@gmail.com>
References: <1400529962-9612-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1400529962-9612-3-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the Broadcom GISB arbiter Device Tree binding that is
used on all Broadcom Set-top-box System-on-a-chip.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v2:
- respin

 .../devicetree/bindings/bus/brcm,gisb-arb.txt      | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt

diff --git a/Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt b/Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt
new file mode 100644
index 000000000000..e2d501d20c9a
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt
@@ -0,0 +1,30 @@
+Broadcom GISB bus Arbiter controller
+
+Required properties:
+
+- compatible: should be "brcm,gisb-arb"
+- reg: specifies the base physical address and size of the registers
+- interrupt-parent: specifies the phandle to the parent interrupt controller
+  this arbiter gets interrupt line from
+- interrupts: specifies the two interrupts (timeout and TEA) to be used from
+  the parent interrupt controller
+
+Optional properties:
+
+- brcm,gisb-arb-master-mask: 32-bits wide bitmask used to specify which GISB
+  masters are valid at the system level
+- brcm,gisb-arb-master-names: string list of the litteral name of the GISB
+  masters. Should match the number of bits set in brcm,gisb-master-mask and
+  the order in which they appear
+
+Example:
+
+gisb-arb at f0400000 {
+	compatible = "brcm,gisb-arb";
+	reg = <0xf0400000 0x800>;
+	interrupts = <0>, <2>;
+	interrupt-parent = <&sun_l2_intc>;
+
+	brcm,gisb-arb-master-mask = <0x7>;
+	brcm,gisb-arb-master-names = "bsp_0", "scpu_0", "cpu_0";
+};
-- 
1.9.1
