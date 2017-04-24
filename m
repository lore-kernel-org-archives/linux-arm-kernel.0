From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Mon, 24 Apr 2017 15:22:01 -0500
Subject: [PATCH v2 1/4] ARM: dts: keystone-k2g: Remove skeleton.dtsi
In-Reply-To: <20170424202204.24170-1-fcooper@ti.com>
References: <20170424202204.24170-1-fcooper@ti.com>
Message-ID: <20170424202204.24170-2-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding the unit address to the memory node was causing the below error:
Warning (reg_format): "reg" property in /memory has invalid length
(8 bytes) (#address-cells == 2, #size-cells == 2)

Further debugging showed that this was due to the memory node added by
default to skeleton.dtsi which was being included in keystone-k2g.dtsi.
Adding a missing node was all that was needed to remove this deprecated
dtsi file from the SoC dtsi. With skeleton.dtsi removed the dtc compiler
no longer complained about including the unit address for the memory node.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 arch/arm/boot/dts/keystone-k2g.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
index f59567f..a789f75 100644
--- a/arch/arm/boot/dts/keystone-k2g.dtsi
+++ b/arch/arm/boot/dts/keystone-k2g.dtsi
@@ -15,7 +15,6 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/keystone.h>
-#include "skeleton.dtsi"
 
 / {
 	compatible = "ti,k2g","ti,keystone";
@@ -24,6 +23,8 @@
 	#size-cells = <2>;
 	interrupt-parent = <&gic>;
 
+	chosen { };
+
 	aliases {
 		serial0 = &uart0;
 	};
-- 
2.10.0
