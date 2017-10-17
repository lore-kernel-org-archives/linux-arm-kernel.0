From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue, 17 Oct 2017 10:53:26 +0200
Subject: [PATCH 04/12] ARM: dts: imx6-tx6: add trickle-charge config for DS1339
In-Reply-To: <1508230414-8090-1-git-send-email-LW@KARO-electronics.de>
References: <1508230414-8090-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1508230414-8090-5-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the DS1339 driver now supports enabling the trickle charge feature
via DTB, add the appropriate properties to utilize this feature.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx6qdl-tx6.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-tx6.dtsi b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
index c6bec97..a50bf71 100644
--- a/arch/arm/boot/dts/imx6qdl-tx6.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
@@ -284,6 +284,8 @@
 	ds1339: rtc at 68 {
 		compatible = "dallas,ds1339";
 		reg = <0x68>;
+		trickle-resistor-ohms = <250>;
+		trickle-diode-disable;
 	};
 };
 
-- 
2.1.4
