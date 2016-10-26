From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Wed, 26 Oct 2016 13:05:12 -0500
Subject: [PATCHv2] ARM: dts: socfpga: Enable QSPI on the Cyclone5 sockit
Message-ID: <1477505112-26079-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Enable the QSPI node and add the flash chip.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
v2: Remove partition entries for the SoCKIT
---
 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
index 02e22f5..2ce6736 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
@@ -175,6 +175,27 @@
 	status = "okay";
 };
 
+&qspi {
+	status = "okay";
+
+	flash: flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "n25q256a";
+		reg = <0>;
+		spi-max-frequency = <100000000>;
+
+		m25p,fast-read;
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
 &usb1 {
 	status = "okay";
 };
-- 
1.7.9.5
