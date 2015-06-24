From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Wed, 24 Jun 2015 14:03:41 +0530
Subject: [PATCH v2 2/2] ARM: dts: vfxxx: Add property for minimum sample time
In-Reply-To: <cover.1435134626.git.maitysanchayan@gmail.com>
References: <cover.1435134626.git.maitysanchayan@gmail.com>
Message-ID: <36fa3cef10b6a21b39e96283ea5d6961e9f6d972.1435134626.git.maitysanchayan@gmail.com>
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
index 90a03d5..71d9c08 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -229,6 +229,7 @@
 				status = "disabled";
 				fsl,adck-max-frequency = <30000000>, <40000000>,
 							<20000000>;
+				min-sample-time = <1000>;
 			};
 
 			wdoga5: wdog at 4003e000 {
@@ -447,6 +448,7 @@
 				status = "disabled";
 				fsl,adck-max-frequency = <30000000>, <40000000>,
 							<20000000>;
+				min-sample-time = <1000>;
 			};
 
 			esdhc1: esdhc at 400b2000 {
-- 
2.4.4
