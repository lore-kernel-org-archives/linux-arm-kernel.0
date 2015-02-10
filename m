From: ykk@rock-chips.com (Yakir Yang)
Date: Tue, 10 Feb 2015 22:17:25 +0800
Subject: [RFC PATCH 1/3] drm: bridge/dw_hdmi: fixed codec style
In-Reply-To: <1423577791-19238-1-git-send-email-ykk@rock-chips.com>
References: <1423577791-19238-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1423577845-19301-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- const struct dw_hdmi_mpll_config *mpll_config =
-                                        hdmi->plat_data->mpll_cfg;
- const struct dw_hdmi_curr_ctrl *curr_ctrl = hdmi->plat_data->cur_ctr;
- const struct dw_hdmi_sym_term *sym_term =  hdmi->plat_data->sym_term;

+ const struct dw_hdmi_plat_data *plat_data = hdmi->plat_data;
+ const struct dw_hdmi_mpll_config *mpll_config = plat_data->mpll_cfg;
+ const struct dw_hdmi_curr_ctrl *curr_ctrl = plat_data->cur_ctr;
+ const struct dw_hdmi_sym_term *sym_term =  plat_data->sym_term;

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---

 drivers/gpu/drm/bridge/dw_hdmi.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index 14c61ee..8b3208c 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -761,10 +761,10 @@ static int hdmi_phy_configure(struct dw_hdmi *hdmi, unsigned char prep,
 {
 	unsigned res_idx, i;
 	u8 val, msec;
-	const struct dw_hdmi_mpll_config *mpll_config =
-						hdmi->plat_data->mpll_cfg;
-	const struct dw_hdmi_curr_ctrl *curr_ctrl = hdmi->plat_data->cur_ctr;
-	const struct dw_hdmi_sym_term *sym_term =  hdmi->plat_data->sym_term;
+	const struct dw_hdmi_plat_data *plat_data = hdmi->plat_data;
+	const struct dw_hdmi_mpll_config *mpll_config = plat_data->mpll_cfg;
+	const struct dw_hdmi_curr_ctrl *curr_ctrl = plat_data->cur_ctr;
+	const struct dw_hdmi_sym_term *sym_term =  plat_data->sym_term;
 
 	if (prep)
 		return -EINVAL;
-- 
1.7.9.5
