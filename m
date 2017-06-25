From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 25 Jun 2017 19:00:20 +0200
Subject: [PATCH 5/5] ARM: dts: mb86s71-f-cue: Add fake UART0 clock
In-Reply-To: <20170625170020.11791-1-afaerber@suse.de>
References: <20170625170020.11791-1-afaerber@suse.de>
Message-ID: <20170625170020.11791-6-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As long as the clk driver is not building, use a fixed-clock for the UART.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm/boot/dts/mb86s71-f-cue.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/mb86s71-f-cue.dts b/arch/arm/boot/dts/mb86s71-f-cue.dts
index 148d1aee11a6..726bf189e8e7 100644
--- a/arch/arm/boot/dts/mb86s71-f-cue.dts
+++ b/arch/arm/boot/dts/mb86s71-f-cue.dts
@@ -27,6 +27,12 @@
 		device_type = "memory";
 		reg = <0x80000000 0x80000000>;
 	};
+
+	uart0_clk: uart0-clk {
+		compatible = "fixed-clock";
+		clock-frequency = <7813000>;
+		#clock-cells = <0>;
+	};
 };
 
 &arch_timer {
@@ -35,4 +41,6 @@
 
 &uart0 {
 	status = "okay";
+	clocks = <&uart0_clk>;
+	clock-names = "apb_pclk";
 };
-- 
2.12.3
