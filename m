From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 12 Oct 2015 13:46:33 +0800
Subject: [PATCH 2/5] ARM: dts: berlin: correct BG2Q's sdhci2 axi clock
In-Reply-To: <1444628796-5484-1-git-send-email-jszhang@marvell.com>
References: <1444628796-5484-1-git-send-email-jszhang@marvell.com>
Message-ID: <1444628796-5484-3-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The optional axi clock is CLKID_SDIO.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm/boot/dts/berlin2q.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index 4ad585c..2f12048 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -119,7 +119,7 @@
 			compatible = "mrvl,pxav3-mmc";
 			reg = <0xab1000 0x200>;
 			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&chip_clk CLKID_NFC_ECC>, <&chip_clk CLKID_NFC>;
+			clocks = <&chip_clk CLKID_NFC_ECC>, <&chip_clk CLKID_SDIO>;
 			clock-names = "core", "axi";
 			status = "disabled";
 		};
-- 
2.6.1
