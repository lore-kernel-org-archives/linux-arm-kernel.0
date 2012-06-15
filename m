From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Fri, 15 Jun 2012 14:23:06 -0300
Subject: [PATCH 3/4] ARM: clk-imx27: Remove unneeded '#ifdef CONFIG_OF'
In-Reply-To: <1339780987-11063-1-git-send-email-fabio.estevam@freescale.com>
References: <1339780987-11063-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1339780987-11063-3-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_OF is always selected for imx SoCs so it is safe
to drop the '#ifdef CONFIG_OF'.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/clk-imx27.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx27.c b/arch/arm/mach-imx/clk-imx27.c
index 295cbd7..e73c05f 100644
--- a/arch/arm/mach-imx/clk-imx27.c
+++ b/arch/arm/mach-imx/clk-imx27.c
@@ -270,7 +270,6 @@ int __init mx27_clocks_init(unsigned long fref)
 	return 0;
 }
 
-#ifdef CONFIG_OF
 int __init mx27_clocks_init_dt(void)
 {
 	struct device_node *np;
@@ -286,4 +285,3 @@ int __init mx27_clocks_init_dt(void)
 
 	return mx27_clocks_init(fref);
 }
-#endif
-- 
1.7.1
