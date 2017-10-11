From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Wed, 11 Oct 2017 13:05:39 +0200
Subject: [PATCH 4/4] ARM: dts: imx28-tx28: add trickle-charge config for DS1339
In-Reply-To: <1507719939-27250-1-git-send-email-LW@KARO-electronics.de>
References: <1507719939-27250-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1507719939-27250-5-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the DS1339 driver now supports enabling the trickle charge feature
via DTB, add the appropriate properties to utilize this feature.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx28-tx28.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx28-tx28.dts b/arch/arm/boot/dts/imx28-tx28.dts
index 3c852f7..4684d2f 100644
--- a/arch/arm/boot/dts/imx28-tx28.dts
+++ b/arch/arm/boot/dts/imx28-tx28.dts
@@ -358,6 +358,8 @@
 	ds1339: rtc at 68 {
 		compatible = "mxim,ds1339";
 		reg = <0x68>;
+		trickle-resistor-ohms = <250>;
+		trickle-diode-disable;
 	};
 };
 
-- 
2.1.4
