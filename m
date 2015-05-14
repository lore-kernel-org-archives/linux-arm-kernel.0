From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 14 May 2015 11:22:34 +0200
Subject: [PATCH] ARM: ux500: add SCU and WD to device tree
Message-ID: <1431595354-2101-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Ux500 like other Cortex-A9 SoC's has a Snoop Control
Unit (SCU) and a Watchdog in the same address range as
the local timers. Add these to the SoC device tree.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: if it looks OK, please apply this directly to
the DT branch with other ux500 DT changes, this is needed
for cleanups when we want to remap the SCU from the DT.
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index 5b876f263af4..f024a1c0de8b 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -185,6 +185,11 @@
 			      <0xa0410100 0x100>;
 		};
 
+		scu at a04100000 {
+			compatible = "arm,cortex-a9-scu";
+			reg = <0xa0410000 0x100>;
+		};
+
 		L2: l2-cache {
 			compatible = "arm,pl310-cache";
 			reg = <0xa0412000 0x1000>;
@@ -245,6 +250,13 @@
 			clocks = <&smp_twd_clk>;
 		};
 
+		watchdog at a0410620 {
+			compatible = "arm,cortex-a9-twd-wdt";
+			reg = <0xa0410620 0x20>;
+			interrupts = <1 14 0x304>;
+			clocks = <&smp_twd_clk>;
+		};
+
 		rtc at 80154000 {
 			compatible = "arm,rtc-pl031", "arm,primecell";
 			reg = <0x80154000 0x1000>;
-- 
1.9.3
