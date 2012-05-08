From: richard.zhao@freescale.com (Richard Zhao)
Date: Tue, 8 May 2012 21:21:15 +0800
Subject: [PATCH] ARM: imx6q: make ksz9021rn_phy_fixup depends on config of FEC
In-Reply-To: <1336478520.23308.36.camel@sauron.fi.intel.com>
References: <1336478520.23308.36.camel@sauron.fi.intel.com>
Message-ID: <1336483275-8610-1-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix build error without choose fec driver.

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 arch/arm/mach-imx/mach-imx6q.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index d25c5d8..999de69 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -60,6 +60,7 @@ soft:
 	soft_restart(0);
 }
 
+#if defined(CONFIG_FEC) || defined(CONFIG_FEC_MODULE)
 /* For imx6q sabrelite board: set KSZ9021RN RGMII pad skew */
 static int ksz9021rn_phy_fixup(struct phy_device *phydev)
 {
@@ -74,11 +75,14 @@ static int ksz9021rn_phy_fixup(struct phy_device *phydev)
 
 	return 0;
 }
+#endif
 
 static void __init imx6q_sabrelite_init(void)
 {
+#if defined(CONFIG_FEC) || defined(CONFIG_FEC_MODULE)
 	phy_register_fixup_for_uid(PHY_ID_KSZ9021, MICREL_PHY_ID_MASK,
 				ksz9021rn_phy_fixup);
+#endif
 }
 
 static void __init imx6q_init_machine(void)
-- 
1.7.5.4
