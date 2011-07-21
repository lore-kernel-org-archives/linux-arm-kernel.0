From: philippe.retornaz@epfl.ch (=?utf-8?q?Philippe=20R=C3=A9tornaz?=)
Date: Thu, 21 Jul 2011 20:04:18 +0200
Subject: [PATCH 1/6] mc13xxx: Unconditionally register regulator subdevice
In-Reply-To: <1311271463-4356-1-git-send-email-philippe.retornaz@epfl.ch>
References: <1311271463-4356-1-git-send-email-philippe.retornaz@epfl.ch>
Message-ID: <1311271463-4356-2-git-send-email-philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Philippe R?tornaz <philippe.retornaz@epfl.ch>
---
 drivers/mfd/mc13xxx-core.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
index 7e4d44b..c238f6b 100644
--- a/drivers/mfd/mc13xxx-core.c
+++ b/drivers/mfd/mc13xxx-core.c
@@ -763,10 +763,8 @@ err_revision:
 	if (pdata->flags & MC13XXX_USE_CODEC)
 		mc13xxx_add_subdevice(mc13xxx, "%s-codec");
 
-	if (pdata->flags & MC13XXX_USE_REGULATOR) {
-		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-regulator",
-				&pdata->regulators, sizeof(pdata->regulators));
-	}
+	mc13xxx_add_subdevice_pdata(mc13xxx, "%s-regulator",
+		&pdata->regulators, sizeof(pdata->regulators));
 
 	if (pdata->flags & MC13XXX_USE_RTC)
 		mc13xxx_add_subdevice(mc13xxx, "%s-rtc");
-- 
1.6.3.3
