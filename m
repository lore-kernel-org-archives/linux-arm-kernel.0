From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 30 Oct 2013 20:42:09 +0000
Subject: [PATCH 3/6] imx-drm: hdmi: fix wrong comment
In-Reply-To: <20131030193622.GN16735@n2100.arm.linux.org.uk>
References: <20131030193622.GN16735@n2100.arm.linux.org.uk>
Message-ID: <E1Vbcaf-00062a-Am@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vsync active edge delay is in lines, not pixel clocks.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/imx-hdmi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-hdmi.c b/drivers/staging/imx-drm/imx-hdmi.c
index fe3a6779b620..0cba5d4a9966 100644
--- a/drivers/staging/imx-drm/imx-hdmi.c
+++ b/drivers/staging/imx-drm/imx-hdmi.c
@@ -1275,7 +1275,7 @@ static void hdmi_av_composer(struct imx_hdmi *hdmi,
 	hdmi_writeb(hdmi, hsync_len >> 8, HDMI_FC_HSYNCINWIDTH1);
 	hdmi_writeb(hdmi, hsync_len, HDMI_FC_HSYNCINWIDTH0);
 
-	/* Set up VSYNC active edge delay (in pixel clks) */
+	/* Set up VSYNC active edge delay (in lines) */
 	vsync_len = mode->vsync_end - mode->vsync_start;
 	hdmi_writeb(hdmi, vsync_len, HDMI_FC_VSYNCINWIDTH);
 }
-- 
1.7.4.4
