From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 13 Nov 2012 16:00:42 +0100
Subject: [PATCH v6 6/7] arm: mvebu: enable Ethernet controllers on OpenBlocks
 AX3-4 platform
In-Reply-To: <1352818843-4457-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1352818843-4457-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1352818843-4457-7-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PlatHome OpenBlocks AX3-4 platform has 4 Ethernet ports, connected
to a single quad-port PHY through SGMII.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts |   43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index cb86853..bb8d83c 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -65,5 +65,48 @@
 				linux,default-trigger = "heartbeat";
 			};
 		};
+
+		mdio {
+			phy0: ethernet-phy at 0 {
+				reg = <0>;
+			};
+
+			phy1: ethernet-phy at 1 {
+				reg = <1>;
+			};
+
+			phy2: ethernet-phy at 2 {
+				reg = <2>;
+			};
+
+			phy3: ethernet-phy at 3 {
+				reg = <3>;
+			};
+		};
+
+		ethernet at d0070000 {
+			clock-frequency = <250000000>;
+			status = "okay";
+			phy = <&phy0>;
+			phy-mode = "sgmii";
+		};
+		ethernet at d0074000 {
+			clock-frequency = <250000000>;
+			status = "okay";
+			phy = <&phy1>;
+			phy-mode = "sgmii";
+		};
+		ethernet at d0030000 {
+			clock-frequency = <250000000>;
+			status = "okay";
+			phy = <&phy2>;
+			phy-mode = "sgmii";
+		};
+		ethernet at d0034000 {
+			clock-frequency = <250000000>;
+			status = "okay";
+			phy = <&phy3>;
+			phy-mode = "sgmii";
+		};
 	};
 };
-- 
1.7.9.5
