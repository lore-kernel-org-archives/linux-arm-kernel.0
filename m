From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Fri, 16 Oct 2015 15:42:29 -0700
Subject: [PATCHv2 2/3] ARM: zynq: dt: Updated devicetree for Zynq 7000
 platform.
In-Reply-To: <1445035350-3569-1-git-send-email-moritz.fischer@ettus.com>
References: <1445035350-3569-1-git-send-email-moritz.fischer@ettus.com>
Message-ID: <1445035350-3569-3-git-send-email-moritz.fischer@ettus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added addtional nodes required for FPGA Manager operation
of the Xilinx Zynq Devc configuration interface.

Reviewed-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>
Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
---

v2: No changes

---
 arch/arm/boot/dts/zynq-7000.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index dc0457e..1a5220e 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -294,6 +294,11 @@
 		devcfg: devcfg at f8007000 {
 			compatible = "xlnx,zynq-devcfg-1.0";
 			reg = <0xf8007000 0x100>;
+			interrupt-parent = <&intc>;
+			interrupts = <0 8 4>;
+			clocks = <&clkc 12>;
+			clock-names = "ref_clk";
+			syscon = <&slcr>;
 		};
 
 		global_timer: timer at f8f00200 {
-- 
2.4.3
