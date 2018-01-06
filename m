From: colin.king@canonical.com (Colin King)
Date: Sat,  6 Jan 2018 16:03:27 +0000
Subject: [PATCH] [media] exynos4-is: make array 'cmd' static,
 shrinks object size
Message-ID: <20180106160327.17961-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the const read-only array 'cmd' on the stack but instead
make it static. Makes the object code smaller by 38 bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
   4950	    868	      0	   5818	   16ba	fimc-is-regs.o

After:
   text	   data	    bss	    dec	    hex	filename
   4824	    956	      0	   5780	   1694	fimc-is-regs.o

(gcc version 7.2.0 x86_64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/media/platform/exynos4-is/fimc-is-regs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/exynos4-is/fimc-is-regs.c b/drivers/media/platform/exynos4-is/fimc-is-regs.c
index cfe4406a83ff..e0e291066037 100644
--- a/drivers/media/platform/exynos4-is/fimc-is-regs.c
+++ b/drivers/media/platform/exynos4-is/fimc-is-regs.c
@@ -159,7 +159,7 @@ void fimc_is_hw_load_setfile(struct fimc_is *is)
 
 int fimc_is_hw_change_mode(struct fimc_is *is)
 {
-	const u8 cmd[] = {
+	static const u8 cmd[] = {
 		HIC_PREVIEW_STILL, HIC_PREVIEW_VIDEO,
 		HIC_CAPTURE_STILL, HIC_CAPTURE_VIDEO,
 	};
-- 
2.15.1
