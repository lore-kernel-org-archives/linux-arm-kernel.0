From: Anson.Huang@nxp.com (Anson Huang)
Date: Tue, 17 Jul 2018 13:12:03 +0800
Subject: [PATCH 2/4] ARM: dts: imx6sx-sdb-reva: make pfuze100 sw4 always on
In-Reply-To: <1531804325-3476-1-git-send-email-Anson.Huang@nxp.com>
References: <1531804325-3476-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1531804325-3476-2-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On i.MX6SX SDB Rev-A board, pfuze100 sw4 supplies
csi, audio codec and i2c etc., these modules do NOT
implement power domain control, so pfuze100 sw4
needs to be always on to make sure these modules
work normally.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sx-sdb-reva.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6sx-sdb-reva.dts b/arch/arm/boot/dts/imx6sx-sdb-reva.dts
index e3533e7..9cc6ff2 100644
--- a/arch/arm/boot/dts/imx6sx-sdb-reva.dts
+++ b/arch/arm/boot/dts/imx6sx-sdb-reva.dts
@@ -63,6 +63,7 @@
 			sw4_reg: sw4 {
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
 			};
 
 			swbst_reg: swbst {
-- 
2.7.4
