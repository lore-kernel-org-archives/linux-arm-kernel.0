Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760F8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:18:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E638206A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YMrkzqi9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oDI8mY+6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E638206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=LE7HS42kgdNsnQuygyrKzQxuNlAjPlscyGT3hjwJAHE=; b=YMrkzqi9RxrFrr
	CFhKoNU7SXfEH5nFqxzFqzxdXXblQMI8AX29WDaVFQ41uidhDKwefqDkT+NrGQ74cKPs4odmx6DGY
	AhxW1ibA906S0g+pyUPmJ9p6w4umuFgvFS43zHV/3fHjqoIKQtv6MOG3RxHZ1l+BizL+A9Dy1cy1N
	GAIDlSuCS/6sQR1rC40DjAqiVsAG4zrWe3DpQUndsDYuO8JGjX0v+qFd4/glxhTf5MqD9Wki+KDKl
	H7Ly5Z/GogXi/K2izosubak+k/t3RXenp+5knXQ3zh8sUvp+TagfA/73KbQAhtBlaEwfdD2bogb+B
	BSHopLfV66/T8wMtQFUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYzLT-0006nC-NA; Mon, 17 Dec 2018 20:18:31 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYzLQ-0006lR-OC
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 20:18:30 +0000
Received: by mail-pl1-x642.google.com with SMTP id u6so6640898plm.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 12:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=sUyJE5XZI7PFTFAoMHl2QCf6i1YL7AfLuhA9/P6Ludc=;
 b=oDI8mY+6/0wwXEtDv6zcp3R2be1Zb57Xo3+v9BgCECtnF3xZe4e8/tCJOt9WNsnuNx
 dqVRMZuoCSfpN+GFfo5EpPACd5VV2asAKw/G+JnlkZozp2FqwUiuz2MyMTA/bpiNA8FP
 /uhScwqU9of7msQcUs0RSLMfAcjhdw226Pxn8s0V8n4CjppbpLxwAuvntwSiFxpLjbA2
 pcmRRP643OFxHfwdNeVffdCCBG6XaRBWXxcCjvuidnKsuqLa7j9RmI8ohICniP6TJhDI
 FERVM7BvY/lViYwRv5CDf8ZBTyVQPoRRuNdXThd00kyj137d+EIDPGbH7zTF1fUS1n7B
 6yfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=sUyJE5XZI7PFTFAoMHl2QCf6i1YL7AfLuhA9/P6Ludc=;
 b=QZ2GMNdD4y1l1leDpEPqcXXn5QvZFjeNqUu6VjrZQB+J68uxt/BskKeWy5/1xyS3n4
 4x9ICpigLqxkNYVdHVrr8gmwSDzcOcbv3BjrBITz7OTaUjS7/kumn53Q0iERLLI//2SH
 382cwaDf33tzJ6PJ3lxf3/FveyH6abZkNiBBDgp2PnlT9peAcC/FIJgZ69CjOxnkTBeM
 WR/G8p+bPy34pqsopcx/qm4bhKVLFce7sow6idkjTpdO0VTLcrPacWJY4V6Ij0TE273d
 2bGGj8b1FmmVi7A/9f2d6dQBbY+wE4AQaey0hqMYnmnZpllp2ViRLbXpv5r1XsL2dyp1
 PoHg==
X-Gm-Message-State: AA+aEWY2PrXLorr9QQiagwdEg5Fq5hZD4Fklf9ZBXQiNaURlyZesds1Z
 g9K58xD9q3Mm7bQ2XvLW9iC/HrZY
X-Google-Smtp-Source: AFSGD/XTMTjOndtTsiXcrd9fAIUCns/BphtM6xp91sNWu1YXSRoFffBVluebJhG/DoyPebkudZUydA==
X-Received: by 2002:a17:902:a70b:: with SMTP id
 w11mr13818009plq.84.1545077897631; 
 Mon, 17 Dec 2018 12:18:17 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.98.208])
 by smtp.gmail.com with ESMTPSA id m19sm35920803pgn.35.2018.12.17.12.18.16
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 17 Dec 2018 12:18:16 -0800 (PST)
Date: Tue, 18 Dec 2018 01:52:09 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
 linux@armlinux.org.uk, robin.murphy@arm.com, iamjoonsoo.kim@lge.com,
 treding@nvidia.com, keescook@chromium.org, m.szyprowski@samsung.com
Subject: [PATCH v4 2/9] arch/arm/mm/dma-mapping.c: Convert to use
 vm_insert_range
Message-ID: <20181217202209.GA8859@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_121828_783260_F59FA605 
X-CRM114-Status: GOOD (  15.14  )
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
index 661fe48..7cbcde5 100644
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
+	if (off >= nr_pages)
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
