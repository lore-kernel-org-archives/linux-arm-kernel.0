From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed, 28 May 2014 14:58:00 +0530
Subject: [PATCH 2/2] ARM: spear: Staticize local symbols in spear1340.c
In-Reply-To: <1401269280-3567-1-git-send-email-sachin.kamat@linaro.org>
References: <1401269280-3567-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1401269280-3567-2-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Symbols local to this file are made static.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 arch/arm/mach-spear/spear1340.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-spear/spear1340.c b/arch/arm/mach-spear/spear1340.c
index 7b6bff7154e1..c601799b4aea 100644
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
1.7.9.5
