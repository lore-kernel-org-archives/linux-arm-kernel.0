From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Wed, 7 Aug 2013 12:00:51 +0530
Subject: [PATCH V2] ARM: dts: AM33xx: Add RNG node
In-Reply-To: <1375777984-6267-4-git-send-email-lokeshvutla@ti.com>
References: <1375777984-6267-4-git-send-email-lokeshvutla@ti.com>
Message-ID: <1375857051-8188-1-git-send-email-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the AM33xx RNG module's device tree data.
Also add Documentation file describing the data
for the RNG module.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
Changes since V1:
- Drop "status=disabled" entry in dt node, Since
  RNG is present on all AM33xx platforms.

 .../devicetree/bindings/hwrng/omap_rng.txt         |   22 ++++++++++++++++++++
 arch/arm/boot/dts/am33xx.dtsi                      |    7 +++++++
 2 files changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwrng/omap_rng.txt

diff --git a/Documentation/devicetree/bindings/hwrng/omap_rng.txt b/Documentation/devicetree/bindings/hwrng/omap_rng.txt
new file mode 100644
index 0000000..6a62acd
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwrng/omap_rng.txt
@@ -0,0 +1,22 @@
+OMAP SoC HWRNG Module
+
+Required properties:
+
+- compatible : Should contain entries for this and backward compatible
+  RNG versions:
+  - "ti,omap2-rng" for OMAP2.
+  - "ti,omap4-rng" for OMAP4, OMAP5 and AM33XX.
+  Note that these two versions are incompatible.
+- ti,hwmods: Name of the hwmod associated with the RNG module
+- reg : Offset and length of the register set for the module
+- interrupts : the interrupt number for the RNG module.
+		Only used for "ti,omap4-rng".
+
+Example:
+/* AM335x */
+rng: rng at 48310000 {
+	compatible = "ti,omap4-rng";
+	ti,hwmods = "rng";
+	reg = <0x48310000 0x2000>;
+	interrupts = <111>;
+};
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 38b446b..26ebe30 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -530,5 +530,12 @@
 			#size-cells = <1>;
 			status = "disabled";
 		};
+
+		rng: rng at 48310000 {
+			compatible = "ti,omap4-rng";
+			ti,hwmods = "rng";
+			reg = <0x48310000 0x2000>;
+			interrupts = <111>;
+		};
 	};
 };
-- 
1.7.9.5
