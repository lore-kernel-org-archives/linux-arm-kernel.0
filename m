From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed,  5 Oct 2016 16:44:33 +0200
Subject: [PATCH] ARM64: dts: meson-gxbb: Add rmii pinctrl node and rename
 rgmii node
Message-ID: <1475678673-15277-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For boards only supporting 10/100 ethernet over a RMII PHY link, add
a separate pinctrl node. By the way, rename the existing node to rgmii
specific naming in all boards dts.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts  |  2 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi     |  2 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi |  2 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi          | 17 ++++++++++++++++-
 4 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index e6e3491..325b9c5 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -83,7 +83,7 @@
 
 &ethmac {
 	status = "okay";
-	pinctrl-0 = <&eth_pins>;
+	pinctrl-0 = <&eth_rgmii_pins>;
 	pinctrl-names = "default";
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
index 06a34dc..031d69b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
@@ -81,7 +81,7 @@
 
 &ethmac {
 	status = "okay";
-	pinctrl-0 = <&eth_pins>;
+	pinctrl-0 = <&eth_rgmii_pins>;
 	pinctrl-names = "default";
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
index 73f1593..e93221a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
@@ -82,7 +82,7 @@
 
 &ethmac {
 	status = "okay";
-	pinctrl-0 = <&eth_pins>;
+	pinctrl-0 = <&eth_rgmii_pins>;
 	pinctrl-names = "default";
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 443811b..aad639a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -443,7 +443,7 @@
 			};
 		};
 
-		eth_pins: eth_c {
+		eth_rgmii_pins: eth-rgmii {
 			mux {
 				groups = "eth_mdio",
 				       "eth_mdc",
@@ -463,6 +463,21 @@
 			};
 		};
 
+		eth_rmii_pins: eth-rmii {
+			mux {
+				groups = "eth_mdio",
+				       "eth_mdc",
+				       "eth_clk_rx_clk",
+				       "eth_rx_dv",
+				       "eth_rxd0",
+				       "eth_rxd1",
+				       "eth_tx_en",
+				       "eth_txd0",
+				       "eth_txd1";
+				function = "eth";
+			};
+		};
+
 		pwm_a_x_pins: pwm_a_x {
 			mux {
 				groups = "pwm_a_x";
-- 
1.9.1
