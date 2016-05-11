From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 11 May 2016 16:39:30 -0300
Subject: [PATCH] ARM: imx6ul: Fix Micrel PHY mask
Message-ID: <1462995570-31055-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

The value used for Micrel PHY mask is not correct. Use the 
MICREL_PHY_ID_MASK definition instead.

Thanks to Jiri Luznicky for proposing the fix at
https://community.freescale.com/thread/387739

Cc: <stable@vger.kernel.org>
Fixes: 709bc0657fe6f9f55 ("ARM: imx6ul: add fec MAC refrence clock and phy fixup init")
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/mach-imx/mach-imx6ul.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/mach-imx6ul.c b/arch/arm/mach-imx/mach-imx6ul.c
index a38b16b..b56de4b 100644
--- a/arch/arm/mach-imx/mach-imx6ul.c
+++ b/arch/arm/mach-imx/mach-imx6ul.c
@@ -46,7 +46,7 @@ static int ksz8081_phy_fixup(struct phy_device *dev)
 static void __init imx6ul_enet_phy_init(void)
 {
 	if (IS_BUILTIN(CONFIG_PHYLIB))
-		phy_register_fixup_for_uid(PHY_ID_KSZ8081, 0xffffffff,
+		phy_register_fixup_for_uid(PHY_ID_KSZ8081, MICREL_PHY_ID_MASK,
 					   ksz8081_phy_fixup);
 }
 
-- 
1.9.1
