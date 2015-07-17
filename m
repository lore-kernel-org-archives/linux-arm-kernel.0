From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Fri, 17 Jul 2015 17:20:33 +0530
Subject: [PATCH v2 3/3] ARM: AMx3xx: RTC: Add lock and unlock functions
In-Reply-To: <1437133833-32355-1-git-send-email-lokeshvutla@ti.com>
References: <1437133833-32355-1-git-send-email-lokeshvutla@ti.com>
Message-ID: <1437133833-32355-4-git-send-email-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hook omap_hwmod_rtc_unlock/lock functions into RTC hwmod,
so that SYSCONFIG register is updated properly.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
index 907a452b..aed3362 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
@@ -918,6 +918,8 @@ static struct omap_hwmod_class_sysconfig am33xx_rtc_sysc = {
 static struct omap_hwmod_class am33xx_rtc_hwmod_class = {
 	.name		= "rtc",
 	.sysc		= &am33xx_rtc_sysc,
+	.unlock		= &omap_hwmod_rtc_unlock,
+	.lock		= &omap_hwmod_rtc_lock,
 };
 
 struct omap_hwmod am33xx_rtc_hwmod = {
-- 
2.1.4
