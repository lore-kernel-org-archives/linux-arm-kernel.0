From: stillcompiling@gmail.com (Joshua Clayton)
Date: Thu,  6 Oct 2016 13:34:18 -0700
Subject: [PATCH 2/3] doc: dt: add cyclone-spi binding document
In-Reply-To: <4b4432c04b4ea92a2af814e3d7866c33f2eb12ea.1475783742.git.stillcompiling@gmail.com>
References: <4b4432c04b4ea92a2af814e3d7866c33f2eb12ea.1475783742.git.stillcompiling@gmail.com>
Message-ID: <8d89e70475e8e1c3ce5117a0367c8444c11c61e3.1475783742.git.stillcompiling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe a cyclonespi devicetree entry, required features

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 .../bindings/fpga/cyclone-spi-fpga-mgr.txt         | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/cyclone-spi-fpga-mgr.txt

diff --git a/Documentation/devicetree/bindings/fpga/cyclone-spi-fpga-mgr.txt b/Documentation/devicetree/bindings/fpga/cyclone-spi-fpga-mgr.txt
new file mode 100644
index 0000000..8de34db
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/cyclone-spi-fpga-mgr.txt
@@ -0,0 +1,23 @@
+Altera SOCFPGA FPGA Manager
+
+Altera cyclone FPGAs support a method of loading the bitstream over what is
+referred to as "passive serial".
+The passive serial link is not technically spi, and might require extra
+circuits in order to play nicely with other spi slaves on the same bus.
+
+See https://www.altera.com/literature/hb/cyc/cyc_c51013.pdf
+
+Required properties:
+- compatible  : should contain "altr,cyclonespi-fpga-mgr"
+- reg         : spi slave id of the fpga
+- reset-gpio  : reset pin (referred to as nCONFIG in the cyclone manual)
+- status-gpio : status pin (referred to as nSTATUS in the cyclone manual)
+
+Example:
+	fpga_spi: evi-fpga-spi at 0 {
+		compatible = "altr,cyclonespi-fpga-mgr";
+		spi-max-frequency = <20000000>;
+		reg = <0>;
+		reset-gpio = <&gpio4 9 GPIO_ACTIVE_HIGH>;
+		status-gpio = <&gpio4 11 GPIO_ACTIVE_HIGH>;
+	};
-- 
2.7.4
