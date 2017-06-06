From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue,  6 Jun 2017 02:54:16 +0200
Subject: [PATCH v4 18/28] ARM: dts: s500-guitar-bb-rev-b: Add fake uart3 clock
In-Reply-To: <20170606005426.26446-1-afaerber@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
Message-ID: <20170606005426.26446-19-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a fixed-clock for baudrate 115200.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v2 -> v3 -> v4: unchanged
 
 v2: new
 
 arch/arm/boot/dts/s500-guitar-bb-rev-b.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/s500-guitar-bb-rev-b.dts b/arch/arm/boot/dts/s500-guitar-bb-rev-b.dts
index 834b71df31bd..f6fd10a9cd34 100644
--- a/arch/arm/boot/dts/s500-guitar-bb-rev-b.dts
+++ b/arch/arm/boot/dts/s500-guitar-bb-rev-b.dts
@@ -19,8 +19,15 @@
 	chosen {
 		stdout-path = "serial3:115200n8";
 	};
+
+	uart3_clk: uart3-clk {
+		compatible = "fixed-clock";
+		clock-frequency = <921600>;
+		#clock-cells = <0>;
+	};
 };
 
 &uart3 {
 	status = "okay";
+	clocks = <&uart3_clk>;
 };
-- 
2.12.3
