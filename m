From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 27 Jul 2015 17:46:38 +0530
Subject: [RFT PATCH 1/4] ARM: dts: omap24xx: Fix broken pbias device creation
In-Reply-To: <1437999401-3519-1-git-send-email-kishon@ti.com>
References: <1437999401-3519-1-git-send-email-kishon@ti.com>
Message-ID: <1437999401-3519-2-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit <72b10ac00eb1> ("ARM: dts: omap24xx: add minimal l4 bus
layout with control module support") moved pbias_regulator dt node
from being a child node of ocp to be the child node of
scm_conf. After this device for pbias_regulator is
not created.

Fix it by adding "simple-bus" compatible property to
scm_conf dt node.

Fixes: 72b10ac00eb1 ("ARM: dts: omap24xx: add minimal l4 bus
layout with control module support")

Cc: <stable@vger.kernel.org>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/omap2430.dtsi |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
index 11a7963..2390f38 100644
--- a/arch/arm/boot/dts/omap2430.dtsi
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -51,7 +51,8 @@
 				};
 
 				scm_conf: scm_conf at 270 {
-					compatible = "syscon";
+					compatible = "syscon",
+						     "simple-bus";
 					reg = <0x270 0x240>;
 					#address-cells = <1>;
 					#size-cells = <1>;
-- 
1.7.9.5
