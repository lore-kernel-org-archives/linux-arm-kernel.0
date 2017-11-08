From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed,  8 Nov 2017 19:22:25 +0100
Subject: [PATCH] ARM: dts: imx6: RDU2: add alias for RTC
Message-ID: <20171108182225.18226-1-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes sure that the battery backed RTC is always the
primary one, regardless of the driver probe ordering.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
index ea9d3c1199e9..289224b863fa 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -49,6 +49,7 @@
 
 	aliases {
 		mdio-gpio0 = &mdio1;
+		rtc0 = &ds1341;
 	};
 
 	mdio1: mdio {
@@ -501,7 +502,7 @@
 		reg = <0x54>;
 	};
 
-	rtc at 68 {
+	ds1341: rtc at 68 {
 		compatible = "dallas,ds1341";
 		reg = <0x68>;
 	};
-- 
2.11.0
