From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 26 Sep 2013 11:33:32 +0800
Subject: [PATCH 3/3] ARM: dts: imx6qdl: add pcie device node
In-Reply-To: <1380166412-13586-1-git-send-email-shawn.guo@linaro.org>
References: <1380166412-13586-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1380166412-13586-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Cross <xobs@kosagi.com>

Add pcie device node for imx6qdl.

Signed-off-by: Sean Cross <xobs@kosagi.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx6qdl.dtsi |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index ef51342..59154dc 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -116,6 +116,22 @@
 			arm,data-latency = <4 2 3>;
 		};
 
+		pcie: pcie at 0x01000000 {
+			compatible = "fsl,imx6q-pcie", "snps,dw-pcie";
+			reg = <0x01ffc000 0x4000>; /* DBI */
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			ranges = <0x00000800 0 0x01f00000 0x01f00000 0 0x00080000 /* configuration space */
+				  0x81000000 0 0          0x01f80000 0 0x00010000 /* downstream I/O */
+				  0x82000000 0 0x01000000 0x01000000 0 0x00f00000>; /* non-prefetchable memory */
+			num-lanes = <1>;
+			interrupts = <0 123 0x04>;
+			clocks = <&clks 189>, <&clks 187>, <&clks 206>, <&clks 144>;
+			clock-names = "pcie_ref_125m", "sata_ref_100m", "lvds_gate", "pcie_axi";
+			status = "disabled";
+		};
+
 		pmu {
 			compatible = "arm,cortex-a9-pmu";
 			interrupts = <0 94 0x04>;
-- 
1.7.9.5
