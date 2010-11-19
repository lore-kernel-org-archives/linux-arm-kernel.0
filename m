From: inki.dae@samsung.com (Inki Dae)
Date: Fri, 19 Nov 2010 10:29:24 +0900
Subject: [PATCH 1/3] FB: added a structure for CPU interface to linux/fb.h
In-Reply-To: <>
References: <>
Message-ID: <1290130164-7835-1-git-send-email-inki.dae@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

FB: added a structure for CPU interface to linux/fb.h

RGB or CPU interfaces could be used as display mode but framebuffer
framework doesn't consider CPU interface so I added this structure
because fb_cpumode structure could be used commonly.

Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 include/linux/fb.h |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index 7fca3dc..9b9842c 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -1147,6 +1147,18 @@ struct fb_videomode {
 	u32 flag;
 };
 
+struct fb_cpumode {
+	const char *name;	/* optional */
+	u32 refresh;		/* optional */
+	u32 xres;
+	u32 yres;
+	u32 pixclock;
+	u32 cs_setup;
+	u32 wr_setup;
+	u32 wr_act;
+	u32 wr_hold;
+};
+
 extern const char *fb_mode_option;
 extern const struct fb_videomode vesa_modes[];
 
-- 
1.5.4.3
