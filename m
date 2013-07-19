From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 19 Jul 2013 10:40:23 -0300
Subject: [PATCH] ARM: dts: imx6qdl-sabresd: Allow buttons to wake-up the system
Message-ID: <1374241223-27975-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

This is useful for testing suspend/resume sequence.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 166b9ae..ac24ed1 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -41,12 +41,14 @@
 		volume-up {
 			label = "Volume Up";
 			gpios = <&gpio1 4 0>;
+			gpio-key,wakeup;
 			linux,code = <115>; /* KEY_VOLUMEUP */
 		};
 
 		volume-down {
 			label = "Volume Down";
 			gpios = <&gpio1 5 0>;
+			gpio-key,wakeup;
 			linux,code = <114>; /* KEY_VOLUMEDOWN */
 		};
 	};
-- 
1.8.1.2
