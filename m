From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 1 Mar 2011 16:56:10 +0530
Subject: [PATCH V6 4/8] ST SPEAr Clock Framework: Rename usbd clock and align
	apb_clk entry
In-Reply-To: <cover.1298977691.git.viresh.kumar@st.com>
References: <cover.1298977691.git.viresh.kumar@st.com>
Message-ID: <a762804e1d4143ad97359c7e35e8258d2fc665ce.1298977691.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Deepak Sikri <deepak.sikri@st.com>
Signed-off-by: shiraz hashim <shiraz.hashim@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear3xx/clock.c |    4 ++--
 arch/arm/mach-spear6xx/clock.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-spear3xx/clock.c b/arch/arm/mach-spear3xx/clock.c
index 5bfeb6f..98bc7ed 100644
--- a/arch/arm/mach-spear3xx/clock.c
+++ b/arch/arm/mach-spear3xx/clock.c
@@ -650,7 +650,7 @@ static struct clk pwm_clk = {
 
 /* array of all spear 3xx clock lookups */
 static struct clk_lookup spear_clk_lookups[] = {
-	{ .con_id = "apb_pclk",	.clk = &dummy_apb_pclk},
+	{ .con_id = "apb_pclk",		.clk = &dummy_apb_pclk},
 	/* root clks */
 	{ .con_id = "osc_32k_clk",	.clk = &osc_32k_clk},
 	{ .con_id = "osc_24m_clk",	.clk = &osc_24m_clk},
@@ -674,8 +674,8 @@ static struct clk_lookup spear_clk_lookups[] = {
 	{ .dev_id = "gpt1",		.clk = &gpt1_clk},
 	{ .dev_id = "gpt2",		.clk = &gpt2_clk},
 	/* clock derived from pll3 clk */
+	{ .dev_id = "designware_udc",   .clk = &usbd_clk},
 	{ .con_id = "usbh_clk",		.clk = &usbh_clk},
-	{ .dev_id = "usbd",		.clk = &usbd_clk},
 	/* clock derived from ahb clk */
 	{ .con_id = "apb_clk",		.clk = &apb_clk},
 	{ .dev_id = "i2c_designware.0",	.clk = &i2c_clk},
diff --git a/arch/arm/mach-spear6xx/clock.c b/arch/arm/mach-spear6xx/clock.c
index 4f351b4..88b748b 100644
--- a/arch/arm/mach-spear6xx/clock.c
+++ b/arch/arm/mach-spear6xx/clock.c
@@ -622,7 +622,7 @@ static struct clk dummy_apb_pclk;
 
 /* array of all spear 6xx clock lookups */
 static struct clk_lookup spear_clk_lookups[] = {
-	{ .con_id = "apb_pclk",	.clk = &dummy_apb_pclk},
+	{ .con_id = "apb_pclk",		.clk = &dummy_apb_pclk},
 	/* root clks */
 	{ .con_id = "osc_32k_clk",	.clk = &osc_32k_clk},
 	{ .con_id = "osc_30m_clk",	.clk = &osc_30m_clk},
@@ -650,9 +650,9 @@ static struct clk_lookup spear_clk_lookups[] = {
 	{ .dev_id = "gpt2",		.clk = &gpt2_clk},
 	{ .dev_id = "gpt3",		.clk = &gpt3_clk},
 	/* clock derived from pll3 clk */
+	{ .dev_id = "designware_udc",	.clk = &usbd_clk},
 	{ .con_id = "usbh.0_clk",	.clk = &usbh0_clk},
 	{ .con_id = "usbh.1_clk",	.clk = &usbh1_clk},
-	{ .dev_id = "usbd",		.clk = &usbd_clk},
 	/* clock derived from ahb clk */
 	{ .con_id = "apb_clk",		.clk = &apb_clk},
 	{ .dev_id = "i2c_designware.0",	.clk = &i2c_clk},
-- 
1.7.2.2
