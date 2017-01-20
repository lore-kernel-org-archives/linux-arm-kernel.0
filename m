From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Fri, 20 Jan 2017 23:21:16 +0100
Subject: [PATCH 16/18] ARM64: dts: meson-gxl-s905x-nexbox-a95x: Reorder nodes
In-Reply-To: <20170120222118.21476-1-afaerber@suse.de>
References: <20170120222118.21476-1-afaerber@suse.de>
Message-ID: <20170120222118.21476-17-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sort nodes referenced by label alphabetically.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 .../dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts    | 28 +++++++++++-----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
index cea4a3eded9b..9e91f0809dcd 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
@@ -129,10 +129,10 @@
 	};
 };
 
-&uart_AO {
-	status = "okay";
-	pinctrl-0 = <&uart_ao_a_pins>;
-	pinctrl-names = "default";
+&cvbs_vdac_port {
+	cvbs_vdac_out: endpoint {
+		remote-endpoint = <&cvbs_connector_in>;
+	};
 };
 
 &ethmac {
@@ -147,6 +147,14 @@
 	pinctrl-names = "default";
 };
 
+&pwm_ef {
+	status = "okay";
+	pinctrl-0 = <&pwm_e_pins>;
+	pinctrl-names = "default";
+	clocks = <&clkc CLKID_FCLK_DIV4>;
+	clock-names = "clkin0";
+};
+
 /* Wireless SDIO Module */
 &sd_emmc_a {
 	status = "okay";
@@ -206,16 +214,8 @@
 	vqmmc-supply = <&vddio_boot>;
 };
 
-&pwm_ef {
+&uart_AO {
 	status = "okay";
-	pinctrl-0 = <&pwm_e_pins>;
+	pinctrl-0 = <&uart_ao_a_pins>;
 	pinctrl-names = "default";
-	clocks = <&clkc CLKID_FCLK_DIV4>;
-	clock-names = "clkin0";
-};
-
-&cvbs_vdac_port {
-	cvbs_vdac_out: endpoint {
-		remote-endpoint = <&cvbs_connector_in>;
-	};
 };
-- 
2.10.2
