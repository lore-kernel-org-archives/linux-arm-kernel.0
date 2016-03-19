From: marex@denx.de (Marek Vasut)
Date: Sun, 20 Mar 2016 00:57:04 +0100
Subject: [PATCH 1/2] ARM: socfpga: dts: Drop phy-addr OF property from CV dtsi
Message-ID: <1458431825-9159-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The phy-addr property of stmmac is deprecated and the stmmac driver
does not use it either. On the contrary, the driver will warn if
this property is defined. Remove it.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/boot/dts/socfpga_cyclone5.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dtsi b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
index 06db951..418c19e 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5.dtsi
+++ b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
@@ -40,7 +40,6 @@
 
 		ethernet at ff702000 {
 			phy-mode = "rgmii";
-			phy-addr = <0xffffffff>; /* probe for phy addr */
 			status = "okay";
 		};
 
-- 
2.7.0
