From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Wed, 28 Apr 2010 10:48:24 -0400
Subject: [PATCH] [ARM] mmp: update clock register function
Message-ID: <mailman.324.1272457073.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use clk_add_table in order to sync with clock driver.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-mmp/mmp2.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index 72eb9da..cca3992 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -101,7 +101,7 @@ static int __init mmp2_init(void)
 	if (cpu_is_mmp2()) {
 		mfp_init_base(MFPR_VIRT_BASE);
 		mfp_init_addr(mmp2_addr_map);
-		clks_register(ARRAY_AND_SIZE(mmp2_clkregs));
+		clkdev_add_table(ARRAY_AND_SIZE(mmp2_clkregs));
 	}

 	return 0;
-- 
1.5.6.5
