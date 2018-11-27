From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:51 +0100
Subject: [PATCH 50/77] ARM: dts: sun7i: lamobo-r1: Remove unused
 address-cells/size-cells
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <c0199b0484f2faafce367a0aa1240ca351e48f74.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The #address-cells and #size-cells are only relevant for nodes that have
childs with reg properties. Otherwise, DTC will emit a warning saying that
those properties are unnecessary.

Remove them when needed.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts b/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
index 6f8dfa717994..f91e1bee44e8 100644
--- a/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
+++ b/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
@@ -123,6 +123,8 @@
 	phy-mode = "rgmii";
 	phy-supply = <&reg_gmac_3v3>;
 	status = "okay";
+	/delete-property/#address-cells;
+	/delete-property/#size-cells;
 
 	fixed-link {
 		speed = <1000>;
@@ -137,8 +139,6 @@
 		switch: ethernet-switch at 1e {
 			compatible = "brcm,bcm53125";
 			reg = <30>;
-			#address-cells = <1>;
-			#size-cells = <0>;
 
 			ports {
 				#address-cells = <1>;
-- 
git-series 0.9.1
