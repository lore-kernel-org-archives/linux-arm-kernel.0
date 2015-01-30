From: chenhui.zhao@freescale.com (Chenhui Zhao)
Date: Fri, 30 Jan 2015 20:22:19 +0800
Subject: [PATCH 2/4] arm: ls1021a: add dts nodes required by deep sleep
In-Reply-To: <1422620541-6843-1-git-send-email-chenhui.zhao@freescale.com>
References: <1422620541-6843-1-git-send-email-chenhui.zhao@freescale.com>
Message-ID: <1422620541-6843-2-git-send-email-chenhui.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add RCPM and DCSR nodes.

Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
---
 arch/arm/boot/dts/ls1021a-qds.dts |   6 +-
 arch/arm/boot/dts/ls1021a.dtsi    | 117 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 122 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ls1021a-qds.dts b/arch/arm/boot/dts/ls1021a-qds.dts
index 9c5e16b..6903f43 100644
--- a/arch/arm/boot/dts/ls1021a-qds.dts
+++ b/arch/arm/boot/dts/ls1021a-qds.dts
@@ -157,7 +157,7 @@
 	fpga: board-control at 3,0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "simple-bus";
+		compatible = "fsl,ls1021aqds-fpga", "simple-bus";
 		reg = <0x3 0x0 0x0000100>;
 		bank-width = <1>;
 		device-width = <1>;
@@ -238,3 +238,7 @@
 &uart1 {
 	status = "okay";
 };
+
+&rcpm {
+	fsl,deep-sleep;
+};
diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index c70bb27..0c51ce0 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -183,6 +183,11 @@
 			};
 		};
 
+		rcpm: rcpm at 1ee2000 {
+			compatible = "fsl,ls1021a-rcpm", "fsl,qoriq-rcpm-2.1";
+			reg = <0x0 0x1ee2000 0x0 0x10000>;
+		};
+
 		dspi0: dspi at 2100000 {
 			compatible = "fsl,vf610-dspi";
 			#address-cells = <1>;
@@ -406,4 +411,116 @@
 			dr_mode = "host";
 		};
 	};
+
+	dcsr {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "fsl,dcsr", "simple-bus";
+		ranges = <0x0 0x0 0x20000000 0x1000000>;
+
+		dcsr-epu at 0 {
+			compatible = "fsl,ls1021a-dcsr-epu";
+			reg = <0x0 0x10000>;
+		};
+
+		dcsr-gdi at 100000 {
+			compatible = "fsl,ls1021a-dcsr-gdi";
+			reg = <0x100000 0x10000>;
+		};
+
+		dcsr-dddi at 120000 {
+			compatible = "fsl,ls1021a-dcsr-dddi";
+			reg = <0x120000 0x10000>;
+		};
+
+		dcsr-dcfg at 220000 {
+			compatible = "fsl,ls1021a-dcsr-dcfg";
+			reg = <0x220000 0x1000>;
+		};
+
+		dcsr-clock at 221000 {
+			compatible = "fsl,ls1021a-dcsr-clock";
+			reg = <0x221000 0x1000>;
+		};
+
+		dcsr-rcpm at 222000 {
+			compatible = "fsl,ls1021a-dcsr-rcpm";
+			reg = <0x222000 0x1000 0x223000 0x1000>;
+		};
+
+		dcsr-ccp at 225000 {
+			compatible = "fsl,ls1021a-dcsr-ccp";
+			reg = <0x225000 0x1000>;
+		};
+
+		dcsr-fusectrl at 226000 {
+			compatible = "fsl,ls1021a-dcsr-fusectrl";
+			reg = <0x226000 0x1000>;
+		};
+
+		dcsr-dap at 300000 {
+			compatible = "fsl,ls1021a-dcsr-dap";
+			reg = <0x300000 0x10000>;
+		};
+
+		dcsr-cstf at 350000 {
+			compatible = "fsl,ls1021a-dcsr-cstf";
+			reg = <0x350000 0x1000 0x3a7000 0x1000>;
+		};
+
+		dcsr-a7rom at 360000 {
+			compatible = "fsl,ls1021a-dcsr-a7rom";
+			reg = <0x360000 0x10000>;
+		};
+
+		dcsr-a7cpu at 370000 {
+			compatible = "fsl,ls1021a-dcsr-a7cpu";
+			reg = <0x370000 0x8000>;
+		};
+
+		dcsr-a7cti at 378000 {
+			compatible = "fsl,ls1021a-dcsr-a7cti";
+			reg = <0x378000 0x4000>;
+		};
+
+		dcsr-etm at 37c000 {
+			compatible = "fsl,ls1021a-dcsr-etm";
+			reg = <0x37c000 0x1000 0x37d000 0x3000>;
+		};
+
+		dcsr-hugorom at 3a0000 {
+			compatible = "fsl,ls1021a-dcsr-hugorom";
+			reg = <0x3a0000 0x1000>;
+		};
+
+		dcsr-etf at 3a1000 {
+			compatible = "fsl,ls1021a-dcsr-etf";
+			reg = <0x3a1000 0x1000 0x3a2000 0x1000>;
+		};
+
+		dcsr-etr at 3a3000 {
+			compatible = "fsl,ls1021a-dcsr-etr";
+			reg = <0x3a3000 0x1000>;
+		};
+
+		dcsr-cti at 3a4000 {
+			compatible = "fsl,ls1021a-dcsr-cti";
+			reg = <0x3a4000 0x1000 0x3a5000 0x1000 0x3a6000 0x1000>;
+		};
+
+		dcsr-atbrepl at 3a8000 {
+			compatible = "fsl,ls1021a-dcsr-atbrepl";
+			reg = <0x3a8000 0x1000>;
+		};
+
+		dcsr-tsgen-ctrl at 3a9000 {
+			compatible = "fsl,ls1021a-dcsr-tsgen-ctrl";
+			reg = <0x3a9000 0x1000>;
+		};
+
+		dcsr-tsgen-read at 3aa000 {
+			compatible = "fsl,ls1021a-dcsr-tsgen-read";
+			reg = <0x3aa000 0x1000>;
+		};
+	};
 };
-- 
1.9.1
