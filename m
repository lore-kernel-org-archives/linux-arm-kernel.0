Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAA2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:04:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AC612084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C+CN49NX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQ9gfhsp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC612084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=P5rSc5Vm9EQbHAmsMHId5p5AMFR4kqMePl2kHOKuVp4=; b=C+CN49NXQ09jdJ
	IITkdoLiRlbEXWnqba0XH6CmLuIDT1Ri2+SVBnqNlJ4wmKeljCOZyaimvmGtMVztMr1LGrHR8Toey
	PjqJPW+n8I56b2UQcDrET+uls8RLe42o+6AWC6imhJ2VKxIEVPnv+5CKSUN2vOdkOWgVpmBXdC1Xe
	60B7ciyn3RDsCVhC9i73XJIb3h1UdIgkAig8Hj6BPDvUWNGJn+0brDjosCnyOT9OYTTjS69ChvKv5
	nsuDTpOrLrewM1db5CtNS14BZsapuoS9xhRaGkepksYxAQ86h6cRoKpSkazlW8YyCfpZTX6fPUDHU
	xNTHR7Nd2Y5Yt2xKQBkg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghyLu-0006Xr-CA; Fri, 11 Jan 2019 15:04:06 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghyLq-0006X3-Cg
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 15:04:03 +0000
Received: by mail-pf1-x443.google.com with SMTP id h3so7086465pfg.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 07:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=WzAQwD4CMcNjfYojTjRfy8sqfmAAp9apVnphS+7qE5M=;
 b=HQ9gfhspvagPH29Me3BRhdtcdpJ1ppAkZvxlrEmPYgRip1IdthcKcOCiWAVY5Z895Z
 PTA3IoN+JoobjwcMS/8b83st4Y+6eHz3yTWfKmWq6hBWZF2NZmmXzgF2mJsADBChdpWa
 BlzbeMjQsitVUoC0lUosclfzkAMgMA1uWDH4Q+jXZ0a8BMEvbSD4/3aYiYIx2RYsqrV/
 uREttfKnl7dDB92r8GsoONQTcYXgxNyBsHnbW/433SZk5GGTnHZxA7gQrkXu0wYSvHer
 Vv27TCONFgJ3EJ2dLRQBnpmyzs3Y3diG7h3yFHd0GF6Ho2Vfd1jpkcOJiHFErnXjtg9V
 WdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=WzAQwD4CMcNjfYojTjRfy8sqfmAAp9apVnphS+7qE5M=;
 b=t7VyQqF0Zf1RFvWwRm+kZxwRiGnMS/g5byC3d0+EWT9dBicuhrfFcRDVaJ80ci2tMp
 nqO4/PI/Hu5pGif9eyOUk4gRWbLq0sUGp24aur5cJ3gZQID0hfVs0pHdwJSnjArm6uaC
 AQOA7xJFX9qTOFP7jP6kLdVX29tjqjWCHGewwU2pJOS9fG/RGIiBKbTvpAvPuiJwlJ1X
 Q+sSzoRUHJjJmxESXQ/QHmIdU4uh9e833+uKbwmi1DGtRKBpA0+9usPhaGOaS+RGeWcU
 o8hgouvReEd9Jgtb/ZxBU9prb7umbYS0DZLVlb+ZVou6My9yySMnGjz3/W87z84RK+0Q
 fx8w==
X-Gm-Message-State: AJcUukcWWspFBnyh/M0RVOGDgS/c4GkYUjI59d1S4IS1UVRLs61emye2
 kY1JKEa2/qLaAWHJEGw0tlk9MZEp
X-Google-Smtp-Source: ALg8bN4zxdDRP2GvwoCa51Ol8AZWOsPmTHbzznH1GTkRyiMejwb4Tfr2KDpSzH8Z6TaZw/NFHZFS/w==
X-Received: by 2002:a62:1c86:: with SMTP id c128mr15538564pfc.54.1547219040807; 
 Fri, 11 Jan 2019 07:04:00 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([49.207.52.190])
 by smtp.gmail.com with ESMTPSA id i62sm92403752pge.44.2019.01.11.07.03.58
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 11 Jan 2019 07:03:59 -0800 (PST)
Date: Fri, 11 Jan 2019 20:38:01 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
 linux@armlinux.org.uk, robin.murphy@arm.com, iamjoonsoo.kim@lge.com,
 treding@nvidia.com, keescook@chromium.org, m.szyprowski@samsung.com
Subject: [PATCH 2/9] arch/arm/mm/dma-mapping.c: Convert to use vm_insert_range
Message-ID: <20190111150801.GA2714@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_070402_427546_985DC301 
X-CRM114-Status: GOOD (  14.10  )
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
index 78de138..5334391 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1582,31 +1582,21 @@ static int __arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma
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
