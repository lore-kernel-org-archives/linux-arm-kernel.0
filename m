From: festevam@gmail.com (Fabio Estevam)
Date: Mon,  8 Jul 2013 14:58:38 -0300
Subject: [PATCH 3/3] ARM: imx: mm-imx3: Free l2x0_base
In-Reply-To: <1373306318-15604-1-git-send-email-festevam@gmail.com>
References: <1373306318-15604-1-git-send-email-festevam@gmail.com>
Message-ID: <1373306318-15604-3-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

After l2x0_base has been used, we should free it.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/mm-imx3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
index 0884ca9..3143f5e 100644
--- a/arch/arm/mach-imx/mm-imx3.c
+++ b/arch/arm/mach-imx/mm-imx3.c
@@ -113,6 +113,7 @@ static void __init imx3_init_l2x0(void)
 	}
 
 	l2x0_init(l2x0_base, 0x00030024, 0x00000000);
+	iounmap(l2x0_base);
 #endif
 }
 
-- 
1.8.1.2
