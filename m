From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Tue, 19 Jun 2018 14:44:02 +0200
Subject: [PATCH 3/3] arm64: dts: marvell: armada-37xx: add the node allowing
 AVS support
In-Reply-To: <20180619124402.902-1-gregory.clement@bootlin.com>
References: <20180619124402.902-1-gregory.clement@bootlin.com>
Message-ID: <20180619124402.902-4-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to be able to use Adaptive Voltage Scaling, we need to add a
reference to these registers.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 3353252d78a0..15eb9e5e4370 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -98,6 +98,12 @@
 				status = "disabled";
 			};
 
+			avs: avs at 11500 {
+				compatible = "marvell,armada-3700-avs",
+					     "syscon";
+				reg = <0x11500 0x40>;
+			};
+
 			uart0: serial at 12000 {
 				compatible = "marvell,armada-3700-uart";
 				reg = <0x12000 0x200>;
-- 
2.17.1
