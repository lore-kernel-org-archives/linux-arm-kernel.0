From: andrzej.p@samsung.com (Andrzej Pietrasiewicz)
Date: Tue, 08 Aug 2017 13:27:07 +0200
Subject: [PATCH 4/5] media: platform: s5p-jpeg: fix number of components macro
In-Reply-To: <1502191628-11958-1-git-send-email-andrzej.p@samsung.com>
References: <1502191352-11595-1-git-send-email-andrzej.p@samsung.com>
 <1502191628-11958-1-git-send-email-andrzej.p@samsung.com>
 <CGME20170808112716eucas1p10a5069ad7ddad2eae5b8dca4f466feee@eucas1p1.samsung.com>
Message-ID: <1502191628-11958-4-git-send-email-andrzej.p@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The value to be processed must be first masked and then shifted,
not the other way round.

Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
---
 drivers/media/platform/s5p-jpeg/jpeg-regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/s5p-jpeg/jpeg-regs.h b/drivers/media/platform/s5p-jpeg/jpeg-regs.h
index 1870400..df790b1 100644
--- a/drivers/media/platform/s5p-jpeg/jpeg-regs.h
+++ b/drivers/media/platform/s5p-jpeg/jpeg-regs.h
@@ -371,7 +371,7 @@
 #define EXYNOS4_NF_SHIFT			16
 #define EXYNOS4_NF_MASK				0xff
 #define EXYNOS4_NF(x)				\
-	(((x) << EXYNOS4_NF_SHIFT) & EXYNOS4_NF_MASK)
+	(((x) & EXYNOS4_NF_MASK) << EXYNOS4_NF_SHIFT)
 
 /* JPEG quantizer table register */
 #define EXYNOS4_QTBL_CONTENT(n)	(0x100 + (n) * 0x40)
-- 
1.9.1
