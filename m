From: eddie.huang@mediatek.com (Eddie Huang)
Date: Thu, 18 Jun 2015 13:29:11 +0800
Subject: [PATCH] arm64: dts: mt8173: add clock_null
Message-ID: <1434605351-64592-1-git-send-email-eddie.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clk_null, which represents clocks that can not / need not
controlled by software.
There are many clocks' parent set to clk_null.

Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
---
Base on 4.1-rc1

Change-Id: I4db9b40d07e28f54f7bae9b676316cbd6a962124
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 924fdb6..4798f44 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -81,6 +81,12 @@
 		cpu_on	      = <0x84000003>;
 	};
 
+	clk_null: clk_null {
+		compatible = "fixed-clock";
+		clock-frequency = <0>;
+		#clock-cells = <0>;
+	};
+
 	uart_clk: dummy26m {
 		compatible = "fixed-clock";
 		clock-frequency = <26000000>;
-- 
1.8.1.1.dirty
