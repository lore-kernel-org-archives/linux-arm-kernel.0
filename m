From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 10 Jul 2017 09:56:21 +0200
Subject: [PATCH 2/2] ARM64: dts: meson-gx: Add AO CEC nodes
In-Reply-To: <1499673381-21039-1-git-send-email-narmstrong@baylibre.com>
References: <1499673381-21039-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1499673381-21039-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the AO CEC node in all the HDMI enabled boards DTS.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi         | 7 +++++++
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi                   | 6 ++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts      | 7 +++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi            | 7 +++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi                 | 6 ++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts        | 8 +++++++-
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts | 7 +++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts        | 7 +++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi                  | 6 ++++++
 arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts         | 7 +++++++
 10 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
index dc478d0..c89010e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
@@ -121,6 +121,13 @@
 	};
 };
 
+&cec_AO {
+	status = "okay";
+	pinctrl-0 = <&ao_cec_pins>;
+	pinctrl-names = "default";
+	hdmi-phandle = <&hdmi_tx>;
+};
+
 &cvbs_vdac_port {
 	cvbs_vdac_out: endpoint {
 		remote-endpoint = <&cvbs_connector_in>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 91a57d4..de73060 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -383,6 +383,12 @@
 				amlogic,pwr-ctrl = <&pwr_AO>;
 			};
 
+			cec_AO: cec at 100 {
+				compatible = "amlogic,meson-gx-ao-cec";
+				reg = <0x0 0x00100 0x0 0x14>;
+				interrupts = <GIC_SPI 199 IRQ_TYPE_EDGE_RISING>;
+			};
+
 			uart_AO: serial at 4c0 {
 				compatible = "amlogic,meson-uart";
 				reg = <0x0 0x004c0 0x0 0x14>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
index a1078b3..9c59c3c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
@@ -171,6 +171,13 @@
 	};
 };
 
+&cec_AO {
+	status = "okay";
+	pinctrl-0 = <&ao_cec_pins>;
+	pinctrl-names = "default";
+	hdmi-phandle = <&hdmi_tx>;
+};
+
 &ethmac {
 	status = "okay";
 	pinctrl-0 = <&eth_rmii_pins>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
index d904deb..6a2d984 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
@@ -148,6 +148,13 @@
 	};
 };
 
+&cec_AO {
+	status = "okay";
+	pinctrl-0 = <&ao_cec_pins>;
+	pinctrl-names = "default";
+	hdmi-phandle = <&hdmi_tx>;
+};
+
 &cvbs_vdac_port {
 	cvbs_vdac_out: endpoint {
 		remote-endpoint = <&cvbs_connector_in>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 17d3efd..7f14136 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -307,6 +307,12 @@
 	};
 };
 
+
+&cec_AO {
+	clocks = <&clkc_AO CLKID_AO_CEC_32K>;
+	clock-names = "core";
+};
+
 &ethmac {
 	clocks = <&clkc CLKID_ETH>,
 		 <&clkc CLKID_FCLK_DIV2>,
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts
index 3e0c023..6827f23 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts
@@ -97,6 +97,13 @@
 	};
 };
 
+&cec_AO {
+	status = "okay";
+	pinctrl-0 = <&ao_cec_pins>;
+	pinctrl-names = "default";
+	hdmi-phandle = <&hdmi_tx>;
+};
+
 /* P230 has exclusive choice between internal or external PHY */
 &ethmac {
 	pinctrl-0 = <&eth_pins>;
@@ -124,7 +131,6 @@
 	};
 };
 
-
 &hdmi_tx {
 	status = "okay";
 	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
index 6633a5d..4c2ac76 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
@@ -140,6 +140,13 @@
 	};
 };
 
+&cec_AO {
+	status = "okay";
+	pinctrl-0 = <&ao_cec_pins>;
+	pinctrl-names = "default";
+	hdmi-phandle = <&hdmi_tx>;
+};
+
 &cvbs_vdac_port {
 	cvbs_vdac_out: endpoint {
 		remote-endpoint = <&cvbs_connector_in>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
index 6ab17c1..6e2bf85 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
@@ -71,6 +71,13 @@
 	};
 };
 
+&cec_AO {
+	status = "okay";
+	pinctrl-0 = <&ao_cec_pins>;
+	pinctrl-names = "default";
+	hdmi-phandle = <&hdmi_tx>;
+};
+
 &cvbs_vdac_port {
 	cvbs_vdac_out: endpoint {
 		remote-endpoint = <&cvbs_connector_in>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 8d4f316..d6b0f5b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -43,6 +43,7 @@
 
 #include "meson-gx.dtsi"
 #include <dt-bindings/clock/gxbb-clkc.h>
+#include <dt-bindings/clock/gxbb-aoclkc.h>
 #include <dt-bindings/gpio/meson-gxl-gpio.h>
 #include <dt-bindings/reset/amlogic,meson-gxbb-reset.h>
 
@@ -207,6 +208,11 @@
 	};
 };
 
+&cec_AO {
+	clocks = <&clkc_AO CLKID_AO_CEC_32K>;
+	clock-names = "core";
+};
+
 &hdmi_tx {
 	compatible = "amlogic,meson-gxl-dw-hdmi", "amlogic,meson-gx-dw-hdmi";
 	resets = <&reset RESET_HDMITX_CAPB3>,
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
index 5f626d6..9b10c5f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
@@ -113,6 +113,13 @@
 	};
 };
 
+&cec_AO {
+	status = "okay";
+	pinctrl-0 = <&ao_cec_pins>;
+	pinctrl-names = "default";
+	hdmi-phandle = <&hdmi_tx>;
+};
+
 &cvbs_vdac_port {
 	cvbs_vdac_out: endpoint {
 		remote-endpoint = <&cvbs_connector_in>;
-- 
1.9.1
