From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Fri, 24 Feb 2017 04:40:55 +0100
Subject: [PATCH v2 17/17] ARM: dts: s500-guitar-bb-rev-b: Add fake uart3 clock
In-Reply-To: <20170224034055.18807-1-afaerber@suse.de>
References: <20170224034055.18807-1-afaerber@suse.de>
Message-ID: <20170224034055.18807-18-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a fixed-clock for baudrate 115200.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v2: new
 
 arch/arm/boot/dts/s500-guitar-bb-rev-b.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/s500-guitar-bb-rev-b.dts b/arch/arm/boot/dts/s500-guitar-bb-rev-b.dts
index 834b71d..f6fd10a 100644
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
2.10.2
