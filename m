From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 10 Nov 2016 01:09:55 +0100
Subject: [PATCH 09/14] ARM: dts: armada-375: Fixup pinctrl DT warnings
In-Reply-To: <20161110001000.10619-1-gregory.clement@free-electrons.com>
References: <20161110001000.10619-1-gregory.clement@free-electrons.com>
Message-ID: <20161110001000.10619-10-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pinctrl has a ranges property, so the unit name should contain an
address.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-375.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index a157b62e810e..84ef033aeeed 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -307,7 +307,7 @@
 				status = "disabled";
 			};
 
-			pinctrl: pinctrl {
+			pinctrl: pinctrl at 18000 {
 				compatible = "marvell,mv88f6720-pinctrl";
 				reg = <0x18000 0x24>;
 
-- 
2.10.1
