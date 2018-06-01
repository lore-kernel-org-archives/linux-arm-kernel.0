From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 1 Jun 2018 08:42:27 +0800
Subject: [RFC PATCH] PCI: mediatek: mtk_pcie_pm_ops can be static
In-Reply-To: <1527647736-19986-1-git-send-email-honghui.zhang@mediatek.com>
References: <1527647736-19986-1-git-send-email-honghui.zhang@mediatek.com>
Message-ID: <20180601004227.GA98217@lkp-sb05>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Fixes: 24dc21cd1e9d ("PCI: mediatek: Add system pm support for MT2712")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 pcie-mediatek.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
index e3b16b0..e01cc66 100644
--- a/drivers/pci/host/pcie-mediatek.c
+++ b/drivers/pci/host/pcie-mediatek.c
@@ -1256,7 +1256,7 @@ static int __maybe_unused mtk_pcie_resume_noirq(struct device *dev)
 	return 0;
 }
 
-const struct dev_pm_ops mtk_pcie_pm_ops = {
+static const struct dev_pm_ops mtk_pcie_pm_ops = {
 	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mtk_pcie_suspend_noirq,
 				      mtk_pcie_resume_noirq)
 };
