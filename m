From: b-cousson@ti.com (Benoit Cousson)
Date: Wed, 15 Dec 2010 15:49:27 +0100
Subject: [PATCH v2 6/6] OMAP4: hwmod data: Add SIDLE_SMART_WKUP modes to
	several IPs
In-Reply-To: <1292424567-25794-1-git-send-email-b-cousson@ti.com>
References: <1292424567-25794-1-git-send-email-b-cousson@ti.com>
Message-ID: <1292424567-25794-7-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

uart, gpio, wd_timer and i2c does support the new smart-idle with wakeup
added in OMAP4.

Add the flag to allow the hwmod core to enable this mode when applicable.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index aaeb3e3..f877cbe 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -665,7 +665,8 @@ static struct omap_hwmod_class_sysconfig omap44xx_gpio_sysc = {
 	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_ENAWAKEUP |
 			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
 			   SYSS_HAS_RESET_STATUS),
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			   SIDLE_SMART_WKUP),
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
@@ -1009,7 +1010,8 @@ static struct omap_hwmod_class_sysconfig omap44xx_i2c_sysc = {
 	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_CLOCKACTIVITY |
 			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE |
 			   SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			   SIDLE_SMART_WKUP),
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
@@ -1391,7 +1393,8 @@ static struct omap_hwmod_class_sysconfig omap44xx_uart_sysc = {
 	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_ENAWAKEUP |
 			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
 			   SYSS_HAS_RESET_STATUS),
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			   SIDLE_SMART_WKUP),
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
@@ -1621,7 +1624,8 @@ static struct omap_hwmod_class_sysconfig omap44xx_wd_timer_sysc = {
 	.syss_offs	= 0x0014,
 	.sysc_flags	= (SYSC_HAS_EMUFREE | SYSC_HAS_SIDLEMODE |
 			   SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			   SIDLE_SMART_WKUP),
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
-- 
1.7.0.4
