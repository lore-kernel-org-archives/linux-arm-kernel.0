From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Sat, 31 Jan 2015 17:29:46 +0800
Subject: [PATCH] [media] ir-hix5hd2: remove writel/readl_relaxed define
Message-ID: <1422696586-27411-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 9439eb3ab9d1ec ("asm-generic: io: implement relaxed
accessor macros as conditional wrappers") has added
{read,write}{b,w,l,q}_relaxed to include/asm-generic/io.h

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/media/rc/ir-hix5hd2.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/media/rc/ir-hix5hd2.c b/drivers/media/rc/ir-hix5hd2.c
index b0df62961c14..58ec5986274e 100644
--- a/drivers/media/rc/ir-hix5hd2.c
+++ b/drivers/media/rc/ir-hix5hd2.c
@@ -16,14 +16,6 @@
 #include <linux/regmap.h>
 #include <media/rc-core.h>
 
-/* Allow the driver to compile on all architectures */
-#ifndef writel_relaxed
-# define writel_relaxed writel
-#endif
-#ifndef readl_relaxed
-# define readl_relaxed readl
-#endif
-
 #define IR_ENABLE		0x00
 #define IR_CONFIG		0x04
 #define CNT_LEADS		0x08
-- 
1.9.1
