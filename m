From: stillcompiling@gmail.com (Joshua Clayton)
Date: Thu, 25 May 2017 10:29:07 -0700
Subject: [PATCH v11 2/6] doc: dt: add altera-ps-spi binding document
In-Reply-To: <20170525172911.11467-1-stillcompiling@gmail.com>
References: <20170525172911.11467-1-stillcompiling@gmail.com>
Message-ID: <20170525172911.11467-3-stillcompiling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe an altera-ps-spi devicetree entry, required features

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 .../bindings/fpga/altera-passive-serial.txt        | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/altera-passive-serial.txt

diff --git a/Documentation/devicetree/bindings/fpga/altera-passive-serial.txt b/Documentation/devicetree/bindings/fpga/altera-passive-serial.txt
new file mode 100644
index 000000000000..3e240b281f21
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/altera-passive-serial.txt
@@ -0,0 +1,29 @@
+Altera Passive Serial SPI FPGA Manager
+
+Altera FPGAs support a method of loading the bitstream over what is
+referred to as "passive serial".
+The passive serial link is not technically SPI, and might require extra
+circuits in order to play nicely with other SPI slaves on the same bus.
+
+See https://www.altera.com/literature/hb/cyc/cyc_c51013.pdf
+
+Required properties:
+- compatible: Must be one of the following:
+	"altr,fpga-passive-serial",
+	"altr,fpga-arria10-passive-serial"
+- reg: SPI chip select of the FPGA
+- nconfig-gpios: config pin (referred to as nCONFIG in the manual)
+- nstat-gpios: status pin (referred to as nSTATUS in the manual)
+
+Optional properties:
+- confd-gpios: confd pin (referred to as CONF_DONE in the manual)
+
+Example:
+	fpga_spi: evi-fpga-spi at 0 {
+		compatible = "altr,fpga-passive-serial";
+		spi-max-frequency = <20000000>;
+		reg = <0>;
+		nconfig-gpios = <&gpio4 9 GPIO_ACTIVE_LOW>;
+		nstat-gpios = <&gpio4 11 GPIO_ACTIVE_LOW>;
+		confd-gpios = <&gpio4 12 GPIO_ACTIVE_LOW>;
+	};
-- 
2.11.0
