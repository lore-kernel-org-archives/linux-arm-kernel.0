From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Fri,  7 Nov 2014 18:34:27 +0530
Subject: [[PATCHv2] 2/3] ARM: dts: vfxxx: Add SNVS node
In-Reply-To: <cover.1415364391.git.maitysanchayan@gmail.com>
References: <cover.1415364391.git.maitysanchayan@gmail.com>
Message-ID: <64244b916de3864b714e829c3adeecec71aea2b3.1415364391.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a devicetree node for the Secure
Non-Volatile Storage (SNVS) on the VF610 platform.
The SNVS block also has a Real Time Counter (RTC).

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 arch/arm/boot/dts/vfxxx.dtsi |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index 4e70833..bc131b0 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -338,6 +338,21 @@
 				status = "disabled";
 			};
 
+			snvs0: snvs at 400a7000 {
+				compatible = "fsl,sec-v4.0-mon", "simple-bus";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x400a7000 0x2000>;
+
+				snvs-rtc-lp at 34 {
+					compatible = "fsl,sec-v4.0-mon-rtc-lp";
+					reg = <0x34 0x58>;
+					interrupts = <0 100 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clks VF610_CLK_SNVS>;
+					clock-names = "snvs-rtc";
+				};
+			};
+
 			uart4: serial at 400a9000 {
 				compatible = "fsl,vf610-lpuart";
 				reg = <0x400a9000 0x1000>;
-- 
1.7.9.5
