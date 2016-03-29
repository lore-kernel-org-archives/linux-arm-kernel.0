From: manabian@gmail.com (Joachim Eastwood)
Date: Wed, 30 Mar 2016 00:30:42 +0200
Subject: [PATCH 3/7] ARM: dts: lpc18xx: remove unit addresses from creg childs
In-Reply-To: <1459290646-3592-1-git-send-email-manabian@gmail.com>
References: <1459290646-3592-1-git-send-email-manabian@gmail.com>
Message-ID: <1459290646-3592-4-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT nodes without reg properties should not have a unit address. This
fixes the following warnings from dtc.

 Warning (unit_address_vs_reg): Node /soc/syscon at 40043000/phy at 004 has a
 unit name, but no reg property
 Warning (unit_address_vs_reg): Node /soc/syscon at 40043000/dma-mux at 11c has
 a unit name, but no reg property

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc18xx.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/lpc18xx.dtsi b/arch/arm/boot/dts/lpc18xx.dtsi
index fdc991b..fdb736c 100644
--- a/arch/arm/boot/dts/lpc18xx.dtsi
+++ b/arch/arm/boot/dts/lpc18xx.dtsi
@@ -201,13 +201,13 @@
 				#clock-cells = <1>;
 			};
 
-			usb0_otg_phy: phy at 004 {
+			usb0_otg_phy: phy {
 				compatible = "nxp,lpc1850-usb-otg-phy";
 				clocks = <&ccu1 CLK_USB0>;
 				#phy-cells = <0>;
 			};
 
-			dmamux: dma-mux at 11c {
+			dmamux: dma-mux {
 				compatible = "nxp,lpc1850-dmamux";
 				#dma-cells = <3>;
 				dma-requests = <64>;
-- 
2.7.4
