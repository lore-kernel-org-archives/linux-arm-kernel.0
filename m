From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Thu, 10 Jul 2014 14:52:55 +0800
Subject: [PATCH v3 02/13] iommu/arm: eliminate errors reported by checkpatch
In-Reply-To: <1404975186-12032-1-git-send-email-thunder.leizhen@huawei.com>
References: <1404975186-12032-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1404975186-12032-3-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If run scripts/checkpatch.pl, returns some errors. About code style, etc.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index d0f0021..dfc53e7 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -10,10 +10,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
- *
  * Copyright (C) 2013 ARM Limited
  *
  * Author: Will Deacon <will.deacon@arm.com>
@@ -419,7 +415,7 @@ struct arm_smmu_option_prop {
 	const char *prop;
 };

-static struct arm_smmu_option_prop arm_smmu_options [] = {
+static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ ARM_SMMU_OPT_SECURE_CFG_ACCESS, "calxeda,smmu-secure-config-access" },
 	{ 0, NULL},
 };
@@ -1913,7 +1909,8 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	}
 	dev_notice(dev, "registered %d master devices\n", i);

-	if ((dev_node = of_parse_phandle(dev->of_node, "smmu-parent", 0)))
+	dev_node = of_parse_phandle(dev->of_node, "smmu-parent", 0);
+	if (dev_node)
 		smmu->parent_of_node = dev_node;

 	err = arm_smmu_device_cfg_probe(smmu);
@@ -2006,7 +2003,7 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 		free_irq(smmu->irqs[i], smmu);

 	/* Turn the thing off */
-	writel(sCR0_CLIENTPD,ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
+	writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
 	return 0;
 }

--
1.8.0
