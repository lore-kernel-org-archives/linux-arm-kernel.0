Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A058C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 06:17:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEB78206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 06:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LIOXAWXB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBs4dq/T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEB78206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=yDs4Xms5Ue56josWB+LHsRMfigi+c1rAhzGbOMhld0k=; b=LIOXAWXBBYB63+
	Q/42Xm5WHYYXh0pyahfDIJVOiPSJIG1iEB3dEvzG+gSmpNrEN8aJi6EDohgoJ5BXYy53Ea3nMmGRY
	n4SEkjr7d4qS7M/0jThkH5n5Mgx0WcvKZviOBvduJEGSAw+ude/InvUg/5xFTn5AAjiwTPDvoszUk
	xttVd5tEK1MCWHTcjB5gU7OuKlvt0tjQ0VYHkuFTBKlEpSymSVvTcBnwsIHQN2ySBRR5DgIZeoazR
	4DFznwG6h6l09AOZ9VFpPgHz2WAY05g7qbB2VzotH2wFbvAfEwj3GeH7ytIUpwYDNrm1wdtKCdetG
	WuofN4Wv/RgxrIlNGvgg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTL4V-00027H-3i; Sun, 02 Dec 2018 06:17:39 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTL4S-00026V-66
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 06:17:37 +0000
Received: by mail-pf1-x442.google.com with SMTP id g62so4771936pfd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 01 Dec 2018 22:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=8CQaNbWYfH4rrtr7y1L1OPdwNgqhGo43ZWeJVCZSPio=;
 b=mBs4dq/TeqPHUFL3AVrh3JJ/g+dMhVdSUtuuYiWThyelgCPlvamNLncj9Z0m9wretJ
 dHQvALWfWyfZ+7pRKHCJ8GadHqubftSlzYY9F1kU9Q42HBarg2E2uV5mDeQzLVNSb048
 gv8GxLTCIgRIx432n2ija9tH3s8sgqauV6Ulm8WtyP7po08V3uPqb5C6Xs5u3x4KCpZC
 GAXsbgqClWr3kUjmQtErJtDmoLutvnGAy293IObP4qojbp3bkmwLacBfB9qkW4bQdN86
 hJ62U470REpyHVCTaNKFe5GJyUfNQi/0Px/7/+s0OfcUYwyXdeauPqvC1Q2BEUbrPjW7
 CDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=8CQaNbWYfH4rrtr7y1L1OPdwNgqhGo43ZWeJVCZSPio=;
 b=l9fpSL/x+vdFl3FA7imjgaHLS9HUE2KOzsyMxAKCOYDNVdcLb4nlA2NbkY3SvphDJT
 +uIueN1GEmVYtKLFSW8lGSWwikPlmTBb0FBmTdUXnlz3dAXnuVhHrJv/7q7yd8OJT3Ck
 GcpMCW6AO6dtCf6L94fWwk/NykveF/xJGjfev3okhvBevJTJD+R+mMiXT/ZGiZsQssyo
 dZSNW/2Eai5uZF+a3uKuis8n5ZZ0v+dQWm6EgIPz12jtN12n8pqDzInH9shihkv9+5g8
 yVadQWpgy/V2BBK9JKOJMJeHx6pXYHLmH9vwt7aOnsNOiyQWZhLZtkzEBiPRfiLcoM8k
 NPfw==
X-Gm-Message-State: AA+aEWZejBUyLA9w7Q6AkQjABaBeSY/J4X896ZYoxSmjH0V+nSTuwb3l
 bfHqDqYMpo3V6Mxbb3pkntUfi/F2
X-Google-Smtp-Source: AFSGD/XskkVCLMV56P5G6hSJkQEj8Bb7420tD78vrgpfyz80/Ofs70Y80gJpaUlH3MXPhcU17HkqjA==
X-Received: by 2002:a65:63d3:: with SMTP id n19mr9785026pgv.179.1543731445240; 
 Sat, 01 Dec 2018 22:17:25 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.99.148])
 by smtp.gmail.com with ESMTPSA id q1sm12648437pfb.96.2018.12.01.22.17.23
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sat, 01 Dec 2018 22:17:24 -0800 (PST)
Date: Sun, 2 Dec 2018 11:51:09 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
 linux@armlinux.org.uk, robin.murphy@arm.com, iamjoonsoo.kim@lge.com,
 treding@nvidia.com, keescook@chromium.org, m.szyprowski@samsung.com
Subject: [PATCH v2 2/9] arch/arm/mm/dma-mapping.c: Convert to use
 vm_insert_range
Message-ID: <20181202062109.GA3111@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181201_221736_224190_86D1D55F 
X-CRM114-Status: GOOD (  15.10  )
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
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Convert to use vm_insert_range() to map range of kernel
memory to user vma.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 arch/arm/mm/dma-mapping.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 661fe48..4eec323 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1582,31 +1582,24 @@ static int __arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma
 		    void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		    unsigned long attrs)
 {
-	unsigned long uaddr = vma->vm_start;
-	unsigned long usize = vma->vm_end - vma->vm_start;
+	unsigned long page_count = vma_pages(vma);
 	struct page **pages = __iommu_get_pages(cpu_addr, attrs);
 	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	unsigned long off = vma->vm_pgoff;
+	int err;
 
 	if (!pages)
 		return -ENXIO;
 
-	if (off >= nr_pages || (usize >> PAGE_SHIFT) > nr_pages - off)
+	if (off >= nr_pages || page_count > nr_pages - off)
 		return -ENXIO;
 
 	pages += off;
+	err = vm_insert_range(vma, vma->vm_start, pages, page_count);
+	if (err)
+		pr_err("Remapping memory failed: %d\n", err);
 
-	do {
-		int ret = vm_insert_page(vma, uaddr, *pages++);
-		if (ret) {
-			pr_err("Remapping memory failed: %d\n", ret);
-			return ret;
-		}
-		uaddr += PAGE_SIZE;
-		usize -= PAGE_SIZE;
-	} while (usize > 0);
-
-	return 0;
+	return err;
 }
 static int arm_iommu_mmap_attrs(struct device *dev,
 		struct vm_area_struct *vma, void *cpu_addr,
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
