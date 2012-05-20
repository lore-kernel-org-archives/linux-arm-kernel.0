From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 20 May 2012 14:21:09 -0300
Subject: [PATCH] ARM: mx51: Add pinctrl_provide_dummies()
Message-ID: <1337534469-26559-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

commit a2aa65a (ARM: imx: enable pinctrl dummy states) missed to add
pinctrl_provide_dummies() for mx51.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/mm-imx5.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/mm-imx5.c b/arch/arm/mach-imx/mm-imx5.c
index feeee17..1d00305 100644
--- a/arch/arm/mach-imx/mm-imx5.c
+++ b/arch/arm/mach-imx/mm-imx5.c
@@ -202,6 +202,8 @@ void __init imx51_soc_init(void)
 	mxc_register_gpio("imx31-gpio", 2, MX51_GPIO3_BASE_ADDR, SZ_16K, MX51_INT_GPIO3_LOW, MX51_INT_GPIO3_HIGH);
 	mxc_register_gpio("imx31-gpio", 3, MX51_GPIO4_BASE_ADDR, SZ_16K, MX51_INT_GPIO4_LOW, MX51_INT_GPIO4_HIGH);
 
+	pinctrl_provide_dummies();
+
 	/* i.mx51 has the i.mx35 type sdma */
 	imx_add_imx_sdma("imx35-sdma", MX51_SDMA_BASE_ADDR, MX51_INT_SDMA, &imx51_sdma_pdata);
 
-- 
1.7.1
