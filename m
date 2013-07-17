From: dinguyen@altera.com (dinguyen at altera.com)
Date: Wed, 17 Jul 2013 18:10:22 -0500
Subject: [PATCH 3/4] ARM: socfpga: dts: Fix entries for the ethernet entries.
In-Reply-To: <1374102623-4154-1-git-send-email-dinguyen@altera.com>
References: <1374102623-4154-1-git-send-email-dinguyen@altera.com>
Message-ID: <1374102623-4154-4-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Use the gate-clock emac_0_clk and emac_1_clk. Fix phy-addr binding to the
correct snps,phy-addr binding.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Olof Johansson <olof@lixom.net>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Pavel Machek <pavel@denx.de>
Cc: Jack Mitchell <jack.mitchell@dbbroadcast.co.uk>
---
 arch/arm/boot/dts/socfpga.dtsi         |    4 ++--
 arch/arm/boot/dts/socfpga_cyclone5.dts |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index dbf7f22..93ee655 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -444,7 +444,7 @@
 			interrupts = <0 115 4>;
 			interrupt-names = "macirq";
 			mac-address = [00 00 00 00 00 00];/* Filled in by U-Boot */
-			clocks = <&emac0_clk>;
+			clocks = <&emac_0_clk>;
 			clock-names = "stmmaceth";
 			status = "disabled";
 		};
@@ -455,7 +455,7 @@
 			interrupts = <0 120 4>;
 			interrupt-names = "macirq";
 			mac-address = [00 00 00 00 00 00];/* Filled in by U-Boot */
-			clocks = <&emac1_clk>;
+			clocks = <&emac_1_clk>;
 			clock-names = "stmmaceth";
 			status = "disabled";
 		};
diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dts b/arch/arm/boot/dts/socfpga_cyclone5.dts
index 1853cb1..102c4d8 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5.dts
@@ -50,7 +50,7 @@
 
 		ethernet at ff702000 {
 			phy-mode = "rgmii";
-			phy-addr = <0xffffffff>; /* probe for phy addr */
+			snps,phy-addr = <0xffffffff>; /* probe for phy addr */
 			status = "okay";
 		};
 
-- 
1.7.9.5
