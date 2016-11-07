From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon,  7 Nov 2016 22:41:26 +0100
Subject: [PATCH 1/3] arm64: dts: marvell: Fixup internal-regs DT warning for
 Armada 37xx
In-Reply-To: <20161107214128.18401-1-gregory.clement@free-electrons.com>
References: <20161107214128.18401-1-gregory.clement@free-electrons.com>
Message-ID: <20161107214128.18401-2-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

internal-regs has a ranges property so the unit name should contain an
address.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index c4762538ec01..f1596daa2bc7 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -91,7 +91,7 @@
 		#size-cells = <2>;
 		ranges;
 
-		internal-regs {
+		internal-regs at d0000000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "simple-bus";
-- 
2.10.1
