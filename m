From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue,  6 Jun 2017 02:54:15 +0200
Subject: [PATCH v4 17/28] ARM64: dts: actions: s900-bubblegum-96: Add fake
 uart5 clock
In-Reply-To: <20170606005426.26446-1-afaerber@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
Message-ID: <20170606005426.26446-18-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Give the serial driver a fixed-clock as input for baudrate 115200.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v2 -> v3 -> v4: unchanged
 
 v2: new
 
 arch/arm64/boot/dts/actions/s900-bubblegum-96.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts b/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
index a0c3484dbd12..21ca80f9941c 100644
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
2.12.3
