Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A300DC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:42:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7756E208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JQi4T17l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7756E208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CPunBSJhVPeLmgl6N82QSfT14dnKiysUeiAUaPMvzFg=; b=JQi4T17lLprtAD
	q7n1X+6ZCpByujlD+aopmeWstGihfgUrhe3PSJGfK7YnZJJSPBj3AiwnL1pbsD0DmLV/iy9t59Rrr
	8oENL8iX1uiVae+JmuDR5ip1LaSuZop7zUbK+f606f++8JPLfF4QauJ/ROkn2Wx5X1Npz/p2tdDaw
	lol+TpanpuO7Ic6k/x8DaLDgehNJvYa+o6+5c4FEiJP2vms+bYXQnhl7RxzZ1VBhssN7mIX91K9us
	qkNxAL7X/8yWSlwPetjrwAsB5snk9nxQyZ9ZP1gZ3XiNES0N25mzfKidHf2F58LwybWOtKR5i33cD
	f71CjjGlBXv51bjbumug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVgcq-00026j-4H; Sat, 08 Dec 2018 17:42:48 +0000
Received: from [184.48.100.57] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVgbP-0000bG-41; Sat, 08 Dec 2018 17:41:19 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 5/6] sparc: move the leon PCI memory space comment to
 <asm/leon.h>
Date: Sat,  8 Dec 2018 09:41:14 -0800
Message-Id: <20181208174115.16237-6-hch@lst.de>
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

It has nothing to do with the content of the pci.h header.

Suggested by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sparc/include/asm/leon.h   | 9 +++++++++
 arch/sparc/include/asm/pci_32.h | 9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
index c68bb5b76e3d..77ea406ff9df 100644
--- a/arch/sparc/include/asm/leon.h
+++ b/arch/sparc/include/asm/leon.h
@@ -255,4 +255,13 @@ extern int leon_ipi_irq;
 #define _pfn_valid(pfn)	 ((pfn < last_valid_pfn) && (pfn >= PFN(phys_base)))
 #define _SRMMU_PTE_PMASK_LEON 0xffffffff
 
+/*
+ * On LEON PCI Memory space is mapped 1:1 with physical address space.
+ *
+ * I/O space is located at low 64Kbytes in PCI I/O space. The I/O addresses
+ * are converted into CPU addresses to virtual addresses that are mapped with
+ * MMU to the PCI Host PCI I/O space window which are translated to the low
+ * 64Kbytes by the Host controller.
+ */
+
 #endif
diff --git a/arch/sparc/include/asm/pci_32.h b/arch/sparc/include/asm/pci_32.h
index cfc0ee9476c6..a475380ea108 100644
--- a/arch/sparc/include/asm/pci_32.h
+++ b/arch/sparc/include/asm/pci_32.h
@@ -23,15 +23,6 @@
 /* generic pci stuff */
 #include <asm-generic/pci.h>
 #else
-/*
- * On LEON PCI Memory space is mapped 1:1 with physical address space.
- *
- * I/O space is located at low 64Kbytes in PCI I/O space. The I/O addresses
- * are converted into CPU addresses to virtual addresses that are mapped with
- * MMU to the PCI Host PCI I/O space window which are translated to the low
- * 64Kbytes by the Host controller.
- */
-
 static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 {
 	return PCI_IRQ_NONE;
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
