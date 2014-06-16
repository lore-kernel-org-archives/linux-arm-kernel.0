From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Mon, 16 Jun 2014 17:07:27 +0200
Subject: [PATCH v4 15/19] ARM: shmobile: r7s72100: Add MTU2 device to DT
In-Reply-To: <1402931251-22581-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1402931251-22581-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1402931251-22581-16-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the MTU2 counter to the r7s72100 device tree and make it disabled by
default.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r7s72100.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index bdee225..c902b0b 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -229,6 +229,16 @@
 		status = "disabled";
 	};
 
+	mtu2: timer at fcff0000 {
+		compatible = "renesas,mtu2";
+		reg = <0xfcff0000 0x400>;
+		interrupts = <0 139 IRQ_TYPE_LEVEL_HIGH>;
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
1.8.5.5
