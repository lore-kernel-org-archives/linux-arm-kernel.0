From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sat,  5 Jul 2014 08:54:48 -0300
Subject: [PATCH v2 3/3] ARM: mvebu: Enable the network controller in Armada
 375 DB board
In-Reply-To: <1404561288-11720-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1404561288-11720-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1404561288-11720-4-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit enables the network controller in the Armada 375 DB board,
and configures the two available ethernet interfaces.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-375-db.dts | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/armada-375-db.dts b/arch/arm/boot/dts/armada-375-db.dts
index 1e2919d..43ac381 100644
--- a/arch/arm/boot/dts/armada-375-db.dts
+++ b/arch/arm/boot/dts/armada-375-db.dts
@@ -123,6 +123,32 @@
 				cd-gpios = <&gpio1 12 GPIO_ACTIVE_HIGH>;
 				wp-gpios = <&gpio1 13 GPIO_ACTIVE_HIGH>;
 			};
+
+			mdio {
+				phy0: ethernet-phy at 0 {
+					reg = <0>;
+				};
+
+				phy3: ethernet-phy at 3 {
+					reg = <3>;
+				};
+			};
+
+			pp2 at f0000 {
+				status = "okay";
+
+				ethernet at c4000 {
+					status = "okay";
+					phy = <&phy0>;
+					phy-mode = "rgmii-id";
+				};
+
+				ethernet at c5000 {
+					status = "okay";
+					phy = <&phy3>;
+					phy-mode = "gmii";
+				};
+			};
 		};
 
 		pcie-controller {
-- 
1.9.1
