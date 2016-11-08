From: dinguyen@kernel.org (Dinh Nguyen)
Date: Mon,  7 Nov 2016 20:28:30 -0600
Subject: [PATCHv3] ARM: dts: socfpga: Enable QSPI on the Cyclone5 sockit
Message-ID: <20161108022830.29303-1-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Enable the QSPI node and add the flash chip.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
v3: Use n25q00 for the compatible entry for the flash part and
    tested on SoCKit
v2: Remove partition entries for the SoCKIT
---
 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
index 02e22f5..d59f6f2 100644
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
+		compatible = "n25q00";
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
2.8.3
