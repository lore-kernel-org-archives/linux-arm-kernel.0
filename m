From: tony@atomide.com (Tony Lindgren)
Date: Wed, 20 May 2015 14:42:11 -0700
Subject: [PATCH] ARM: dts: Enable SDIO card interrupt for 37xx-evm
Message-ID: <1432158131-20998-1-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows to use the MMC1 slot with SDIO cards.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap3-evm-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/omap3-evm-common.dtsi b/arch/arm/boot/dts/omap3-evm-common.dtsi
index 346552b..b2589f9 100644
--- a/arch/arm/boot/dts/omap3-evm-common.dtsi
+++ b/arch/arm/boot/dts/omap3-evm-common.dtsi
@@ -96,6 +96,7 @@
 };
 
 &mmc1 {
+	interrupts-extended = <&intc 83 &omap3_pmx_core 0x11a>;
 	vmmc-supply = <&vmmc1>;
 	vmmc_aux-supply = <&vsim>;
 	bus-width = <8>;
-- 
2.1.4
