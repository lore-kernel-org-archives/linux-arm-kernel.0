From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 16 Nov 2015 18:56:35 +0800
Subject: [PATCH v2 PART-RESEND 2/2] ARM: dts: berlin: add 2nd clock for BG2Q
 sdhci0 and sdhci1
In-Reply-To: <1447671395-8023-1-git-send-email-jszhang@marvell.com>
References: <1447671395-8023-1-git-send-email-jszhang@marvell.com>
Message-ID: <1447671395-8023-3-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the optional 2nd clock for BG2Q's sdhci0 and sdhci1. This would let the
clock be disabled during runtime pm, so saves power a bit.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm/boot/dts/berlin2q.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index 145dd33..3920310 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -118,7 +118,8 @@
 		sdhci0: sdhci at ab0000 {
 			compatible = "mrvl,pxav3-mmc";
 			reg = <0xab0000 0x200>;
-			clocks = <&chip_clk CLKID_SDIO1XIN>;
+			clocks = <&chip_clk CLKID_SDIO1XIN>, <&chip_clk CLKID_SDIO>;
+			clock-names = "io", "core";
 			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
@@ -126,7 +127,8 @@
 		sdhci1: sdhci at ab0800 {
 			compatible = "mrvl,pxav3-mmc";
 			reg = <0xab0800 0x200>;
-			clocks = <&chip_clk CLKID_SDIO1XIN>;
+			clocks = <&chip_clk CLKID_SDIO1XIN>, <&chip_clk CLKID_SDIO>;
+			clock-names = "io", "core";
 			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
-- 
2.6.2
