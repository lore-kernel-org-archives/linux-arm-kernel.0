Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABE6C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:14:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABE00214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uRVkASlS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABE00214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=28qaWeWA0tNoZ+6siuOAL03UuJRwa/wsiRgGETHefbU=; b=uRVkASlS+x9fEg
	UHbI+itq/NtdoXNY4hh0DXppT7BOzcAUsyrY8oNjsnz1DW2dJSEBjECsHsbVCiDzT6tOMcjVPZxNN
	zennLwGh8kn/mVFTiYjHbmhHs0/A5JrWrlg8xrupOgCQPODTPF7hVa/oUKBpu4F9xdOgPRA1LcuDU
	McthZEVB8jUk9QaJWL0Bro5gHxp/yiZ+vGS64LVaK0ZnyKXetn0qiAOJUe+2mruCAJ9r6UVtIN859
	Wh5ZYx5b2bGwhjSWE96BOWHnyGBzZGFRV3PKRUi3K0p+BK+z9e3ZpObY2w5QNDnyJdpksOqcH/nde
	u9PhqFR2i8aO5kObJrEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqZP3-0000Tb-NT; Mon, 04 Feb 2019 08:14:53 +0000
Received: from 089144212163.atnat0021.highway.a1.net ([89.144.212.163]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqZOc-0008Pp-Hp; Mon, 04 Feb 2019 08:14:26 +0000
From: Christoph Hellwig <hch@lst.de>
To: Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Paul Burton <paul.burton@mips.com>
Subject: [PATCH 1/2] dma-mapping: add a kconfig symbol for arch_setup_dma_ops
 availability
Date: Mon,  4 Feb 2019 09:14:19 +0100
Message-Id: <20190204081420.15083-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204081420.15083-1-hch@lst.de>
References: <20190204081420.15083-1-hch@lst.de>
MIME-Version: 1.0
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: iommu@lists.linux-foundation.org, linux-snps-arc@lists.infradead.org,
 linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arc/Kconfig                     |  1 +
 arch/arc/include/asm/Kbuild          |  1 +
 arch/arc/include/asm/dma-mapping.h   | 13 -------------
 arch/arm/Kconfig                     |  1 +
 arch/arm/include/asm/dma-mapping.h   |  4 ----
 arch/arm64/Kconfig                   |  1 +
 arch/arm64/include/asm/dma-mapping.h |  4 ----
 arch/mips/Kconfig                    |  1 +
 arch/mips/include/asm/dma-mapping.h  | 10 ----------
 arch/mips/mm/dma-noncoherent.c       |  8 ++++++++
 include/linux/dma-mapping.h          | 12 ++++++++----
 kernel/dma/Kconfig                   |  3 +++
 12 files changed, 24 insertions(+), 35 deletions(-)
 delete mode 100644 arch/arc/include/asm/dma-mapping.h

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 376366a7db81..2ab27d88eb1c 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -11,6 +11,7 @@ config ARC
 	select ARC_TIMERS
 	select ARCH_HAS_DMA_COHERENT_TO_PFN
 	select ARCH_HAS_PTE_SPECIAL
+	select ARCH_HAS_SETUP_DMA_OPS
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_SUPPORTS_ATOMIC_RMW if ARC_HAS_LLSC
diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild
index caa270261521..b41f8881ecc8 100644
--- a/arch/arc/include/asm/Kbuild
+++ b/arch/arc/include/asm/Kbuild
@@ -3,6 +3,7 @@ generic-y += bugs.h
 generic-y += compat.h
 generic-y += device.h
 generic-y += div64.h
+generic-y += dma-mapping.h
 generic-y += emergency-restart.h
 generic-y += extable.h
 generic-y += ftrace.h
diff --git a/arch/arc/include/asm/dma-mapping.h b/arch/arc/include/asm/dma-mapping.h
deleted file mode 100644
index c946c0a83e76..000000000000
--- a/arch/arc/include/asm/dma-mapping.h
+++ /dev/null
@@ -1,13 +0,0 @@
-// SPDX-License-Identifier:  GPL-2.0
-// (C) 2018 Synopsys, Inc. (www.synopsys.com)
-
-#ifndef ASM_ARC_DMA_MAPPING_H
-#define ASM_ARC_DMA_MAPPING_H
-
-#include <asm-generic/dma-mapping.h>
-
-void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-			const struct iommu_ops *iommu, bool coherent);
-#define arch_setup_dma_ops arch_setup_dma_ops
-
-#endif
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 664e918e2624..c1cf44f00870 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -12,6 +12,7 @@ config ARM
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_PTE_SPECIAL if ARM_LPAE
 	select ARCH_HAS_PHYS_TO_DMA
