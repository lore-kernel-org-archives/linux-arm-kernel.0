From: philippe.retornaz@epfl.ch (=?utf-8?q?Philippe=20R=C3=A9tornaz?=)
Date: Thu, 21 Jul 2011 20:04:19 +0200
Subject: [PATCH 2/6] mc13xxx: implicitly register led subdevice
In-Reply-To: <1311271463-4356-2-git-send-email-philippe.retornaz@epfl.ch>
References: <1311271463-4356-1-git-send-email-philippe.retornaz@epfl.ch>
	<1311271463-4356-2-git-send-email-philippe.retornaz@epfl.ch>
Message-ID: <1311271463-4356-3-git-send-email-philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Philippe R?tornaz <philippe.retornaz@epfl.ch>
---
 drivers/mfd/mc13xxx-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
index c238f6b..2867c21 100644
--- a/drivers/mfd/mc13xxx-core.c
+++ b/drivers/mfd/mc13xxx-core.c
@@ -772,7 +772,7 @@ err_revision:
 	if (pdata->flags & MC13XXX_USE_TOUCHSCREEN)
 		mc13xxx_add_subdevice(mc13xxx, "%s-ts");
 
-	if (pdata->flags & MC13XXX_USE_LED)
+	if (pdata->leds)
 		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-led",
 				pdata->leds, sizeof(*pdata->leds));
 
-- 
1.6.3.3
