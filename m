From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 17 Jan 2017 13:05:38 +0100
Subject: [PATCH 2/2] ARM64: dts: meson-gx: Add HDMI HPD/DDC pinctrl nodes
In-Reply-To: <1484654738-5496-1-git-send-email-narmstrong@baylibre.com>
References: <1484654738-5496-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1484654738-5496-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinctrl nodes for HDMI HPD and DDC pins modes for Amlogic Meson GXL
and GXBB SoCs.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 14 ++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 14 ++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 596240c..31d64a1 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -463,6 +463,20 @@
 				function = "pwm_f_y";
 			};
 		};
+
+		hdmi_hpd_pins: hdmi_hpd {
+			mux {
+				groups = "hdmi_hpd";
+				function = "hdmi_hpd";
+			};
+		};
+
+		hdmi_i2c_pins: hdmi_i2c {
+			mux {
+				groups = "hdmi_sda", "hdmi_scl";
+				function = "hdmi_i2c";
+			};
+		};
 	};
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 6921624..17dbcf6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -229,6 +229,20 @@
 				function = "pwm_e";
 			};
 		};
+
+		hdmi_hpd_pins: hdmi_hpd {
+			mux {
+				groups = "hdmi_hpd";
+				function = "hdmi_hpd";
+			};
+		};
+
+		hdmi_i2c_pins: hdmi_i2c {
+			mux {
+				groups = "hdmi_sda", "hdmi_scl";
+				function = "hdmi_i2c";
+			};
+		};
 	};
 
 	eth-phy-mux {
-- 
1.9.1
