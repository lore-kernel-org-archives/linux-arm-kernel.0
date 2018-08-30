From: kurt@linutronix.de (Kurt Kanzenbach)
Date: Thu, 30 Aug 2018 11:00:38 +0200
Subject: [PATCH] arm64: dts: ls208xa: add second duart
Message-ID: <20180830090038.6956-1-kurt@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NXP LS208xA SoCs have two dual uarts. Thus, add the second one.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 8cb78dd99672..547a86ec7cd2 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -22,6 +22,8 @@
 		crypto = &crypto;
 		serial0 = &serial0;
 		serial1 = &serial1;
+		serial2 = &serial2;
+		serial3 = &serial3;
 	};
 
 	cpu: cpus {
@@ -221,6 +223,20 @@
 			interrupts = <0 32 0x4>; /* Level high type */
 		};
 
+		serial2: serial at 21d0500 {
+			compatible = "fsl,ns16550", "ns16550a";
+			reg = <0x0 0x21d0500 0x0 0x100>;
+			clocks = <&clockgen 4 3>;
+			interrupts = <0 33 0x4>; /* Level high type */
+		};
+
+		serial3: serial at 21d0600 {
+			compatible = "fsl,ns16550", "ns16550a";
+			reg = <0x0 0x21d0600 0x0 0x100>;
+			clocks = <&clockgen 4 3>;
+			interrupts = <0 33 0x4>; /* Level high type */
+		};
+
 		cluster1_core0_watchdog: wdt at c000000 {
 			compatible = "arm,sp805-wdt", "arm,primecell";
 			reg = <0x0 0xc000000 0x0 0x1000>;
-- 
2.11.0
