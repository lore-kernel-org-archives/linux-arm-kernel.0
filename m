From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu,  2 Jun 2016 10:20:10 -0400
Subject: [PATCH] drm/exynos: don't use HW trigger for Exynos5420/5422/5800
Message-ID: <1464877210-27207-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit a6f75aa161c5 ("drm/exynos: fimd: add HW trigger support") added
hardware trigger support to the FIMD controller driver. But this broke
the display in at least the Exynos5800 Peach Pi Chromebook.

So until the issue is fixed, avoid using HW trigger for the Exynos5420
based boards and use SW trigger as it was before the mentioned commit.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

Hello Inki,

Since commit a6f75aa161c5 landed in v4.7-rc1, I think $SUBJECT should be
picked to make sure that v4.7 is released with the display working for
the Exynos5420 based Chromebooks.

We can then figure out what's wrong with the HW trigger support and fix
it for v4.8.

Best regards,
Javier

 drivers/gpu/drm/exynos/exynos_drm_fimd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
index 1c23a8ff5e83..f10030ff00e6 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
@@ -170,14 +170,11 @@ static struct fimd_driver_data exynos5420_fimd_driver_data = {
 	.lcdblk_vt_shift = 24,
 	.lcdblk_bypass_shift = 15,
 	.lcdblk_mic_bypass_shift = 11,
-	.trg_type = I80_HW_TRG,
 	.has_shadowcon = 1,
 	.has_vidoutcon = 1,
 	.has_vtsel = 1,
 	.has_mic_bypass = 1,
 	.has_dp_clk = 1,
-	.has_hw_trigger = 1,
-	.has_trigger_per_te = 1,
 };
 
 struct fimd_context {
-- 
2.5.5
