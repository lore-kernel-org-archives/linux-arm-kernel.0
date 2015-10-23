From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Fri, 23 Oct 2015 09:25:31 -0700
Subject: [PATCH 2/3] ARM: zynq: DT: Add interrupt-controller property to GPIO
In-Reply-To: <1445617532-10228-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1445617532-10228-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1445617532-10228-2-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPIO can be used as interrupt-controller. Add the missing properties to
the GPIO node.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 arch/arm/boot/dts/zynq-7000.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index 1a5220e05109..fe1a5d0cf03b 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -101,6 +101,8 @@
 			#gpio-cells = <2>;
 			clocks = <&clkc 42>;
 			gpio-controller;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 			interrupt-parent = <&intc>;
 			interrupts = <0 20 4>;
 			reg = <0xe000a000 0x1000>;
-- 
2.6.2.3.ga463a5b
