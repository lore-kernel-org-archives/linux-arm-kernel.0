From: yixun.lan@amlogic.com (Yixun Lan)
Date: Sat, 16 Dec 2017 11:55:27 +0800
Subject: [PATCH v4 2/2] ARM64: dts: meson-axg: enable ethernet for A113D S400
 board
In-Reply-To: <20171216035527.96952-1-yixun.lan@amlogic.com>
References: <20171216035527.96952-1-yixun.lan@amlogic.com>
Message-ID: <20171216035527.96952-3-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is tested in the S400 dev board which use a RTL8211F PHY,
and the pins connect to the 'eth_rgmii_y_pins' group.

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index 70eca1f8736a..8932654f5090 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -17,6 +17,13 @@
 	};
 };
 
+&ethmac {
+	status = "okay";
+	phy-mode = "rgmii";
+	pinctrl-0 = <&eth_rgmii_y_pins>;
+	pinctrl-names = "default";
+};
+
 &uart_AO {
 	status = "okay";
 };
-- 
2.15.1
