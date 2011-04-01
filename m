From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Fri, 1 Apr 2011 16:29:47 -0300
Subject: [PATCH 2/3] ARM: mach-mx5/mx53_evk.c: Fix SD3 registration
In-Reply-To: <1301686188-14827-1-git-send-email-fabio.estevam@freescale.com>
References: <1301686188-14827-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1301686188-14827-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the MX53EVK board there are two eSDHC ports available: SD1 and SD3.

Fix the argument passed to the esdhc registration function to correctly register SD3.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/board-mx53_evk.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx53_evk.c b/arch/arm/mach-mx5/board-mx53_evk.c
index 2af3f43..a6e0cad 100644
--- a/arch/arm/mach-mx5/board-mx53_evk.c
+++ b/arch/arm/mach-mx5/board-mx53_evk.c
@@ -129,7 +129,7 @@ static void __init mx53_evk_board_init(void)
 	imx53_add_imx_i2c(1, &mx53_evk_i2c_data);
 
 	imx53_add_sdhci_esdhc_imx(0, NULL);
-	imx53_add_sdhci_esdhc_imx(1, NULL);
+	imx53_add_sdhci_esdhc_imx(2, NULL);
 
 	spi_register_board_info(mx53_evk_spi_board_info,
 		ARRAY_SIZE(mx53_evk_spi_board_info));
-- 
1.6.0.4
