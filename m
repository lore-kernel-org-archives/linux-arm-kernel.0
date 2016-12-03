From: baoyou.xie@linaro.org (Baoyou Xie)
Date: Sat,  3 Dec 2016 19:59:14 +0800
Subject: [PATCH] arm64: dts: zx: add pcu_domain node for zx296718
Message-ID: <1480766354-25168-1-git-send-email-baoyou.xie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the pcu_domain node, so it can be used
by zte-soc's power domain driver.

Furthermore, it adds the document of the node.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 Documentation/devicetree/bindings/arm/zte.txt | 11 +++++++++++
 arch/arm64/boot/dts/zte/zx296718.dtsi         |  7 +++++++
 2 files changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/zte.txt b/Documentation/devicetree/bindings/arm/zte.txt
index 83369785..19a7e1b 100644
--- a/Documentation/devicetree/bindings/arm/zte.txt
+++ b/Documentation/devicetree/bindings/arm/zte.txt
@@ -27,6 +27,9 @@ System management required properties:
       - compatible = "zte,zx296718-aon-sysctrl"
       - compatible = "zte,zx296718-sysctrl"
 
+Low power management required properties:
+      - compatible = "zte,zx296718-pcu"
+
 Example:
 aon_sysctrl: aon-sysctrl at 116000 {
 	compatible = "zte,zx296718-aon-sysctrl", "syscon";
@@ -37,3 +40,11 @@ sysctrl: sysctrl at 1463000 {
 	compatible = "zte,zx296718-sysctrl", "syscon";
 	reg = <0x1463000 0x1000>;
 };
+
+pcu_domain: pcu at 0x00117000 {
+        compatible = "zte,zx296718-pcu";
+        reg = <0x00117000 0x1000>;
+        #power-domain-cells = <1>;
+        status = "ok";
+};
+
diff --git a/arch/arm64/boot/dts/zte/zx296718.dtsi b/arch/arm64/boot/dts/zte/zx296718.dtsi
index b44d1d1..39e70c7 100644
--- a/arch/arm64/boot/dts/zte/zx296718.dtsi
+++ b/arch/arm64/boot/dts/zte/zx296718.dtsi
@@ -351,5 +351,12 @@
 			reg = <0x01480000 0x1000>;
 			#clock-cells = <1>;
 		};
+
+		pcu_domain: pcu at 0x00117000 {
+			compatible = "zte,zx296718-pcu";
+			reg = <0x00117000 0x1000>;
+			#power-domain-cells = <1>;
+			status = "ok";
+		};
 	};
 };
-- 
2.7.4
