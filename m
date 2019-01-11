Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90339C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:03:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 628632084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MatSI9p0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecFP8Fvc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 628632084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=xfggkln8Fe7T2dpJDzLwDbUEk+ufEeb9vt9YEMeRAw0=; b=MatSI9p0DV7tAd
	+FpFlEzqcvWcWbt2McYueY5CBsgf3wHJm0rgTkn89C0kKsM4plJpcXmH7+3rD7cue/5X4gkKQ2nOA
	d35bmDDjjTvzBABP5fhus2A/i6g4qYSRJQEgx8MxMkD2PhgDxhSwZQQQvj2fOWkzULOZz3i4MWbjn
	R3pasfVtMxJErqJpTPNeahyeLo0ALMH2kiJn42cdFOui2DVT5bMmL3BHJpb1xS7ih88KvlibRJEw5
	Gli7wZViLb0EmnK1EKgS3ixfWm5CaqzpiynNitCURlVmXhvwOgGpvRLUZdy0nSOVEy3GyiIR/SvgB
	XuWto0/gtFslF2A4Znrg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghyL7-0006Ca-RQ; Fri, 11 Jan 2019 15:03:17 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghyL3-0006Bo-Gf; Fri, 11 Jan 2019 15:03:15 +0000
Received: by mail-pf1-x442.google.com with SMTP id h3so7085466pfg.1;
 Fri, 11 Jan 2019 07:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=OKnr+eVdmA4Yca5asvAl3VJvv/8NsBSwy+KQiY0Jcow=;
 b=ecFP8FvcstIqu0NB/u52GoYNOTcWG2DvcB07IgY8lEs9qJPP4QRrMpFsf79PdPyxVo
 +95bi0qc4yFsVreg3UGS61GpTOuoYCQnYZyc+5rX9mPEq6iWXgJAAzC0Dic6/1Ac4kdd
 ToSp1I9tu34JSInsxojwgpUz/v6muGU8hTz3xenp7NxE8zdhMiFKGpknt4LFIcIdPB8A
 yk0tCLiaSAkmPdaK/WpQa8EEuvjBTrzwO+wwZHg4X6ykM3D78CNfnJIFfuAC4GhqGeJE
 2By7VfXiT62OJFnrYXEMYkgKZWvN35vVUGiGIWMLm2+uUIMEr0RRqcicvSTWrx7DGnxD
 TQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=OKnr+eVdmA4Yca5asvAl3VJvv/8NsBSwy+KQiY0Jcow=;
 b=fngzHXQJ13nMFw+U9a4zpLjKWa19yvpWuJV5sk2m6gWSIhjKmvt9GKqDpqXUFdO070
 W99PPs7ZH/6ntPPiqZG1amCaImkUIduvWPijhN82pU4v1ckP/+m82/Di1EjXZCZfC2F3
 9PglRy03YJxCJ6dgnUtaNWNCwy0lEIWGQouKmbk7INwRB7e2iw3zPA5W+FiI65JBlE5F
 R2uiTKAnCChtKEMvzj6APUFIBkjaS9YpApqwIRmaEKOK6CCAVCk1ZZdCpFdeJgxh3c1L
 mRa8RsiEbBVKuL/2n2QMXkaWUW/1nnEhHVADrDPmaPWU+kZEomd/vdMjxaaaoqy6idX8
 ID1A==
X-Gm-Message-State: AJcUukfHO5mz5H5B8/h6PMMz4VDaVvXFAlT5kiv8m52+4cpKNUQC8FMm
 bviyjITGn8dN9pkpe1iHNBE=
X-Google-Smtp-Source: ALg8bN4N+0OC/ohlRldBlS6pqDxN4tNRJaVupZC6A5wD5JEK2YvVMDK1VGgLB+11HRGTGie4+RIV4Q==
X-Received: by 2002:aa7:80d7:: with SMTP id a23mr14629976pfn.86.1547218992868; 
 Fri, 11 Jan 2019 07:03:12 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([49.207.52.190])
 by smtp.gmail.com with ESMTPSA id d129sm119031814pfc.31.2019.01.11.07.03.10
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 11 Jan 2019 07:03:11 -0800 (PST)
Date: Fri, 11 Jan 2019 20:37:12 +0530
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
Subject: [PATCH 1/9] mm: Introduce new vm_insert_range and
 vm_insert_range_buggy API
Message-ID: <20190111150712.GA2696@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_070313_556375_ECA2BCFB 
X-CRM114-Status: GOOD (  16.65  )
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
be generalized by creating new functions and use it across
the drivers.

vm_insert_range() is the API which could be used to mapped
kernel memory/pages in drivers which has considered vm_pgoff

vm_insert_range_buggy() is the API which could be used to map
range of kernel memory/pages in drivers which has not considered
vm_pgoff. vm_pgoff is passed default as 0 for those drivers.

