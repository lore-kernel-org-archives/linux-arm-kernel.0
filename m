From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 22 Feb 2011 20:24:13 -0300
Subject: [PATCH] ARM: imx/mach-mx25_3ds: Use IMX_GPIO_NR instead of hard-coded
	values
Message-ID: <1298417053-14418-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/mach-mx25_3ds.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx25_3ds.c b/arch/arm/mach-imx/mach-mx25_3ds.c
index aafc6f7..66b6cdd 100644
--- a/arch/arm/mach-imx/mach-mx25_3ds.c
+++ b/arch/arm/mach-imx/mach-mx25_3ds.c
@@ -109,8 +109,8 @@ static const struct fec_platform_data mx25_fec_pdata __initconst = {
 	.phy    = PHY_INTERFACE_MODE_RMII,
 };
 
-#define FEC_ENABLE_GPIO		35
-#define FEC_RESET_B_GPIO	104
+#define FEC_ENABLE_GPIO		IMX_GPIO_NR(2, 3)
+#define FEC_RESET_B_GPIO	IMX_GPIO_NR(4, 8)
 
 static void __init mx25pdk_fec_reset(void)
 {
-- 
1.6.0.4
