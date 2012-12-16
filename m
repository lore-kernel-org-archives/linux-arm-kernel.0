From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Sun, 16 Dec 2012 18:25:49 +0100
Subject: [PATCH/WIP/RFC 03/14] shmobile-iommu: Remove __devinit
In-Reply-To: <1355678760-27357-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1350290093-998-1-git-send-email-hdk@igel.co.jp>
 <1355678760-27357-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1355678760-27357-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_HOTPLUG is going away as an option, remove __devinit.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/iommu/shmobile-ipmmu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/iommu/shmobile-ipmmu.c b/drivers/iommu/shmobile-ipmmu.c
index 72cacb9..2339f91 100644
--- a/drivers/iommu/shmobile-ipmmu.c
+++ b/drivers/iommu/shmobile-ipmmu.c
@@ -106,7 +106,7 @@ void ipmmu_tlb_set(struct device *dev, unsigned long phys, int size, int asid)
 	mutex_unlock(&priv->flush_lock);
 }
 
-static int __devinit ipmmu_probe(struct platform_device *pdev)
+static int ipmmu_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct ipmmu_priv *priv;
-- 
1.7.8.6
