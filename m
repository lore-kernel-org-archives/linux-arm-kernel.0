From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 16 Nov 2015 22:26:32 +0100
Subject: [PATCH 3/3] ste_dma40: Delete an unnecessary variable initialisation
 in d40_probe()
In-Reply-To: <564A4899.8040109@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net> <564A4899.8040109@users.sourceforge.net>
Message-ID: <564A4A08.5000705@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 16 Nov 2015 22:00:28 +0100

The variable "res" will eventually be set to a resource pointer from
a call of the d40_hw_detect_init(() function.
Thus let us omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/dma/ste_dma40.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 8ebfde1..6fb8307 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3544,7 +3544,7 @@ static int __init d40_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	int ret = -ENOENT;
 	struct d40_base *base;
-	struct resource *res = NULL;
+	struct resource *res;
 	int num_reserved_chans;
 	u32 val;
 
-- 
2.6.2
