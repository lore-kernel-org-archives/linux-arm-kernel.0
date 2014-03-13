From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 13 Mar 2014 17:24:31 -0300
Subject: [PATCH v3 4/6] ARM: mvebu: Add support for NAND controller in Armada
 38x SoC
In-Reply-To: <1394742273-5113-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1394742273-5113-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1394742273-5113-5-git-send-email-ezequiel.garcia@free-electrons.com>
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
index 0ba4b48..a064f59 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -345,6 +345,16 @@
 				clocks = <&mainpll>;
 				clock-output-names = "nand";
 			};
+
+			flash at d0000 {
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
