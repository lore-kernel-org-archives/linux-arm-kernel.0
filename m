From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Fri, 17 Jul 2015 17:20:32 +0530
Subject: [PATCH v2 2/3] ARM: DRA7: RTC: Add lock and unlock functions
In-Reply-To: <1437133833-32355-1-git-send-email-lokeshvutla@ti.com>
References: <1437133833-32355-1-git-send-email-lokeshvutla@ti.com>
Message-ID: <1437133833-32355-3-git-send-email-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hook omap_hwmod_rtc_unlock/lock functions into RTC hwmod,
so that SYSCONFIG register is updated properly

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index 2606c66..95d9bc5c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -1572,6 +1572,8 @@ static struct omap_hwmod_class_sysconfig dra7xx_rtcss_sysc = {
 static struct omap_hwmod_class dra7xx_rtcss_hwmod_class = {
 	.name	= "rtcss",
 	.sysc	= &dra7xx_rtcss_sysc,
+	.unlock	= &omap_hwmod_rtc_unlock,
+	.lock	= &omap_hwmod_rtc_lock,
 };
 
 /* rtcss */
-- 
2.1.4
