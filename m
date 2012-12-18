From: linux@prisktech.co.nz (Tony Prisk)
Date: Wed, 19 Dec 2012 06:34:07 +1300
Subject: [PATCH RESEND 5/6] clk: s5p-fimc: Fix incorrect usage of
 IS_ERR_OR_NULL
In-Reply-To: <1355852048-23188-1-git-send-email-linux@prisktech.co.nz>
References: <1355852048-23188-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <1355852048-23188-6-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Resend to include mailing lists.

Replace IS_ERR_OR_NULL with IS_ERR on clk_get results.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
CC: Kyungmin Park <kyungmin.park@samsung.com>
CC: Tomasz Stanislawski <t.stanislaws@samsung.com>
CC: linux-media at vger.kernel.org
---
 drivers/media/platform/s5p-fimc/fimc-mdevice.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/s5p-fimc/fimc-mdevice.c b/drivers/media/platform/s5p-fimc/fimc-mdevice.c
index 0531ab7..3ac4da2 100644
--- a/drivers/media/platform/s5p-fimc/fimc-mdevice.c
+++ b/drivers/media/platform/s5p-fimc/fimc-mdevice.c
@@ -730,7 +730,7 @@ static int fimc_md_get_clocks(struct fimc_md *fmd)
 	for (i = 0; i < FIMC_MAX_CAMCLKS; i++) {
 		snprintf(clk_name, sizeof(clk_name), "sclk_cam%u", i);
 		clock = clk_get(NULL, clk_name);
-		if (IS_ERR_OR_NULL(clock)) {
+		if (IS_ERR(clock)) {
 			v4l2_err(&fmd->v4l2_dev, "Failed to get clock: %s",
 				  clk_name);
 			return -ENXIO;
-- 
1.7.9.5
