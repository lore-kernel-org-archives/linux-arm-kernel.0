From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 20 Aug 2014 09:24:16 +0900
Subject: [PATCH 7/8] ARM: shmobile: r7s72100: Add MTU2 device to DT
In-Reply-To: <cover.1408492048.git.horms+renesas@verge.net.au>
References: <cover.1408492048.git.horms+renesas@verge.net.au>
Message-ID: <9162d39ccb9400bfaed85630cf517c85861faa6f.1408492048.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Add the MTU2 counter to the r7s72100 device tree and make it disabled by
default.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
[horms+renesas at verge.net.au correct irq number]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r7s72100.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index bdee225..1d28d01 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -229,6 +229,16 @@
 		status = "disabled";
 	};
 
+	mtu2: timer at fcff0000 {
+		compatible = "renesas,mtu2";
+		reg = <0xfcff0000 0x400>;
+		interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "tgi0a";
+		clocks = <&mstp3_clks R7S72100_CLK_MTU2>;
+		clock-names = "fck";
+		status = "disabled";
+	};
+
 	scif0: serial at e8007000 {
 		compatible = "renesas,scif-r7s72100", "renesas,scif";
 		reg = <0xe8007000 64>;
-- 
2.0.1
