From: manish.narani@xilinx.com (Manish Narani)
Date: Mon, 29 Oct 2018 17:40:26 +0530
Subject: [PATCH v3 3/3] arm64: zynqmp: DT: Add Xilinx AMS node
In-Reply-To: <1540815026-1012-1-git-send-email-manish.narani@xilinx.com>
References: <1540815026-1012-1-git-send-email-manish.narani@xilinx.com>
Message-ID: <1540815026-1012-4-git-send-email-manish.narani@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Xilinx AMS includes an ADC as well as on-chip sensors that can be
used to sample external and monitor on-die operating conditions, such as
temperature and supply voltage levels.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 29ce234..e5facd8 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -617,5 +617,32 @@
 			reg = <0x0 0xfd4d0000 0x0 0x1000>;
 			timeout-sec = <10>;
 		};
+
+		xilinx_ams: ams at ffa50000 {
+			compatible = "xlnx,zynqmp-ams";
+			status = "disabled";
+			interrupt-parent = <&gic>;
+			interrupts = <0 56 4>;
+			interrupt-names = "ams-irq";
+			reg = <0x0 0xffa50000 0x0 0x800>;
+			reg-names = "ams-base";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#io-channel-cells = <1>;
+			ranges = <0 0 0xffa50800 0x400
+				  1 0 0xffa50c00 0x400>;
+
+			ams_ps: ams_ps at 0,0 {
+				compatible = "xlnx,zynqmp-ams-ps";
+				status = "disabled";
+				reg = <0 0x400>;
+			};
+
+			ams_pl: ams_pl at 1,0 {
+				compatible = "xlnx,zynqmp-ams-pl";
+				status = "disabled";
+				reg = <0 0x400>;
+			};
+		};
 	};
 };
-- 
2.1.1
