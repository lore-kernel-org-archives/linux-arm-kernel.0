From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 21 Jun 2016 11:20:31 +0100
Subject: [[PATCH v2] 10/11] [V2] memory: samsung: endian fixes for IO
In-Reply-To: <1466504432-24187-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1466504432-24187-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1466504432-24187-11-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the relaxed versions of the IO accessors to avoid any issues
if running in big endian.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
V1..V2: Fix indentation changes
---
Cc: Pavel Fedin <p.fedin@samsung.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Pankaj Dubey <pankaj.dubey@samsung.com>
Cc: linux-arm-kernel at lists.codethink.co.uk
---
 drivers/memory/samsung/exynos-srom.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/memory/samsung/exynos-srom.c b/drivers/memory/samsung/exynos-srom.c
index 96756fb..5714bdf 100644
--- a/drivers/memory/samsung/exynos-srom.c
+++ b/drivers/memory/samsung/exynos-srom.c
@@ -91,17 +91,17 @@ static int exynos_srom_configure_bank(struct exynos_srom *srom,
 	if (width == 2)
 		cs |= 1 << EXYNOS_SROM_BW__DATAWIDTH__SHIFT;
 
-	bw = __raw_readl(srom->reg_base + EXYNOS_SROM_BW);
+	bw = readl_relaxed(srom->reg_base + EXYNOS_SROM_BW);
 	bw = (bw & ~(EXYNOS_SROM_BW__CS_MASK << bank)) | (cs << bank);
-	__raw_writel(bw, srom->reg_base + EXYNOS_SROM_BW);
-
-	__raw_writel(pmc | (timing[0] << EXYNOS_SROM_BCX__TACP__SHIFT) |
-		    (timing[1] << EXYNOS_SROM_BCX__TCAH__SHIFT) |
-		    (timing[2] << EXYNOS_SROM_BCX__TCOH__SHIFT) |
-		    (timing[3] << EXYNOS_SROM_BCX__TACC__SHIFT) |
-		    (timing[4] << EXYNOS_SROM_BCX__TCOS__SHIFT) |
-		    (timing[5] << EXYNOS_SROM_BCX__TACS__SHIFT),
-		    srom->reg_base + EXYNOS_SROM_BC0 + bank);
+	writel_relaxed(bw, srom->reg_base + EXYNOS_SROM_BW);
+
+	writel_relaxed(pmc | (timing[0] << EXYNOS_SROM_BCX__TACP__SHIFT) |
+		       (timing[1] << EXYNOS_SROM_BCX__TCAH__SHIFT) |
+		       (timing[2] << EXYNOS_SROM_BCX__TCOH__SHIFT) |
+		       (timing[3] << EXYNOS_SROM_BCX__TACC__SHIFT) |
+		       (timing[4] << EXYNOS_SROM_BCX__TCOS__SHIFT) |
+		       (timing[5] << EXYNOS_SROM_BCX__TACS__SHIFT),
+		       srom->reg_base + EXYNOS_SROM_BC0 + bank);
 
 	return 0;
 }
-- 
2.8.1
