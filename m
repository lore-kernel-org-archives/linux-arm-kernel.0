From: wens@csie.org (Chen-Yu Tsai)
Date: Sat,  7 Dec 2013 01:29:38 +0800
Subject: [PATCH 05/10] ARM: dts: sun7i: Add GMAC controller node to sun7i DTSI
In-Reply-To: <1386350983-13281-1-git-send-email-wens@csie.org>
References: <1386350983-13281-1-git-send-email-wens@csie.org>
Message-ID: <1386350983-13281-6-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index e46cfed..ebb2cce 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -395,6 +395,20 @@
 			status = "disabled";
 		};
 
+		gmac: ethernet at 01c50000 {
+			compatible = "allwinner,sun7i-gmac", "snps,dwmac";
+			reg = <0x01c50000 0x10000>,
+			      <0x01c20164 0x4>;
+			interrupts = <0 85 1>;
+			interrupt-names = "macirq";
+			clocks = <&ahb_gates 49>;
+			clock-names = "stmmaceth";
+			snps,pbl = <2>;
+			snps,fixed-burst;
+			snps,force_sf_dma_mode;
+			status = "disabled";
+		};
+
 		gic: interrupt-controller at 01c81000 {
 			compatible = "arm,cortex-a7-gic", "arm,cortex-a15-gic";
 			reg = <0x01c81000 0x1000>,
-- 
1.8.5.1
