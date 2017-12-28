From: weiyongjun1@huawei.com (Wei Yongjun)
Date: Thu, 28 Dec 2017 03:18:30 +0000
Subject: [PATCH -next] clk: meson-axg: make local symbol axg_gp0_params_table
 static
Message-ID: <1514431110-98277-1-git-send-email-weiyongjun1@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes the following sparse warning:

drivers/clk/meson/axg.c:260:25: warning:
 symbol 'axg_gp0_params_table' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/clk/meson/axg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index a66b3a5..f979cb6 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -257,7 +257,7 @@
 	{ /* sentinel */ },
 };
 
-struct pll_params_table axg_gp0_params_table[] = {
+static struct pll_params_table axg_gp0_params_table[] = {
 	PLL_PARAM(HHI_GP0_PLL_CNTL, 0x40010250),
 	PLL_PARAM(HHI_GP0_PLL_CNTL1, 0xc084a000),
 	PLL_PARAM(HHI_GP0_PLL_CNTL2, 0xb75020be),
