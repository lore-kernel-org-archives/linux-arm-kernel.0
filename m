From: pkarthik@intrinsyc.com (Prasanna Karthik)
Date: Thu, 28 Apr 2016 21:22:55 +0000
Subject: [PATCH] ARM: davinci: dm646x: Make use of PTR_ERR_OR_ZERO
Message-ID: <20160428212256.GA25520@prasanna-ubuntu.itc.intrinsyc.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using PTR_ERR_OR_ZERO instead of explicit Conditional operation

Signed-off-by: Prasanna Karthik <pkarthik@intrinsyc.com>
---
 arch/arm/mach-davinci/dm646x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index a43db0f..9a5faaf1 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -949,7 +949,7 @@ int __init dm646x_init_edma(struct edma_rsv_info *rsv)
 	dm646x_edma_pdata.rsv = rsv;
 
 	edma_pdev = platform_device_register_full(&dm646x_edma_device);
-	return IS_ERR(edma_pdev) ? PTR_ERR(edma_pdev) : 0;
+	return PTR_ERR_OR_ZERO(edma_pdev);
 }
 
 void __init dm646x_init(void)
-- 
1.9.1
