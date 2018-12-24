Return-Path: <SRS0=tR0U=PB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAC3C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 13:18:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 699B721850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 13:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qfS5IXTO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2KO5MMx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 699B721850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Q5eRZzflgUxPZYzm6dyV+RmY5SIqYDQONZafcycsS20=; b=qfS5IXTO5WfALB
	WqlYYs2WGIrqZaPDFAkJuBYqj+rdEUEzsSBfV+ZUTGvMHK5iseLgN4SfY0jtl4tcjTdvPrsnBgWSh
	5XOXCrBMBtqB9G2yZn4Ul+Pb9pXbwc251f21z3NrvjJe8B4kKaaJaHxpHO5tlZq1Kv7RKKzbPVQ+X
	oSWiP6eXsOA8NXLy1gY0hURlRBQxY5Pzjjm80hQDNiy28+x8r3+LDCPKoSRpXOI1XK1lFLF3ZaXj6
	5fx4HakpYfVbphw8Ii6hAFeIk4G298iydXN0GMbVpGuYNapUZaLqjNQCp/OKp/uZ6/aD77JRAu13k
	MmjsTEr7pcEyTSlBQb2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbQ7M-00033N-RB; Mon, 24 Dec 2018 13:18:00 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbQ7J-00032F-Kk
 for linux-arm-kernel@lists.infradead.org; Mon, 24 Dec 2018 13:17:58 +0000
Received: by mail-pf1-x443.google.com with SMTP id h3so5812842pfg.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 24 Dec 2018 05:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=MMGJzHhmNthI9sRZkbXZ1iYyH2jshJ0o/VQkgO88tcs=;
 b=i2KO5MMxJo3/5LWrPLeNLGeva3Ne1DqGYNQmkVfffqJy/7Blwc1ZQTxF5q7/4cdbVK
 vIexInnWRoT/V11j7MMRf8p2pNk7N6+FKaVdWJPsVT0PJ7MRGJWCmKDRYYVgzm9PVFZR
 7Kz4JADaRzoTvV+K+ajZHPtgb0txgVU5jA3CliuIeqyf9MC+6XxOOcepTV0uLQH9GDeU
 B5bw7Mj0iLy6LrkPqE9j4pev1wfm6d67jrKNbReUFngf1M0upuqrGUYdICcRDO0tsAEw
 f+JmsDBaFgTBiSI+JannbW3PzQBDJacAB8VRitF1ub03PgJ8p0gttKrXb8wKIRMKAK35
 /Ikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=MMGJzHhmNthI9sRZkbXZ1iYyH2jshJ0o/VQkgO88tcs=;
 b=QQAvy0W7QmWPassPfxpTbKDTM9sRBQpPFx9g0phxajbd+urhc8gilSAIcQsRAGmzMY
 Opi8t7xWD1+TEiEHpYKDtvK6lZ5Och6vawQ3WO0ZhsFyNj/5LcVWEU0BfqDbrkXfYyS6
 PGo6bpVoQQ5/AfdOjZvRSIMlZWo/FuCN3HcSlv2Iozzemervyfg15IIQcRKaYrkpghGa
 XvzskYUVXdH3n5qmnkISlq3SbnxWxBxtjpN8rkDPw6j+An6qYz05aBcQgewsRw4RleFe
 qgHw2H671aLbOiLPAmX4DycEdM52FFGyZMNVIY7W64vOFYeqKWsZUIqVQsqZeRuugdPs
 Um4Q==
X-Gm-Message-State: AA+aEWaB6PBnvl0muzAV4l4Cz4a/Wrqu7VyEu02g2awsOOlqNWDZS57Z
 0wxNiENt/srOkmW3fBy/mFfc1Jk5
X-Google-Smtp-Source: AFSGD/UmasEKtYGJVvYE7ECLRPqA3+g1rUsYqcP4hh5vWWnPBQkurqM+K4wJcBIT4twxElNbufrYjA==
X-Received: by 2002:a62:e0d8:: with SMTP id d85mr12901342pfm.214.1545657466691; 
 Mon, 24 Dec 2018 05:17:46 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([106.51.18.181])
 by smtp.gmail.com with ESMTPSA id c23sm39254231pfi.83.2018.12.24.05.17.45
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 24 Dec 2018 05:17:45 -0800 (PST)
Date: Mon, 24 Dec 2018 18:51:42 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
 linux@armlinux.org.uk, robin.murphy@arm.com, iamjoonsoo.kim@lge.com,
 treding@nvidia.com, keescook@chromium.org, m.szyprowski@samsung.com
Subject: [PATCH v5 2/9] arch/arm/mm/dma-mapping.c: Convert to use
 vm_insert_range
Message-ID: <20181224132142.GA22070@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181224_051757_684664_40379F00 
X-CRM114-Status: GOOD (  14.86  )
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
 arch/arm/mm/dma-mapping.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 661fe48..63467b6 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1582,11 +1582,12 @@ static int __arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma
 		    void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		    unsigned long attrs)
 {
-	unsigned long uaddr = vma->vm_start;
 	unsigned long usize = vma->vm_end - vma->vm_start;
+	unsigned long page_count = vma_pages(vma);
 	struct page **pages = __iommu_get_pages(cpu_addr, attrs);
 	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	unsigned long off = vma->vm_pgoff;
+	int err;
 
 	if (!pages)
 		return -ENXIO;
@@ -1595,18 +1596,11 @@ static int __arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma
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
