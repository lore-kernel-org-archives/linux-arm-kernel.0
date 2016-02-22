From: tony@atomide.com (Tony Lindgren)
Date: Mon, 22 Feb 2016 15:04:02 -0800
Subject: [PATCH 1/4] ARM: OMAP2+: Fix hwmod clock for l4_ls
In-Reply-To: <1456182245-1843-1-git-send-email-tony@atomide.com>
References: <1456182245-1843-1-git-send-email-tony@atomide.com>
Message-ID: <1456182245-1843-2-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looks like we have few cases with wrong clock, and some
entries with missing clock. It should always be sysclk6
for the l4_ls instance.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
index e493ae3..f8cc400 100644
--- a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
@@ -429,6 +429,7 @@ static struct omap_hwmod dm81xx_elm_hwmod = {
 static struct omap_hwmod_ocp_if dm81xx_l4_ls__elm = {
 	.master		= &dm81xx_l4_ls_hwmod,
 	.slave		= &dm81xx_elm_hwmod,
+	.clk		= "sysclk6_ck",
 	.user		= OCP_USER_MPU,
 };
 
@@ -478,6 +479,7 @@ static struct omap_hwmod dm81xx_gpio1_hwmod = {
 static struct omap_hwmod_ocp_if dm81xx_l4_ls__gpio1 = {
 	.master		= &dm81xx_l4_ls_hwmod,
 	.slave		= &dm81xx_gpio1_hwmod,
+	.clk		= "sysclk6_ck",
 	.user		= OCP_USER_MPU,
 };
 
@@ -504,6 +506,7 @@ static struct omap_hwmod dm81xx_gpio2_hwmod = {
 static struct omap_hwmod_ocp_if dm81xx_l4_ls__gpio2 = {
 	.master		= &dm81xx_l4_ls_hwmod,
 	.slave		= &dm81xx_gpio2_hwmod,
+	.clk		= "sysclk6_ck",
 	.user		= OCP_USER_MPU,
 };
 
@@ -628,7 +631,7 @@ static struct omap_hwmod dm814x_timer1_hwmod = {
 static struct omap_hwmod_ocp_if dm814x_l4_ls__timer1 = {
 	.master		= &dm81xx_l4_ls_hwmod,
 	.slave		= &dm814x_timer1_hwmod,
-	.clk		= "timer1_fck",
+	.clk		= "sysclk6_ck",
 	.user		= OCP_USER_MPU,
 };
 
@@ -665,7 +668,7 @@ static struct omap_hwmod dm814x_timer2_hwmod = {
 static struct omap_hwmod_ocp_if dm814x_l4_ls__timer2 = {
 	.master		= &dm81xx_l4_ls_hwmod,
 	.slave		= &dm814x_timer2_hwmod,
-	.clk		= "timer2_fck",
+	.clk		= "sysclk6_ck",
 	.user		= OCP_USER_MPU,
 };
 
@@ -1123,6 +1126,7 @@ static struct omap_hwmod dm81xx_mailbox_hwmod = {
 static struct omap_hwmod_ocp_if dm81xx_l4_ls__mailbox = {
 	.master		= &dm81xx_l4_ls_hwmod,
 	.slave		= &dm81xx_mailbox_hwmod,
+	.clk		= "sysclk6_ck",
 	.user		= OCP_USER_MPU,
 };
 
@@ -1157,6 +1161,7 @@ static struct omap_hwmod dm81xx_spinbox_hwmod = {
 static struct omap_hwmod_ocp_if dm81xx_l4_ls__spinbox = {
 	.master		= &dm81xx_l4_ls_hwmod,
 	.slave		= &dm81xx_spinbox_hwmod,
+	.clk		= "sysclk6_ck",
 	.user		= OCP_USER_MPU,
 };
 
-- 
2.7.0
