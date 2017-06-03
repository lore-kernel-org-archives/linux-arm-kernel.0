From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 3 Jun 2017 22:10:30 +0200
Subject: [PATCH 3/3] ARM: pxa: Delete an error message for a failed memory
 allocation in pxa3xx_u2d_probe()
In-Reply-To: <f50bf224-7fdc-f9ba-b73b-0b3c11df50dc@users.sourceforge.net>
References: <f50bf224-7fdc-f9ba-b73b-0b3c11df50dc@users.sourceforge.net>
Message-ID: <519a96e2-675c-5d46-f7d1-fc3146384206@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Jun 2017 21:46:26 +0200

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/mach-pxa/pxa3xx-ulpi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-pxa/pxa3xx-ulpi.c b/arch/arm/mach-pxa/pxa3xx-ulpi.c
index 13f9909ac8bf..60cb59a7ebd1 100644
--- a/arch/arm/mach-pxa/pxa3xx-ulpi.c
+++ b/arch/arm/mach-pxa/pxa3xx-ulpi.c
@@ -290,7 +290,5 @@ static int pxa3xx_u2d_probe(struct platform_device *pdev)
-	if (!u2d) {
-		dev_err(&pdev->dev, "failed to allocate memory\n");
+	if (!u2d)
 		return -ENOMEM;
-	}
 
 	u2d->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(u2d->clk)) {
-- 
2.13.0
