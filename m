Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E03BC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:04:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D721218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eW4z+Zsq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tSgjerC4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D721218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=CAh7QdxqeeSeZjRvb+525QkSHCYHIjL9tykpAOvGOcE=; b=eW4z+ZsqrOsg9E
	7VkHOjiUOoMuKn0MvqGdw30G4tZVSZv8ng9JR7bbDRS0OnTGTpGAHHtslcjQrqOSmapRkI/qiRLGp
	la/ifJH8u8zm0sIC3LWPGPL61QVi57kNC6twnwkx4tEcK0IZQF7rcswKjIq7o3P6T8V5T2GgxgiIZ
	xy8bjSny655mGoSY93RE8muL2G1UplDkxX89ZGETZDsSPBC20At+Apj9/1RmHLRPEWSfXoIalHNjp
	rvEZGStma5KVAMAxOGxn5FVHoV71a3VZiF1YVV75Rw1tdXP9cKQqfXIbUgOnFRDdkVp2VbeOaTEXH
	UdSEs8fZmF0lzURCS1HQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp2ep-0001lk-Vr; Thu, 31 Jan 2019 03:04:51 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp2em-0001ji-AC
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 03:04:50 +0000
Received: by mail-pf1-x441.google.com with SMTP id 64so791461pfr.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 19:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=9UKheLNLSM7085+hYajJxzL+Wpldb3TOma8RXX0hjL4=;
 b=tSgjerC4dK44S06W0OSTr53cNg28+6cUTE4HzPUKTdkevWVpDJ97JFTp+cPosrPNEV
 D8rphH0u8PJiDjdQsW2TNjafYIBoOsL1lTpSoOkAZyJOLs4Vo+jTdmYEwU7Jl7hXgk8u
 bhAoeiu1BDGFLMWPAWbdszIxVsMvwVSrmn9/NbkQyumWfBx94sOwPfkrdncoz+vMpmLN
 GvJIbeBoL5m3lTrGsdAHY7E5Ffo5FQtSCX5JwL9a+t7uCBTkj1fO/HsLuTpU2zXaDEU3
 Ob05VCxwKCGE7QtPagY4Sd1s9LT8xNY41xJLt1okURF5K+hRbPJY9tnqbjP0VDuMbxqy
 h/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=9UKheLNLSM7085+hYajJxzL+Wpldb3TOma8RXX0hjL4=;
 b=h8VqgGA1wP8v7J0dMRK0UhwN9UYbq11kUp3Hq4SsC1Z29px/58i3DImZ9urIr5owCE
 wCS3UOsZ4U+Ym0HbkaYFPe+LgPJFp8oPWZvsaegh/6keU5RQ9V+OVnggReI7EA6mwwia
 BXi+Pl3VHiutFdmhnASF3G7AY8JIHlW+rHiBJd3zNVQ3v6ZUxvg+UKjGXPycXKHXmJ/Z
 LAF8R4esvXW1yekvuoaXidIKwUsr/uLtfy1JI8fX2CAsSsByPOOSu6tACEh/TWdBuAlN
 dfvIyKtVaywbl+GjEvkDuCQG+8huJ6yvH/odyIn5PnFiYm3AGSE2fF5zCXmENszbf5Ka
 JRbQ==
X-Gm-Message-State: AJcUukdqK1w0T/TvIpUUjnJBbQA3xNbZ6fvMm9CCwweEkLhU0MKU3cpM
 kObfRb3yPwzBPE1+DR1LYjzeSMvu
X-Google-Smtp-Source: ALg8bN4FchuqbyYG65Y851K8FAAMbykpYxvta9bA6d520FyHakM49c32bL40WPlrtGU5T7jPX/J4QA==
X-Received: by 2002:a63:7c6:: with SMTP id 189mr30429168pgh.129.1548903887364; 
 Wed, 30 Jan 2019 19:04:47 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([106.51.20.103])
 by smtp.gmail.com with ESMTPSA id o13sm4055072pfk.57.2019.01.30.19.04.45
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 30 Jan 2019 19:04:46 -0800 (PST)
Date: Thu, 31 Jan 2019 08:39:00 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
 linux@armlinux.org.uk, robin.murphy@arm.com, iamjoonsoo.kim@lge.com,
 treding@nvidia.com, keescook@chromium.org, m.szyprowski@samsung.com
Subject: [PATCHv2 2/9] arch/arm/mm/dma-mapping.c: Convert to use
 vm_insert_range
Message-ID: <20190131030900.GA2284@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_190448_586777_20D015CE 
X-CRM114-Status: GOOD (  13.79  )
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
 arch/arm/mm/dma-mapping.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index f1e2922..915f701 100644
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
+	err = vm_insert_range(vma, pages, nr_pages);
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
