From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 24 Jan 2014 13:49:51 +0100
Subject: [PATCH 15/15] ARM: shmobile: koelsch dts: Enable Quad SPI transfers
 for the SPI FLASH
In-Reply-To: <1390567791-8988-1-git-send-email-geert@linux-m68k.org>
References: <1390567791-8988-1-git-send-email-geert@linux-m68k.org>
Message-ID: <1390567791-8988-16-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Cc: devicetree at vger.kernel.org
---
This depends on spi-rspi and m25p80 updates

 arch/arm/boot/dts/r8a7791-koelsch.dts |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 42fd5ebe9119..d4ca21cd2c34 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -160,6 +160,8 @@
 		compatible = "spansion,s25fl512s";
 		reg = <0>;
 		spi-max-frequency = <30000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
 		m25p,fast-read;
 
 		partition at 0 {
-- 
1.7.9.5
