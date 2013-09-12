From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Thu, 12 Sep 2013 09:50:40 -0700
Subject: [PATCH 2/2] arm: zynq: Enable arm_global_timer
In-Reply-To: <1379004640-15117-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1379004640-15117-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1379004640-15117-3-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Zynq is based on an ARM Cortex-A9 MPCore, which features the
arm_global_timer in its SCU. Therefore enable the timer for Zynq.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 arch/arm/boot/dts/zynq-7000.dtsi | 8 ++++++++
 arch/arm/mach-zynq/Kconfig       | 1 +
 2 files changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index e32b92b..eaacb39 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -92,6 +92,14 @@
 			};
 		};
 
+		global_timer: global_timer at f8f00200 {
+			compatible = "arm,cortex-a9-global-timer";
+			reg = <0xf8f00200 0x20>;
+			interrupts = <1 11 0x301>;
+			interrupt-parent = <&intc>;
+			clocks = <&clkc 4>;
+		};
+
 		ttc0: ttc0 at f8001000 {
 			interrupt-parent = <&intc>;
 			interrupts = < 0 10 4 0 11 4 0 12 4 >;
diff --git a/arch/arm/mach-zynq/Kconfig b/arch/arm/mach-zynq/Kconfig
index 04f8a4a..6b04260 100644
--- a/arch/arm/mach-zynq/Kconfig
+++ b/arch/arm/mach-zynq/Kconfig
@@ -13,5 +13,6 @@ config ARCH_ZYNQ
 	select HAVE_SMP
 	select SPARSE_IRQ
 	select CADENCE_TTC_TIMER
+	select ARM_GLOBAL_TIMER
 	help
 	  Support for Xilinx Zynq ARM Cortex A9 Platform
-- 
1.8.4
