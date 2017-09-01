From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri,  1 Sep 2017 11:36:32 +0200
Subject: [PATCH 2/7 v2] drm/pl111: Add all registers to debugfs
In-Reply-To: <20170901093637.4041-1-linus.walleij@linaro.org>
References: <20170901093637.4041-1-linus.walleij@linaro.org>
Message-ID: <20170901093637.4041-3-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds all the main control registers to the debugfs
register file. This was helpful for my debugging so it will
likely help others as well.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Collect Eric's ACK.
---
 drivers/gpu/drm/pl111/pl111_debugfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/pl111/pl111_debugfs.c b/drivers/gpu/drm/pl111/pl111_debugfs.c
index 0d9dee199b2c..7ddc7e3b9e7d 100644
--- a/drivers/gpu/drm/pl111/pl111_debugfs.c
+++ b/drivers/gpu/drm/pl111/pl111_debugfs.c
@@ -22,8 +22,14 @@ static const struct {
 	REGDEF(CLCD_TIM2),
 	REGDEF(CLCD_TIM3),
 	REGDEF(CLCD_UBAS),
+	REGDEF(CLCD_LBAS),
 	REGDEF(CLCD_PL111_CNTL),
 	REGDEF(CLCD_PL111_IENB),
+	REGDEF(CLCD_PL111_RIS),
+	REGDEF(CLCD_PL111_MIS),
+	REGDEF(CLCD_PL111_ICR),
+	REGDEF(CLCD_PL111_UCUR),
+	REGDEF(CLCD_PL111_LCUR),
 };
 
 int pl111_debugfs_regs(struct seq_file *m, void *unused)
-- 
2.13.5
