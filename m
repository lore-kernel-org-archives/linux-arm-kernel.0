From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 14 Nov 2012 15:56:50 +0100
Subject: [PATCH v7 6/6] arm: mvebu: enable Ethernet controllers on OpenBlocks
 AX3-4 platform
In-Reply-To: <1352905010-24172-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1352905010-24172-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1352905010-24172-7-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PlatHome OpenBlocks AX3-4 platform has 4 Ethernet ports, connected
to a single quad-port PHY through SGMII.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts |   24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index cb86853..1a07e09 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -65,5 +65,29 @@
 				linux,default-trigger = "heartbeat";
 			};
 		};
+		ethernet at d0070000 {
+			clock-frequency = <250000000>;
+			status = "okay";
+			phy-mode = "sgmii";
+			phy-addr = <0>;
+		};
+		ethernet at d0074000 {
+			clock-frequency = <250000000>;
+			status = "okay";
+			phy-mode = "sgmii";
+			phy-addr = <1>;
+		};
+		ethernet at d0030000 {
+			clock-frequency = <250000000>;
+			status = "okay";
+			phy-mode = "sgmii";
+			phy-addr = <2>;
+		};
+		ethernet at d0034000 {
+			clock-frequency = <250000000>;
+			status = "okay";
+			phy-mode = "sgmii";
+			phy-addr = <3>;
+		};
 	};
 };
-- 
1.7.9.5
