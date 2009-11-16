From: niej0001@gmail.com (Jun Nie)
Date: Mon, 16 Nov 2009 17:34:32 +0800
Subject: [PATCH 3/8] pxa: fix offset setting at initialization
Message-ID: <7c34ac520911160134t3e378b28q45c2a662fabfb8d0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jun Nie <njun@marvell.com>
Date: Tue, 10 Nov 2009 09:33:49 +0800
Subject: [PATCH] pxa: fix offset setting at initialization

Signed-off-by: Jun Nie <njun@marvell.com>
---
 drivers/video/pxa168fb.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/pxa168fb.c b/drivers/video/pxa168fb.c
index e728be3..6283c16 100644
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
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0003-pxa-fix-offset-setting-at-initialization.patch
Type: text/x-diff
Size: 740 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091116/4a5e4c00/attachment.bin>
