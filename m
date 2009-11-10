From: njun@marvell.com (Jun Nie)
Date: Tue, 10 Nov 2009 09:33:49 +0800
Subject: [PATCH] pxa: fix offset setting at initialization
Message-ID: <mailman.7.1257840742.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jun Nie <njun@marvell.com>
---
 drivers/video/pxa168fb.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/pxa168fb.c b/drivers/video/pxa168fb.c
index 50f72e9..55c69a1 100644
--- a/drivers/video/pxa168fb.c
+++ b/drivers/video/pxa168fb.c
@@ -765,6 +765,7 @@ static int __init pxa168fb_probe(struct
platform_device *pdev)
 	}

 	info->fix.smem_start = (unsigned long)fbi->fb_start_dma;
+	set_graphics_start(info, 0, 0);

 	/*
 	 * Set video mode according to platform data.
-- 
1.5.4.3
