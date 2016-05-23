From: jean.guyomarch@openwide.fr (Jean Guyomarc'h)
Date: Mon, 23 May 2016 17:16:25 +0200
Subject: [PATCH] ARM: mach-imx6q: fix spelling mistake in error message
Message-ID: <1464016585-31852-1-git-send-email-jean.guyomarch@openwide.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The compatible device tree node that is searched for is imx6q-iomuxc-gpr
but was misspelled imx6q-iomux-gpr in the error handling message.

Signed-off-by: Jean Guyomarc'h <jean.guyomarch@openwide.fr>
---
 arch/arm/mach-imx/mach-imx6q.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 3ab6154..6e0a64e 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -220,7 +220,7 @@ static void __init imx6q_1588_init(void)
 				IMX6Q_GPR1_ENET_CLK_SEL_MASK,
 				clksel);
 	else
-		pr_err("failed to find fsl,imx6q-iomux-gpr regmap\n");
+		pr_err("failed to find fsl,imx6q-iomuxc-gpr regmap\n");
 
 	clk_put(enet_ref);
 put_ptp_clk:
-- 
2.1.4
