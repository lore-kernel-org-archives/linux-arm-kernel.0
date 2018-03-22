From: abel.vesa@nxp.com (Abel Vesa)
Date: Thu, 22 Mar 2018 11:55:28 +0200
Subject: [PATCH 3/4] arm: imx: Correct ahb clk parent select
In-Reply-To: <1521712529-632-1-git-send-email-abel.vesa@nxp.com>
References: <1521712529-632-1-git-send-email-abel.vesa@nxp.com>
Message-ID: <1521712529-632-4-git-send-email-abel.vesa@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Anson Huang <anson.huang@nxp.com>

Design team change the ahb's clk parent options but did NOT update the DOC
accordingly in time, so the AHB/IPG's clk rate in clk tree is incorrect, AHB is
67.5MHz and IPG is 33.75MHz, but using scope to monitor them, they are actually
135MHz and 67.5MHz, update the clk parent option to make clk tree info correct.

Signed-off-by: Anson Huang <anson.huang@nxp.com>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-imx7d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index d786f98..3553b68 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -74,7 +74,7 @@ static const char *nand_usdhc_bus_sel[] = { "osc", "pll_sys_pfd2_270m_clk",
 
 static const char *ahb_channel_sel[] = { "osc", "pll_sys_pfd2_270m_clk",
 	"pll_dram_533m_clk", "pll_sys_pfd0_392m_clk",
-	"pll_enet_125m_clk", "pll_usb_main_clk", "pll_audio_post_div",
+	"pll_enet_250m_clk", "pll_usb_main_clk", "pll_audio_post_div",
 	"pll_video_post_div", };
 
 static const char *dram_phym_sel[] = { "pll_dram_main_clk",
-- 
2.7.4
