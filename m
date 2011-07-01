From: b-cousson@ti.com (Benoit Cousson)
Date: Fri, 1 Jul 2011 22:41:28 +0200
Subject: [PATCH v2 05/18] OMAP4: clock data: Remove usb_host_fs clkdev with
	NULL dev
In-Reply-To: <1309552901-8944-1-git-send-email-b-cousson@ti.com>
References: <1309552901-8944-1-git-send-email-b-cousson@ti.com>
Message-ID: <1309552901-8944-6-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

usb_host_fs_fck does have a clkdev mapping with "usbhs-omap.0"
and "fs_fck" alias used by the driver.
The entry with NULL dev is thus not needed anymore.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index bd2aa4b..2a0820b 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -3205,7 +3205,6 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"uart2_fck",			&uart2_fck,	CK_443X),
 	CLK(NULL,	"uart3_fck",			&uart3_fck,	CK_443X),
 	CLK(NULL,	"uart4_fck",			&uart4_fck,	CK_443X),
-	CLK(NULL,	"usb_host_fs_fck",		&usb_host_fs_fck,	CK_443X),
 	CLK("usbhs-omap.0",	"fs_fck",		&usb_host_fs_fck,	CK_443X),
 	CLK(NULL,	"utmi_p1_gfclk",		&utmi_p1_gfclk,	CK_443X),
 	CLK(NULL,	"usb_host_hs_utmi_p1_clk",	&usb_host_hs_utmi_p1_clk,	CK_443X),
@@ -3217,7 +3216,6 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"usb_host_hs_hsic60m_p2_clk",	&usb_host_hs_hsic60m_p2_clk,	CK_443X),
 	CLK(NULL,	"usb_host_hs_hsic480m_p2_clk",	&usb_host_hs_hsic480m_p2_clk,	CK_443X),
 	CLK(NULL,	"usb_host_hs_func48mclk",	&usb_host_hs_func48mclk,	CK_443X),
-	CLK(NULL,	"usb_host_hs_fck",		&usb_host_hs_fck,	CK_443X),
 	CLK("usbhs-omap.0",	"hs_fck",		&usb_host_hs_fck,	CK_443X),
 	CLK("usbhs-omap.0",	"usbhost_ick",		&dummy_ck,		CK_443X),
 	CLK(NULL,	"otg_60m_gfclk",		&otg_60m_gfclk,	CK_443X),
@@ -3227,7 +3225,6 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"usb_tll_hs_usb_ch2_clk",	&usb_tll_hs_usb_ch2_clk,	CK_443X),
 	CLK(NULL,	"usb_tll_hs_usb_ch0_clk",	&usb_tll_hs_usb_ch0_clk,	CK_443X),
 	CLK(NULL,	"usb_tll_hs_usb_ch1_clk",	&usb_tll_hs_usb_ch1_clk,	CK_443X),
-	CLK(NULL,	"usb_tll_hs_ick",		&usb_tll_hs_ick,	CK_443X),
 	CLK("usbhs-omap.0",	"usbtll_ick",		&usb_tll_hs_ick,	CK_443X),
 	CLK("usbhs-omap.0",	"usbtll_fck",		&dummy_ck,	CK_443X),
 	CLK(NULL,	"usim_ck",			&usim_ck,	CK_443X),
-- 
1.7.0.4
