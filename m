Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16093C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:43:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B528A2082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A8UzHAEP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B528A2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tcEeicANRd4jXPjBrWxn9I1eIt1GM4Jj2Ny6HV1NFCQ=; b=A8UzHAEPGaSK/h
	l2vg3OZiMYU50F9wsh4xAPYLM6p5jvwnOIiiXBBt4dPyXLwG3Hurx9duNoMSeQyzfA7ODbRUTUaD3
	EAW22Lq0YRpgfjgDjcrOLbZK5ePOWFXbDfsA0Q/mdMLq52nI1qNudEmFt/Tb3e7b7DlqJTRt6H1cy
	bidQNcyhtlxG2uk3WK78qZhq4eFIuJzCghzn0NnV+Vikdzs7p+7ecgSwd1p8ow2swVwnxj97IfwRA
	5c0FTi5/KBrNPJC9b5nAVvUqQqI+Jd+zoyKLOBBYmrMxSZFkDJLJHkaMv4K+TcI98lfbsSkogQb1/
	AB5pFvHyMmeH7AitdPJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVgd5-0002Ji-L2; Sat, 08 Dec 2018 17:43:03 +0000
Received: from [184.48.100.57] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVgbP-0000bv-Lf; Sat, 08 Dec 2018 17:41:19 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 6/6] sparc: merge 32-bit and 64-bit version of pci.h
Date: Sat,  8 Dec 2018 09:41:15 -0800
Message-Id: <20181208174115.16237-7-hch@lst.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181208174115.16237-1-hch@lst.de>
References: <20181208174115.16237-1-hch@lst.de>
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
Cc: linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 Vineet Gupta <vgupta@synopsys.com>, Robin Murphy <robin.murphy@arm.com>,
 dri-devel@lists.freedesktop.org, "Matwey V. Kornilov" <matwey@sai.msu.ru>,
 openrisc@lists.librecores.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 Ezequiel Garcia <ezequiel@collabora.com>, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

There are enough common defintions that a single header seems nicer.

Also drop the pointless <linux/dma-mapping.h> include.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/pci.h    | 53 ++++++++++++++++++++++++++++++---
 arch/sparc/include/asm/pci_32.h | 32 --------------------
 arch/sparc/include/asm/pci_64.h | 52 --------------------------------
 3 files changed, 49 insertions(+), 88 deletions(-)
 delete mode 100644 arch/sparc/include/asm/pci_32.h
 delete mode 100644 arch/sparc/include/asm/pci_64.h

diff --git a/arch/sparc/include/asm/pci.h b/arch/sparc/include/asm/pci.h
index cad79a6ce0e4..cfec79bb1831 100644
--- a/arch/sparc/include/asm/pci.h
+++ b/arch/sparc/include/asm/pci.h
@@ -1,9 +1,54 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef ___ASM_SPARC_PCI_H
 #define ___ASM_SPARC_PCI_H
-#if defined(__sparc__) && defined(__arch64__)
-#include <asm/pci_64.h>
+
+
+/* Can be used to override the logic in pci_scan_bus for skipping
+ * already-configured bus numbers - to be used for buggy BIOSes
+ * or architectures with incomplete PCI setup by the loader.
+ */
+#define pcibios_assign_all_busses()	0
+
+#define PCIBIOS_MIN_IO		0UL
+#define PCIBIOS_MIN_MEM		0UL
+
+#define PCI_IRQ_NONE		0xffffffff
+
+
+#ifdef CONFIG_SPARC64
+
+/* PCI IOMMU mapping bypass support. */
+
+/* PCI 64-bit addressing works for all slots on all controller
+ * types on sparc64.  However, it requires that the device
+ * can drive enough of the 64 bits.
+ */
+#define PCI64_REQUIRED_MASK	(~(u64)0)
+#define PCI64_ADDR_BASE		0xfffc000000000000UL
+
+/* Return the index of the PCI controller for device PDEV. */
+int pci_domain_nr(struct pci_bus *bus);
+static inline int pci_proc_domain(struct pci_bus *bus)
+{
+	return 1;
+}
+
+/* Platform support for /proc/bus/pci/X/Y mmap()s. */
+#define HAVE_PCI_MMAP
+#define arch_can_pci_mmap_io()	1
+#define HAVE_ARCH_PCI_GET_UNMAPPED_AREA
+#define get_pci_unmapped_area get_fb_unmapped_area
+
+#define HAVE_ARCH_PCI_RESOURCE_TO_USER
+#endif /* CONFIG_SPARC64 */
+
+#if defined(CONFIG_SPARC64) || defined(CONFIG_LEON_PCI)
+static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
+{
+	return PCI_IRQ_NONE;
+}
 #else
