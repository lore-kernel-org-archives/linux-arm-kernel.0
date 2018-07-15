From: sravanhome@gmail.com (Saravanan Sekar)
Date: Sun, 15 Jul 2018 14:31:45 +0200
Subject: [PATCH v4 5/5] arm64: dts: actions: Set UART clock reference from CMU
In-Reply-To: <20180715123145.16975-1-sravanhome@gmail.com>
References: <20180715123145.16975-1-sravanhome@gmail.com>
Message-ID: <20180715123145.16975-6-sravanhome@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 arch/arm64/boot/dts/actions/s700-cubieboard7.dts | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
index ef79d7905f44..388a5d8bb48d 100644
--- a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
+++ b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
@@ -28,12 +28,6 @@
 		device_type = "memory";
 		reg = <0x1 0xe0000000 0x0 0x0>;
 	};
-
-	uart3_clk: uart3-clk {
-		compatible = "fixed-clock";
-		clock-frequency = <921600>;
-		#clock-cells = <0>;
-	};
 };
 
 &timer {
@@ -42,5 +36,5 @@
 
 &uart3 {
 	status = "okay";
-	clocks = <&uart3_clk>;
+	clocks = <&clock CLK_UART3>;
 };
-- 
2.18.0
