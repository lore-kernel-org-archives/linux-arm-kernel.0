From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 12 Mar 2014 12:16:42 -0300
Subject: [PATCH 4/6] ARM: mvebu: Add support for NAND controller in Armada 38x
 SoC
In-Reply-To: <1394637404-7651-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1394637404-7651-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1394637404-7651-5-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 38x SoC family has a NAND controller, compatible
with the controller in Armada 370/375/XP SoCs. Add support for
it in the devicetree file.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-38x.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 76cc27e..18d8f80 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -345,6 +345,16 @@
 				clocks = <&mainpll>;
 				clock-output-names = "nand";
 			};
+
+			nand at d0000 {
+				compatible = "marvell,armada370-nand";
+				reg = <0xd0000 0x54>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&coredivclk 0>;
+				status = "disabled";
+			};
 		};
 	};
 
-- 
1.9.0
