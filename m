From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 21 Nov 2016 16:35:24 +0100
Subject: [RFC PATCH net v2 3/3] ARM64: dts: meson: odroidc2: disable
 advertisement EEE for GbE.
In-Reply-To: <1479742524-30222-1-git-send-email-jbrunet@baylibre.com>
References: <1479742524-30222-1-git-send-email-jbrunet@baylibre.com>
Message-ID: <1479742524-30222-4-git-send-email-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index e6e3491d48a5..b34da077b2f8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -98,3 +98,18 @@
 	pinctrl-0 = <&i2c_a_pins>;
 	pinctrl-names = "default";
 };
+
+&ethmac {
+	phy-handle = <&eth_phy0>;
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		eth_phy0: ethernet-phy at 0 {
+			reg = <0>;
+			eee-advert-disable = <0x4>;
+		};
+	};
+};
-- 
2.7.4
