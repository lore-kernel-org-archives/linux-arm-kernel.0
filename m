From: maxime.chevallier@bootlin.com (Maxime Chevallier)
Date: Wed, 25 Apr 2018 13:07:31 +0200
Subject: [PATCH net 3/3] ARM64: dts: marvell: armada-cp110: Add clocks for the
 xmdio node
In-Reply-To: <20180425110731.20153-1-maxime.chevallier@bootlin.com>
References: <20180425110731.20153-1-maxime.chevallier@bootlin.com>
Message-ID: <20180425110731.20153-4-maxime.chevallier@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell XSMI controller needs 3 clocks to operate correctly :
 - The MG clock (clk 5)
 - The MG Core clock (clk 6)
 - The GOP clock (clk 18)

 This commit adds them, to avoid system hangs when using these
 interfaces.

Fixes: c7e92def1ef4 ("clk: mvebu: cp110: Fix clock tree representation")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
index 6c137ac656e9..ed2f1237ea1e 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
@@ -142,6 +142,8 @@
 			#size-cells = <0>;
 			compatible = "marvell,xmdio";
 			reg = <0x12a600 0x10>;
+			clocks = <&CP110_LABEL(clk) 1 5>,
+				 <&CP110_LABEL(clk) 1 6>, <&CP110_LABEL(clk) 1 18>;
 			status = "disabled";
 		};
 
-- 
2.11.0
