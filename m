From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 12 Nov 2012 18:07:10 +0100
Subject: [PATCH 7/7] arm: mvebu: enable Ethernet controllers on Mirabox
 platform
In-Reply-To: <1352740030-12801-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1352740030-12801-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1352740030-12801-8-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Globalscale Mirabox platform has two Ethernet interfaces,
connected to the SoC with a RGMII interface.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-mirabox.dts |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/armada-370-mirabox.dts
index 9eef8dd..8554dbe 100644
--- a/arch/arm/boot/dts/armada-370-mirabox.dts
+++ b/arch/arm/boot/dts/armada-370-mirabox.dts
@@ -33,5 +33,26 @@
 			clock-frequency = <600000000>;
 			status = "okay";
 		};
+		mdio {
+			phy0: ethernet-phy at 0 {
+				reg = <0>;
+			};
+
+			phy1: ethernet-phy at 1 {
+				reg = <1>;
+			};
+		};
+		ethernet at d0070000 {
+			clock-frequency = <200000000>;
+			status = "okay";
+			phy = <&phy0>;
+			phy-mode = "rgmii-id";
+		};
+		ethernet at d0074000 {
+			clock-frequency = <200000000>;
+			status = "okay";
+			phy = <&phy1>;
+			phy-mode = "rgmii-id";
+		};
 	};
 };
-- 
1.7.9.5
