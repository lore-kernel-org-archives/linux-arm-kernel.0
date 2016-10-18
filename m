From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Tue, 18 Oct 2016 09:43:03 +0200
Subject: [PATCH 2/3] ARM: socfpga: socrates: enable qspi
In-Reply-To: <20161018074304.6744-1-s.trumtrar@pengutronix.de>
References: <20161018074304.6744-1-s.trumtrar@pengutronix.de>
Message-ID: <20161018074304.6744-2-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the qspi controller on the socrates and add the flash chip.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/socfpga_cyclone5_socrates.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts b/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
index d79853775061..c3d52f27b21e 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
@@ -80,3 +80,22 @@
 &mmc {
 	status = "okay";
 };
+
+&qspi {
+	status = "okay";
+
+	flash: flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "n25q256a";
+		reg = <0>;
+		spi-max-frequency = <100000000>;
+		m25p,fast-read;
+		cdns,read-delay = <4>;
+		cdns,tshsl-ns = <50>;
+		cdns,tsd2d-ns = <50>;
+		cdns,tchsh-ns = <4>;
+		cdns,tslch-ns = <4>;
+		status = "okay";
+	};
+};
-- 
2.9.3
