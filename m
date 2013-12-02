From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon,  2 Dec 2013 12:30:25 +0100
Subject: [PATCH] clk: tegra: Correct clock number for UARTE
Message-ID: <1385983825-20317-1-git-send-email-treding@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

UARTE has clock number 66. Number 65 is the right one for UARTD.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/clk/tegra/clk-tegra-periph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/clk-tegra-periph.c b/drivers/clk/tegra/clk-tegra-periph.c
index 5c35885f4a7c..3744a6fe589e 100644
--- a/drivers/clk/tegra/clk-tegra-periph.c
+++ b/drivers/clk/tegra/clk-tegra-periph.c
@@ -492,7 +492,7 @@ static struct tegra_periph_init_data periph_clks[] = {
 	UART("uartb", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_UARTB, 7, tegra_clk_uartb),
 	UART("uartc", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_UARTC, 55, tegra_clk_uartc),
 	UART("uartd", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_UARTD, 65, tegra_clk_uartd),
-	UART("uarte", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_UARTE, 65, tegra_clk_uarte),
+	UART("uarte", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_UARTE, 66, tegra_clk_uarte),
 	XUSB("xusb_host_src", mux_clkm_pllp_pllc_pllre, CLK_SOURCE_XUSB_HOST_SRC, 143, TEGRA_PERIPH_ON_APB | TEGRA_PERIPH_NO_RESET, tegra_clk_xusb_host_src),
 	XUSB("xusb_falcon_src", mux_clkm_pllp_pllc_pllre, CLK_SOURCE_XUSB_FALCON_SRC, 143, TEGRA_PERIPH_NO_RESET, tegra_clk_xusb_falcon_src),
 	XUSB("xusb_fs_src", mux_clkm_48M_pllp_480M, CLK_SOURCE_XUSB_FS_SRC, 143, TEGRA_PERIPH_NO_RESET, tegra_clk_xusb_fs_src),
-- 
1.8.4.2
