From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Fri, 5 Feb 2016 11:12:31 +0530
Subject: [PATCH v4 2/3] ARM: DRA7: RTC: Add lock and unlock functions
In-Reply-To: <1454650952-20154-1-git-send-email-lokeshvutla@ti.com>
References: <1454650952-20154-1-git-send-email-lokeshvutla@ti.com>
Message-ID: <1454650952-20154-3-git-send-email-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hook omap_hwmod_rtc_unlock/lock functions into RTC hwmod,
so that SYSCONFIG register is updated properly

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index 848356e..6625650 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -1609,6 +1609,8 @@ static struct omap_hwmod_class_sysconfig dra7xx_rtcss_sysc = {
 static struct omap_hwmod_class dra7xx_rtcss_hwmod_class = {
 	.name	= "rtcss",
 	.sysc	= &dra7xx_rtcss_sysc,
+	.unlock	= &omap_hwmod_rtc_unlock,
+	.lock	= &omap_hwmod_rtc_lock,
 };
 
 /* rtcss */
-- 
2.1.4
