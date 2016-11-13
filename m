From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sun, 13 Nov 2016 22:32:29 +0100
Subject: [PATCH v2 08/13] ARM: dts: armada-375: Fixup pinctrl DT warnings
In-Reply-To: <20161113213234.3368-1-gregory.clement@free-electrons.com>
References: <20161113213234.3368-1-gregory.clement@free-electrons.com>
Message-ID: <20161113213234.3368-9-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pinctrl has a ranges property, so the unit name should contain an
address.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-375.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index 4824a4c1883c..aedd74ee6f6b 100644
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
2.10.2
