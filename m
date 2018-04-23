From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 23 Apr 2018 10:46:14 -0300
Subject: [PATCH 5/5] ARM: dts: imx6qdl-sabre: Remove #address/#size-cells from
 camera port nodes
In-Reply-To: <1524491174-16878-1-git-send-email-festevam@gmail.com>
References: <1524491174-16878-1-git-send-email-festevam@gmail.com>
Message-ID: <1524491174-16878-5-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Remove unnecessary #address-cells/#size-cells to fix the following
DTC warnings:

arch/arm/boot/dts/imx6q-novena.dtb: Warning (avoid_unnecessary_addr_size): /soc/ipu at 2400000/port at 2: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
arch/arm/boot/dts/imx6q-novena.dtb: Warning (avoid_unnecessary_addr_size): /soc/ipu at 2400000/port at 3: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
arch/arm/boot/dts/imx6q-novena.dtb: Warning (avoid_unnecessary_addr_size): /soc/ipu at 2800000/port at 2: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
arch/arm/boot/dts/imx6q-novena.dtb: Warning (avoid_unnecessary_addr_size): /soc/ipu at 2800000/port at 3: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi | 3 ---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi   | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index 18b6505..654cf2c 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -379,9 +379,6 @@
 		powerdown-gpios = <&gpio6 9 GPIO_ACTIVE_HIGH>; /* NANDF_WP_B */
 
 		port {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
 			ov5640_to_mipi_csi2: endpoint {
 				remote-endpoint = <&mipi_csi2_in>;
 				clock-lanes = <0>;
diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index f019f99..c2de225 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -294,9 +294,6 @@
 		reset-gpios = <&gpio1 20 GPIO_ACTIVE_LOW>;
 
 		port {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
 			ov5640_to_mipi_csi2: endpoint {
 				remote-endpoint = <&mipi_csi2_in>;
 				clock-lanes = <0>;
-- 
2.7.4
