From: yliu.null@gmail.com (Yuanhan Liu)
Date: Wed,  8 Aug 2012 17:02:08 +0800
Subject: [PATCH] ARM: mmp: fix potential NULL dereference
Message-ID: <1344416528-3586-1-git-send-email-yliu.null@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the wrong logic: we should use || instead of &&

Cc: Leo Yan <leoy@marvell.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
Signed-off-by: Yuanhan Liu <yliu.null@gmail.com>
---
 arch/arm/mach-mmp/sram.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mmp/sram.c b/arch/arm/mach-mmp/sram.c
index 4304f95..7e8a5a2 100644
--- a/arch/arm/mach-mmp/sram.c
+++ b/arch/arm/mach-mmp/sram.c
@@ -68,7 +68,7 @@ static int __devinit sram_probe(struct platform_device *pdev)
 	struct resource *res;
 	int ret = 0;
 
-	if (!pdata && !pdata->pool_name)
+	if (!pdata || !pdata->pool_name)
 		return -ENODEV;
 
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
-- 
1.7.4.4
