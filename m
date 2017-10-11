From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Wed, 11 Oct 2017 13:07:38 +0200
Subject: [PATCH 4/7] ARM: dts: imx53-tx53: add trickle-charge config for DS1339
In-Reply-To: <1507720061-27666-1-git-send-email-LW@KARO-electronics.de>
References: <1507720061-27666-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1507720061-27666-5-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the DS1339 driver now supports enabling the trickle charge feature
via DTB, add the appropriate properties to utilize this feature.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx53-tx53.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx53-tx53.dtsi b/arch/arm/boot/dts/imx53-tx53.dtsi
index a3e7cf9..72971da8 100644
--- a/arch/arm/boot/dts/imx53-tx53.dtsi
+++ b/arch/arm/boot/dts/imx53-tx53.dtsi
@@ -245,6 +245,8 @@
 		pinctrl-0 = <&pinctrl_ds1339>;
 		interrupt-parent = <&gpio4>;
 		interrupts = <20 0>;
+		trickle-resistor-ohms = <250>;
+		trickle-diode-disable;
 	};
 };
 
-- 
2.1.4
