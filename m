From: hzhuang1@marvell.com (Haojian Zhuang)
Date: Wed, 25 Aug 2010 20:53:56 -0700
Subject: [PATCH] pxa168fb: Fix section mismatch
In-Reply-To: <1282794717-27728-1-git-send-email-marek.vasut@gmail.com>
References: <1282794717-27728-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <25B60CDC2F704E4E9D88FFD52780CB4C0598176EBB@SC-VEXCH1.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


-----Original Message-----
From: Marek Vasut [mailto:marek.vasut at gmail.com] 
Sent: 2010?8?26? 11:52 AM
To: linux-arm-kernel at lists.infradead.org
Cc: Haojian Zhuang; mark.brown314 at gmail.com; eric.y.miao at gmail.com; Marek Vasut
Subject: [PATCH] pxa168fb: Fix section mismatch

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 drivers/video/pxa168fb.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/pxa168fb.c b/drivers/video/pxa168fb.c
index c91a7f7..5d786bd 100644
--- a/drivers/video/pxa168fb.c
+++ b/drivers/video/pxa168fb.c
@@ -559,7 +559,7 @@ static struct fb_ops pxa168fb_ops = {
 	.fb_imageblit	= cfb_imageblit,
 };
 
-static int __init pxa168fb_init_mode(struct fb_info *info,
+static int __devinit pxa168fb_init_mode(struct fb_info *info,
 			      struct pxa168fb_mach_info *mi)
 {
 	struct pxa168fb_info *fbi = info->par;
@@ -599,7 +599,7 @@ static int __init pxa168fb_init_mode(struct fb_info *info,
 	return ret;
 }
 
-static int __init pxa168fb_probe(struct platform_device *pdev)
+static int __devinit pxa168fb_probe(struct platform_device *pdev)
 {
 	struct pxa168fb_mach_info *mi;
 	struct fb_info *info = 0;
@@ -792,7 +792,7 @@ static struct platform_driver pxa168fb_driver = {
 	.probe		= pxa168fb_probe,
 };
 
-static int __devinit pxa168fb_init(void)
+static int __init pxa168fb_init(void)
 {
 	return platform_driver_register(&pxa168fb_driver);
 }
-- 
1.7.1

I'm fine on this patch. Acked.
