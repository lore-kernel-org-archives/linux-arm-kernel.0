From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu,  8 Jun 2017 17:31:22 +0200
Subject: [PATCH 3/4] ARM64: dts: meson-gxl-s905x-khadas-vim: Add HDMI nodes
In-Reply-To: <1496935883-4966-1-git-send-email-narmstrong@baylibre.com>
References: <1496935883-4966-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1496935883-4966-4-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add HDMI nodes for the Khadas Vim board.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../dts/amlogic/meson-gxl-s905x-khadas-vim.dts     | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
index 6a81f01..72c5a9f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
@@ -54,6 +54,29 @@
 			linux,default-trigger = "default-on";
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
+};
+
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
 };
 
 &i2c_A {
-- 
1.9.1
