From: michal.simek@xilinx.com (Michal Simek)
Date: Thu,  3 Aug 2017 13:36:50 +0200
Subject: [PATCH 4/5] arm64: zynqmp: Enable can1 for ep108
In-Reply-To: <cover.1501760202.git.michal.simek@xilinx.com>
References: <cover.1501760202.git.michal.simek@xilinx.com>
Message-ID: <c881a97250d2c691d2e0414228b59d520e05e1a8.1501760202.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>

This patch enables can1 for ep108.

Signed-off-by: Naga Sureshkumar Relli <nagasure@xilinx.com>
Reviewed-by: Kedareswara rao Appana <appanad@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi | 4 ++++
 arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts      | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi
index 31d25327cfb9..b87b8316f4ac 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi
@@ -47,6 +47,10 @@
 	clocks = <&misc_clk &misc_clk>;
 };
 
+&can1 {
+	clocks = <&misc_clk &misc_clk>;
+};
+
 &fpd_dma_chan1 {
 	clocks = <&clk600>, <&clk100>;
 };
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
index fba8f049769b..6a8b4b445531 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
@@ -37,6 +37,10 @@
 	status = "okay";
 };
 
+&can1 {
+	status = "okay";
+};
+
 &gem0 {
 	status = "okay";
 	phy-handle = <&phy0>;
-- 
1.9.1
