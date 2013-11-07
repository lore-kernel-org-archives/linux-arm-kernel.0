From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu,  7 Nov 2013 12:17:33 -0300
Subject: [PATCH v4 29/31] ARM: mvebu: Add support for NAND controller in
 Armada 370/XP
In-Reply-To: <1383837455-30721-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1383837455-30721-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1383837455-30721-30-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 370 and Armada XP SoC have a NAND controller (aka NFCv2).
This commit adds support for it in Armada 370 and Armada XP SoC
common devicetree.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 01e69fc..b4e6898 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -258,6 +258,15 @@
 				status = "disabled";
 			};
 
+			nand at d0000 {
+				compatible = "marvell,armada370-nand";
+				reg = <0xd0000 0x54>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				interrupts = <113>;
+				clocks = <&coredivclk 0>;
+				status = "disabled";
+			};
 		};
 	};
 
-- 
1.8.1.5
