From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 26 Mar 2015 17:38:24 +0000
Subject: [PATCH 2/3] ARM: at91/dt: sama5d3 add mmc0 vmmcq entry
In-Reply-To: <1427391505-29129-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1427391505-29129-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1427391505-29129-3-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SAM5D3 Xplained device tree is missing hte vqmmc node which is
tied to 3.3V on the board. Add this to avoid the kernel warning that
there is no vqmmc node.

atmel_mci f0000000.mmc: No vqmmc regulator found

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
--
CC: linux-arm-kernel at lists.infradead.org
CC: Andrew Victor <linux@maxim.org.za>
CC: Nicolas Ferre <nicolas.ferre@atmel.com>
CC: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
CC: Rob Herring <robh+dt@kernel.org>
CC: Pawel Moll <pawel.moll@arm.com>
CC: Mark Rutland <mark.rutland@arm.com>
CC: Ian Campbell <ijc+devicetree@hellion.org.uk>
CC: Kumar Gala <galak@codeaurora.org>
CC: Russell King <linux@arm.linux.org.uk>
CC: linux-arm-kernel at lists.infradead.org
CC: devicetree at vger.kernel.org
---
 arch/arm/boot/dts/at91-sama5d3_xplained.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/at91-sama5d3_xplained.dts b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
index 652c4dd..1eb150d 100644
--- a/arch/arm/boot/dts/at91-sama5d3_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
@@ -36,6 +36,7 @@
 			mmc0: mmc at f0000000 {
 				pinctrl-0 = <&pinctrl_mmc0_clk_cmd_dat0 &pinctrl_mmc0_dat1_3 &pinctrl_mmc0_dat4_7 &pinctrl_mmc0_cd>;
 				status = "okay";
+				vqmmc-supply = <&vcc_3v3_reg>;
 				slot at 0 {
 					reg = <0>;
 					bus-width = <8>;
-- 
2.1.4
