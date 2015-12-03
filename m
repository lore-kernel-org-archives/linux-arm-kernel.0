From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  3 Dec 2015 16:20:13 +0800
Subject: [PATCH 4/4] ARM: dts: sun9i: Add NMI controller device node
In-Reply-To: <1449130813-22400-1-git-send-email-wens@csie.org>
References: <1449130813-22400-1-git-send-email-wens@csie.org>
Message-ID: <1449130813-22400-5-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner A80 SoC has an NMI controller. NMI is an external
interrupt pin exclusely used with PMICs and other system critical
peripherals (such as RTC) in Allwinner's reference designs.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index dc666c69f6ab..e838f206f2a0 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -858,6 +858,14 @@
 			#reset-cells = <1>;
 		};
 
+		nmi_intc: interrupt-controller at 080015a0 {
+			compatible = "allwinner,sun9i-a80-nmi";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			reg = <0x080015a0 0xc>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		r_ir: ir at 08002000 {
 			compatible = "allwinner,sun5i-a13-ir";
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.6.2
