From: Anson.Huang@nxp.com (Anson Huang)
Date: Tue, 15 May 2018 17:18:15 +0800
Subject: [PATCH] ARM: dts: imx7s-warp: remove unnecessary cpu regulator supply
Message-ID: <1526375895-23633-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX7S does NOT support CPU frequency scaling, so no
need to specify the CPU regulator supply.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx7s-warp.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx7s-warp.dts b/arch/arm/boot/dts/imx7s-warp.dts
index 8a30b14..fa390da 100644
--- a/arch/arm/boot/dts/imx7s-warp.dts
+++ b/arch/arm/boot/dts/imx7s-warp.dts
@@ -113,10 +113,6 @@
 	assigned-clock-rates = <884736000>;
 };
 
-&cpu0 {
-	arm-supply = <&sw1a_reg>;
-};
-
 &i2c1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c1>;
-- 
2.7.4
