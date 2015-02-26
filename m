From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 26 Feb 2015 10:51:17 +0100
Subject: [PATCH] ARM: mvebu: Fix MPIC unit address
Message-ID: <1424944277-15745-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The unit-address is supposed to be equal the first reg address, which is not
the case for the MPIC, that uses the mbus-controller one. Fix this.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/armada-38x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 1dff30a81e24..885fcee6580c 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -368,7 +368,7 @@
 				reg = <0x20000 0x100>, <0x20180 0x20>;
 			};
 
-			mpic: interrupt-controller at 20000 {
+			mpic: interrupt-controller at 20a00 {
 				compatible = "marvell,mpic";
 				reg = <0x20a00 0x2d0>, <0x21070 0x58>;
 				#interrupt-cells = <1>;
-- 
2.3.0
