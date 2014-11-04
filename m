From: kever.yang@rock-chips.com (Kever Yang)
Date: Tue,  4 Nov 2014 15:52:35 +0800
Subject: [PATCH 1/5] clk: rockchip: add some clock rate into rate table for
 rk3288
In-Reply-To: <1415087559-19444-1-git-send-email-kever.yang@rock-chips.com>
References: <1415087559-19444-1-git-send-email-kever.yang@rock-chips.com>
Message-ID: <1415087559-19444-2-git-send-email-kever.yang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We are going to support all the HDMI resolutions which need a bunch
of accurate clock rates. This patch makes the pll rate table can
provide all the option clock rate that HDMI controller may needed.

Here's what HDMI needs:
resolutions 		Pixel clock(Mhz)
1920x1080p 60/50	148.5
1920x1080i 100/120 	148.5
1920x1080i 60/50	74.25
1280x720p 60/50/30/25 	74.25
720x576p 50		27
720x480p 60		27
1440x480i 60		27
1440x576i 50 		27
1680x1050 60 		146.25
1280x1024 60		108
1280x960 60 		108
1440x900 60 		106.5
1280x800 60 		83.5
1024x768 60 		65
800x600 60 		40
800x600 56 		36
640x480 60 		25.175

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

 drivers/clk/rockchip/clk-rk3288.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index 279a662..48412e9 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -73,6 +73,7 @@ struct rockchip_pll_rate_table rk3288_pll_rates[] = {
 	RK3066_PLL_RATE(1128000000, 1, 47, 1),
 	RK3066_PLL_RATE(1104000000, 1, 46, 1),
 	RK3066_PLL_RATE(1008000000, 1, 84, 2),
+	RK3066_PLL_RATE(1007000000, 12, 1007, 2),
 	RK3066_PLL_RATE( 912000000, 1, 76, 2),
 	RK3066_PLL_RATE( 891000000, 8, 594, 2),
 	RK3066_PLL_RATE( 888000000, 1, 74, 2),
@@ -84,6 +85,7 @@ struct rockchip_pll_rate_table rk3288_pll_rates[] = {
 	RK3066_PLL_RATE( 696000000, 1, 58, 2),
 	RK3066_PLL_RATE( 600000000, 1, 50, 2),
 	RK3066_PLL_RATE_BWADJ(594000000, 1, 198, 8, 1),
+	RK3066_PLL_RATE( 585000000, 4, 195, 2),
 	RK3066_PLL_RATE( 552000000, 1, 46, 2),
 	RK3066_PLL_RATE( 504000000, 1, 84, 4),
 	RK3066_PLL_RATE( 500000000, 3, 125, 2),
@@ -97,6 +99,7 @@ struct rockchip_pll_rate_table rk3288_pll_rates[] = {
 	RK3066_PLL_RATE( 297000000, 2, 198, 8),
 	RK3066_PLL_RATE( 252000000, 1, 84, 8),
 	RK3066_PLL_RATE( 216000000, 1, 72, 8),
+	RK3066_PLL_RATE( 167000000, 3, 167, 8),
 	RK3066_PLL_RATE( 148500000, 2, 99, 8),
 	RK3066_PLL_RATE( 126000000, 1, 84, 16),
 	RK3066_PLL_RATE(  48000000, 1, 64, 32),
-- 
1.9.1
