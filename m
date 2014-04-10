From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 10 Apr 2014 19:06:05 +0900
Subject: [PATCH 15/27] ARM: dts: exynos3250: Add uart dt node to support seiral
 ports
In-Reply-To: <1397122658-16013-1-git-send-email-cw00.choi@samsung.com>
References: <1397122658-16013-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1397124377-16969-7-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add UART dt node for Exynos3250. Exynos3250 uses same UART IP
of Exynos4 SoC and has only two independent channels.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
[Fix incorrect clock id by Tomasz Figa]
Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos3250.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 758913e..d17ed54 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -74,4 +74,22 @@
 		reg = <0x11400000 0x1000>;
 		interrupts = <0 240 0>;
 	};
+
+	serial at 13800000 {
+		compatible = "samsung,exynos4210-uart";
+		reg = <0x13800000 0x100>;
+		interrupts = <0 109 0>;
+		clocks = <&cmu CLK_UART0>, <&cmu CLK_SCLK_UART0>;
+		clock-names = "uart", "clk_uart_baud0";
+		status = "disabled";
+	};
+
+	serial at 13810000 {
+		compatible = "samsung,exynos4210-uart";
+		reg = <0x13810000 0x100>;
+		interrupts = <0 110 0>;
+		clocks = <&cmu CLK_UART1>, <&cmu CLK_SCLK_UART1>;
+		clock-names = "uart", "clk_uart_baud0";
+		status = "disabled";
+	};
 };
-- 
1.8.0
