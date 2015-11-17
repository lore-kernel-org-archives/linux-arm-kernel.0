From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Nov 2015 16:45:01 +0100
Subject: [PATCH] drm/exynos: remove unused variables
In-Reply-To: <9569056.LBRz4v8fSj@wuerfel>
References: <9569056.LBRz4v8fSj@wuerfel>
Message-ID: <3867500.zoI62Joc47@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After a recent change, two variables were left unused:

exynos/exynos5433_drm_decon.c: In function 'decon_enable':
exynos/exynos5433_drm_decon.c:381:6: warning: unused variable 'i' [-Wunused-variable]
exynos/exynos5433_drm_decon.c:380:6: warning: unused variable 'ret' [-Wunused-variable]

This removes them too.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 186ba87a6e31 ("drm/exynos: add pm_runtime to DECON 5433")

diff --git a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
index edfd6e390ef7..2ac1d4d14368 100644
--- a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
@@ -377,8 +377,6 @@ static void decon_swreset(struct decon_context *ctx)
 static void decon_enable(struct exynos_drm_crtc *crtc)
 {
 	struct decon_context *ctx = crtc->ctx;
-	int ret;
-	int i;
 
 	if (!test_and_clear_bit(BIT_SUSPENDED, &ctx->flags))
 		return;
