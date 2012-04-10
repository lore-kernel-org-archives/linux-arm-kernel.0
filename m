From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Tue, 10 Apr 2012 16:26:37 +0530
Subject: [PATCHv6 19/19] ARM: OMAP4: hwmod data: I2C: add flag for context
 restore
In-Reply-To: <1334055397-899-1-git-send-email-shubhrajyoti@ti.com>
References: <1334055397-899-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <1334055397-899-20-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Restore of context is not done for OMAP4. This patch
adds the OMAP_I2C_FLAG_RESET_REGS_POSTIDLE in the OMAP4
hwmod data which activates the restore for OMAP4.
Currently the OMAP4 does not hit device off still the
driver may have support for it.

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Wamsley <paul@pwsan.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 08daa5e..cddce60 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -2262,7 +2262,8 @@ static struct omap_hwmod_class omap44xx_i2c_hwmod_class = {
 };
 
 static struct omap_i2c_dev_attr i2c_dev_attr = {
-	.flags	= OMAP_I2C_FLAG_BUS_SHIFT_NONE,
+	.flags	= OMAP_I2C_FLAG_BUS_SHIFT_NONE |
+			OMAP_I2C_FLAG_RESET_REGS_POSTIDLE,
 };
 
 /* i2c1 */
-- 
1.7.4.1
