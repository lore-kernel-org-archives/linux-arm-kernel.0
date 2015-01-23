From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 23 Jan 2015 17:46:26 +0100
Subject: [PATCH v3 6/7] ARM: mvebu: Update the SDHCI node on Armada 38x
In-Reply-To: <1422031587-18212-1-git-send-email-gregory.clement@free-electrons.com>
References: <1422031587-18212-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1422031587-18212-7-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The binding of the armada-380-sdhci has been extended with a new
register in order to be able to use the SDR50 and DDR50 mode. This
commit add the resource associated to this new register for the
Armada 38x.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-38x.dtsi | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 71d4eca5b497..474b2ebf4a82 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -515,7 +515,10 @@
 
 			sdhci at d8000 {
 				compatible = "marvell,armada-380-sdhci";
-				reg = <0xd8000 0x1000>, <0xdc000 0x100>;
+				reg-names = "sdhci", "mbus", "conf-sdio3";
+				reg = <0xd8000 0x1000>,
+					<0xdc000 0x100>,
+					<0x18454 0x4>;
 				interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gateclk 17>;
 				mrvl,clk-delay-cycles = <0x1F>;
-- 
2.1.0
