From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Feb 2014 17:03:57 +0900
Subject: [PATCH 10/11] ARM: shmobile: lager legacy: Switch QSPI to named IRQs
In-Reply-To: <cover.1392276547.git.horms+renesas@verge.net.au>
References: <cover.1392276547.git.horms+renesas@verge.net.au>
Message-ID: <a70eda7e40d09b8bf1a817488a255ce907587a71.1392276547.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-lager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index e8242c5..3175748 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -310,7 +310,7 @@ static const struct spi_board_info spi_info[] __initconst = {
 /* QSPI resource */
 static const struct resource qspi_resources[] __initconst = {
 	DEFINE_RES_MEM(0xe6b10000, 0x1000),
-	DEFINE_RES_IRQ(gic_spi(184)),
+	DEFINE_RES_IRQ_NAMED(gic_spi(184), "mux"),
 };
 
 /* VIN */
-- 
1.8.5.2
