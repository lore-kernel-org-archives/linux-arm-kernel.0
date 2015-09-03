From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 3 Sep 2015 16:57:52 +0530
Subject: [PATCH 3/4] ARM: dts: omap5: fix address translation for pbias
In-Reply-To: <1441279673-28105-1-git-send-email-kishon@ti.com>
References: <1441279673-28105-1-git-send-email-kishon@ti.com>
Message-ID: <1441279673-28105-4-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit <ed8509edddeb> ("ARM: dts: omap5: add minimal l4 bus
layout with control module support") moved pbias_regulator dt node
from being a child node of ocp to be the child node of
omap5_padconf_global. Since omap5_padconf_global doesn't have the
'ranges' property, address translation fails while trying to convert
the address to resource. Fix it here.

Fixes: ed8509edddeb ("ARM: dts: omap5: add minimal l4 bus
layout with control module support")

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 76ef595..dd7a0e8 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -185,6 +185,7 @@
 					reg = <0x5a0 0xec>;
 					#address-cells = <1>;
 					#size-cells = <1>;
+					ranges = <0 0x5a0 0xec>;
 
 					pbias_regulator: pbias_regulator {
 						compatible = "ti,pbias-omap5", "ti,pbias-omap";
-- 
1.7.9.5
