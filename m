From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 31 Dec 2014 16:57:50 +0800
Subject: [PATCH 1/3] ARM: dts: berlin: fix io clk and add missing core clk for
 BG2Q sdhci2 host
In-Reply-To: <1420016272-6789-1-git-send-email-jszhang@marvell.com>
References: <1420016272-6789-1-git-send-email-jszhang@marvell.com>
Message-ID: <1420016272-6789-2-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On BG2Q, the sdhci2 host uses nfcecc for "io" clk and nfc for "core" clk.
The shdci2 can't work Without this patch due to the "core" clk is gated.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Cc: stable at vger.kernel.org # 3.16+
---
 arch/arm/boot/dts/berlin2q.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index 35253c9..903f3bb 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -83,7 +83,8 @@
 			compatible = "mrvl,pxav3-mmc";
 			reg = <0xab1000 0x200>;
 			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&chip CLKID_SDIO1XIN>;
+			clocks = <&chip CLKID_NFC_ECC>, <&chip CLKID_NFC>;
+			clock-names = "io", "core";
 			status = "disabled";
 		};
 
-- 
2.1.4
