From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri,  4 Aug 2017 15:12:13 +0200
Subject: [PATCH v2 2/2] ARM64: dts: meson-gx: Add AO CEC nodes
In-Reply-To: <1501852333-3560-1-git-send-email-narmstrong@baylibre.com>
References: <1501852333-3560-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1501852333-3560-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the AO CEC node in all the HDMI enabled boards DTS.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi          | 7 +++++++
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi                    | 6 ++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts       | 7 +++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi             | 7 +++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts       | 6 ++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi                  | 5 +++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts         | 8 +++++++-
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts   | 7 +++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts | 7 +++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts  | 7 +++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts         | 7 +++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi                   | 6 ++++++
 arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts          | 7 +++++++
 13 files changed, 86 insertions(+), 1 deletion(-)

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
index 7b7fbc8..673fdc4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -378,6 +378,12 @@
 				};
 			};
 
+			cec_AO: cec at 100 {
+				compatible = "amlogic,meson-gx-ao-cec";
+				reg = <0x0 0x00100 0x0 0x14>;
+				interrupts = <GIC_SPI 199 IRQ_TYPE_EDGE_RISING>;
+			};
+
 			sec_AO: ao-secure at 140 {
 				compatible = "amlogic,meson-gx-ao-secure", "syscon";
 				reg = <0x0 0x140 0x0 0x140>;
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
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts
index e76ac31..f7144fd 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts
@@ -108,6 +108,12 @@
 	};
 };
 
+&cec_AO {
+	status = "okay";
+	pinctrl-0 = <&ao_cec_pins>;
+	pinctrl-names = "default";
+	hdmi-phandle = <&hdmi_tx>;
+};
 
 &cvbs_vdac_port {
 	cvbs_vdac_out: endpoint {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 3e5e895..f6da4f0 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -307,6 +307,11 @@
 	};
 };
 
+&cec_AO {
+	clocks = <&clkc_AO CLKID_AO_CEC_32K>;
+	clock-names = "core";
+};
+
 &clkc_AO {
 	compatible = "amlogic,meson-gxbb-aoclkc", "amlogic,meson-gx-aoclkc";
 };
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
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
index 72c5a9f..37d8c81 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
@@ -67,6 +67,13 @@
 	};
 };
 
+&cec_AO {
+	status = "okay";
+	pinctrl-0 = <&ao_cec_pins>;
+	pinctrl-names = "default";
+	hdmi-phandle = <&hdmi_tx>;
+};
+
 &hdmi_tx {
 	status = "okay";
 	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
index 890821d..d537d7c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
@@ -55,6 +55,13 @@
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
index 39bbe3a..d9aa259 100644
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
 &clkc_AO {
 	compatible = "amlogic,meson-gxl-aoclkc", "amlogic,meson-gx-aoclkc";
 };
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
