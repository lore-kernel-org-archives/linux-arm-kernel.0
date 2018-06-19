From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 19 Jun 2018 09:54:10 +0200
Subject: [PATCH] ARM: dts: nomadik: Cut FSMC timings
Message-ID: <20180619075410.2844-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After the work done by Thomas Petazzoni, the NAND chip timings
can be read out from the chip instead of open coded in the
device tree, so let's just remove the timing information.

Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
index dd9d1f08a337..b5ed312808df 100644
--- a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
@@ -662,7 +662,6 @@
 		reg-names = "fsmc_regs", "nand_data", "nand_addr", "nand_cmd";
 		clocks = <&hclksmc>;
 		status = "okay";
-		timings = /bits/ 8 <0 0 0 0x10 0x0a 0>;
 
 		partition at 0 {
 		label = "X-Loader(NAND)";
-- 
2.17.1
