From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 10 Apr 2014 19:06:12 +0900
Subject: [PATCH 22/27] ARM: dts: exynos3250: Add amba and pdma dt node
In-Reply-To: <1397122658-16013-1-git-send-email-cw00.choi@samsung.com>
References: <1397122658-16013-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1397124377-16969-14-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tomasz Figa <t.figa@samsung.com>

This patch add amba and pdma dt node to support bus on Exynos3250.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos3250.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 2f0ca32..b8e5ae13 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -148,6 +148,36 @@
 		status = "disabled";
 	};
 
+	amba {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "arm,amba-bus";
+		interrupt-parent = <&gic>;
+		ranges;
+
+		pdma0: pdma at 12680000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x12680000 0x1000>;
+			interrupts = <0 138 0>;
+			clocks = <&cmu CLK_PDMA0>;
+			clock-names = "apb_pclk";
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
+		};
+
+		pdma1: pdma at 12690000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x12690000 0x1000>;
+			interrupts = <0 139 0>;
+			clocks = <&cmu CLK_PDMA1>;
+			clock-names = "apb_pclk";
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
+		};
+	};
+
 	adc: adc at 126C0000 {
 		compatible = "samsung,exynos-adc-v2";
 		reg = <0x126C0000 0x100>, <0x10020718 0x4>;
-- 
1.8.0
