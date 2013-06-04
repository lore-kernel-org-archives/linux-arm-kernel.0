From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Tue,  4 Jun 2013 13:07:12 +0200
Subject: [PATCH 5/8] ARM i.MX53: mba53: add missing gpio stuff for pca9554
In-Reply-To: <1370344035-7417-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1370344035-7417-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1370344035-7417-6-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Niebel <Markus.Niebel@tqs.de>

Add properties to make use of pca9554 gpio expander.

Signed-off-by: Markus Niebel <Markus.Niebel@tqs.de>
Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/imx53-mba53.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx53-mba53.dts b/arch/arm/boot/dts/imx53-mba53.dts
index b171c00..67f5655 100644
--- a/arch/arm/boot/dts/imx53-mba53.dts
+++ b/arch/arm/boot/dts/imx53-mba53.dts
@@ -163,6 +163,8 @@
 		compatible = "pca9554";
 		reg = <0x20>;
 		interrupts = <109>;
+		#gpio-cells = <2>;
+		gpio-controller;
 	};
 
 	sensor2: lm75 at 49 {
-- 
1.8.2.rc2
