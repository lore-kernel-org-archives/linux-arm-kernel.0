From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 17 Jul 2017 22:25:04 +0200
Subject: [PATCH 5/5] ARM: dts: imx6: RDU2: Add Micrel PHY interrupt
In-Reply-To: <1500323104-11583-1-git-send-email-andrew@lunn.ch>
References: <1500323104-11583-1-git-send-email-andrew@lunn.ch>
Message-ID: <1500323104-11583-6-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Micrel PHY has its interrupt pin connected to a GPIO line. Wire
this up in the device tree.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
index 83f311a51cca..eeb7679fd348 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -61,7 +61,11 @@
 		         &gpio6 4 GPIO_ACTIVE_HIGH>;
 
 		phy: ethernet-phy at 0 {
+			pinctrl-0 = <&pinctrl_rmii_phy_irq>;
+			pinctrl-names = "default";
 			reg = <0>;
+			interrupt-parent = <&gpio3>;
+			interrupts = <30 IRQ_TYPE_LEVEL_LOW>;
 		};
 	};
 
-- 
2.13.2
