From: jaz@semihalf.com (Grzegorz Jaszczyk)
Date: Thu,  4 Aug 2016 12:14:09 +0200
Subject: [PATCH v2 06/17] ARM: dts: mvebu: armada-39x: update the SDHCI node
 on Armada 39x
In-Reply-To: <1470305660-6601-1-git-send-email-jaz@semihalf.com>
References: <1470305660-6601-1-git-send-email-jaz@semihalf.com>
Message-ID: <1470305660-6601-7-git-send-email-jaz@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 1140011ee9d9 ("mmc: sdhci-pxav3: Modify clock settings
for the SDR50 and DDR50 modes") has extended the Device Tree
binding used to describe PXAv3 SDHCI controllers in order to be
able to use the SDR50 and DDR50 modes.

This commit updates the Device Tree description of the Armada
39x SDHCI controller in other to take advantage of this
functionality.

Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-39x.dtsi | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-39x.dtsi b/arch/arm/boot/dts/armada-39x.dtsi
index dc6efd3..cb66f20 100644
--- a/arch/arm/boot/dts/armada-39x.dtsi
+++ b/arch/arm/boot/dts/armada-39x.dtsi
@@ -380,7 +380,10 @@
 
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
1.8.3.1
