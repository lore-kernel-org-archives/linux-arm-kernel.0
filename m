From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 18 Apr 2018 14:54:07 +0530
Subject: [PATCH v2 1/2] ARM: dts: da850: get rid of skeleton.dtsi
In-Reply-To: <20180418092408.2077-1-nsekhar@ti.com>
References: <20180418092408.2077-1-nsekhar@ti.com>
Message-ID: <20180418092408.2077-2-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

skeleton.dtsi is deprecated. Drop its usage in da850.dtsi
and move the nodes and properties included by it directly
to keep the dtb same.

The memory node has been changed to get rid of warnings
(see below). It contains the memory base address as that is
fixed for DA850 SoCs. But the size needs to be added by
bootloader or a board specific dts.

This gets rid of the following W=1 warnings:

arch/arm/boot/dts/da850-enbw-cmc.dtb: Warning (unit_address_vs_reg): /memory: node has a reg or ranges property, but no unit name
arch/arm/boot/dts/da850-evm.dtb: Warning (unit_address_vs_reg): /memory: node has a reg or ranges property, but no unit name
arch/arm/boot/dts/da850-lego-ev3.dtb: Warning (unit_address_vs_reg): /memory: node has a reg or ranges property, but no unit name

Reviewed-by: David Lechner <david@lechnology.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
v2: No change, add David's Reviewed-by.

 arch/arm/boot/dts/da850.dtsi | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 73bf7cd3d229..cba3afd00763 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -7,10 +7,19 @@
  * Free Software Foundation;  either version 2 of the  License, or (at your
  * option) any later version.
  */
-#include "skeleton.dtsi"
 #include <dt-bindings/interrupt-controller/irq.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	chosen { };
+	aliases { };
+
+	memory at c0000000 {
+		device_type = "memory";
+		reg = <0xc0000000 0x0>;
+	};
+
 	arm {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.16.2
