From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 1 Nov 2013 16:42:49 +0800
Subject: [PATCH] ARM: imx: remove mxc_iomux_v3_init() call from
 imx53_init_early()
Message-ID: <1383295369-14448-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Today, imx53 handles iomux configuration using pinctrl driver, so
mxc_iomux_v3_init() call in imx53_init_early() is there for nothing.
Remove the call from there.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/mm-imx5.c |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-imx/mm-imx5.c b/arch/arm/mach-imx/mm-imx5.c
index d1d5260..4c11202 100644
--- a/arch/arm/mach-imx/mm-imx5.c
+++ b/arch/arm/mach-imx/mm-imx5.c
@@ -89,15 +89,7 @@ void __init imx51_init_early(void)
 
 void __init imx53_init_early(void)
 {
-	struct device_node *np;
-	void __iomem *base;
-
 	mxc_set_cpu_type(MXC_CPU_MX53);
-
-	np = of_find_compatible_node(NULL, NULL, "fsl,imx53-iomuxc");
-	base = of_iomap(np, 0);
-	WARN_ON(!base);
-	mxc_iomux_v3_init(base);
 	imx_src_init();
 }
 
-- 
1.7.9.5
