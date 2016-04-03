From: andrew@lunn.ch (Andrew Lunn)
Date: Sun,  3 Apr 2016 04:03:50 +0200
Subject: [PATCH 8/8] ARM: kirkwood: DT: Add address go regulator unit name
In-Reply-To: <1459649030-21886-1-git-send-email-andrew@lunn.ch>
References: <1459649030-21886-1-git-send-email-andrew@lunn.ch>
Message-ID: <1459649030-21886-9-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The regulator has a reg property so include it in the unit name.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts | 2 +-
 arch/arm/boot/dts/kirkwood-netgear_readynas_nv+_v2.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts b/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
index 8745484912d2..c0413b63cf2e 100644
--- a/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
+++ b/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
@@ -183,7 +183,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		usb3_regulator: usb3-regulator {
+		usb3_regulator: usb3-regulator at 1 {
 			compatible = "regulator-fixed";
 			reg = <1>;
 			regulator-name = "USB 3.0 Power";
diff --git a/arch/arm/boot/dts/kirkwood-netgear_readynas_nv+_v2.dts b/arch/arm/boot/dts/kirkwood-netgear_readynas_nv+_v2.dts
index a4e97f7f5804..2bfc6cfa151d 100644
--- a/arch/arm/boot/dts/kirkwood-netgear_readynas_nv+_v2.dts
+++ b/arch/arm/boot/dts/kirkwood-netgear_readynas_nv+_v2.dts
@@ -193,7 +193,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		usb3_regulator: usb3-regulator {
+		usb3_regulator: usb3-regulator at 1 {
 			compatible = "regulator-fixed";
 			reg = <1>;
 			regulator-name = "USB 3.0 Power";
-- 
2.7.0
