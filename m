From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 3 Sep 2015 16:57:53 +0530
Subject: [PATCH 4/4] ARM: dts: dra7: fix address translation for pbias
In-Reply-To: <1441279673-28105-1-git-send-email-kishon@ti.com>
References: <1441279673-28105-1-git-send-email-kishon@ti.com>
Message-ID: <1441279673-28105-5-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit <d919501feffa> ("ARM: dts: dra7: add minimal l4 bus
layout with control module support") moved pbias_regulator dt node
from being a child node of ocp to be the child node of
scm_conf. Since scm_conf doesn't have the 'ranges'
property, address translation fails while trying to convert the
address to resource. Fix it here.

Fixes: d919501feffa ("ARM: dts: dra7: add minimal l4 bus
layout with control module support")

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index d6bc6db..5896896 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -120,6 +120,7 @@
 					reg = <0x0 0x1400>;
 					#address-cells = <1>;
 					#size-cells = <1>;
+					ranges = <0 0x0 0x1400>;
 
 					pbias_regulator: pbias_regulator {
 						compatible = "ti,pbias-dra7", "ti,pbias-omap";
-- 
1.7.9.5
