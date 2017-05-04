From: marex@denx.de (Marek Vasut)
Date: Thu,  4 May 2017 12:29:47 +0200
Subject: [PATCH 1/4] ARM: dts: socfpga: Enable QSPI support on VINING FPGA
Message-ID: <20170504102950.10667-1-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the QSPI node and add the flash chips.

Signed-off-by: Marek Vasut <marex@denx.de>
---
 arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts b/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
index 893198049397..cb4bdbcf54ee 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
@@ -300,6 +300,44 @@
 	};
 };
 
+&qspi {
+	status = "okay";
+
+	n25q128 at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "n25q128";
+		reg = <0>;		/* chip select */
+		spi-max-frequency = <100000000>;
+		m25p,fast-read;
+
+		cdns,page-size = <256>;
+		cdns,block-size = <16>;
+		cdns,read-delay = <4>;
+		cdns,tshsl-ns = <50>;
+		cdns,tsd2d-ns = <50>;
+		cdns,tchsh-ns = <4>;
+		cdns,tslch-ns = <4>;
+	};
+
+	n25q00 at 1 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "n25q00";
+		reg = <1>;		/* chip select */
+		spi-max-frequency = <100000000>;
+		m25p,fast-read;
+
+		cdns,page-size = <256>;
+		cdns,block-size = <16>;
+		cdns,read-delay = <4>;
+		cdns,tshsl-ns = <50>;
+		cdns,tsd2d-ns = <50>;
+		cdns,tchsh-ns = <4>;
+		cdns,tslch-ns = <4>;
+	};
+};
+
 &usb0 {
 	dr_mode = "host";
 	status = "okay";
-- 
2.11.0
