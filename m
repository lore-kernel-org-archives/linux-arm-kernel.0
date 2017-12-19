From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 19 Dec 2017 22:31:55 +0100
Subject: [PATCH 31/45] ARM: dts: at91: sama5d3: TC blocks are also simple-mfd
 and syscon devices
In-Reply-To: <20171219213209.13823-1-alexandre.belloni@free-electrons.com>
References: <20171219213209.13823-1-alexandre.belloni@free-electrons.com>
Message-ID: <20171219213209.13823-32-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add simple-mfd and syscon to the TC blocks to allow to register one of the
channels as clocksource properly at boot time and free up the remaining
channels for other use.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/sama5d3.dtsi      | 4 +++-
 arch/arm/boot/dts/sama5d3_tcb1.dtsi | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 1889b4dea066..b9c05b57735e 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -142,7 +142,9 @@
 			};
 
 			tcb0: timer at f0010000 {
-				compatible = "atmel,at91sam9x5-tcb";
+				compatible = "atmel,at91sam9x5-tcb", "simple-mfd", "syscon";
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0xf0010000 0x100>;
 				interrupts = <26 IRQ_TYPE_LEVEL_HIGH 0>;
 				clocks = <&tcb0_clk>, <&clk32k>;
diff --git a/arch/arm/boot/dts/sama5d3_tcb1.dtsi b/arch/arm/boot/dts/sama5d3_tcb1.dtsi
index 801f9745e82f..cb30bdb1a9ca 100644
--- a/arch/arm/boot/dts/sama5d3_tcb1.dtsi
+++ b/arch/arm/boot/dts/sama5d3_tcb1.dtsi
@@ -28,7 +28,9 @@
 			};
 
 			tcb1: timer at f8014000 {
-				compatible = "atmel,at91sam9x5-tcb";
+				compatible = "atmel,at91sam9x5-tcb", "simple-mfd", "syscon";
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0xf8014000 0x100>;
 				interrupts = <27 IRQ_TYPE_LEVEL_HIGH 0>;
 				clocks = <&tcb1_clk>, <&clk32k>;
-- 
2.15.1
