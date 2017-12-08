From: amery@hanoverdisplays.com (Alejandro Mery)
Date: Fri, 8 Dec 2017 10:35:58 +0000
Subject: [PATCH v3] ARM: davinci: fix mmc entries in dm365's dma_slave_map
Message-ID: <20171208103558.24494-1-amery@hanoverdisplays.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fix mmc entries in dm365's dma_slave_map to match the actual device names

Fixes: 0c750e1fe481 ("ARM: davinci: dm365: Add dma_slave_map to edma")
Signed-off-by: Alejandro Mery <amery@hanoverdisplays.com>
---

changes since v2:
* better patch description

 arch/arm/mach-davinci/dm365.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 103316f01a22..5ace9380626a 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -868,10 +868,10 @@ static const struct dma_slave_map dm365_edma_map[] = {
 	{ "spi_davinci.0", "rx", EDMA_FILTER_PARAM(0, 17) },
 	{ "spi_davinci.3", "tx", EDMA_FILTER_PARAM(0, 18) },
 	{ "spi_davinci.3", "rx", EDMA_FILTER_PARAM(0, 19) },
-	{ "dm6441-mmc.0", "rx", EDMA_FILTER_PARAM(0, 26) },
-	{ "dm6441-mmc.0", "tx", EDMA_FILTER_PARAM(0, 27) },
-	{ "dm6441-mmc.1", "rx", EDMA_FILTER_PARAM(0, 30) },
-	{ "dm6441-mmc.1", "tx", EDMA_FILTER_PARAM(0, 31) },
+	{ "da830-mmc.0", "rx", EDMA_FILTER_PARAM(0, 26) },
+	{ "da830-mmc.0", "tx", EDMA_FILTER_PARAM(0, 27) },
+	{ "da830-mmc.1", "rx", EDMA_FILTER_PARAM(0, 30) },
+	{ "da830-mmc.1", "tx", EDMA_FILTER_PARAM(0, 31) },
 };
 
 static struct edma_soc_info dm365_edma_pdata = {
-- 
2.15.0
