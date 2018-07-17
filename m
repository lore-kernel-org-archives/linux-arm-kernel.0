From: Anson.Huang@nxp.com (Anson Huang)
Date: Tue, 17 Jul 2018 13:12:05 +0800
Subject: [PATCH 4/4] ARM: dts: imx6sl-evk: make pfuze100 sw4 always on
In-Reply-To: <1531804325-3476-1-git-send-email-Anson.Huang@nxp.com>
References: <1531804325-3476-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1531804325-3476-4-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robin Gong <yibin.gong@nxp.com>

On i.MX6SL EVK board, pfuze100 sw4 supplies
LPDDR2 which is critical for system, must be
always on.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sl-evk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-evk.dts
index 046cfab..679b448 100644
--- a/arch/arm/boot/dts/imx6sl-evk.dts
+++ b/arch/arm/boot/dts/imx6sl-evk.dts
@@ -201,6 +201,7 @@
 			sw4_reg: sw4 {
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
 			};
 
 			swbst_reg: swbst {
-- 
2.7.4