+	select ARCH_HAS_SETUP_DMA_OPS
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
 	select ARCH_HAS_STRICT_MODULE_RWX if MMU
diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index 31d3b96f0f4b..a224b6e39e58 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -96,10 +96,6 @@ static inline unsigned long dma_max_pfn(struct device *dev)
 }
 #define dma_max_pfn(dev) dma_max_pfn(dev)
 
-#define arch_setup_dma_ops arch_setup_dma_ops
-extern void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-			       const struct iommu_ops *iommu, bool coherent);
-
 #ifdef CONFIG_MMU
 #define arch_teardown_dma_ops arch_teardown_dma_ops
 extern void arch_teardown_dma_ops(struct device *dev);
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a4168d366127..63909f318d56 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -22,6 +22,7 @@ config ARM64
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_PTE_SPECIAL
+	select ARCH_HAS_SETUP_DMA_OPS
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_STRICT_MODULE_RWX
diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index 95dbf3ef735a..de96507ee2c1 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -29,10 +29,6 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return NULL;
 }
 
-void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-			const struct iommu_ops *iommu, bool coherent);
-#define arch_setup_dma_ops	arch_setup_dma_ops
-
 #ifdef CONFIG_IOMMU_DMA
 void arch_teardown_dma_ops(struct device *dev);
 #define arch_teardown_dma_ops	arch_teardown_dma_ops
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 0d14f51d0002..dc5d70f674e0 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1118,6 +1118,7 @@ config DMA_MAYBE_COHERENT
 
 config DMA_PERDEV_COHERENT
 	bool
+	select ARCH_HAS_SETUP_DMA_OPS
 	select DMA_NONCOHERENT
 
 config DMA_NONCOHERENT
diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
index 20dfaad3a55d..34de7b17b41b 100644
--- a/arch/mips/include/asm/dma-mapping.h
+++ b/arch/mips/include/asm/dma-mapping.h
@@ -15,14 +15,4 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 #endif
 }
 
-#define arch_setup_dma_ops arch_setup_dma_ops
-static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base,
-				      u64 size, const struct iommu_ops *iommu,
-				      bool coherent)
-{
-#ifdef CONFIG_DMA_PERDEV_COHERENT
-	dev->dma_coherent = coherent;
-#endif
-}
-
 #endif /* _ASM_DMA_MAPPING_H */
diff --git a/arch/mips/mm/dma-noncoherent.c b/arch/mips/mm/dma-noncoherent.c
index cb38461391cb..0606fc87b294 100644
--- a/arch/mips/mm/dma-noncoherent.c
+++ b/arch/mips/mm/dma-noncoherent.c
@@ -159,3 +159,11 @@ void arch_dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 
 	dma_sync_virt(vaddr, size, direction);
 }
+
+#ifdef CONFIG_DMA_PERDEV_COHERENT
+void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
+		const struct iommu_ops *iommu, bool coherent)
+{
+	dev->dma_coherent = coherent;
+}
+#endif
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index b904d55247ab..2b20d60e6158 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -671,11 +671,15 @@ static inline int dma_coerce_mask_and_coherent(struct device *dev, u64 mask)
 	return dma_set_mask_and_coherent(dev, mask);
 }
 
-#ifndef arch_setup_dma_ops
+#ifdef CONFIG_ARCH_HAS_SETUP_DMA_OPS
+void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
+		const struct iommu_ops *iommu, bool coherent);
+#else
 static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base,
-				      u64 size, const struct iommu_ops *iommu,
-				      bool coherent) { }
-#endif
+		u64 size, const struct iommu_ops *iommu, bool coherent)
+{
+}
+#endif /* CONFIG_ARCH_HAS_SETUP_DMA_OPS */
 
 #ifndef arch_teardown_dma_ops
 static inline void arch_teardown_dma_ops(struct device *dev) { }
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index ca88b867e7fe..c44599d128e8 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -19,6 +19,9 @@ config ARCH_HAS_DMA_COHERENCE_H
 config HAVE_GENERIC_DMA_COHERENT
 	bool
 
+config ARCH_HAS_SETUP_DMA_OPS
+	bool
+
 config ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	bool
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
