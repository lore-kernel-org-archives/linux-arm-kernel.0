From: iwamatsu@nigauri.org (Nobuhiro Iwamatsu)
Date: Thu,  9 Feb 2017 09:43:49 +0900
Subject: [PATCH] ARM: dts: socfpga: sodia: enable qspi
Message-ID: <20170209004349.9772-1-iwamatsu@nigauri.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the qspi controller on sodia board and add the flash chip
(n25q512a).

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 arch/arm/boot/dts/socfpga_cyclone5_sodia.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga_cyclone5_sodia.dts b/arch/arm/boot/dts/socfpga_cyclone5_sodia.dts
index 5b7e3c27e6e9..d69ad29d1e53 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_sodia.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_sodia.dts
@@ -121,3 +121,24 @@
 &usb1 {
 	status = "okay";
 };
+
+&qspi {
+        status = "okay";
+
+        flash0: n25q512a at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "n25q512a";
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
-- 
2.11.0
