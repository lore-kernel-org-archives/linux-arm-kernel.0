From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Mon,  8 Apr 2013 14:57:32 +0200
Subject: [PATCH 2/3] ARM: mx28: add auart3 2 pins pinmux to imx28.dtsi
In-Reply-To: <1365425853-12457-1-git-send-email-eric@eukrea.com>
References: <1365425853-12457-1-git-send-email-eric@eukrea.com>
Message-ID: <1365425853-12457-2-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add auart3 2 pins configuration on its main pads

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/boot/dts/imx28.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 13799cf..5c45f29 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -343,6 +343,17 @@
 					fsl,pull-up = <0>;
 				};
 
+				auart3_2pins_b: auart3-2pins at 1 {
+					reg = <1>;
+					fsl,pinmux-ids = <
+						0x30c0 /* MX28_PAD_AUART3_RX__AUART3_RX */
+						0x30d0 /* MX28_PAD_AUART3_TX__AUART3_TX */
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
