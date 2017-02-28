From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue, 28 Feb 2017 07:35:27 +0100
Subject: [PATCH v3 17/25] ARM64: dts: actions: s900-bubblegum-96: Add fake
 uart5 clock
In-Reply-To: <20170228063535.32069-1-afaerber@suse.de>
References: <20170228063535.32069-1-afaerber@suse.de>
Message-ID: <20170228063535.32069-18-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Give the serial driver a fixed-clock as input for baudrate 115200.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v2 -> v3: unchanged
 
 v2: new
 
 arch/arm64/boot/dts/actions/s900-bubblegum-96.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts b/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
index a0c3484..21ca80f 100644
--- a/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
+++ b/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
@@ -24,6 +24,12 @@
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
+
+	uart5_clk: uart5-clk {
+		compatible = "fixed-clock";
+		clock-frequency = <921600>;
+		#clock-cells = <0>;
+	};
 };
 
 &timer {
@@ -32,4 +38,5 @@
 
 &uart5 {
 	status = "okay";
+	clocks = <&uart5_clk>;
 };
-- 
2.10.2
