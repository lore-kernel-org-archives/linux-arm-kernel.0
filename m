From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 25 Sep 2012 19:05:41 +0300
Subject: [PATCHv6 10/11] ARM: OMAP4: hwmod data: set mpu hwmod modulemode to
 hwauto
In-Reply-To: <1348589142-11983-1-git-send-email-t-kristo@ti.com>
References: <1348589142-11983-1-git-send-email-t-kristo@ti.com>
Message-ID: <1348589142-11983-11-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes sure it is handled as autoidle type by the usecounting.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 2d13b33..367de25 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -2492,6 +2492,7 @@ static struct omap_hwmod omap44xx_mpu_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_MPU_MPU_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_MPU_MPU_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 };
-- 
1.7.4.1
