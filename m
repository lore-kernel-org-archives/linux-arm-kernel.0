From: baoyou.xie@linaro.org (Baoyou Xie)
Date: Fri,  6 Jan 2017 17:16:00 +0800
Subject: [PATCH v7 1/5] dt-bindings: zte: add bindings document for zx2967
 power domain controller
Message-ID: <1483694164-7668-1-git-send-email-baoyou.xie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device tree bindings document for ZTE zx2967
family power domain controller.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 .../devicetree/bindings/soc/zte/pd-2967xx.txt         | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/zte/pd-2967xx.txt

diff --git a/Documentation/devicetree/bindings/soc/zte/pd-2967xx.txt b/Documentation/devicetree/bindings/soc/zte/pd-2967xx.txt
new file mode 100644
index 0000000..7629de1
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/zte/pd-2967xx.txt
@@ -0,0 +1,19 @@
+* ZTE zx2967 family Power Domains
+
+zx2967 family includes support for multiple power domains which are used
+to gate power to one or more peripherals on the processor.
+
+Required Properties:
+  - compatible: should be one of the following.
+      * zte,zx296718-pcu - for zx296718 power domain.
+  - reg: physical base address of the controller and length of memory mapped
+      region.
+  - #power-domain-cells: Must be 1.
+
+Example:
+
+	pcu_domain: pcu at 117000 {
+		compatible = "zte,zx296718-pcu";
+		reg = <0x00117000 0x1000>;
+		#power-domain-cells = <1>;
+	};
-- 
2.7.4
