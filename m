From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu,  8 Jun 2017 17:31:20 +0200
Subject: [PATCH 1/4] ARM64: dts: meson-gxbb-wetek-play2: Add HDMI and CVBS
 Nodes
In-Reply-To: <1496935883-4966-1-git-send-email-narmstrong@baylibre.com>
References: <1496935883-4966-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1496935883-4966-2-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add HDMI and CVBS nodes for the Wetek Play2 board.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-gxbb-wetek-play2.dts    | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts
index 743acb5..e76ac31 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts
@@ -85,6 +85,34 @@
 			gpios = <&gpio_ao GPIOAO_3 GPIO_ACTIVE_LOW>;
 		};
 	};
+
+	cvbs-connector {
+		compatible = "composite-video-connector";
+
+		port {
+			cvbs_connector_in: endpoint {
+				remote-endpoint = <&cvbs_vdac_out>;
+			};
+		};
+	};
+
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&hdmi_tx_tmds_out>;
+			};
+		};
+	};
+};
+
+
+&cvbs_vdac_port {
+	cvbs_vdac_out: endpoint {
+		remote-endpoint = <&cvbs_connector_in>;
+	};
 };
 
 &ethmac {
@@ -113,6 +141,18 @@
 	};
 };
 
+&hdmi_tx {
+	status = "okay";
+	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
+	pinctrl-names = "default";
+};
+
+&hdmi_tx_tmds_port {
+	hdmi_tx_tmds_out: endpoint {
+		remote-endpoint = <&hdmi_connector_in>;
+	};
+};
+
 &i2c_A {
 	status = "okay";
 	pinctrl-0 = <&i2c_a_pins>;
-- 
1.9.1
