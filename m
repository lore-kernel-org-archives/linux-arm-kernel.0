From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 19 Feb 2017 04:20:00 +0100
Subject: [PATCH 4/4] ARM64: dts: marvell: iap140-andromeda-box-edge: Add uart0
 clock
In-Reply-To: <20170219032000.4674-1-afaerber@suse.de>
References: <20170219032000.4674-1-afaerber@suse.de>
Message-ID: <20170219032000.4674-5-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use a fixed clock to enable ttyS0 output.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm64/boot/dts/marvell/iap140-andromeda-box-edge.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/iap140-andromeda-box-edge.dts b/arch/arm64/boot/dts/marvell/iap140-andromeda-box-edge.dts
index de01d93..dceab69 100644
--- a/arch/arm64/boot/dts/marvell/iap140-andromeda-box-edge.dts
+++ b/arch/arm64/boot/dts/marvell/iap140-andromeda-box-edge.dts
@@ -63,8 +63,15 @@
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x40000000>;
 	};
+
+	uart0_clk: uart0-clk {
+		compatible = "fixed-clock";
+		clock-frequency = <14740000>;
+		#clock-cells = <0>;
+	};
 };
 
 &uart0 {
 	status = "okay";
+	clocks = <&uart0_clk>;
 };
-- 
2.10.2
