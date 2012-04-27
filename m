From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 27 Apr 2012 15:02:59 +0800
Subject: [PATCH 05/11] ARM: imx6q: move imx6q_sabrelite specific code to a
 dedicated function
In-Reply-To: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
References: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1335510185-7906-6-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It'll be easier to add other board specific code.

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 arch/arm/mach-imx/mach-imx6q.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index da6c1d9..d25c5d8 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -75,11 +75,16 @@ static int ksz9021rn_phy_fixup(struct phy_device *phydev)
 	return 0;
 }
 
+static void __init imx6q_sabrelite_init(void)
+{
+	phy_register_fixup_for_uid(PHY_ID_KSZ9021, MICREL_PHY_ID_MASK,
+				ksz9021rn_phy_fixup);
+}
+
 static void __init imx6q_init_machine(void)
 {
 	if (of_machine_is_compatible("fsl,imx6q-sabrelite"))
-		phy_register_fixup_for_uid(PHY_ID_KSZ9021, MICREL_PHY_ID_MASK,
-					   ksz9021rn_phy_fixup);
+		imx6q_sabrelite_init();
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
-- 
1.7.5.4
