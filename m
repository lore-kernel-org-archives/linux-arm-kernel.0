From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 26 Apr 2014 08:52:07 +0400
Subject: [PATCH 2/8] ARM: dts: imx27-phytec-phycore-som: Fix active level for
 FEC reset
In-Reply-To: <1398487933-5683-1-git-send-email-shc_work@mail.ru>
References: <1398487933-5683-1-git-send-email-shc_work@mail.ru>
Message-ID: <1398487933-5683-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

FEC reset GPIO is active low. Fix this typo.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
index 32cc7dac9a..93482e9 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
@@ -182,7 +182,7 @@
 
 &fec {
 	phy-mode = "mii";
-	phy-reset-gpios = <&gpio3 30 GPIO_ACTIVE_HIGH>;
+	phy-reset-gpios = <&gpio3 30 GPIO_ACTIVE_LOW>;
 	phy-supply = <&reg_3v3>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec1>;
-- 
1.8.3.2
