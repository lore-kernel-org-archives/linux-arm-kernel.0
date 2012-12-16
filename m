From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Sun, 16 Dec 2012 18:25:47 +0100
Subject: [PATCH/WIP/RFC 01/14] ARM: sh-mobile: Protect ipmmu.h header with
 ifndef/define
In-Reply-To: <1355678760-27357-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1350290093-998-1-git-send-email-hdk@igel.co.jp>
 <1355678760-27357-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1355678760-27357-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/include/mach/ipmmu.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/ipmmu.h b/arch/arm/mach-shmobile/include/mach/ipmmu.h
index ede2f0b..4b805b1f 100644
--- a/arch/arm/mach-shmobile/include/mach/ipmmu.h
+++ b/arch/arm/mach-shmobile/include/mach/ipmmu.h
@@ -1,3 +1,6 @@
+#ifndef __SHMOBILE_IPMMU_H__
+#define __SHMOBILE_IPMMU_H__
+
 #ifdef CONFIG_SHMOBILE_IPMMU_TLB
 void ipmmu_tlb_flush(struct device *ipmmu_dev);
 void ipmmu_tlb_set(struct device *ipmmu_dev, unsigned long phys, int size,
@@ -14,3 +17,5 @@ static int ipmmu_iommu_init(struct device *dev)
 	return -EINVAL;
 }
 #endif
+
+#endif /* __SHMOBILE_IPMMU_H__ */
-- 
1.7.8.6
