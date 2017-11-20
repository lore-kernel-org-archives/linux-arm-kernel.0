From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 20 Nov 2017 15:19:57 +0100
Subject: [PATCH v2 4/4] ARM64: dts: odroid-c2: Add HDMI and CEC Nodes
In-Reply-To: <1511187597-18248-1-git-send-email-narmstrong@baylibre.com>
References: <1511187597-18248-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1511187597-18248-5-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now the VPU Power Domain has been fixed while boothing from Mainline U-Boot,
VPU and HDMI nodes can finally be added to the Odroid-C2 DTS.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index f8d2214..d6d3af5 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -135,6 +135,24 @@
 		compatible = "mmc-pwrseq-emmc";
 		reset-gpios = <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
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
+&cec_AO {
+	status = "okay";
+	pinctrl-0 = <&ao_cec_pins>;
+	pinctrl-names = "default";
+	hdmi-phandle = <&hdmi_tx>;
 };
 
 &ethmac {
@@ -179,6 +197,18 @@
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
2.7.4