We _could_ then at a later "fix" these drivers which are using
vm_insert_range_buggy() to behave according to the normal vm_pgoff
offsetting simply by removing the _buggy suffix on the function
name and if that causes regressions, it gives us an easy way to revert.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Suggested-by: Russell King <linux@armlinux.org.uk>
Suggested-by: Matthew Wilcox <willy@infradead.org>
---
 include/linux/mm.h |  4 +++
 mm/memory.c        | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/nommu.c         | 14 ++++++++++
 3 files changed, 99 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5411de9..9d1dff6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2514,6 +2514,10 @@ unsigned long change_prot_numa(struct vm_area_struct *vma,
 int remap_pfn_range(struct vm_area_struct *, unsigned long addr,
 			unsigned long pfn, unsigned long size, pgprot_t);
 int vm_insert_page(struct vm_area_struct *, unsigned long addr, struct page *);
+int vm_insert_range(struct vm_area_struct *vma, struct page **pages,
+				unsigned long num);
+int vm_insert_range_buggy(struct vm_area_struct *vma, struct page **pages,
+				unsigned long num);
 vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn);
 vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
diff --git a/mm/memory.c b/mm/memory.c
index 4ad2d29..00e66df 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1520,6 +1520,87 @@ int vm_insert_page(struct vm_area_struct *vma, unsigned long addr,
 }
 EXPORT_SYMBOL(vm_insert_page);
 
+/**
+ * __vm_insert_range - insert range of kernel pages into user vma
+ * @vma: user vma to map to
+ * @pages: pointer to array of source kernel pages
+ * @num: number of pages in page array
+ * @offset: user's requested vm_pgoff
+ *
+ * This allows drivers to insert range of kernel pages they've allocated
+ * into a user vma.
+ *
+ * If we fail to insert any page into the vma, the function will return
+ * immediately leaving any previously inserted pages present.  Callers
+ * from the mmap handler may immediately return the error as their caller
+ * will destroy the vma, removing any successfully inserted pages. Other
+ * callers should make their own arrangements for calling unmap_region().
+ *
+ * Context: Process context.
+ * Return: 0 on success and error code otherwise.
+ */
+static int __vm_insert_range(struct vm_area_struct *vma, struct page **pages,
+				unsigned long num, unsigned long offset)
+{
+	unsigned long count = vma_pages(vma);
+	unsigned long uaddr = vma->vm_start;
+	int ret, i;
+
+	/* Fail if the user requested offset is beyond the end of the object */
+	if (offset > num)
+		return -ENXIO;
+
+	/* Fail if the user requested size exceeds available object size */
+	if (count > num - offset)
+		return -ENXIO;
+
+	for (i = 0; i < count; i++) {
+		ret = vm_insert_page(vma, uaddr, pages[offset + i]);
+		if (ret < 0)
+			return ret;
+		uaddr += PAGE_SIZE;
+	}
+
+	return 0;
+}
+
+/**
+ * vm_insert_range - insert range of kernel pages starts with non zero offset
+ * @vma: user vma to map to
+ * @pages: pointer to array of source kernel pages
+ * @num: number of pages in page array
+ *
+ * Maps an object consisting of `num' `pages', catering for the user's
+ * requested vm_pgoff
+ *
+ * Context: Process context. Called by mmap handlers.
+ * Return: 0 on success and error code otherwise.
+ */
+int vm_insert_range(struct vm_area_struct *vma, struct page **pages,
+				unsigned long num)
+{
+	return __vm_insert_range(vma, pages, num, vma->vm_pgoff);
+}
+EXPORT_SYMBOL(vm_insert_range);
+
+/**
+ * vm_insert_range_buggy - insert range of kernel pages starts with zero offset
+ * @vma: user vma to map to
+ * @pages: pointer to array of source kernel pages
+ * @num: number of pages in page array
+ *
+ * Maps a set of pages, always starting at page[0]
+ *
+ * Context: Process context. Called by mmap handlers.
+ * Return: 0 on success and error code otherwise.
+ */
+int vm_insert_range_buggy(struct vm_area_struct *vma, struct page **pages,
+				unsigned long num)
+{
+	return __vm_insert_range(vma, pages, num, 0);
+}
+EXPORT_SYMBOL(vm_insert_range_buggy);
+
 static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 			pfn_t pfn, pgprot_t prot, bool mkwrite)
 {
diff --git a/mm/nommu.c b/mm/nommu.c
index 749276b..21d101e 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -473,6 +473,20 @@ int vm_insert_page(struct vm_area_struct *vma, unsigned long addr,
 }
 EXPORT_SYMBOL(vm_insert_page);
 
+int vm_insert_range(struct vm_area_struct *vma, struct page **pages,
+			unsigned long num)
+{
+	return -EINVAL;
+}
+EXPORT_SYMBOL(vm_insert_range);
+
+int vm_insert_range_buggy(struct vm_area_struct *vma, struct page **pages,
+				unsigned long num)
+{
+	return -EINVAL;
+}
+EXPORT_SYMBOL(vm_insert_range_buggy);
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
