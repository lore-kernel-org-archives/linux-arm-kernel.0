From: rnayak@ti.com (Rajendra Nayak)
Date: Thu, 27 Oct 2011 13:34:33 +0530
Subject: [PATCH 2/3] omap4: sdp: Pass regulator data from dt
In-Reply-To: <1319702674-16304-1-git-send-email-rnayak@ti.com>
References: <1319702674-16304-1-git-send-email-rnayak@ti.com>
Message-ID: <1319702674-16304-3-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pass adjustable regulator information for omap4sdp from device tree so the
regulator driver can then use the regulator helper
routine to extract and use them during the driver probe().

Also add documentation for TWL regulator specific bindings.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 .../bindings/regulator/twl-regulator.txt           |   57 ++++++++++++++++++++
 arch/arm/boot/dts/omap4-sdp.dts                    |   36 ++++++++++++
 2 files changed, 93 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/twl-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/twl-regulator.txt b/Documentation/devicetree/bindings/regulator/twl-regulator.txt
new file mode 100644
index 0000000..2b0842c
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/twl-regulator.txt
@@ -0,0 +1,57 @@
+TWL family of regulators
+
+Required properties:
+- compatible:
+  - "ti,twl4030" for twl4030 regulators
+  - "ti,twl6025" for twl6025 regulators
+  - "ti,twl6030" for twl6030 regulators
+
+Additionally compatible can be used to specify the
+exact regulator/ldo instance like
+For twl6030 regulators/LDO's
+- compatible:
+  - "ti,twl6030-vaux1" for VAUX1 LDO
+  - "ti,twl6030-vaux2" for VAUX2 LDO
+  - "ti,twl6030-vaux3" for VAUX3 LDO
+  - "ti,twl6030-vmmc" for VMMC LDO
+  - "ti,twl6030-vpp" for VPP LDO
+  - "ti,twl6030-vusim" for VUSIM LDO
+For twl6025 regulators/LDO's
+- compatible:
+  - "ti,twl6025-ldo1" for LDO1 LDO
+  - "ti,twl6025-ldo2" for LDO2 LDO
+  - "ti,twl6025-ldo3" for LDO3 LDO
+  - "ti,twl6025-ldo4" for LDO4 LDO
+  - "ti,twl6025-ldo5" for LDO5 LDO
+  - "ti,twl6025-ldo6" for LDO6 LDO
+  - "ti,twl6025-ldo7" for LDO7 LDO
+  - "ti,twl6025-ldoln" for LDOLN LDO
+  - "ti,twl6025-ldousb" for LDOUSB LDO
+For twl4030 regulators/LDO's
+- compatible:
+  - "ti,twl4030-vaux1" for VAUX1 LDO
+  - "ti,twl4030-vaux2" for VAUX2 LDO
+  - "ti,twl5030-vaux2" for VAUX2 LDO
+  - "ti,twl4030-vaux3" for VAUX3 LDO
+  - "ti,twl4030-vaux4" for VAUX4 LDO
+  - "ti,twl4030-vmmc1" for VMMC1 LDO
+  - "ti,twl4030-vmmc2" for VMMC2 LDO
+  - "ti,twl4030-vpll1" for VPLL1 LDO
+  - "ti,twl4030-vpll2" for VPLL2 LDO
+  - "ti,twl4030-vsim" for VSIM LDO
+  - "ti,twl4030-vdac" for VDAC LDO
+  - "ti,twl4030-vintana2" for VINTANA2 LDO
+  - "ti,twl4030-vio" for VIO LDO
+  - "ti,twl4030-vdd1" for VDD1 LDO
+  - "ti,twl4030-vdd2" for VDD2 LDO
+
+Optional properties:
+- Any optional property defined in bindings/regulator/regulator.txt
+
+Example:
+
+	xyz: regulator at 0 {
+		compatible = "ti,twl6030-vaux1","ti,twl6030";
+		regulator-min_uV  = <1000000>;
+		regulator-max_uV  = <3000000>;
+	};
diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 2990841..adc7faf 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -48,6 +48,42 @@
 			compatible = "ti,twl4030-rtc";
 			interrupts = <11>;
 		};
+
+		vaux1: regulator at 0 {
+			compatible = "ti,twl6030-vaux1","ti,twl6030";
+			regulator-min-uV = <1000000>;
+			regulator-max-uV = <3000000>;
+		};
+
+		vaux2: regulator at 1 {
+			compatible = "ti,twl6030-vaux2","ti,twl6030";
+			regulator-min-uV = <1200000>;
+			regulator-max-uV = <2800000>;
+		};
+
+		vaux3: regulator at 2 {
+			compatible = "ti,twl6030-vaux3","ti,twl6030";
+			regulator-min-uV = <1000000>;
+			regulator-max-uV = <3000000>;
+		};
+
+		vmmc: regulator at 3 {
+			compatible = "ti,twl6030-vmmc","ti,twl6030";
+			regulator-min-uV = <1200000>;
+			regulator-max-uV = <3000000>;
+		};
+
+		vpp: regulator at 4 {
+			compatible = "ti,twl6030-vpp","ti,twl6030";
+			regulator-min-uV = <1800000>;
+			regulator-max-uV = <2500000>;
+		};
+
+		vusim: regulator at 5 {
+			compatible = "ti,twl6030-vusim","ti,twl6030";
+			regulator-min-uV = <1200000>;
+			regulator-max-uV = <2900000>;
+		};
 	};
 };
 
-- 
1.7.1
