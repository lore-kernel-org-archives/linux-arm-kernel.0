From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 23 Sep 2017 16:14:01 +0200
Subject: [PATCH 1/3] dt-bindings: Amlogic: add documentation for the SoC info
 register areas
In-Reply-To: <20170923141403.20882-1-martin.blumenstingl@googlemail.com>
References: <20170923141403.20882-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170923141403.20882-2-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are three register areas which contain information about the SoC
version and revision:
- the assist registers contain the SoC's "major version" which encodes
  the SoC generation and part number. this is available on Meson6,
  Meson8 and Meson8b SoCs.
- the bootrom register contains at least the SoCs "misc version". this
  is avilable on Meson6, Meson8 and Meson8b
- the analog top registers contain information about the SoC revision.
  this is only available on Meson8 and Meson8b

Not much else is currently known about these registers.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../devicetree/bindings/arm/amlogic/analog-top.txt   | 20 ++++++++++++++++++++
 .../devicetree/bindings/arm/amlogic/assist.txt       | 17 +++++++++++++++++
 .../devicetree/bindings/arm/amlogic/bootrom.txt      | 17 +++++++++++++++++
 3 files changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/amlogic/analog-top.txt
 create mode 100644 Documentation/devicetree/bindings/arm/amlogic/assist.txt
 create mode 100644 Documentation/devicetree/bindings/arm/amlogic/bootrom.txt

diff --git a/Documentation/devicetree/bindings/arm/amlogic/analog-top.txt b/Documentation/devicetree/bindings/arm/amlogic/analog-top.txt
new file mode 100644
index 000000000000..101dc21014ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/amlogic/analog-top.txt
@@ -0,0 +1,20 @@
+Amlogic Meson8 and Meson8b "analog top" registers:
+--------------------------------------------------
+
+The analog top registers contain information about the so-called
+"metal revision" (which encodes the "minor version") of the SoC.
+
+Required properties:
+- reg: the register range of the analog top registers
+- compatible: depending on the SoC this should be one of:
+		- "amlogic,meson8-analog-top"
+		- "amlogic,meson8b-analog-top"
+		along with "syscon"
+
+
+Example:
+
+	analog_top: analog-top at 81a8 {
+		compatible = "amlogic,meson8-analog-top", "syscon";
+		reg = <0x81a8 0x14>;
+	};
diff --git a/Documentation/devicetree/bindings/arm/amlogic/assist.txt b/Documentation/devicetree/bindings/arm/amlogic/assist.txt
new file mode 100644
index 000000000000..7656812b67b9
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/amlogic/assist.txt
@@ -0,0 +1,17 @@
+Amlogic Meson6/Meson8/Meson8b assist registers:
+-----------------------------------------------
+
+The assist registers contain basic information about the SoC,
+for example the encoded SoC part number.
+
+Required properties:
+- reg: the register range of the assist registers
+- compatible: should be "amlogic,meson-mx-assist" along with "syscon"
+
+
+Example:
+
+	assist: assist at 7c00 {
+		compatible = "amlogic,meson-mx-assist", "syscon";
+		reg = <0x7c00 0x200>;
+	};
diff --git a/Documentation/devicetree/bindings/arm/amlogic/bootrom.txt b/Documentation/devicetree/bindings/arm/amlogic/bootrom.txt
new file mode 100644
index 000000000000..407e27f230ab
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/amlogic/bootrom.txt
@@ -0,0 +1,17 @@
+Amlogic Meson6/Meson8/Meson8b bootrom:
+--------------------------------------
+
+The bootrom register area can be used to access SoC specific
+information, such as the "misc version".
+
+Required properties:
+- reg: the register range of the bootrom registers
+- compatible: should be "amlogic,meson-mx-bootrom" along with "syscon"
+
+
+Example:
+
+	bootrom: bootrom at d9040000 {
+		compatible = "amlogic,meson-mx-bootrom", "syscon";
+		reg = <0xd9040000 0x10000>;
+	};
-- 
2.14.1
