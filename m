From: t.stanislaws@samsung.com (Tomasz Stanislawski)
Date: Mon, 16 Apr 2012 15:58:55 +0200
Subject: [PATCHv2 8/8] media/video/s5p-tv: mark const init data with
 __initconst instead of __initdata
In-Reply-To: <1334584735-12439-1-git-send-email-t.stanislaws@samsung.com>
References: <1334584735-12439-1-git-send-email-t.stanislaws@samsung.com>
Message-ID: <1334584735-12439-9-git-send-email-t.stanislaws@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

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
---
 drivers/media/video/s5p-tv/mixer_drv.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

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
-- 
1.7.5.4
