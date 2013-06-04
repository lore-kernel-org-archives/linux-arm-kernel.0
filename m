From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Tue,  4 Jun 2013 11:12:27 +0200
Subject: [PATCH 1/4] ARM i.MX53: tqma53: Fix interrupt polarity for the mc34708
In-Reply-To: <1370337150-18487-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1370337150-18487-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1370337150-18487-2-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

It's active high, not active low.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx53-tqma53.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53-tqma53.dtsi b/arch/arm/boot/dts/imx53-tqma53.dtsi
index 38bed3e..3b2eb7d 100644
--- a/arch/arm/boot/dts/imx53-tqma53.dtsi
+++ b/arch/arm/boot/dts/imx53-tqma53.dtsi
@@ -149,7 +149,7 @@
 		reg = <0x8>;
 		fsl,mc13xxx-uses-rtc;
 		interrupt-parent = <&gpio2>;
-		interrupts = <6 8>; /* PDATA_DATA6, low active */
+		interrupts = <6 4>; /* PATA_DATA6, active high */
 	};
 
 	sensor1: lm75 at 48 {
-- 
1.8.2.rc2
