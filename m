Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735EFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:35:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39A9B218CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dZYeJNBd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39A9B218CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U7T9gTDvcjpfl8wEbR7LwKUNFvsVfn0xWPtRR21WIfE=; b=dZYeJNBd2Weram
	5WY8vs7XdjBKE0kowaQv/udk3YjGEHbYmg54zBS03N27m1DwtYLmDpbacOkGjRqtkFWTPyUUFELJs
	gnT3HVwckBAKikgPD2VKCgQ6KFLwMvS5F8UHdZ8CgQq+4Z438GsK++en86L9uhyu4Id4b6Ysn+YTX
	W/7pKVDzusqZSk1RNMnWlBpsukzyIkbygRGonyC9ljOuk0fI4ZC+m3A0tLLcfcUbYQUiUBAA+sYpw
	zoobciZkgasdQNBWBzISuB2HM5fJgMKNF75sMpAFXeYkH2begmRg59iuRnMx1WJvO1j2rLrtLlEr5
	t3oP7cboa/f6/5VDzK4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfTN2-0006hs-7e; Fri, 04 Jan 2019 17:34:56 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfTMy-0006gs-Gj
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 17:34:54 +0000
Received: by newverein.lst.de (Postfix, from userid 2407)
 id 1D0EB68D93; Fri,  4 Jan 2019 18:34:47 +0100 (CET)
Date: Fri, 4 Jan 2019 18:34:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Liviu Dudau <liviu@dudau.co.uk>
Subject: Re: [REGRESSION, BISECTED] pci: nvme device with HMB fails on arm64
Message-ID: <20190104173446.GA24554@lst.de>
References: <20190104125735.GF20342@bart.dudau.co.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190104125735.GF20342@bart.dudau.co.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_093452_705948_627ABEC1 
X-CRM114-Status: GOOD (  13.95  )
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
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 LAKML <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Liviu,

please try the patch below.  Note that this is in top of mainline,
as the commit you found already needed another fixup, which has
made it to Linus already.

--
From a959cc1a8ee00dcb274922f9d74f6ed632709047 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Fri, 4 Jan 2019 18:31:48 +0100
Subject: dma-direct: fix DMA_ATTR_NO_KERNEL_MAPPING for remapped allocations

We need to return a dma_addr_t even if we don't have a kernel mapping.
Do so by consolidating the phys_to_dma call in a single place and jump
to it from all the branches that return successfully.

Fixes: bfd56cd60521 ("dma-mapping: support highmem in the generic remap allocator")
Reported-by: Liviu Dudau <liviu@dudau.co.uk
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/remap.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
index 18cc09fc27b9..7a723194ecbe 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -204,8 +204,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		ret = dma_alloc_from_pool(size, &page, flags);
 		if (!ret)
 			return NULL;
-		*dma_handle = phys_to_dma(dev, page_to_phys(page));
-		return ret;
+		goto done;
 	}
 
 	page = __dma_direct_alloc_pages(dev, size, dma_handle, flags, attrs);
@@ -215,8 +214,10 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	/* remove any dirty cache lines on the kernel alias */
 	arch_dma_prep_coherent(page, size);
 
-	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING)
-		return page; /* opaque cookie */
+	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING) {
+		ret = page; /* opaque cookie */
+		goto done;
+	}
 
 	/* create a coherent mapping */
 	ret = dma_common_contiguous_remap(page, size, VM_USERMAP,
@@ -227,9 +228,9 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		return ret;
 	}
 
-	*dma_handle = phys_to_dma(dev, page_to_phys(page));
 	memset(ret, 0, size);
-
+done:
+	*dma_handle = phys_to_dma(dev, page_to_phys(page));
 	return ret;
 }
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
