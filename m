Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2C1C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 06:16:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F41E206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 06:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SwwUOEh2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWk6uLkF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F41E206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=EnTxqhTPWtIbvs1vXRwvbzvl8j+enRT+T5argddrCOE=; b=SwwUOEh2nIxfDD
	lTgcb73Jb9Qlhe08/XViFCCcK31nwyLC+5pXDUaTpVmlfkxrSpqsAJzKrwxNzg4jJ58lxLx98606k
	vLaJdtAs/r+gJ2LSq/y18cSYaEUi9q98d3p/MQYxh0+5BmM9tG0M0har5A95OqPYs1eczFSDkKDgx
	DUKFtzvRuRR3ixTbtxilczr8hWMlOvzISuJi+kgUUV+Dt0PWKXY2t1FPyJBPfwJhxi65jQm4wCqbC
	GtPGpwx2p7GbNQ6iYCn8kliutfg/nG6iz1j0GEjwtVy/9p3zQ5O+1kHVcYMSezAwQeFxLPEQN0WgA
	731RQE55WS7kq28L7t3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTL39-0001i9-R6; Sun, 02 Dec 2018 06:16:15 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTL35-0001gt-F7; Sun, 02 Dec 2018 06:16:12 +0000
Received: by mail-pf1-x442.google.com with SMTP id c123so4796301pfb.0;
 Sat, 01 Dec 2018 22:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=zpuGNdUnpdN5wTEIRBOxYuxj5rUfCCVuWQ25gpRoE6s=;
 b=bWk6uLkFrct4pezrRVHDS3fxAfnzuH30JJU4oMJOz2yuRc6qGON0LS3euO9PI18qCG
 ZWCJ/La6wnc++Nb6Jl5M7htxappQkoe07uJn+Tgm2gzZrUpW4u6sFMq4hhElyN39p+9v
 zz1vE8r8mohE3kP3S+LsBxTj9Y9QmOvTxyr+xuNsnDmySrcEt7Zz/1uqxJRqxgRQTFTW
 h/SSYR9cuTSYigG5l+TwSwbmOvd7pT/sHv8kYvijQHX0gOgpzngqpuzQWss+3SjvQuvP
 Q74IyFtYvg1IFgMLRPd0NLO+dpLsHbzDcBnYYIMyHZbKylIA5otr3Lj2UWKVL3p/SPpM
 lv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=zpuGNdUnpdN5wTEIRBOxYuxj5rUfCCVuWQ25gpRoE6s=;
 b=oqd+jTb5niOe0MPJswwtIHCf2gcionrUvms+eFkvjOwNEmTEkbZX8GWD8hj5ShSoFG
 5DmmhTwXCp2pB5p3W/GpIGM4cH5fq4vDNTo2PFHSg/rvruU2O1R7VFgOemf2cZzf2mcx
 vuJ0AKAl1yumKhnK4vkw47DUKZUHdNPyTaQ9ojzrR4RUSq2zR0baDCZbPcMte49MlHOR
 zKdKDKnN5rXZTSm1PUuwnWOe1ATN2EOIyDsiS7nf2l6+AINxMlBEeMQ0I70asfOb9nTu
 IThhX7+hffwPuFTQmUy+U3Wf+ehLVgqPGSBtrOL9RMcB2nZrMWk0uFNTmu5UB61sclTY
 PrcA==
X-Gm-Message-State: AA+aEWaRzHghXmj3EvuGQuAGYezSpCyriAyZJErluuS2tcmf846h1E56
 CRxIx28M//5KQuHUEHoYNiQ=
X-Google-Smtp-Source: AFSGD/UBkP9uRpZkSu5Rmi17UiqjfK/g8dHm6TgDXv94eGr1l1iC6bkXVyD45WRhl9f9OjSvEy60DQ==
X-Received: by 2002:a63:4c4e:: with SMTP id m14mr9689461pgl.173.1543731360563; 
 Sat, 01 Dec 2018 22:16:00 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.99.148])
 by smtp.gmail.com with ESMTPSA id v14sm16952190pgf.3.2018.12.01.22.15.58
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sat, 01 Dec 2018 22:15:59 -0800 (PST)
Date: Sun, 2 Dec 2018 11:49:44 +0530
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
Subject: [PATCH v2 1/9] mm: Introduce new vm_insert_range API
Message-ID: <20181202061944.GA3094@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181201_221611_510478_93E54419 
X-CRM114-Status: GOOD (  16.44  )
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
Tested-by: Heiko Stuebner <heiko@sntech.de>
---
 include/linux/mm_types.h |  3 +++
 mm/memory.c              | 38 ++++++++++++++++++++++++++++++++++++++
 mm/nommu.c               |  7 +++++++
 3 files changed, 48 insertions(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5ed8f62..15ae24f 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -523,6 +523,9 @@ extern void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
 extern void tlb_finish_mmu(struct mmu_gather *tlb,
 				unsigned long start, unsigned long end);
 
+int vm_insert_range(struct vm_area_struct *vma, unsigned long addr,
+			struct page **pages, unsigned long page_count);
+
 static inline void init_tlb_flush_pending(struct mm_struct *mm)
 {
 	atomic_set(&mm->tlb_flush_pending, 0);
diff --git a/mm/memory.c b/mm/memory.c
index 15c417e..84ea46c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1478,6 +1478,44 @@ static int insert_page(struct vm_area_struct *vma, unsigned long addr,
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
