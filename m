From: mchehab@s-opensource.com (Mauro Carvalho Chehab)
Date: Fri, 14 Oct 2016 17:20:11 -0300
Subject: [PATCH 23/57] [media] exynos4-is: don't break long lines
In-Reply-To: <cover.1476475770.git.mchehab@s-opensource.com>
References: <cover.1476475770.git.mchehab@s-opensource.com>
Message-ID: <b46229c0703d42350a23b7fa661bd3a762d27930.1476475771.git.mchehab@s-opensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to the 80-cols checkpatch warnings, several strings
were broken into multiple lines. This is not considered
a good practice anymore, as it makes harder to grep for
strings at the source code. So, join those continuation
lines.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 drivers/media/platform/exynos4-is/media-dev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/platform/exynos4-is/media-dev.c b/drivers/media/platform/exynos4-is/media-dev.c
index 1a1154a9dfa4..e3a8709138fa 100644
--- a/drivers/media/platform/exynos4-is/media-dev.c
+++ b/drivers/media/platform/exynos4-is/media-dev.c
@@ -938,8 +938,7 @@ static int fimc_md_create_links(struct fimc_md *fmd)
 
 			csis = fmd->csis[pdata->mux_id].sd;
 			if (WARN(csis == NULL,
-				 "MIPI-CSI interface specified "
-				 "but s5p-csis module is not loaded!\n"))
+				 "MIPI-CSI interface specified but s5p-csis module is not loaded!\n"))
 				return -EINVAL;
 
 			pad = sensor->entity.num_pads - 1;
-- 
2.7.4
