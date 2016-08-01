From: chenhui.zhao@nxp.com (Chenhui Zhao)
Date: Mon, 1 Aug 2016 17:49:02 +0800
Subject: [PATCH 1/2] ARM: dts: ls1043a: add a rcpm node
Message-ID: <1470044943-3814-1-git-send-email-chenhui.zhao@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

LS1043A have a RCPM module (Run Control and Power Management), which
performs all device-level tasks associated with power management.

Signed-off-by: Chenhui Zhao <chenhui.zhao@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index de0323b..43944b7 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -196,6 +196,12 @@
 			bus-width = <4>;
 		};
 
+		rcpm: rcpm at 1ee2000 {
+			compatible = "fsl,ls1043a-rcpm", "fsl,qoriq-rcpm-2.1";
+			reg = <0x0 0x1ee2000 0x0 0x1000>;
+			fsl,#rcpm-wakeup-cells = <1>;
+		};
+
 		dspi0: dspi at 2100000 {
 			compatible = "fsl,ls1043a-dspi", "fsl,ls1021a-v1.0-dspi";
 			#address-cells = <1>;
-- 
1.9.1
