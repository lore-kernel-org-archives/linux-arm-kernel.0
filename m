From: yibin.gong@nxp.com (Robin Gong)
Date: Mon, 25 Jun 2018 20:34:11 +0800
Subject: [PATCH v1] ARM: dts: imx6sl-evk: keep sw4 always on
Message-ID: <1529930051-14122-1-git-send-email-yibin.gong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SW4 is one power rail for LPDDR2 on i.mx6sl-evk, so it should
be kept always on. But it's disabled after switch disabled
interface implemented in pfuze driver
'commit 5fe156f1cab4
("regulator: pfuze100: add enable/disable for switch")'.Thus,
it breaks kernel bootup. Add 'regulator-always-on' for SW4.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 arch/arm/boot/dts/imx6sl-evk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-evk.dts
index 37e792f..798df66 100644
--- a/arch/arm/boot/dts/imx6sl-evk.dts
+++ b/arch/arm/boot/dts/imx6sl-evk.dts
@@ -199,6 +199,7 @@
 			sw4_reg: sw4 {
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
 			};
 
 			swbst_reg: swbst {
-- 
2.7.4
