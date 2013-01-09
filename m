From: festevam@gmail.com (Fabio Estevam)
Date: Tue,  8 Jan 2013 23:37:01 -0200
Subject: [PATCH] ARM: clk-imx35: Fix build warnings with W=1
Message-ID: <1357695421-6862-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Fix the following warnings when building with W=1 option:

arch/arm/mach-imx/clk-imx35.c: In function 'mx35_clocks_init':
arch/arm/mach-imx/clk-imx35.c:70:12: warning: old-style function definition [-Wold-style-definition]
arch/arm/mach-imx/clk-imx35.c:201:16: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/clk-imx35.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx35.c b/arch/arm/mach-imx/clk-imx35.c
index 66f3d65..219ab6c 100644
--- a/arch/arm/mach-imx/clk-imx35.c
+++ b/arch/arm/mach-imx/clk-imx35.c
@@ -67,13 +67,13 @@ enum mx35_clks {
 
 static struct clk *clk[clk_max];
 
-int __init mx35_clocks_init()
+int __init mx35_clocks_init(void)
 {
 	void __iomem *base = MX35_IO_ADDRESS(MX35_CCM_BASE_ADDR);
 	u32 pdr0, consumer_sel, hsp_sel;
 	struct arm_ahb_div *aad;
 	unsigned char *hsp_div;
-	int i;
+	u32 i;
 
 	pdr0 = __raw_readl(base + MXC_CCM_PDR0);
 	consumer_sel = (pdr0 >> 16) & 0xf;
-- 
1.7.9.5
