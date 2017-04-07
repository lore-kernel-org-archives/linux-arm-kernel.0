From: lipengcheng8@huawei.com (Li Pengcheng)
Date: Fri, 7 Apr 2017 16:06:58 +0800
Subject: [PATCH] arm64: dts: Add coresight DT nodes for hi6220-hikey
Message-ID: <1491552418-74386-1-git-send-email-lipengcheng8@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add coresight DT nodes for hikey board.

Signed-off-by: Li Pengcheng <lipengcheng8@huawei.com>
Signed-off-by: Li Zhong <lizhong11@hisilicon.com>
---
 .../arm64/boot/dts/hisilicon/hi6220-coresight.dtsi | 318 +++++++++++++++++++++
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts     |   1 +
 2 files changed, 319 insertions(+)
 create mode 100644 arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi
new file mode 100644
index 0000000..a523e43
--- /dev/null
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi
@@ -0,0 +1,318 @@
+/*
+ * Hisilicon Ltd. Hi6220 SoC
+ *
+ * Copyright (C) 2015-2016 Hisilicon Ltd.
+ * Author: lipengcheng  <lipengcheng8@huawei.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * publishhed by the Free Software Foundation.
+ */
+/ {
+	amba {
+		/* A53 cluster0 internal coresight */
+		#address-cells = <2>;
+		#size-cells = <2>;
+		compatible = "arm,amba-bus";
+		ranges;
+		etm at 0,f659c000 {
+			compatible = "arm,coresight-etm4x","arm,primecell";
+			reg = <0 0xf659c000 0 0x1000>;
+
+			clocks = <&sys_ctrl HI6220_CS_ATB>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu0>;
+			port {
+				etm0_out_port: endpoint {
+					remote-endpoint = <&funnel0_in_port0>;
+				};
+			};
+		};
+
+		etm at 1,f659d000 {
+			compatible = "arm,coresight-etm4x","arm,primecell";
+			reg = <0 0xf659d000 0 0x1000>;
+
+			clocks = <&sys_ctrl HI6220_CS_ATB>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu1>;
+			port {
+				etm1_out_port: endpoint {
+					remote-endpoint = <&funnel0_in_port1>;
+				};
+			};
+
+		};
+
+		etm at 2,f659e000 {
+			compatible = "arm,coresight-etm4x","arm,primecell";
+			reg = <0 0xf659e000 0 0x1000>;
+
+			clocks = <&sys_ctrl HI6220_CS_ATB>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu2>;
+			port {
+				etm2_out_port: endpoint {
+					remote-endpoint = <&funnel0_in_port2>;
+				};
+			};
+		};
+
+		etm at 3,f659f000 {
+			compatible = "arm,coresight-etm4x","arm,primecell";
+			reg = <0 0xf659f000 0 0x1000>;
+
+			clocks = <&sys_ctrl HI6220_CS_ATB>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu3>;
+			port {
+				etm3_out_port: endpoint {
+					remote-endpoint = <&funnel0_in_port3>;
+				};
+			};
+		};
+
+		/* A53 cluster1 internal coresight */
+		etm at 4,f65dc000 {
+			compatible = "arm,coresight-etm4x","arm,primecell";
+			reg = <0 0xf65dc000 0 0x1000>;
+
+			clocks = <&sys_ctrl HI6220_CS_ATB>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu4>;
+			port {
+				etm4_out_port: endpoint {
+				remote-endpoint = <&funnel0_in_port4>;
+				};
+			};
+		};
+
+		etm at 5,f65dd000 {
+			compatible = "arm,coresight-etm4x","arm,primecell";
+			reg = <0 0xf65dd000 0 0x1000>;
+
+			clocks = <&sys_ctrl HI6220_CS_ATB>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu5>;
+			port {
+				etm5_out_port: endpoint {
+				remote-endpoint = <&funnel0_in_port5>;
+				};
+			};
+		};
+
+		etm at 6,f65de000 {
+			compatible = "arm,coresight-etm4x","arm,primecell";
+			reg = <0 0xf65de000 0 0x1000>;
+
+			clocks = <&sys_ctrl HI6220_CS_ATB>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu6>;
+			port {
+				etm6_out_port: endpoint {
+					remote-endpoint = <&funnel0_in_port6>;
+				};
+			};
+		};
+
+		etm at 7,f65df000 {
+			compatible = "arm,coresight-etm4x","arm,primecell";
+			reg = <0 0xf65df000 0 0x1000>;
+
+			clocks = <&sys_ctrl HI6220_CS_ATB>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu7>;
+			port {
+				etm7_out_port: endpoint {
+					remote-endpoint = <&funnel0_in_port7>;
+				};
+			};
+		};
+
+		funnel0:funnel at 0,f6501000 {
+			compatible = "arm,coresight-funnel","arm,primecell";
+			reg = <0 0xf6501000 0 0x1000>;
+
+			clocks = <&sys_ctrl HI6220_CS_ATB>;
+			clock-names = "apb_pclk";
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				/* funnel output port */
+				port at 0 {
+					reg = <0>;
+					funnel0_out_port: endpoint {
+						remote-endpoint = <&funnel1_in_port>;
+					};
+				};
+
+				/* funnel input ports */
+				port at 1 {
+					reg = <0>;
+					funnel0_in_port0: endpoint {
+						slave-mode;
+						remote-endpoint = <&etm0_out_port>;
+					};
+				};
+
+				port at 2 {
+					reg = <1>;
+					funnel0_in_port1: endpoint {
+						slave-mode;
+						remote-endpoint = <&etm1_out_port>;
+					};
+				};
+
+				port at 3 {
+					reg = <2>;
+					funnel0_in_port2: endpoint {
+						slave-mode;
+						remote-endpoint = <&etm2_out_port>;
+					};
+				};
+
+				port at 4 {
+					reg = <3>;
+					funnel0_in_port3: endpoint {
+						slave-mode;
+						remote-endpoint = <&etm3_out_port>;
+					};
+				};
+
+				port at 5 {
+					reg = <4>;
+					funnel0_in_port4: endpoint {
+						slave-mode;
+						remote-endpoint = <&etm4_out_port>;
+					};
+				};
+
+				port at 6 {
+					reg = <5>;
+					funnel0_in_port5: endpoint {
+						slave-mode;
+						remote-endpoint = <&etm5_out_port>;
+					};
+				};
+
+				port at 7 {
+					reg = <6>;
+					funnel0_in_port6: endpoint {
+						slave-mode;
+						remote-endpoint = <&etm6_out_port>;
+					};
+				};
+
+				port at 8 {
+					reg = <7>;
+					funnel0_in_port7: endpoint {
+						slave-mode;
+						remote-endpoint = <&etm7_out_port>;
+					};
+				};
+			};
+		};
+
+		funnel1:funnel at 1,f6401000 {
+			compatible = "arm,coresight-funnel","arm,primecell";
+			reg = <0 0xf6401000 0 0x1000>;
+
+			clocks = <&sys_ctrl HI6220_CS_ATB>;
+			clock-names = "apb_pclk";
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				/* funnel1 output port */
+				port at 0 {
+					reg = <0>;
+					funnel1_out_port: endpoint {
+						remote-endpoint = <&etf_in_port>;
+					};
+				};
+
+				/* funnel1 input port */
+				port at 1 {
+					reg = <0>;
+					funnel1_in_port: endpoint {
+						slave-mode;
+						remote-endpoint = <&funnel0_out_port>;
+					};
+				};
+			};
+		};
+		etf:etf at 0,f6402000 {
+			compatible = "arm,coresight-tmc","arm,primecell";
+			reg = <0 0xf6402000 0 0x1000>;
+
+			clocks = <&sys_ctrl HI6220_CS_ATB>;
+			clock-names = "apb_pclk";
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				/* etf input port */
+				port at 0 {
+					reg = <0>;
+					etf_in_port: endpoint {
+						slave-mode;
+						remote-endpoint = <&funnel1_out_port>;
+					};
+				};
+				/* etf output port */
+				port at 1 {
+					reg = <0>;
+					etf_out_port: endpoint {
+						remote-endpoint = <&replicator0_in_port>;
+					};
+				};
+			};
+		};
+
+		replicator at 0{
+			compatible = "arm,coresight-replicator";
+
+			clocks = <&sys_ctrl HI6220_CS_ATB>;
+			clock-names = "apb_pclk";
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				/* replicator input port  */
+				port at 0 {
+					reg = <0>;
+					replicator0_in_port: endpoint{
+					slave-mode;
+					remote-endpoint = <&etf_out_port>;
+					};
+				};
+				/* replicator out port  */
+				port at 1 {
+					reg = <0>;
+					replicator0_out_port: endpoint {
+						remote-endpoint = <&etr0_in_port>;
+					};
+				};
+			};
+		};
+
+		etr at 0,f6404000 {
+			compatible = "arm,coresight-tmc","arm,primecell";
+			reg = <0 0xf6404000 0 0x1000>;
+
+			coresight-default-sink;
+			clocks = <&sys_ctrl HI6220_CS_ATB>;
+			clock-names = "apb_pclk";
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				/* etr input port  */
+				port at 0 {
+					etr0_in_port: endpoint{
+					slave-mode;
+					remote-endpoint = <&replicator0_out_port>;
+					};
+				};
+			};
+		};
+	};
+};
+
diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index dba3c13..fb70c9b 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 #include "hi6220.dtsi"
 #include "hikey-pinctrl.dtsi"
+#include "hi6220-coresight.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 
 / {
-- 
2.1.0
