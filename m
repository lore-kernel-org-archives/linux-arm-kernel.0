Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68DCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:17:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75622206A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EWg6hXWC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/e9LBg0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75622206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=XH/iOSsdcHrvToiNUWFpvguu+1Z6+Y/xIsmwRaHGcZw=; b=EWg6hXWCDzFrKA
	8WfvE0gg39r9IAkWV5CuX1SgHLKfqkSC9nVxjK1c+YXytbQPOh75AjR6UzwL2xelum3wUbyqbi2wF
	AyTkcyVX+gPQGJ2JNvM8ucHQvFQMn9YpadMVHodDO2Y36evMW7SqIQgoYs7di/E3p53sF1Waestx/
	gE7o4Dr4ktkdOdQBX4nnpWDSUaQRmH/LwD06tqkjhZYjigxo/a8O2rLuUahdsnUZQJBhMevKtCIWr
	w2kYyzmQtJhxl/XU640aczLiJvarA3N+qHys2o8B24YhNwRXE5l6Z8FxNFpnZ/WkCt/boejqJfhlC
	PQ9KVQDwvbYSGv0xzP1g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYzKh-0006KP-Sc; Mon, 17 Dec 2018 20:17:43 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYzKe-0006J1-6E; Mon, 17 Dec 2018 20:17:41 +0000
Received: by mail-pf1-x444.google.com with SMTP id b7so6903724pfi.8;
 Mon, 17 Dec 2018 12:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=LP5lsofdni2cSLjgAraOzOMBqzsN96J57RYIndiS9eY=;
 b=p/e9LBg09urJWLaio2BVun4A6kGUQCG7HWz9LLsvx7iRIBvbaKonR5S0UKsIOc35I7
 SSVLxSCuJqmJlEbu5QtUruzWvMTPabWv1I6cmgAzPKZ+UoKGTtflhdKlyvEmf9RpxgjJ
 jgZlhJTMJQ8243EIkKtQ6gL1JidxGUbiNWT4LYKMyzoJouaLP3bUfsgcbYxIQkBi+g7L
 73YRfXK3iBDh/kpNWD7HgQ1vG55H+CgsVYjWo0In+Jx/SeF7VmnhMlECM2b7QHQ0chbv
 +xri/+GSpBZqI9ExlEHam5pX5MDN3BwJ1Gb9xJmzHrzKGNoTgpVbEglFsGdjNrLD9aeH
 t2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=LP5lsofdni2cSLjgAraOzOMBqzsN96J57RYIndiS9eY=;
 b=mt313hx8j64G+RR0dfjBLLRPCVQrjATopGPPJpzpncNloFD8bn2VLPvPvQwWGl8TAS
 PKErwZNZqYuiIvXzfqsMyH/kqShPpXW1R0vkifC+hSYuc45OYmWNynQbekeBjLrAdrOz
 OVTzMJjZrMb+4hbzyCiMC816X6VBfT2ZVw5ro9Q2R+HTEYEO8uYDUuzEbJfpgQs04S98
 3DtRn+Lak+qzeB8MOfoVQCZ7Lev3zGlu9HqwlDo5JPlwXnW1ljolj3Pf74cPw3U/+MKG
 7NU5BDtAY94AvRfaVZpC+beMcvYIejRGrIks1nGl3P1MGQ5L7Bo0575B1/m6O7/gAJyx
 XX6w==
X-Gm-Message-State: AA+aEWYrYqBPTMDutVXmKbJ9axMkI53464idfLCEiuM6L77c4zoc74mx
 cuPJJD7/dp6AIHpd4zNoqIE=
X-Google-Smtp-Source: AFSGD/X4Uak/TI8ZYtxtZsFEKfKGnP+/T22Np31XBV/bP6gFwwiKErESpa4F78Q5JQiA2M4ia/MNlw==
X-Received: by 2002:a62:33c1:: with SMTP id
 z184mr13951345pfz.104.1545077849354; 
 Mon, 17 Dec 2018 12:17:29 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.98.208])
 by smtp.gmail.com with ESMTPSA id h129sm18659195pfb.110.2018.12.17.12.17.27
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 17 Dec 2018 12:17:28 -0800 (PST)
Date: Tue, 18 Dec 2018 01:51:21 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
 kirill.shutemov@linux.intel.com, vbabka@suse.cz, riel@surriel.com,
 sfr@canb.auug.org.au, rppt@linux.vnet.ibm.com, peterz@infradead.org,
 linux@armlinux.org.uk, robin.murphy@arm.com, iamjoonsoo.kim@lge.com,
 treding@nvidia.com, keescook@chromium.org, m.szyprowski@samsung.com,
 stefanr@s5r6.in-berlin.de, hjc@rock-chips.com, heiko@sntech.de,
 airlied@linux.ie, oleksandr_andrushchenko@epam.com, joro@8bytes.org,
 pawel@osciak.com, kyungmin.park@samsung.com, mchehab@kernel.org,
 boris.ostrovsky@oracle.com, jgross@suse.com
