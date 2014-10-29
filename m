From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 29 Oct 2014 18:25:11 -0200
Subject: [PATCH] ARM: dts: imx6sx-sdb: Allow wakeup from buttons
Message-ID: <1414614311-2199-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Allow the two button wakeup the system from low power mode.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6sx-sdb.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sdb.dts b/arch/arm/boot/dts/imx6sx-sdb.dts
index 448489b..80ae281 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dts
+++ b/arch/arm/boot/dts/imx6sx-sdb.dts
@@ -39,12 +39,14 @@
 		volume-up {
 			label = "Volume Up";
 			gpios = <&gpio1 18 GPIO_ACTIVE_LOW>;
+			gpio-key,wakeup;
 			linux,code = <KEY_VOLUMEUP>;
 		};
 
 		volume-down {
 			label = "Volume Down";
 			gpios = <&gpio1 19 GPIO_ACTIVE_LOW>;
+			gpio-key,wakeup;
 			linux,code = <KEY_VOLUMEDOWN>;
 		};
 	};
-- 
1.9.1
