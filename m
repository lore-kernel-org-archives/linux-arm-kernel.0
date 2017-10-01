From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun,  1 Oct 2017 14:56:57 +0200
Subject: [PATCH 1/4] dt-bindings: nvmem: Describe the Amlogic
 Meson6/Meson8/Meson8b efuse
In-Reply-To: <20171001125700.1520-1-martin.blumenstingl@googlemail.com>
References: <20171001125700.1520-1-martin.blumenstingl@googlemail.com>
Message-ID: <20171001125700.1520-2-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Amlogic Meson6, Meson8 and Meson8b SoCs have an efuse which contains
calibration data from the factory (for the internal temperature sensor
and some CVBS connector settings). Some manufacturers also store the MAC
address or serial number in the efuse.

This documents the devicetree bindings for the efuse on these SoCs.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../bindings/nvmem/amlogic-meson-mx-efuse.txt      | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/amlogic-meson-mx-efuse.txt

diff --git a/Documentation/devicetree/bindings/nvmem/amlogic-meson-mx-efuse.txt b/Documentation/devicetree/bindings/nvmem/amlogic-meson-mx-efuse.txt
new file mode 100644
index 000000000000..a3c63954a1a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/amlogic-meson-mx-efuse.txt
@@ -0,0 +1,22 @@
+Amlogic Meson6/Meson8/Meson8b efuse
+
+Required Properties:
+- compatible: depending on the SoC this should be one of:
+	- "amlogic,meson6-efuse"
+	- "amlogic,meson8-efuse"
+	- "amlogic,meson8b-efuse"
+- reg: base address and size of the efuse registers
+- clocks: a reference to the efuse core gate clock
+- clock-names: must be "core"
+
+All properties and sub-nodes as well as the consumer bindings
+defined in nvmem.txt in this directory are also supported.
+
+
+Example:
+	efuse: nvmem at 0 {
+		compatible = "amlogic,meson8-efuse";
+		reg = <0x0 0x2000>;
+		clocks = <&clkc CLKID_EFUSE>;
+		clock-names = "core";
+	};
-- 
2.14.2
