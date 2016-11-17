From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 18 Nov 2016 00:08:25 +0100
Subject: [PATCH v3 08/13] ARM: dts: armada-375: Fixup pinctrl DT warnings
In-Reply-To: <20161117230830.31047-1-gregory.clement@free-electrons.com>
References: <20161117230830.31047-1-gregory.clement@free-electrons.com>
Message-ID: <20161117230830.31047-9-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pinctrl has a ranges property, so the unit name should contain an
address.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-375.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index 3afdc4c31032..f213b6786e10 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -316,7 +316,7 @@
 				status = "disabled";
 			};
 
-			pinctrl: pinctrl {
+			pinctrl: pinctrl at 18000 {
 				compatible = "marvell,mv88f6720-pinctrl";
 				reg = <0x18000 0x24>;
 
-- 
2.10.2
