From: bhumirks@gmail.com (Bhumika Goyal)
Date: Wed, 21 Jun 2017 12:01:09 +0530
Subject: [PATCH v2 2/2] drm/sun4i: add const to drm_encoder_helper_funcs
 structures
In-Reply-To: <1498026670-10671-1-git-send-email-bhumirks@gmail.com>
References: <1498026670-10671-1-git-send-email-bhumirks@gmail.com>
Message-ID: <1498026670-10671-2-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add const to drm_encoder_helper_funcs structures as they are only passed
as an argument to the function drm_encoder_helper_add and this argument
is of type const. So, add const to these structures.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
Changes in v2 -
* No change

 drivers/gpu/drm/sun4i/sun4i_rgb.c | 2 +-
 drivers/gpu/drm/sun4i/sun4i_tv.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
index 422b191..67847d2 100644
--- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -181,7 +181,7 @@ static void sun4i_rgb_encoder_mode_set(struct drm_encoder *encoder,
 	clk_set_phase(tcon->dclk, 120);
 }
 
-static struct drm_encoder_helper_funcs sun4i_rgb_enc_helper_funcs = {
+static const struct drm_encoder_helper_funcs sun4i_rgb_enc_helper_funcs = {
 	.atomic_check	= sun4i_rgb_atomic_check,
 	.mode_set	= sun4i_rgb_encoder_mode_set,
 	.disable	= sun4i_rgb_encoder_disable,
diff --git a/drivers/gpu/drm/sun4i/sun4i_tv.c b/drivers/gpu/drm/sun4i/sun4i_tv.c
index 338b9e5..b20f97a 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tv.c
@@ -488,7 +488,7 @@ static void sun4i_tv_mode_set(struct drm_encoder *encoder,
 	regmap_write(tv->regs, SUN4I_TVE_SLAVE_REG, 0);
 }
 
-static struct drm_encoder_helper_funcs sun4i_tv_helper_funcs = {
+static const struct drm_encoder_helper_funcs sun4i_tv_helper_funcs = {
 	.atomic_check	= sun4i_tv_atomic_check,
 	.disable	= sun4i_tv_disable,
 	.enable		= sun4i_tv_enable,
-- 
2.7.4
