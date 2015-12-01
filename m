From: tony@atomide.com (Tony Lindgren)
Date: Tue,  1 Dec 2015 15:38:14 -0800
Subject: [PATCH 01/10] ARM: OMAP2+: Fix timer entries for dm814x
In-Reply-To: <1449013103-23238-1-git-send-email-tony@atomide.com>
References: <1449013103-23238-1-git-send-email-tony@atomide.com>
Message-ID: <1449013103-23238-2-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's a mux after the oscillator similar to am335x. I did not
notice this on hp t410 as it boots even with no clocks configured.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
index 6256052..d5246b3 100644
--- a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
@@ -599,7 +599,7 @@ static struct omap_timer_capability_dev_attr capability_alwon_dev_attr = {
 static struct omap_hwmod dm814x_timer1_hwmod = {
 	.name		= "timer1",
 	.clkdm_name	= "alwon_l3s_clkdm",
-	.main_clk	= "timer_sys_ck",
+	.main_clk	= "timer1_fck",
 	.dev_attr	= &capability_alwon_dev_attr,
 	.class		= &dm816x_timer_hwmod_class,
 	.flags		= HWMOD_NO_IDLEST,
@@ -608,7 +608,7 @@ static struct omap_hwmod dm814x_timer1_hwmod = {
 static struct omap_hwmod_ocp_if dm814x_l4_ls__timer1 = {
 	.master		= &dm81xx_l4_ls_hwmod,
 	.slave		= &dm814x_timer1_hwmod,
-	.clk		= "timer_sys_ck",
+	.clk		= "timer1_fck",
 	.user		= OCP_USER_MPU,
 };
 
@@ -636,7 +636,7 @@ static struct omap_hwmod_ocp_if dm816x_l4_ls__timer1 = {
 static struct omap_hwmod dm814x_timer2_hwmod = {
 	.name		= "timer2",
 	.clkdm_name	= "alwon_l3s_clkdm",
-	.main_clk	= "timer_sys_ck",
+	.main_clk	= "timer2_fck",
 	.dev_attr	= &capability_alwon_dev_attr,
 	.class		= &dm816x_timer_hwmod_class,
 	.flags		= HWMOD_NO_IDLEST,
@@ -645,7 +645,7 @@ static struct omap_hwmod dm814x_timer2_hwmod = {
 static struct omap_hwmod_ocp_if dm814x_l4_ls__timer2 = {
 	.master		= &dm81xx_l4_ls_hwmod,
 	.slave		= &dm814x_timer2_hwmod,
-	.clk		= "timer_sys_ck",
+	.clk		= "timer2_fck",
 	.user		= OCP_USER_MPU,
 };
 
-- 
2.6.2
