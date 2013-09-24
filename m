From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Tue, 24 Sep 2013 11:35:16 +0800
Subject: [PATCH RESEND] ARM: pxa: ssp: remove kfree for memory allocated with
 devm_kzalloc
Message-ID: <CAPgLHd9T5_auqA_4Ev_Qh6f_vZONqc8z6AcJVuV1S0VkFn4S_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

It's not necessary to free memory allocated with devm_kzalloc
and using kfree leads to a double free.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
Correct Mark's mail address
---
 arch/arm/plat-pxa/ssp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
index 3ea0290..528143e 100644
--- a/arch/arm/plat-pxa/ssp.c
+++ b/arch/arm/plat-pxa/ssp.c
@@ -250,7 +250,6 @@ static int pxa_ssp_remove(struct platform_device *pdev)
 	list_del(&ssp->node);
 	mutex_unlock(&ssp_lock);
 
-	kfree(ssp);
 	return 0;
 }
 