-#include <asm/pci_32.h>
-#endif
+#include <asm-generic/pci.h>
 #endif
+
+#endif /* ___ASM_SPARC_PCI_H */
diff --git a/arch/sparc/include/asm/pci_32.h b/arch/sparc/include/asm/pci_32.h
deleted file mode 100644
index a475380ea108..000000000000
--- a/arch/sparc/include/asm/pci_32.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __SPARC_PCI_H
-#define __SPARC_PCI_H
-
-#ifdef __KERNEL__
-
-#include <linux/dma-mapping.h>
-
-/* Can be used to override the logic in pci_scan_bus for skipping
- * already-configured bus numbers - to be used for buggy BIOSes
- * or architectures with incomplete PCI setup by the loader.
- */
-#define pcibios_assign_all_busses()	0
-
-#define PCIBIOS_MIN_IO		0UL
-#define PCIBIOS_MIN_MEM		0UL
-
-#define PCI_IRQ_NONE		0xffffffff
-
-#endif /* __KERNEL__ */
-
-#ifndef CONFIG_LEON_PCI
-/* generic pci stuff */
-#include <asm-generic/pci.h>
-#else
-static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
-{
-	return PCI_IRQ_NONE;
-}
-#endif
-
-#endif /* __SPARC_PCI_H */
diff --git a/arch/sparc/include/asm/pci_64.h b/arch/sparc/include/asm/pci_64.h
deleted file mode 100644
index fac77813402c..000000000000
--- a/arch/sparc/include/asm/pci_64.h
+++ /dev/null
@@ -1,52 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __SPARC64_PCI_H
-#define __SPARC64_PCI_H
-
-#ifdef __KERNEL__
-
-#include <linux/dma-mapping.h>
-
-/* Can be used to override the logic in pci_scan_bus for skipping
- * already-configured bus numbers - to be used for buggy BIOSes
- * or architectures with incomplete PCI setup by the loader.
- */
-#define pcibios_assign_all_busses()	0
-
-#define PCIBIOS_MIN_IO		0UL
-#define PCIBIOS_MIN_MEM		0UL
-
-#define PCI_IRQ_NONE		0xffffffff
-
-/* PCI IOMMU mapping bypass support. */
-
-/* PCI 64-bit addressing works for all slots on all controller
- * types on sparc64.  However, it requires that the device
- * can drive enough of the 64 bits.
- */
-#define PCI64_REQUIRED_MASK	(~(u64)0)
-#define PCI64_ADDR_BASE		0xfffc000000000000UL
-
-/* Return the index of the PCI controller for device PDEV. */
-
-int pci_domain_nr(struct pci_bus *bus);
-static inline int pci_proc_domain(struct pci_bus *bus)
-{
-	return 1;
-}
-
-/* Platform support for /proc/bus/pci/X/Y mmap()s. */
-
-#define HAVE_PCI_MMAP
-#define arch_can_pci_mmap_io()	1
-#define HAVE_ARCH_PCI_GET_UNMAPPED_AREA
-#define get_pci_unmapped_area get_fb_unmapped_area
-
-static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
-{
-	return PCI_IRQ_NONE;
-}
-
-#define HAVE_ARCH_PCI_RESOURCE_TO_USER
-#endif /* __KERNEL__ */
-
-#endif /* __SPARC64_PCI_H */
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
