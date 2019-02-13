Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B0DC282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:58:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9F31207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SYlfkjtw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pbigDwG3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9F31207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=LacHrzkRLThnLynaaORXfyuuDEOnTOpBIdlX8qgBqyM=; b=SYlfkjtwqEyPti
	DsmQhZr+h5kuRzq/4wrIA5kQ8vjb+ddg9kU4MvTyWbOXnmTdPcjU6Z/vspDmFNPz9HG5tROiXWLHh
	ZGv5jeaXWfCJ2+keRoxeNkhV0kHw+5qn820b2CYqflMJP4Vi3BBlbOzKQDS+f1HrXV5ZoAQjIfuCk
	bSK2oCEpDoD9DEh43hu11tlaYSQbByk4YWkgjhDwX7t2upQjMPB3rCESazxfxs07GmtuMhYXsxBN3
	c0u3ZjDWPUzmYsTK2tFrou/XlGtXhwRSRaLwuYyvF30lzfHBcwWAKDWADWNd6MiyW7Xen9Pdqt6RL
	vwoFj+qYyuKRBcU+SiJQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtv3i-0005rf-KL; Wed, 13 Feb 2019 13:58:42 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtv3f-0005qY-MG
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 13:58:41 +0000
Received: by mail-pl1-x644.google.com with SMTP id e5so1208702plb.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 05:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=cNyFM0J2DfW9voxw9FzV7E7Y/LrzsWkGDKLqwe0d5pk=;
 b=pbigDwG3xTm4YxvGqJgLG5mkUt5O5OB6iH/4JOZPoXunwWHE5QfP4W9AElQvSudJa3
 oftivCtQcvYNS8YSZXakLgY/n/6uMXhgwbuZgbrYOMW2A6d9qxKamu6y4VDWZG9hKIXJ
 Ozs0l8wXg2IVBGQ5Lx1acSQcHqvuaQpFa+H5Y1d0IpRM9leug/xYa7/aLNdDjG8Ibi0w
 4YGogL/vRIFJoYsg51t1pmC4flEIvAwvnxiLzYGzdVd4eEsIiXYF+OFdhEXjta13phln
 wgXDc3SFMpLh8t92NQ4l/buWitqvWvWgjk6iHFgB8KwSjqoqS1sBA9XRvXu1Nzpx0Uuh
 rkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=cNyFM0J2DfW9voxw9FzV7E7Y/LrzsWkGDKLqwe0d5pk=;
 b=M4Hzp8EDHUlGbVQG2TUaEmLMmMIslyl9927JyxlVBu9YqPU9kiORUxsfKspCuvGHGN
 8sV+lC1bb3WxALY5MV+StFI51bGmd73ogk0Mr/QzPk+cxaQwy66e4/4FHGy9Pk3hypmi
 b0C2LTy08jktOD5RG0s+kXSLtHlyYpWkis35LFBV7Q5f9S9wiTo8jP2fGI8P08N34XO9
 umAGmVtdxj6qYqWxotyUtoZqDmNelh6qpGQp4TUwX0zNu4P8e+s5otzKEmbyiFlMDV4z
 kz3NV0mr0fuo/gDbL2sVKxY9bQl8WUkhfEiIFqEj49gxU6j0pEOI1010duecZLOSbxB0
 2+vw==
X-Gm-Message-State: AHQUAuY1hzFeGzqZ89sWJnTv12fl1EwAXXYDvNrQR4YW4vi5u8W3mQKc
 JhU1rTUY/RGhPDE3QhRFoAvfNJxE
X-Google-Smtp-Source: AHgI3IabBr7i0UINT5tZChzG9mkUSIkz97ziRf+i4G4ZGRQ2Pfd1KkCHgUpEt1D+OFFkb4bWmp/4Cw==
X-Received: by 2002:a17:902:20e2:: with SMTP id
 v31mr640198plg.307.1550066318585; 
 Wed, 13 Feb 2019 05:58:38 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([49.207.48.54])
 by smtp.gmail.com with ESMTPSA id f67sm30721286pfc.141.2019.02.13.05.58.37
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 13 Feb 2019 05:58:37 -0800 (PST)
Date: Wed, 13 Feb 2019 19:32:56 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
 linux@armlinux.org.uk, robin.murphy@arm.com, iamjoonsoo.kim@lge.com,
 treding@nvidia.com, keescook@chromium.org, m.szyprowski@samsung.com
Subject: [PATCH v3 2/9] arm: mm: dma-mapping: Convert to use vm_map_pages()
Message-ID: <20190213140256.GA21977@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_055839_724825_4A5DCF80 
X-CRM114-Status: GOOD (  14.63  )
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

Convert to use vm_map_pages() to map range of kernel
memory to user vma.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 arch/arm/mm/dma-mapping.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index f1e2922..de7c76e 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1575,31 +1575,21 @@ static int __arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma
 		    void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		    unsigned long attrs)
 {
-	unsigned long uaddr = vma->vm_start;
-	unsigned long usize = vma->vm_end - vma->vm_start;
 	struct page **pages = __iommu_get_pages(cpu_addr, attrs);
 	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	unsigned long off = vma->vm_pgoff;
+	int err;
 
 	if (!pages)
 		return -ENXIO;
 
-	if (off >= nr_pages || (usize >> PAGE_SHIFT) > nr_pages - off)
+	if (vma->vm_pgoff >= nr_pages)
 		return -ENXIO;
 
-	pages += off;
-
-	do {
-		int ret = vm_insert_page(vma, uaddr, *pages++);
-		if (ret) {
-			pr_err("Remapping memory failed: %d\n", ret);
-			return ret;
-		}
-		uaddr += PAGE_SIZE;
-		usize -= PAGE_SIZE;
-	} while (usize > 0);
+	err = vm_map_pages(vma, pages, nr_pages);
+	if (err)
+		pr_err("Remapping memory failed: %d\n", err);
 
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
