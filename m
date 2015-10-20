From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 20 Oct 2015 19:16:44 +0800
Subject: [PATCH v2 1/4] ARM: dts: berlin: correct BG2Q's sdhci2 2nd clock
In-Reply-To: <1445339807-2351-1-git-send-email-jszhang@marvell.com>
References: <1445339807-2351-1-git-send-email-jszhang@marvell.com>
Message-ID: <1445339807-2351-2-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The optional 2nd clock is CLKID_SDIO.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm/boot/dts/berlin2q.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index 63a4849..2cb07fa 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -119,7 +119,7 @@
 			compatible = "mrvl,pxav3-mmc";
 			reg = <0xab1000 0x200>;
 			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&chip_clk CLKID_NFC_ECC>, <&chip_clk CLKID_NFC>;
+			clocks = <&chip_clk CLKID_NFC_ECC>, <&chip_clk CLKID_SDIO>;
 			clock-names = "io", "core";
 			status = "disabled";
 		};
-- 
2.6.1
