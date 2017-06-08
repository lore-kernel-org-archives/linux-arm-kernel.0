From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu,  8 Jun 2017 17:31:23 +0200
Subject: [PATCH 4/4] ARM64: dts: meson-gxl-s905x-p212: Add HDMI and CVBS nodes
In-Reply-To: <1496935883-4966-1-git-send-email-narmstrong@baylibre.com>
References: <1496935883-4966-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1496935883-4966-5-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add HDMI and CVBS nodes for the Amlogic P212 reference board.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-gxl-s905x-p212.dts      | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
index db31e09..6ab17c1 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
@@ -58,6 +58,17 @@
 			};
 		};
 	};
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
 };
 
 &cvbs_vdac_port {
@@ -66,6 +77,18 @@
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
 /* This UART is brought out to the DB9 connector */
 &uart_AO {
 	status = "okay";
-- 
1.9.1
