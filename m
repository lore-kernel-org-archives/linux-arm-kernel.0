From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 21 Jul 2014 13:48:16 -0300
Subject: [PATCH 6/6] ARM: mvebu: Add missing MDIO clock in Armada 375
In-Reply-To: <1405961296-5846-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1405961296-5846-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1405961296-5846-7-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In Armada 375 SoCs, the MDIO is handled by a separate orion-mdio driver,
despite the register is contained within the "LMS" block of the network
controller.

Therefore we need to add the clock to the MDIO devicetree to prevent the
controller from being accesed with its clock gated. This is needed, for
instance, to be able to load the MDIO driver before the network driver.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-375.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index bfcbe58..c1e49e7 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -158,6 +158,7 @@
 				#size-cells = <0>;
 				compatible = "marvell,orion-mdio";
 				reg = <0xc0054 0x4>;
+				clocks = <&gateclk 19>;
 			};
 
 			/* Network controller */
-- 
2.0.1
