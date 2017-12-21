From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Dec 2017 22:48:19 +0100
Subject: [PATCH] ARM: dts: tango4: remove bogus interrupt-controller property
Message-ID: <20171221214831.3859194-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dtc points out that the parent node of the interrupt controllers is not
actually an interrupt controller itself, and lacks an #interrupt-cells
property:

arch/arm/boot/dts/tango4-vantage-1172.dtb: Warning (interrupts_property): Missing #interrupt-cells in interrupt-parent /soc/interrupt-controller at 6e000

This removes the annotation.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/dts/tango4-common.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/tango4-common.dtsi b/arch/arm/boot/dts/tango4-common.dtsi
index 0ec1b0a317b4..ff72a8efb73d 100644
--- a/arch/arm/boot/dts/tango4-common.dtsi
+++ b/arch/arm/boot/dts/tango4-common.dtsi
@@ -156,7 +156,6 @@
 			reg = <0x6e000 0x400>;
 			ranges = <0 0x6e000 0x400>;
 			interrupt-parent = <&gic>;
-			interrupt-controller;
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-- 
2.9.0
