From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 20 Feb 2015 18:04:23 +0100
Subject: [PATCHv2 04/15] ARM: mvebu: use IRQ macros to define the SDHCI
 interrupt on Armada 38x
In-Reply-To: <1424451874-25375-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1424451874-25375-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1424451874-25375-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 38x SDHCI controller definition in the SoC Device Tree file
is using hardcoded values instead of the nice GIC and IRQ macros
provided by DT header files. This commit fixes that, which allows the
SDHCI interrupt definition to be consistent with was is done in the
rest of the file.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-38x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 8c76a8d..0f0cc41 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -542,7 +542,7 @@
 			sdhci at d8000 {
 				compatible = "marvell,armada-380-sdhci";
 				reg = <0xd8000 0x1000>, <0xdc000 0x100>;
-				interrupts = <0 25 0x4>;
+				interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gateclk 17>;
 				mrvl,clk-delay-cycles = <0x1F>;
 				status = "disabled";
-- 
2.1.0
