From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 14 Nov 2014 21:43:33 +0100
Subject: [PATCH v2] ARM: mvebu: fix ordering in Armada 370 .dtsi
In-Reply-To: <1415993776-3469-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1415993776-3469-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20141114204333.GS27002@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit a095b1c78a35 ("ARM: mvebu: sort DT nodes by address")
missed placing the system-controller in the correct order.                                                                                                               

Fixes: a095b1c78a35 ("ARM: mvebu: sort DT nodes by address")
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello Andrew,

I guess your question concerning overlapping ranges doesn't stop this
patch from being useful, does it?

Also thanks for the suggested wording which I nearly took as is.

Best regards
Uwe

 arch/arm/boot/dts/armada-370.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 6b3c23b1e138..7513410f7b89 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -106,11 +106,6 @@
 				reg = <0x11100 0x20>;
 			};
 
-			system-controller at 18200 {
-				compatible = "marvell,armada-370-xp-system-controller";
-				reg = <0x18200 0x100>;
-			};
-
 			pinctrl {
 				compatible = "marvell,mv88f6710-pinctrl";
 				reg = <0x18000 0x38>;
@@ -205,6 +200,11 @@
 				interrupts = <91>;
 			};
 
+			system-controller at 18200 {
+				compatible = "marvell,armada-370-xp-system-controller";
+				reg = <0x18200 0x100>;
+			};
+
 			gateclk: clock-gating-control at 18220 {
 				compatible = "marvell,armada-370-gating-clock";
 				reg = <0x18220 0x4>;
-- 
2.1.3

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
