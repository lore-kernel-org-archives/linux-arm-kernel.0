From: xander.huff@ni.com (Xander Huff)
Date: Thu, 7 May 2015 17:32:20 -0500
Subject: [PATCH 1/6] ARM: Zynq: DT: Disable xadc node by default in
 zynq-7000.dtsi
Message-ID: <1431037945-40360-1-git-send-email-xander.huff@ni.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the de-facto practice.

Signed-off-by: Xander Huff <xander.huff@ni.com>
Reviewed-by: Ben Shelton <ben.shelton@ni.com>
Reviewed-by: Josh Cartwright <joshc@ni.com>
Reviewed-by: Joe Hershberger <joe.hershberger@ni.com>
---
 arch/arm/boot/dts/zynq-7000.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index a5cd2ed..7640bdc 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -66,6 +66,7 @@
 
 		adc: adc at f8007100 {
 			compatible = "xlnx,zynq-xadc-1.00.a";
+			status = "disabled";
 			reg = <0xf8007100 0x20>;
 			interrupts = <0 7 4>;
 			interrupt-parent = <&intc>;
-- 
1.9.1
