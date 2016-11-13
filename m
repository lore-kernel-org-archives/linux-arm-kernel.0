From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sun, 13 Nov 2016 22:32:31 +0100
Subject: [PATCH v2 10/13] ARM: dts: armada-375: Fixup internal-regs DT warning
In-Reply-To: <20161113213234.3368-1-gregory.clement@free-electrons.com>
References: <20161113213234.3368-1-gregory.clement@free-electrons.com>
Message-ID: <20161113213234.3368-11-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

internal-regs has a ranges property so the unit name should contain an
address.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-375.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index 4e510489a9b9..9e61351a58c2 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -165,7 +165,7 @@
 			status = "disabled";
 		};
 
-		internal-regs {
+		internal-regs at f0_01_0 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.10.2
