From: rickard_strandqvist@spectrumdigital.se (Rickard Strandqvist)
Date: Sat,  5 Jul 2014 14:20:15 +0200
Subject: [PATCH] video: fbdev: exynos: s6e8ax0.c: Cleaning up variable that is
 never used
Message-ID: <1404562815-19356-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rickard Strandqvist <rickard.strandqvist@sonymobile.com>

Variable ar assigned a value that is never used.
I have also removed all the code that thereby serves no purpose.

This was found using a static code analysis program called cppcheck

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/video/fbdev/exynos/s6e8ax0.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/exynos/s6e8ax0.c b/drivers/video/fbdev/exynos/s6e8ax0.c
index 29e70ed..9bd67e7 100644
--- a/drivers/video/fbdev/exynos/s6e8ax0.c
+++ b/drivers/video/fbdev/exynos/s6e8ax0.c
@@ -602,11 +602,10 @@ static void s6e8ax0_acl_ctrl_set(struct s6e8ax0 *lcd)
 
 static void s6e8ax0_read_id(struct s6e8ax0 *lcd, u8 *mtp_id)
 {
-	unsigned int ret;
 	unsigned int addr = 0xd1;	/* MTP ID */
 	struct mipi_dsim_master_ops *ops = lcd_to_master_ops(lcd);
 
-	ret = ops->cmd_read(lcd_to_master(lcd),
+	ops->cmd_read(lcd_to_master(lcd),
 			MIPI_DSI_GENERIC_READ_REQUEST_1_PARAM,
 			addr, 3, mtp_id);
 }
-- 
1.7.10.4
