From: tony@atomide.com (Tony Lindgren)
Date: Thu,  3 Dec 2015 17:25:32 -0800
Subject: [PATCH 4/7] ARM: dts: Add mmc device entries for dm814x
In-Reply-To: <1449192335-10137-1-git-send-email-tony@atomide.com>
References: <1449192335-10137-1-git-send-email-tony@atomide.com>
Message-ID: <1449192335-10137-5-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add mmc device entries for dm814x.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dm814x.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/dm814x.dtsi b/arch/arm/boot/dts/dm814x.dtsi
index 9d81980e..18a8f0d 100644
--- a/arch/arm/boot/dts/dm814x.dtsi
+++ b/arch/arm/boot/dts/dm814x.dtsi
@@ -183,6 +183,28 @@
 				ti,hwmods = "timer3";
 			};
 
+			mmc1: mmc at 60000 {
+				compatible = "ti,omap4-hsmmc";
+				ti,hwmods = "mmc1";
+				dmas = <&edma 24 0
+					&edma 25 0>;
+				dma-names = "tx", "rx";
+				interrupts = <64>;
+				interrupt-parent = <&intc>;
+				reg = <0x60000 0x1000>;
+			};
+
+			mmc2: mmc at 1d8000 {
+				compatible = "ti,omap4-hsmmc";
+				ti,hwmods = "mmc2";
+				dmas = <&edma 2 0
+					&edma 3 0>;
+				dma-names = "tx", "rx";
+				interrupts = <28>;
+				interrupt-parent = <&intc>;
+				reg = <0x1d8000 0x1000>;
+			};
+
 			control: control at 140000 {
 				compatible = "ti,dm814-scm", "simple-bus";
 				reg = <0x140000 0x20000>;
@@ -279,6 +301,15 @@
 			reg = <0x48200000 0x1000>;
 		};
 
+		/* Board must configure evtmux with edma_xbar for EDMA */
+		mmc3: mmc at 47810000 {
+			compatible = "ti,omap4-hsmmc";
+			ti,hwmods = "mmc3";
+			interrupts = <29>;
+			interrupt-parent = <&intc>;
+			reg = <0x47810000 0x1000>;
+		};
+
 		edma: edma at 49000000 {
 			compatible = "ti,edma3-tpcc";
 			ti,hwmods = "tpcc";
-- 
2.6.2
