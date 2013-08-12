From: zonque@gmail.com (Daniel Mack)
Date: Mon, 12 Aug 2013 10:37:14 +0200
Subject: [PATCH 1/5] ARM: pxa: ssp: remove unnecessary warning on kzalloc()
 failure
In-Reply-To: <1376296638-19804-1-git-send-email-zonque@gmail.com>
References: <1376296638-19804-1-git-send-email-zonque@gmail.com>
Message-ID: <1376296638-19804-2-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The memory subsystem will already complain loudly enough in such cases.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 arch/arm/plat-pxa/ssp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
index 8e11e96..f746b6a 100644
--- a/arch/arm/plat-pxa/ssp.c
+++ b/arch/arm/plat-pxa/ssp.c
@@ -80,10 +80,9 @@ static int pxa_ssp_probe(struct platform_device *pdev)
 	int ret = 0;
 
 	ssp = kzalloc(sizeof(struct ssp_device), GFP_KERNEL);
-	if (ssp == NULL) {
-		dev_err(&pdev->dev, "failed to allocate memory");
+	if (ssp == NULL)
 		return -ENOMEM;
-	}
+
 	ssp->pdev = pdev;
 
 	ssp->clk = clk_get(&pdev->dev, NULL);
-- 
1.8.3.1
