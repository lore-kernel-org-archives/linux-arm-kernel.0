From: joelf@ti.com (Joel Fernandes)
Date: Mon, 25 Nov 2013 15:44:36 -0600
Subject: [PATCH 7/7] OMAP: AM33xx: hwmod: Correct AES module SYSC type
In-Reply-To: <1385415876-12387-1-git-send-email-joelf@ti.com>
References: <1385415876-12387-1-git-send-email-joelf@ti.com>
Message-ID: <1385415876-12387-8-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the newly added sysc type4 for AES module.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
index 0f17862..7f97863 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
@@ -209,6 +209,7 @@ static struct omap_hwmod_class_sysconfig am33xx_aes0_sysc = {
 	.sysc_offs	= 0x84,
 	.syss_offs	= 0x88,
 	.sysc_flags	= SYSS_HAS_RESET_STATUS,
+	.sysc_fields    = &omap_hwmod_sysc_type4,
 };
 
 static struct omap_hwmod_class am33xx_aes0_hwmod_class = {
-- 
1.8.1.2
