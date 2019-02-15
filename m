Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C726C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:39:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E239222DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eYPZcy97";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8J8YEaP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E239222DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=LacHrzkRLThnLynaaORXfyuuDEOnTOpBIdlX8qgBqyM=; b=eYPZcy97598hgL
	uRVl6X707P53KB5rlNpsNTx+3uRoT0Yzq3NE3BtHe/dMrPOLT2a/nIAnV38gcqjKfiq+SmumScct5
	PZxeb4AWDQ2bhqGuK90xXSnlQopAsmdDY6CVZI6NQWdNSG1uKJElJT8y5O0pRKNYsPTLvZdSx4ptD
	a6NITsOdzwABjbbakdA39uFjOIHLO91ckpd4zaCYfH7TdoQbFbOZMftGiD1cUhWr8aSuHvoyATNCL
	845M+5uMNRWzd3LrYG6xBJlCk6pieIWBCNiynCTwwB7Z3+8mExq0tMLy6u4ChYhdxFFyuYyF7m7dx
	8vA3hZWSNHJ3VSargQCg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guTPE-0005I0-JU; Fri, 15 Feb 2019 02:39:12 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guTPC-0005Hh-CX
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 02:39:11 +0000
Received: by mail-pf1-x444.google.com with SMTP id h1so4090145pfo.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 18:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=cNyFM0J2DfW9voxw9FzV7E7Y/LrzsWkGDKLqwe0d5pk=;
 b=C8J8YEaP1sXar/+zW0yONM/GThKVOZP43UoKx+bsMs0rR+kOwbwuiT2BIDoESBLxKN
 X6AH8lyLqHVlJ3S1+7SjnEjca5R1G8T4RFnjNToQO6v4YNaQSQSNkLbvxe90zZykLVDi
 54ov/SHMO/cZOMqPEs91uSOr6MV9wmu9R1mZMEKYCox3q1ABu4U+roRJf/5xpBsTlTDO
 KAmeeosjCfbEhSgpHYgu6X3qTk/lRll1yN/eR/pYc5h5Gznm4xGDGVTvZ1VW0BjA2yKi
 9shB5cJBIHEFyFW2Gn9ppb3AKrv2U+8H26GIKZ1mUlV4K3ypWZYz6UbQihzp+r6bWUJk
 St0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=cNyFM0J2DfW9voxw9FzV7E7Y/LrzsWkGDKLqwe0d5pk=;
 b=MbjLPNzVapHAQX09wq9TZQascwseirvs/BP/HVNoiLmoaNku1TJQDmuCMqORba+Rt+
 qjC1HprllCNOaPLHQW84X80n2WRATv2C0Xmkzr+cuBlUOpGi4koFR3I15AKNXUhg3zME
 VYxyUMT4phCsjpJviLau5U2IpackKFIcJjUiifGjv3WCN71VvEayZWONSeil9CzlHgf/
 4PJl5zPXelMhWeGXb9cefAhJEwplRBps/Tom3ZSiJe9OEWwZrwqgTwbsxCxRuJsBtmkR
 pWzUzMP+oLrANTTndjLdmn6hssxBjV/b3/3rQWs6bgynxbWYzz+1pd39fciNA/dt32HH
 dE5w==
X-Gm-Message-State: AHQUAuaulPNR2Laz1Nf0LNnYQTkr80Gxg03haNuS8YgoQfqLeWNP9N/X
 mD5M33hO5ge5bS8L46AXSvrLwhOK
X-Google-Smtp-Source: AHgI3IYPDJcfAJcux7am1/kgkI8RGRJz/Eho2e26RlxYpln5H5W4x8B/Nfk9OSESdiI7mMZpfEdzLw==
X-Received: by 2002:a63:4b12:: with SMTP id y18mr3125993pga.340.1550198349469; 
 Thu, 14 Feb 2019 18:39:09 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([49.207.53.51])
 by smtp.gmail.com with ESMTPSA id t3sm4758131pga.31.2019.02.14.18.39.07
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 14 Feb 2019 18:39:08 -0800 (PST)
Date: Fri, 15 Feb 2019 08:13:29 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
 linux@armlinux.org.uk, robin.murphy@arm.com, iamjoonsoo.kim@lge.com,
 treding@nvidia.com, keescook@chromium.org, m.szyprowski@samsung.com
Subject: [PATCH v4 2/9] arm: mm: dma-mapping: Convert to use vm_map_pages()
Message-ID: <20190215024329.GA26372@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_183910_425513_6E3A6784 
X-CRM114-Status: GOOD (  14.52  )
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
