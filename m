From: mchehab@redhat.com (Mauro Carvalho Chehab)
Date: Wed, 11 Apr 2012 02:38:16 +0200
Subject: [git:v4l-dvb/for_v3.5] [media] s5p-tv: mark const init data with
 __initconst instead of __initdata
Message-ID: <E1SKVVd-0007xf-Up@www.linuxtv.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is an automatic generated email to let you know that the following patch were queued at the 
http://git.linuxtv.org/media_tree.git tree:

Subject: [media] s5p-tv: mark const init data with __initconst instead of __initdata
Author:  Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Date:    Fri Mar 30 16:05:03 2012 -0300

As long as there is no other non-const variable marked __initdata in the
same compilation unit it doesn't hurt. If there were one however
compilation would fail with

	error: $variablename causes a section type conflict

because a section containing const variables is marked read only and so
cannot contain non-const variables.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Tomasz Stanislawski <t.stanislaws@samsung.com>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-media at vger.kernel.org
Signed-off-by: Mauro Carvalho Chehab <mchehab@redhat.com>

 drivers/media/video/s5p-tv/mixer_drv.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

---

http://git.linuxtv.org/media_tree.git?a=commitdiff;h=f9d1ae81dc9abfa7e6a2128989cca35a9bdea57b

diff --git a/drivers/media/video/s5p-tv/mixer_drv.c b/drivers/media/video/s5p-tv/mixer_drv.c
index a2c0c25..edca065 100644
--- a/drivers/media/video/s5p-tv/mixer_drv.c
+++ b/drivers/media/video/s5p-tv/mixer_drv.c
@@ -461,7 +461,7 @@ static struct platform_driver mxr_driver __refdata = {
 static int __init mxr_init(void)
 {
 	int i, ret;
-	static const char banner[] __initdata = KERN_INFO
+	static const char banner[] __initconst = KERN_INFO
 		"Samsung TV Mixer driver, "
 		"(c) 2010-2011 Samsung Electronics Co., Ltd.\n";
 	printk(banner);
