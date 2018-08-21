From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 21 Aug 2018 22:12:33 +0300
Subject: [PATCH] ARM: dts: clearfog: fix sdhci supply property name
Message-ID: <606cef37c2776bdc7dfa3ef578a18c40004e17af.1534878753.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vmmc phandle, like all power supply property names, must have the
'-supply' suffix.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/boot/dts/armada-388-clearfog.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-388-clearfog.dtsi b/arch/arm/boot/dts/armada-388-clearfog.dtsi
index 7c6ad2afb094..1b0d0680c8b6 100644
--- a/arch/arm/boot/dts/armada-388-clearfog.dtsi
+++ b/arch/arm/boot/dts/armada-388-clearfog.dtsi
@@ -48,7 +48,7 @@
 					     &clearfog_sdhci_cd_pins>;
 				pinctrl-names = "default";
 				status = "okay";
-				vmmc = <&reg_3p3v>;
+				vmmc-supply = <&reg_3p3v>;
 				wp-inverted;
 			};
 
-- 
2.18.0
