From: marex@denx.de (Marek Vasut)
Date: Thu, 26 May 2016 00:40:42 +0200
Subject: [PATCH] ARM: dts: socfpga: Add missing PHY phandle
Message-ID: <1464216042-6477-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing PHY phandle into the DT, otherwise the stmmac code won't
detect the PHY correctly anymore.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts b/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
index a3601e4..b844473 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
@@ -136,6 +136,7 @@
 &gmac1 {
 	status = "okay";
 	phy-mode = "rgmii";
+	phy-handle = <&phy1>;
 
 	snps,reset-gpio = <&porta 0 GPIO_ACTIVE_LOW>;
 	snps,reset-active-low;
-- 
2.7.0
