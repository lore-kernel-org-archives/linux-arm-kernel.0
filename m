From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 27 Jul 2015 11:48:09 +0200
Subject: [PATCH 1/7] ARM64: zynqmp: Use zynqmp specific compatible string for
 gpio
Message-ID: <48a75b64b05dc094e34fe27e5d03552dbfe77fe2.1437990464.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch:
"gpio: Added support to Zynq Ultrascale+ MPSoC"
(sha1: bdf7a4ae371894b4dc10b5820006b0a82d484929)
added zynqmp specific features. This patch is switching the driver to
use the zynqmp compatible string.
Also enable the driver for ep108 platform.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts | 4 ++++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi      | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
index 02b5d76c33f7..82deb24dddeb 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
@@ -42,6 +42,10 @@
 	};
 };
 
+&gpio {
+	status = "okay";
+};
+
 &sata0 {
 	status = "okay";
 	ceva,broken-gen2;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index e7545edf6179..bd9ba0cab504 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -163,7 +163,7 @@
 		};
 
 		gpio: gpio at ff0a0000 {
-			compatible = "xlnx,zynq-gpio-1.0";
+			compatible = "xlnx,zynqmp-gpio-1.0";
 			status = "disabled";
 			#gpio-cells = <0x2>;
 			clocks = <&misc_clk>;
-- 
2.3.5
