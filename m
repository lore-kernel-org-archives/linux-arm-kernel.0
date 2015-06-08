From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Mon,  8 Jun 2015 11:12:01 +0530
Subject: [PATCH v1 2/2] ARM: dts: vfxxx: Add property for minimum sample time
In-Reply-To: <cover.1433740528.git.maitysanchayan@gmail.com>
References: <cover.1433740528.git.maitysanchayan@gmail.com>
Message-ID: <4d2ba0ad1bbc61dedc9ec144e9be6aeb6cf4747d.1433740528.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a device tree property which allows to specify the minimum sample
time which can be used to calculate the actual ADC cycles required
depending on the hardware.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 arch/arm/boot/dts/vfxxx.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index 90a03d5..463cfe3 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -229,6 +229,7 @@
 				status = "disabled";
 				fsl,adck-max-frequency = <30000000>, <40000000>,
 							<20000000>;
+				fsl,min-sample-time = <1000>;
 			};
 
 			wdoga5: wdog at 4003e000 {
@@ -447,6 +448,7 @@
 				status = "disabled";
 				fsl,adck-max-frequency = <30000000>, <40000000>,
 							<20000000>;
+				fsl,min-sample-time = <1000>;
 			};
 
 			esdhc1: esdhc at 400b2000 {
-- 
2.4.2
