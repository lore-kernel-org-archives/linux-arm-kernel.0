From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 18 Mar 2014 11:58:27 +0100
Subject: [PATCH RESEND] ARM: SPEAr1340: static-ize SATA functions
Message-ID: <1678906.b5uh0Nm7QE@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sata_miphy_exit(), sata_suspend() and sata_resume() static.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
Previous submission:
https://lkml.org/lkml/2013/10/4/369

 arch/arm/mach-spear/spear1340.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-spear/spear1340.c b/arch/arm/mach-spear/spear1340.c
index 3fb6834..e0e4251 100644
--- a/arch/arm/mach-spear/spear1340.c
+++ b/arch/arm/mach-spear/spear1340.c
@@ -93,7 +93,7 @@ static int sata_miphy_init(struct device *dev, void __iomem *addr)
 	return 0;
 }
 
-void sata_miphy_exit(struct device *dev)
+static void sata_miphy_exit(struct device *dev)
 {
 	writel(0, SPEAR1340_PCIE_SATA_CFG);
 	writel(0, SPEAR1340_PCIE_MIPHY_CFG);
@@ -107,7 +107,7 @@ void sata_miphy_exit(struct device *dev)
 	msleep(20);
 }
 
-int sata_suspend(struct device *dev)
+static int sata_suspend(struct device *dev)
 {
 	if (dev->power.power_state.event == PM_EVENT_FREEZE)
 		return 0;
@@ -117,7 +117,7 @@ int sata_suspend(struct device *dev)
 	return 0;
 }
 
-int sata_resume(struct device *dev)
+static int sata_resume(struct device *dev)
 {
 	if (dev->power.power_state.event == PM_EVENT_THAW)
 		return 0;
-- 
1.8.2.3
