From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Fri, 20 Jan 2017 14:26:48 +0100
Subject: [PATCH v2 7/9] ARM64: dts: meson-gxbb-p20x: remove the ethernet node
In-Reply-To: <20170120132650.9784-1-martin.blumenstingl@googlemail.com>
References: <20161202234739.22929-1-martin.blumenstingl@googlemail.com>
 <20170120132650.9784-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170120132650.9784-8-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This efficively disables ethernet on the meson-gxbb-p200 board.

Amlogic's own .dts specifies that the P200 board uses a RMII PHY,
however our own P200 board .dts does not override the PHY-mode (meaning
that it takes the default from meson-gx, which is RGMII mode).
This prevents people from thinking that ethernet is actually supported
on the P200 boards. People with access to such a board can simply
provide a patch which re-enables the ethmac node and adds the required
properties.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
index 4a96e0f6f926..17ebe46e48d4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
@@ -144,12 +144,6 @@
 	pinctrl-names = "default";
 };
 
-&ethmac {
-	status = "okay";
-	pinctrl-0 = <&eth_rgmii_pins>;
-	pinctrl-names = "default";
-};
-
 &ir {
 	status = "okay";
 	pinctrl-0 = <&remote_input_ao_pins>;
-- 
2.11.0
