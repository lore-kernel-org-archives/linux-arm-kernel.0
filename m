From: will.deacon@arm.com (Will Deacon)
Date: Mon, 10 Jun 2013 19:34:42 +0100
Subject: [PATCH 6/9] arm64: device: add iommu pointer to device archdata
In-Reply-To: <1370889285-22799-1-git-send-email-will.deacon@arm.com>
References: <1370889285-22799-1-git-send-email-will.deacon@arm.com>
Message-ID: <1370889285-22799-7-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When using an IOMMU for device mappings, it is necessary to keep a
pointer between the device and the IOMMU to which it is attached in
order to obtain the correct IOMMU when attaching the device to a domain.

This patch adds an iommu pointer to the dev_archdata structure, in a
similar manner to other architectures (ARM, PowerPC, x86, ...).

Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/device.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/device.h b/arch/arm64/include/asm/device.h
index 07dd743..01fac31 100644
--- a/arch/arm64/include/asm/device.h
+++ b/arch/arm64/include/asm/device.h
@@ -18,6 +18,9 @@
 
 struct dev_archdata {
 	struct dma_map_ops *dma_ops;
+#ifdef CONFIG_IOMMU_API
+	void *iommu; /* private IOMMU data */
+#endif
 	struct dma_iommu_mapping	*mapping;
 };
 
-- 
1.8.2.2
