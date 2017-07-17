From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 17 Jul 2017 22:25:00 +0200
Subject: [PATCH 1/5] ARM: dts: imx6: RDU2: Add Micrel PHY to FEC
In-Reply-To: <1500323104-11583-1-git-send-email-andrew@lunn.ch>
References: <1500323104-11583-1-git-send-email-andrew@lunn.ch>
Message-ID: <1500323104-11583-2-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The FEC has a Micrel PHY connected to it. This PHY is managed using
the bit-banging MDIO bus. Add this to the device tree.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
index 5d94b5ee6aa0..d7328e9166e9 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -59,6 +59,10 @@
 		pinctrl-0 = <&pinctrl_mdio1>;
 		gpios = <&gpio6 5 GPIO_ACTIVE_HIGH
 		         &gpio6 4 GPIO_ACTIVE_HIGH>;
+
+		phy: ethernet-phy at 0 {
+			reg = <0>;
+		};
 	};
 
 	reg_28p0v: regulator-28p0v {
@@ -615,15 +619,11 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rmii";
+	phy-handle = <&phy>;
 	phy-reset-gpios = <&gpio1 23 GPIO_ACTIVE_LOW>;
 	phy-reset-duration = <100>;
 	phy-supply = <&reg_3p3v>;
 	status = "okay";
-
-	fixed-link {
-		speed = <100>;
-		full-duplex;
-	};
 };
 
 &usbh1 {
-- 
2.13.2
