From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Oct 2015 15:08:46 +0200
Subject: [PATCH 03/10] mtd: afs: break out v1 footer magic to a define
In-Reply-To: <1444914533-27782-1-git-send-email-linus.walleij@linaro.org>
References: <1444914533-27782-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1444914533-27782-4-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Break out the magic number to a #defined constant.

Cc: Ryan Harkin <ryan.harkin@linaro.org>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mtd/afs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/afs.c b/drivers/mtd/afs.c
index 9af00528586f..d09280ae12bd 100644
--- a/drivers/mtd/afs.c
+++ b/drivers/mtd/afs.c
@@ -34,6 +34,8 @@
 #include <linux/mtd/map.h>
 #include <linux/mtd/partitions.h>
 
+#define AFSV1_FOOTER_MAGIC 0xA0FFFF9F
+
 struct footer_v1 {
 	u32 image_info_base;	/* Address of first word of ImageFooter  */
 	u32 image_start;	/* Start of area reserved by this footer */
@@ -90,7 +92,7 @@ afs_read_footer_v1(struct mtd_info *mtd, u_int *img_start, u_int *iis_start,
 	/*
 	 * Does it contain the magic number?
 	 */
-	if (fs.signature != 0xa0ffff9f)
+	if (fs.signature != AFSV1_FOOTER_MAGIC)
 		ret = 0;
 
 	/*
-- 
2.4.3
