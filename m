From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Tue, 18 Jan 2011 09:52:40 +0200
Subject: [PATCH 2/7] arm: mach-omap1: board-h2: make h2_nand_platdata static
In-Reply-To: <1295337165-22934-1-git-send-email-aaro.koskinen@iki.fi>
References: <1295337165-22934-1-git-send-email-aaro.koskinen@iki.fi>
Message-ID: <1295337165-22934-3-git-send-email-aaro.koskinen@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eliminates the following sparse warning:

	arch/arm/mach-omap1/board-h2.c:205:27: warning: symbol 'h2_nand_platdata' was not declared. Should it be static?

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/mach-omap1/board-h2.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index 28b84aa..ba3bd09 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -202,7 +202,7 @@ static int h2_nand_dev_ready(struct mtd_info *mtd)
 
 static const char *h2_part_probes[] = { "cmdlinepart", NULL };
 
-struct platform_nand_data h2_nand_platdata = {
+static struct platform_nand_data h2_nand_platdata = {
 	.chip	= {
 		.nr_chips		= 1,
 		.chip_offset		= 0,
-- 
1.5.6.5
