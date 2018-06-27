From: Anson.Huang@nxp.com (Anson Huang)
Date: Wed, 27 Jun 2018 09:25:25 +0800
Subject: [PATCH V3] ARM: dts: imx6sll-evk: make pfuze100 sw4 always on
Message-ID: <1530062725-25779-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On i.MX6SLL EVK board, PFuze100's SW4 is supplying
LPDDR3, it needs to be always on. This patch fixes
Linux kernel boot up hang caused by commit 5fe156f1cab4
("regulator: pfuze100: add enable/disable for switch"),
because SW4 is turned off unexpectedly:

[    1.693613] cfg80211: failed to load regulatory.db
[    1.700063] SW4: disabling
[    1.703973] SWBST: disabling

Fixes: 5fe156f1cab4 ("regulator: pfuze100: add enable/disable for switch")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
---
changes since V2:
	improve the way of referencing commit, and add fix tag.
 arch/arm/boot/dts/imx6sll-evk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6sll-evk.dts b/arch/arm/boot/dts/imx6sll-evk.dts
index 4684ac4..2217c40 100644
--- a/arch/arm/boot/dts/imx6sll-evk.dts
+++ b/arch/arm/boot/dts/imx6sll-evk.dts
@@ -142,6 +142,7 @@
 			sw4_reg: sw4 {
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
 			};
 
 			swbst_reg: swbst {
-- 
2.7.4
