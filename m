From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 28 Nov 2016 16:50:28 +0100
Subject: [PATCH net-next v4 4/4] ARM64: dts: meson: odroidc2: disable
 advertisement EEE for GbE.
In-Reply-To: <1480348229-25672-1-git-send-email-jbrunet@baylibre.com>
References: <1480348229-25672-1-git-send-email-jbrunet@baylibre.com>
Message-ID: <1480348229-25672-5-git-send-email-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Tested-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index e6e3491d48a5..2036582ca0d6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -46,6 +46,7 @@
 
 #include "meson-gxbb.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/net/mdio.h>
 
 / {
 	compatible = "hardkernel,odroid-c2", "amlogic,meson-gxbb";
@@ -85,6 +86,19 @@
 	status = "okay";
 	pinctrl-0 = <&eth_pins>;
 	pinctrl-names = "default";
+
+	phy-handle = <&eth_phy0>;
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		eth_phy0: ethernet-phy at 0 {
+			reg = <0>;
+			eee-broken-modes = <MDIO_EEE_1000T>;
+		};
+	};
 };
 
 &ir {
-- 
2.7.4
