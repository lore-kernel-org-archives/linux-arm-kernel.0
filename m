From: manish.narani@xilinx.com (Manish Narani)
Date: Wed, 4 Jan 2017 18:52:55 +0530
Subject: [RFC PATCH] arch: arm64: dts: add USB OTG interrupts support in
 ZynqMP device tree
Message-ID: <1483536181-22356-1-git-send-email-mnarani@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds OTG interrupt support in device tree. It will add
an extra interrupt line number dedicated to OTG events. This will
enable OTG interrupts to serve in DWC3 OTG driver.

Signed-off-by: Manish Narani <mnarani@xilinx.com>
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 68a90833..ce9ad02 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -351,7 +351,7 @@
 			compatible = "snps,dwc3";
 			status = "disabled";
 			interrupt-parent = <&gic>;
-			interrupts = <0 65 4>;
+			interrupts = <0 65 4>, <0 69 4>;
 			reg = <0x0 0xfe200000 0x0 0x40000>;
 			clock-names = "clk_xin", "clk_ahb";
 		};
-- 
2.1.1
