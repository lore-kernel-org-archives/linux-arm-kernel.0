From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 25 Feb 2018 14:08:14 +0100
Subject: [PATCH] ARM: dts: Set D-Link DNS-313 SATA to muxmode 0
Message-ID: <20180225130814.26515-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This stops the driver from trying to probe the ATA slave
interface. The vendor code enables the slave interface
but the driver in the vendor tree does not make use of
it.

Setting it to muxmode 0 disables the slave interface:
the hardware only has the master interface connected
to the one harddrive slot anyways.

Without this change booting takes excessive time, so it
is very annoying to end users.

Fixes: dd5c0561db75 ("ARM: dts: Add basic devicetree for D-Link DNS-313")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: please apply this for fixes for v4.16.
---
 arch/arm/boot/dts/gemini-dlink-dns-313.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/gemini-dlink-dns-313.dts b/arch/arm/boot/dts/gemini-dlink-dns-313.dts
index 08568ce24d06..da8bb9d60f99 100644
--- a/arch/arm/boot/dts/gemini-dlink-dns-313.dts
+++ b/arch/arm/boot/dts/gemini-dlink-dns-313.dts
@@ -269,7 +269,7 @@
 
 		sata: sata at 46000000 {
 			/* The ROM uses this muxmode */
-			cortina,gemini-ata-muxmode = <3>;
+			cortina,gemini-ata-muxmode = <0>;
 			cortina,gemini-enable-sata-bridge;
 			status = "okay";
 		};
-- 
2.14.3
