From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon,  3 Sep 2012 12:05:49 +0200
Subject: [PATCHv2 3/3] dts: mxs: spi: Add SSP3 to the 10049 board
In-Reply-To: <1346666749-6094-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1346666749-6094-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1346666749-6094-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/imx28-cfa10049.dts |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts b/arch/arm/boot/dts/imx28-cfa10049.dts
index c73b9b8..a0c7b83 100644
--- a/arch/arm/boot/dts/imx28-cfa10049.dts
+++ b/arch/arm/boot/dts/imx28-cfa10049.dts
@@ -16,6 +16,15 @@
 	compatible = "crystalfontz,cfa10049", "crystalfontz,cfa10036", "fsl,imx28";
 
 	apb at 80000000 {
+		apbh at 80000000 {
+			ssp3: ssp at 80016000 {
+				compatible = "fsl,imx28-spi";
+				pinctrl-names = "default";
+				pinctrl-0 = <&spi3_pins_b>;
+				status = "okay";
+			};
+		};
+
 		apbx at 80040000 {
 			i2c1: i2c at 8005a000 {
 				pinctrl-names = "default";
-- 
1.7.9.5