Subject: [PATCH v4 1/9] mm: Introduce new vm_insert_range API
Message-ID: <20181217202121.GA4335@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_121740_257236_EC5FCFC3 
X-CRM114-Status: GOOD (  16.79  )
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
Cc: linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, xen-devel@lists.xen.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, linux1394-devel@lists.sourceforge.net,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Previouly drivers have their own way of mapping range of
kernel pages/memory into user vma and this was done by
invoking vm_insert_page() within a loop.

As this pattern is common across different drivers, it can
be generalized by creating a new function and use it across
the drivers.

vm_insert_range is the new API which will be used to map a
range of kernel memory/pages to user vma.

This API is tested by Heiko for Rockchip drm driver, on rk3188,
rk3288, rk3328 and rk3399 with graphics.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <willy@infradead.org>
Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Tested-by: Heiko Stuebner <heiko@sntech.de>
---
 include/linux/mm.h |  2 ++
 mm/memory.c        | 41 +++++++++++++++++++++++++++++++++++++++++
 mm/nommu.c         |  7 +++++++
 3 files changed, 50 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index fcf9cc9..2bc399f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2506,6 +2506,8 @@ unsigned long change_prot_numa(struct vm_area_struct *vma,
 int remap_pfn_range(struct vm_area_struct *, unsigned long addr,
 			unsigned long pfn, unsigned long size, pgprot_t);
 int vm_insert_page(struct vm_area_struct *, unsigned long addr, struct page *);
+int vm_insert_range(struct vm_area_struct *vma, unsigned long addr,
+			struct page **pages, unsigned long page_count);
 vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn);
 vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
diff --git a/mm/memory.c b/mm/memory.c
index 15c417e..d44d4a8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1478,6 +1478,47 @@ static int insert_page(struct vm_area_struct *vma, unsigned long addr,
 }
 
 /**
+ * vm_insert_range - insert range of kernel pages into user vma
+ * @vma: user vma to map to
+ * @addr: target user address of this page
+ * @pages: pointer to array of source kernel pages
+ * @page_count: number of pages need to insert into user vma
+ *
+ * This allows drivers to insert range of kernel pages they've allocated
+ * into a user vma. This is a generic function which drivers can use
+ * rather than using their own way of mapping range of kernel pages into
+ * user vma.
+ *
+ * If we fail to insert any page into the vma, the function will return
+ * immediately leaving any previously-inserted pages present.  Callers
+ * from the mmap handler may immediately return the error as their caller
+ * will destroy the vma, removing any successfully-inserted pages. Other
+ * callers should make their own arrangements for calling unmap_region().
+ *
+ * Context: Process context. Called by mmap handlers.
+ * Return: 0 on success and error code otherwise
+ */
+int vm_insert_range(struct vm_area_struct *vma, unsigned long addr,
+			struct page **pages, unsigned long page_count)
+{
+	unsigned long uaddr = addr;
+	int ret = 0, i;
+
+	if (page_count > vma_pages(vma))
+		return -ENXIO;
+
+	for (i = 0; i < page_count; i++) {
+		ret = vm_insert_page(vma, uaddr, pages[i]);
+		if (ret < 0)
+			return ret;
+		uaddr += PAGE_SIZE;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(vm_insert_range);
+
+/**
  * vm_insert_page - insert single page into user vma
  * @vma: user vma to map to
  * @addr: target user address of this page
diff --git a/mm/nommu.c b/mm/nommu.c
index 749276b..d6ef5c7 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -473,6 +473,13 @@ int vm_insert_page(struct vm_area_struct *vma, unsigned long addr,
 }
 EXPORT_SYMBOL(vm_insert_page);
 
+int vm_insert_range(struct vm_area_struct *vma, unsigned long addr,
+			struct page **pages, unsigned long page_count)
+{
+	return -EINVAL;
+}
+EXPORT_SYMBOL(vm_insert_range);
+
 /*
  *  sys_brk() for the most part doesn't need the global kernel
  *  lock, except when an application is doing something nasty
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
