From: kaloz@openwrt.org (Imre Kaloz)
Date: Fri, 31 Jul 2015 20:42:00 +0200
Subject: [PATCH] ARM: mvebu: fix GPIO config on the Linksys boards
Message-ID: <1438368120-23860-1-git-send-email-kaloz@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some of the GPIO configs were wrong in the submitted DTS files,
this patch fixes all affected boards.

Signed-off-by: Imre Kaloz <kaloz@openwrt.org>

Cc: <stable@vger.kernel.org> # v4.1 +
---
 arch/arm/boot/dts/armada-385-linksys.dtsi     | 6 +++---
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/armada-385-linksys.dtsi b/arch/arm/boot/dts/armada-385-linksys.dtsi
index 74a9c6b..1b0075f 100644
--- a/arch/arm/boot/dts/armada-385-linksys.dtsi
+++ b/arch/arm/boot/dts/armada-385-linksys.dtsi
@@ -243,7 +243,7 @@
 		button at 2 {
 			label = "Factory Reset Button";
 			linux,code = <KEY_RESTART>;
-			gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio0 29 GPIO_ACTIVE_LOW>;
 		};
 	};
 
@@ -258,7 +258,7 @@
 		};
 
 		sata {
-			gpios = <&gpio1 22 GPIO_ACTIVE_HIGH>;
+			gpios = <&gpio1 22 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 		};
 	};
@@ -311,7 +311,7 @@
 
 &pinctrl {
 	keys_pin: keys-pin {
-		marvell,pins = "mpp24", "mpp47";
+		marvell,pins = "mpp24", "mpp29";
 		marvell,function = "gpio";
 	};
 
diff --git a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
index fdd187c..e767735 100644
--- a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
+++ b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
@@ -302,13 +302,13 @@
 		button at 1 {
 			label = "WPS";
 			linux,code = <KEY_WPS_BUTTON>;
-			gpios = <&gpio1 0 GPIO_ACTIVE_HIGH>;
+			gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
 		};
 
 		button at 2 {
 			label = "Factory Reset Button";
 			linux,code = <KEY_RESTART>;
-			gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
+			gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
 		};
 	};
 
-- 
2.1.0
