From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 10 Feb 2014 11:47:33 +0100
Subject: [PATCH 7/7] ARM: shmobile: lager dts: Enable Quad SPI transfers for
 the SPI FLASH
In-Reply-To: <1392029254-15400-1-git-send-email-geert@linux-m68k.org>
References: <1392029254-15400-1-git-send-email-geert@linux-m68k.org>
Message-ID: <1392029254-15400-8-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
This depends on spi-rspi updates

 arch/arm/boot/dts/r8a7790-lager.dts |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index adff2dc4012d..0b47ade38340 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -113,6 +113,8 @@
 		compatible = "spansion,s25fl512s";
 		reg = <0>;
 		spi-max-frequency = <30000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
 		m25p,fast-read;
 
 		partition at 0 {
-- 
1.7.9.5
