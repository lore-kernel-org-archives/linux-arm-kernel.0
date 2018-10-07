From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Sun,  7 Oct 2018 11:38:51 +0200
Subject: [PATCH v2 15/29] drm/bridge/synopsys: dw-hdmi: Enable workaround for
 v2.12a
In-Reply-To: <20181007093905.11253-1-jernej.skrabec@siol.net>
References: <20181007093905.11253-1-jernej.skrabec@siol.net>
Message-ID: <20181007093905.11253-16-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It turns out that even new DW HDMI controllers exhibits same magenta
line issues as older versions.

Enable workaround for v2.12a.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 5971976284bf..df1c7a2d6961 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -1664,6 +1664,7 @@ static void dw_hdmi_clear_overflow(struct dw_hdmi *hdmi)
 	case 0x131a:
 	case 0x132a:
 	case 0x201a:
+	case 0x212a:
 		count = 1;
 		break;
 	default:
-- 
2.19.0
