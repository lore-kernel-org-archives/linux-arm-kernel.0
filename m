From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 20 May 2012 14:08:56 -0300
Subject: [PATCH] AMR: mx31: Add pinctrl_provide_dummies()
Message-ID: <1337533736-7857-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

commit a2aa65a (ARM: imx: enable pinctrl dummy states) missed to add
pinctrl_provide_dummies() for mx31.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/mm-imx3.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
index 967ed5b..0b211f6 100644
--- a/arch/arm/mach-imx/mm-imx3.c
+++ b/arch/arm/mach-imx/mm-imx3.c
@@ -179,6 +179,8 @@ void __init imx31_soc_init(void)
 	mxc_register_gpio("imx31-gpio", 1, MX31_GPIO2_BASE_ADDR, SZ_16K, MX31_INT_GPIO2, 0);
 	mxc_register_gpio("imx31-gpio", 2, MX31_GPIO3_BASE_ADDR, SZ_16K, MX31_INT_GPIO3, 0);
 
+	pinctrl_provide_dummies();
+
 	if (to_version == 1) {
 		strncpy(imx31_sdma_pdata.fw_name, "sdma-imx31-to1.bin",
 			strlen(imx31_sdma_pdata.fw_name));
-- 
1.7.1
