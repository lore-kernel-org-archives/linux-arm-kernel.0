From: stefan@agner.ch (Stefan Agner)
Date: Wed, 27 May 2015 14:47:52 +0200
Subject: [PATCH v5 2/2] ARM: dts: add property for maximum ADC clock
 frequencies
In-Reply-To: <1432730872-14325-1-git-send-email-stefan@agner.ch>
References: <1432730872-14325-1-git-send-email-stefan@agner.ch>
Message-ID: <1432730872-14325-3-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ADC clock frequency is limited depending on modes used. Add
device tree property which allow to set the mode used and the
maximum frequency ratings for the instance. These allows to
set the ADC clock to a frequency which is within specification
according to the actual mode used.

Acked-by: Fugang Duan <B38611@freescale.com>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/vfxxx.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index a29c7ce..c6609bd 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -189,6 +189,8 @@
 				clocks = <&clks VF610_CLK_ADC0>;
 				clock-names = "adc";
 				status = "disabled";
+				fsl,adck-max-frequency = <30000000>, <40000000>,
+							<20000000>;
 			};
 
 			wdoga5: wdog at 4003e000 {
@@ -387,6 +389,8 @@
 				clocks = <&clks VF610_CLK_ADC1>;
 				clock-names = "adc";
 				status = "disabled";
+				fsl,adck-max-frequency = <30000000>, <40000000>,
+							<20000000>;
 			};
 
 			esdhc1: esdhc at 400b2000 {
-- 
2.4.1
