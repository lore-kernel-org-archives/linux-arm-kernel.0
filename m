From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 14 Sep 2016 14:27:46 +0100
Subject: [PATCH 08/19] thermal: sti: Remove obsolete platforms from the DT doc.
In-Reply-To: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
References: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1473859677-9231-9-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

STiH415/6 SoC's are being removed from the kernel. This
patch removes the compatibles from the dt doc and also
updates the example to a supported platform.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Cc: <rui.zhang@intel.com>
Cc: <edubezval@gmail.com>
Cc: <robh+dt@kernel.org>
---
 .../devicetree/bindings/thermal/st-thermal.txt     | 28 +++++++---------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/st-thermal.txt b/Documentation/devicetree/bindings/thermal/st-thermal.txt
index 3b9251b..a2f9391 100644
--- a/Documentation/devicetree/bindings/thermal/st-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/st-thermal.txt
@@ -3,17 +3,8 @@ Binding for Thermal Sensor driver for STMicroelectronics STi series of SoCs.
 Required parameters:
 -------------------
 
-compatible : 	st,<SoC>-<module>-thermal; should be one of:
-		  "st,stih415-sas-thermal",
-		  "st,stih415-mpe-thermal",
-		  "st,stih416-sas-thermal"
-		  "st,stih416-mpe-thermal"
-		  "st,stid127-thermal" or
-		  "st,stih407-thermal"
-		according to the SoC type (stih415, stih416, stid127, stih407)
-		and module type (sas or mpe). On stid127 & stih407 there is only
-		one die/module, so there is no module type in the compatible
-		string.
+compatible : 	Should be "st,stih407-thermal"
+
 clock-names : 	Should be "thermal".
 		  See: Documentation/devicetree/bindings/resource-names.txt
 clocks : 	Phandle of the clock used by the thermal sensor.
@@ -25,18 +16,17 @@ Optional parameters:
 reg : 		For non-sysconf based sensors, this should be the physical base
 		address and length of the sensor's registers.
 interrupts :	Standard way to define interrupt number.
-		Interrupt is mandatory to be defined when compatible is
-		"stih416-mpe-thermal".
 		  NB: For thermal sensor's for which no interrupt has been
 		  defined, a polling delay of 1000ms will be used to read the
 		  temperature from device.
 
 Example:
 
-	temp1 at fdfe8000 {
-		compatible	= "st,stih416-mpe-thermal";
-		reg		= <0xfdfe8000 0x10>;
-		clock-names	= "thermal";
-		clocks		= <&clk_m_mpethsens>;
-		interrupts	= <GIC_SPI 23 IRQ_TYPE_NONE>;
+	temp0 at 91a0000 {
+		compatible = "st,stih407-thermal";
+		reg = <0x91a0000 0x28>;
+		clock-names = "thermal";
+		clocks = <&CLK_SYSIN>;
+		interrupts = <GIC_SPI 205 IRQ_TYPE_EDGE_RISING>;
+		st,passive_cooling_temp = <110>;
 	};
-- 
1.9.1
