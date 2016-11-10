From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 10 Nov 2016 01:09:49 +0100
Subject: [PATCH 03/14] ARM: dts: armada-375: Fixup mdio DT warning
In-Reply-To: <20161110001000.10619-1-gregory.clement@free-electrons.com>
References: <20161110001000.10619-1-gregory.clement@free-electrons.com>
Message-ID: <20161110001000.10619-4-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MDIO has a reg property so the unit name should contain an address.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-375.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index e016ff3ed970..97b663d83fb6 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -203,7 +203,7 @@
 				      <0xc100 0x100>;
 			};
 
-			mdio: mdio {
+			mdio: mdio at c0054 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				compatible = "marvell,orion-mdio";
-- 
2.10.1
