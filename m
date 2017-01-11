From: jacob-chen@iotwrt.com (Jacob Chen)
Date: Wed, 11 Jan 2017 09:26:32 +0800
Subject: [PATCH] clk: rockchip: rk3288: make aclk_vio1_niu a critical clock
Message-ID: <1484097992-9118-1-git-send-email-jacob-chen@iotwrt.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the pd blocks, VIO1_NIU is required by RGA,ISP and VOP1.
Then at least one VIO_NIU should be turned on to supply eDP, HDMI, MIPI.

If eDP,HDMI,MIPI is inited early than VOP or RGA is inited early than VOP1,
system will hang.

So make aclk_vio1_niu a critical clock and turn it on at all times.

Signed-off-by: Jacob Chen <jacob-chen@iotwrt.com>
---
 drivers/clk/rockchip/clk-rk3288.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index f071c24..59ee244 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -815,6 +815,7 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
 static const char *const rk3288_critical_clocks[] __initconst = {
 	"aclk_cpu",
 	"aclk_peri",
+	"aclk_vio1_niu",
 	"hclk_peri",
 	"pclk_pd_pmu",
 };
-- 
2.7.4
