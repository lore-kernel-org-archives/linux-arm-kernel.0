From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 18 Nov 2016 00:08:27 +0100
Subject: [PATCH v3 10/13] ARM: dts: armada-375: Fixup internal-regs DT warning
In-Reply-To: <20161117230830.31047-1-gregory.clement@free-electrons.com>
References: <20161117230830.31047-1-gregory.clement@free-electrons.com>
Message-ID: <20161117230830.31047-11-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

internal-regs has a ranges property so the unit name should contain an
address.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-375.dtsi | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index 120dd7ac40cb..04333ba3f180 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -178,7 +178,11 @@
 			status = "disabled";
 		};
 
-		internal-regs {
+		/* The following unit address is composed of the target
+		 * value (bit [40-47]), attributes value (bits [32-39],
+		 * and the address value in the window memory: [0-31].
+		 */
+		internal-regs at f00100000000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.10.2
