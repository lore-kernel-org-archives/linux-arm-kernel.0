From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue,  4 Feb 2014 16:24:05 +0100
Subject: [PATCH v2 11/11] ARM: shmobile: lager legacy: Switch QSPI to named
 IRQs
In-Reply-To: <1391527445-14881-1-git-send-email-geert@linux-m68k.org>
References: <1391527445-14881-1-git-send-email-geert@linux-m68k.org>
Message-ID: <1391527445-14881-12-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
v2:
  - s/DEFINE_RES_IRQ/DEFINE_RES_IRQ_NAMED/
  - Rebased on top of renesas-devel-v3.14-rc1-20140204

 arch/arm/mach-shmobile/board-lager.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index fdcc868de1fa..3fe982b5ca87 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -293,7 +293,7 @@ static const struct spi_board_info spi_info[] __initconst = {
 /* QSPI resource */
 static const struct resource qspi_resources[] __initconst = {
 	DEFINE_RES_MEM(0xe6b10000, 0x1000),
-	DEFINE_RES_IRQ(gic_spi(184)),
+	DEFINE_RES_IRQ_NAMED(gic_spi(184), "mux"),
 };
 
 /* VIN */
-- 
1.7.9.5
