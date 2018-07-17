From: Anson.Huang@nxp.com (Anson Huang)
Date: Tue, 17 Jul 2018 13:12:02 +0800
Subject: [PATCH 1/4] ARM: dts: imx6qdl-sabresd: make pfuze100 sw4 always on
Message-ID: <1531804325-3476-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On i.MX6QDL Sabre-SD board, pfuze100 sw4 supplies
GPS, touch and RGMII etc., these modules do NOT
implement power domain control, so pfuze100 sw4
needs to be always on to make sure these modules
work normally.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 15744ad..6e46a19 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -341,6 +341,7 @@
 			sw4_reg: sw4 {
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
 			};
 
 			swbst_reg: swbst {
-- 
2.7.4
