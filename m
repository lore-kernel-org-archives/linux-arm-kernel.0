Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0D1C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:37:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91D2320878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="orEFGE6R";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQdYEmv/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91D2320878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=yDs4Xms5Ue56josWB+LHsRMfigi+c1rAhzGbOMhld0k=; b=orEFGE6RksC5CS
	G9wgxPDSoEtWl1B1oMjfFPHUiCi1jAcUoG2RzAag5HteWazpPCdoQo1wh9Ar26g2ljXl6CbfWF8lF
	2BnkyFsDjOO02wlocjWFNtc5c6I+fUM9xY6RIxudOd7PNQf9JCj7f9Wc6yPXIfmuE+fQVMIozR65i
	9mH8eNroWsOTkUr5SDxwSA6+dgJB30zyGrDVhdCbcsggM1ySLdnH/Sz95tSwr/AMOph6S/bKMc8ln
	tiXc8rq/lovFmdxfTS7ImT+biINNJ7JqNQ2WCbiACjIveexHMAOw83Lfo79tlcxxyCrdEMXa+ARIe
	ZbBRTv25rcuLU0Kl/96A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUyWh-0003rO-Rn; Thu, 06 Dec 2018 18:37:31 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUyWe-0003mj-3S
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 18:37:29 +0000
Received: by mail-pg1-x541.google.com with SMTP id y4so506783pgc.12
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 10:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=8CQaNbWYfH4rrtr7y1L1OPdwNgqhGo43ZWeJVCZSPio=;
 b=jQdYEmv/c31kkxNf63DO2hDppf2yyeLJmKw6Ll2SJ/lUFEj87Ru6+xfE3lKIfctczi
 8ZbadMqzX3u4nD/kPuuo5FTDsAsBFI8Ica4ERuDuRDBeSZYaRW+qebFFg1LWFvnsI++k
 MP6iVmmy3D44dFT9yBmdq4IPLjCpp/2yOZUh93d29NzVG2QDnxm4vPTpZo0UYpNJWOgm
 cuJ4s1duczRJmygZdRUaSnFePvExxPYFUdNMrtwXEle4l04GSONHvunsQ2k+atUkoSOP
 OUpXiJJsaBLM4RVh52ZhX9s5lYy25JjRE8z2bZKooZryBibA6lnE5g5v8EhgIFTtZHBP
 ShLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=8CQaNbWYfH4rrtr7y1L1OPdwNgqhGo43ZWeJVCZSPio=;
 b=r1CHTQuYfH5KVYDXw1ECS2deAArUUFANxuhXBz6b1ijvOIH/Qkv6LMmOpxCXFk3pqh
 6xWEEkX4G1/fB4SV96AsPOdZ+b3pQzzewIy9QWggsSXNxr7x4TxwvtG+oRQAXh+kBE2p
 e0crqnI/K2Egk4d/8ZhukMe3gAPiO7pfWA7f+78n/cihwiEik+omtPwUoHtbmxTU6nbF
 sbrfwHBZYCindYbokncu4x6v3ATTseUPa7xF767oZyeT9BJjd6Tf/ddEM9ckxooSEXyz
 cBnV1foBgBY8eS90nSBfhgySDwDv+ckN7mMyRR5Tj/aai4/UhWrJW2xp4l+YnBPP7Up1
 N95Q==
X-Gm-Message-State: AA+aEWaBtvcfNeOVI1/mGfaeHd+n17sdavTraBGp/iDW4NLukLrnMwLK
 elNV94COa46HqtDpL7SEl6GLi7vy
X-Google-Smtp-Source: AFSGD/X8vL0xWSmYdOfWCYDwSxgcM4w7QeNvIJM2oEJ88aXzCt2cszDLSX+lbehOI7LOGmWx4fpNaA==
X-Received: by 2002:a63:68c4:: with SMTP id d187mr24796460pgc.11.1544121437220; 
 Thu, 06 Dec 2018 10:37:17 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.99.39])
 by smtp.gmail.com with ESMTPSA id n66sm1517646pfk.19.2018.12.06.10.37.15
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 06 Dec 2018 10:37:16 -0800 (PST)
Date: Fri, 7 Dec 2018 00:11:03 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
 linux@armlinux.org.uk, robin.murphy@arm.com, iamjoonsoo.kim@lge.com,
 treding@nvidia.com, keescook@chromium.org, m.szyprowski@samsung.com
Subject: [PATCH v3 2/9] arch/arm/mm/dma-mapping.c: Convert to use
 vm_insert_range
Message-ID: <20181206184103.GA25872@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_103728_146705_D6CBA3DF 
X-CRM114-Status: GOOD (  15.07  )
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
