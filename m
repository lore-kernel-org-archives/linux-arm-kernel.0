From: niej0001@gmail.com (Jun Nie)
Date: Mon, 16 Nov 2009 17:34:45 +0800
Subject: [PATCH 5/8] pxa: frame buffer support both pxa168 and pxa910
Message-ID: <7c34ac520911160134m16d33fa6p6c43ff2b273e916f@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jun Nie <njun@marvell.com>
Date: Tue, 10 Nov 2009 09:43:57 +0800
Subject: [PATCH] pxa: frame buffer support both pxa168 and pxa910

Signed-off-by: Jun Nie <njun@marvell.com>
---
 drivers/video/pxa168fb.c |    6 ++++++
 include/video/pxa168fb.h |    3 +++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/video/pxa168fb.c b/drivers/video/pxa168fb.c
index 6283c16..09ada72 100644
--- a/drivers/video/pxa168fb.c
+++ b/drivers/video/pxa168fb.c
@@ -882,12 +882,18 @@ failed:
 	return ret;
 }

+ static const struct platform_device_id mmpfb_id_table[] = {
+	 {"pxa168-fb", PXA168_FB},
+	 {"pxa910-fb", PXA910_FB},
+ };
+
 static struct platform_driver pxa168fb_driver = {
 	.driver		= {
 		.name	= "pxa168-fb",
 		.owner	= THIS_MODULE,
 	},
 	.probe		= pxa168fb_probe,
+	.id_table	= mmpfb_id_table,
 };

 static int __devinit pxa168fb_init(void)
diff --git a/include/video/pxa168fb.h b/include/video/pxa168fb.h
index 53919fe..da83c94 100644
--- a/include/video/pxa168fb.h
+++ b/include/video/pxa168fb.h
@@ -87,6 +87,9 @@
 #define PIX_FMT_PSEUDOCOLOR	20
 #define PIX_FMT_UYVY422PACK	(0x1000|PIX_FMT_YUV422PACK)

+#define PXA168_FB 0x0168
+#define PXA910_FB 0x0910
+
 /*
  * PXA LCD controller private state.
  */
-- 
1.5.4.3
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0005-pxa-frame-buffer-support-both-pxa168-and-pxa910.patch
Type: text/x-diff
Size: 1321 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091116/0b5a9b17/attachment.bin>
