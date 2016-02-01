From: mkarthi3@visteon.com (Mutharaju, Prasanna (P.))
Date: Mon, 1 Feb 2016 09:58:59 +0000
Subject: [PATCH] ARM: davinci: Use PTR_ERR_OR_ZERO at the end of
 dm646x_init_edma
Message-ID: <20160201095736.GA6255@jci-VirtualBox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Making use of PTR_ERR_OR_ZERO helper function

Signed-off-by: Prasanna Karthik <mkarthi3@visteon.com>
---
 arch/arm/mach-davinci/dm646x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 70eb427..9984632 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -938,7 +938,7 @@ int __init dm646x_init_edma(struct edma_rsv_info *rsv)
 	dm646x_edma_pdata.rsv = rsv;
 
 	edma_pdev = platform_device_register_full(&dm646x_edma_device);
-	return IS_ERR(edma_pdev) ? PTR_ERR(edma_pdev) : 0;
+	return PTR_ERR_OR_ZERO(edma_pdev);
 }
 
 void __init dm646x_init(void)
-- 
1.9.1
