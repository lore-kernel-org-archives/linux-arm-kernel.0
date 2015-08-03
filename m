From: m-karicheri2@ti.com (Murali Karicheri)
Date: Mon, 3 Aug 2015 14:11:57 -0400
Subject: [PATCH 1/2] ARM: dts: keystone: fix the clock node for mdio
Message-ID: <1438625518-21315-1-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the MDIO clock is pointing to clkpa instead of clkcpgmac.
MDIO is part of the ethss and the clock should be clkcpgmac.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 arch/arm/boot/dts/keystone.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index e7a6f6d..6245a17 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -273,7 +273,7 @@
 			#size-cells = <0>;
 			reg		= <0x02090300 0x100>;
 			status = "disabled";
-			clocks = <&clkpa>;
+			clocks = <&clkcpgmac>;
 			clock-names = "fck";
 			bus_freq	= <2500000>;
 		};
-- 
1.9.1
