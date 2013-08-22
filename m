From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Thu, 22 Aug 2013 10:35:13 +0800
Subject: [PATCH -next] ARM: pxa: ssp: remove kfree for memory allocated with
 devm_kzalloc
Message-ID: <CAPgLHd8N4G4b2LwFKBRWJi-_ay6FihPL2WXMh4W3+iwObRcJzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

It's not necessary to free memory allocated with devm_kzalloc
and using kfree leads to a double free.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/plat-pxa/ssp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
index c83f27b..d1230a8 100644
--- a/arch/arm/plat-pxa/ssp.c
+++ b/arch/arm/plat-pxa/ssp.c
@@ -240,7 +240,6 @@ static int pxa_ssp_remove(struct platform_device *pdev)
 	list_del(&ssp->node);
 	mutex_unlock(&ssp_lock);
 
-	kfree(ssp);
 	return 0;
 }
 
