From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 18 Aug 2010 23:01:15 +0900
Subject: [PATCH 05/14] ARM: S5PV310: Adds clk_sclk_usbphy0, _usbphy1,
	and _hdmiphy
In-Reply-To: <1282140084-10265-1-git-send-email-kgene.kim@samsung.com>
References: <1282140084-10265-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1282140084-10265-6-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jongpill Lee <boyko.lee@samsung.com>

This patch adds struct clk clk_sclk_usbphy0, _usbphy1, and _hdmiphy
for adding member of clkset_group_list.

Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv310/clock.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv310/clock.c b/arch/arm/mach-s5pv310/clock.c
index c60d3b0..892259b 100644
--- a/arch/arm/mach-s5pv310/clock.c
+++ b/arch/arm/mach-s5pv310/clock.c
@@ -30,6 +30,22 @@ static struct clk clk_sclk_hdmi27m = {
 	.rate		= 27000000,
 };
 
+static struct clk clk_sclk_hdmiphy = {
+	.name		= "sclk_hdmiphy",
+	.id		= -1,
+};
+
+static struct clk clk_sclk_usbphy0 = {
+	.name		= "sclk_usbphy0",
+	.id		= -1,
+	.rate		= 27000000,
+};
+
+static struct clk clk_sclk_usbphy1 = {
+	.name		= "sclk_usbphy1",
+	.id		= -1,
+};
+
 /* Core list of CMU_CPU side */
 
 static struct clksrc_clk clk_mout_apll = {
@@ -239,6 +255,9 @@ static struct clk *clkset_group_list[] = {
 	[0] = &clk_ext_xtal_mux,
 	[1] = &clk_xusbxti,
 	[2] = &clk_sclk_hdmi27m,
+	[3] = &clk_sclk_usbphy0,
+	[4] = &clk_sclk_usbphy1,
+	[5] = &clk_sclk_hdmiphy,
 	[6] = &clk_mout_mpll.clk,
 	[7] = &clk_mout_epll.clk,
 	[8] = &clk_sclk_vpll.clk,
-- 
1.6.2.5
