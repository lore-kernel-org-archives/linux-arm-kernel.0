From: ykk@rock-chips.com (Yakir Yang)
Date: Tue, 10 Feb 2015 22:18:22 +0800
Subject: [RFC PATCH 2/3] drm: bridge/dw_hdmi_rockchip: improve hdmi
 eye-diagram test
In-Reply-To: <1423577791-19238-1-git-send-email-ykk@rock-chips.com>
References: <1423577791-19238-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1423577902-19357-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As for 1920x1080 display resolution, we should turn on the Transmitter
Trailer-B, and adjust slopeboost to 25%-35% decrease.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---

 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index e46e1d9..51030ca 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -142,7 +142,7 @@ static const struct dw_hdmi_curr_ctrl rockchip_cur_ctr[] = {
 static const struct dw_hdmi_sym_term rockchip_sym_term[] = {
 	/*pixelclk   symbol   term*/
 	{ 74250000,  0x8009, 0x0004 },
-	{ 148500000, 0x8029, 0x0004 },
+	{ 148500000, 0x803b, 0x0004 },
 	{ 297000000, 0x8039, 0x0005 },
 	{ ~0UL,	     0x0000, 0x0000 }
 };
-- 
1.7.9.5
