From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 3 Dec 2016 18:02:31 +0100
Subject: [PATCH 2/2] ARM: mmp: Delete an unnecessary variable initialisation
 in sram_probe()
In-Reply-To: <b687577b-e664-6aa1-a85c-438e96216171@users.sourceforge.net>
References: <b687577b-e664-6aa1-a85c-438e96216171@users.sourceforge.net>
Message-ID: <d5679f55-fbed-5987-9daf-a8acb5be797f@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Dec 2016 17:38:21 +0100

The local variable "ret" will be set to an appropriate value a bit later.
Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/mach-mmp/sram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mmp/sram.c b/arch/arm/mach-mmp/sram.c
index 0fbfc2a42ab3..260e8309dfd3 100644
--- a/arch/arm/mach-mmp/sram.c
+++ b/arch/arm/mach-mmp/sram.c
@@ -66,7 +66,7 @@ static int sram_probe(struct platform_device *pdev)
 	struct sram_platdata *pdata = pdev->dev.platform_data;
 	struct sram_bank_info *info;
 	struct resource *res;
-	int ret = 0;
+	int ret;
 
 	if (!pdata || !pdata->pool_name)
 		return -ENODEV;
-- 
2.11.0
