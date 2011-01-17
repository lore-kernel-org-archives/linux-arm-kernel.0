From: axel.lin@gmail.com (Axel Lin)
Date: Mon, 17 Jan 2011 16:33:42 +0800
Subject: [PATCH 2/2] video: nuc900fb: properly free resources in
	nuc900fb_remove
In-Reply-To: <1295253143.12890.3.camel@mola>
References: <1295253143.12890.3.camel@mola>
Message-ID: <1295253222.12890.4.camel@mola>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From f0064467b1f9696ebcade98ec75ef3fbc6cfe38f Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@gmail.com>
Date: Mon, 17 Jan 2011 16:25:57 +0800
Subject: [PATCH 2/2] video: nuc900fb: properly free resources in nuc900fb_remove

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/video/nuc900fb.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/video/nuc900fb.c b/drivers/video/nuc900fb.c
index 29ef92f..f838d9e 100644
--- a/drivers/video/nuc900fb.c
+++ b/drivers/video/nuc900fb.c
@@ -696,6 +696,8 @@ static int nuc900fb_remove(struct platform_device *pdev)
 	nuc900fb_stop_lcd(fbinfo);
 	msleep(1);
 
+	unregister_framebuffer(fbinfo);
+	nuc900fb_cpufreq_deregister(fbi);
 	nuc900fb_unmap_video_memory(fbinfo);
 
 	iounmap(fbi->io);
-- 
1.7.2
