From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:29:48 +0900
Subject: [PATCH 07/33] ARM: shmobile: r8a73a4: don't use named irq for
 DMAEngine
In-Reply-To: <cover.1386897180.git.horms+renesas@verge.net.au>
References: <cover.1386897180.git.horms+renesas@verge.net.au>
Message-ID: <1a936a38561b6b12c5075f704d97688ae56ceb05.1386897180.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

sh-dma-engine driver doesn't care irq name.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a73a4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c b/arch/arm/mach-shmobile/setup-r8a73a4.c
index b0f2749..cc94b64 100644
--- a/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
@@ -275,7 +275,7 @@ static const struct sh_dmae_pdata dma_pdata = {
 
 static struct resource dma_resources[] = {
 	DEFINE_RES_MEM(0xe6700020, 0x89e0),
-	DEFINE_RES_IRQ_NAMED(gic_spi(220), "error_irq"),
+	DEFINE_RES_IRQ(gic_spi(220)),
 	{
 		/* IRQ for channels 0-19 */
 		.start  = gic_spi(200),
-- 
1.8.4
