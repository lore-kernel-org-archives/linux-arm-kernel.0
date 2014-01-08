From: fkan@apm.com (Feng Kan)
Date: Wed,  8 Jan 2014 14:56:11 -0800
Subject: [PATCH] arm64: dts: optimize serial port dts entry for X-Gene
 platform.
Message-ID: <1389221771-29057-1-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Optimize the serial port dts entry by select correct representation
that enables deeper fifo. Fix clk input frequency to be consistent
with bootloader fixup.

Signed-off-by: Feng Kan <fkan@apm.com>
---
 arch/arm64/boot/dts/apm-storm.dtsi |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
index 78d29781..a8d43ea 100644
--- a/arch/arm64/boot/dts/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm-storm.dtsi
@@ -180,10 +180,10 @@
 
 		serial0: serial at 1c020000 {
 			device_type = "serial";
-			compatible = "ns16550";
+			compatible = "ns16550a";
 			reg = <0 0x1c020000 0x0 0x1000>;
 			reg-shift = <2>;
-			clock-frequency = <10000000>; /* Updated by bootloader */
+			clock-frequency = <50000000>; /* Updated by bootloader */
 			interrupt-parent = <&gic>;
 			interrupts = <0x0 0x4c 0x4>;
 		};
-- 
1.7.6.1
