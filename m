From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Mon,  8 Apr 2013 14:57:33 +0200
Subject: [PATCH 3/3] ARM: mx28: add auart4 2 pins pinmux to imx28.dtsi
In-Reply-To: <1365425853-12457-1-git-send-email-eric@eukrea.com>
References: <1365425853-12457-1-git-send-email-eric@eukrea.com>
Message-ID: <1365425853-12457-3-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add auart4 2 pins configuration on SSP3 pads

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/boot/dts/imx28.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 5c45f29..25f2243 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -354,6 +354,17 @@
 					fsl,pull-up = <0>;
 				};
 
+				auart4_2pins_a: auart4 at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x2181 /* MX28_PAD_SSP3_SCK__AUART4_TX */
+						0x2191 /* MX28_PAD_SSP3_MOSI__AUART4_RX */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
 				mac0_pins_a: mac0 at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
-- 
1.7.11.7
