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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CC9C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:05:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 682912084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XW8VtWq0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sh2LY1Wi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 682912084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=gQmFQ+6xaAhKhgVMscv6B2vZ4IX116pWMmgheNWKtkU=; b=XW8VtWq0fuJiVG
	iUaMdot15jFSqesx7qRaEGziTl4YxH9pQ4HurE87J9dCV9sQLlfSCYAsUZKRnLmb4ZEdXMdJKSG2u
	6JuoFutpjdUou5mFU9blXQEH5HKKSqu6Ra36IxiQo2SNlsvHtidE1Z89y7SeAN+z+LHjr6N2/PVVL
	hEIbVBNJIZNXmAAN7pxVWHpvY8bwEHXq41Nax2ogq873IZE2CJqDRW0jRfhJirRMcL8TteCUwVUUU
	ymWCfbEjJfkIHl/MwsbiaBpTU4S8IUqTwLTU3al0m+OaGXZmcVS84jjO3AMnpGN7P+CqAOPtXQGS3
	URsyx8NCNoGObPEkQW/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghyNS-0000DL-Lf; Fri, 11 Jan 2019 15:05:42 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghyNO-0000Bt-HS; Fri, 11 Jan 2019 15:05:39 +0000
Received: by mail-pl1-x644.google.com with SMTP id 101so6877081pld.6;
 Fri, 11 Jan 2019 07:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=fve/F1/lKXEnfpzre5B+d6239UbIM50sDNUC8vj1UvQ=;
 b=sh2LY1WiZPIeUaF3MW5DJg/QEYmtg7MuKqRcV+ohKVqeLOX2kAj87/ncMa6egebbYo
 k294jPvUpvY8tWh/TVJyCnvyC/T/VHszUoQByu4+B0bLPUEBcCPJg3A6iuRrk0nL/SCc
 lpg3ZBT6tI1It72Jxe2UE98iYfsC88cR1xfpH7vrMx9OJMw9tL2Vr1vv2W8XZ4Xktn9H
 NZtgrvTlD3Ik9YbSkPstnCWGQNPhb3+vQLQJ5oV3oYtnxdhNYQ0n2lHyDmzWabMOBagm
 +fOV5sL4jmozsC4arWO7kSdaVEIRpgV9bHvSvYqaiApnZh3+zyi/XPtspSlyoMBygeU3
 sZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=fve/F1/lKXEnfpzre5B+d6239UbIM50sDNUC8vj1UvQ=;
 b=PHcPjVCW7liU5grs+dalOsnkKlYeM873WJgtiQj5EYnTZD5phy6yRvyZNIosbKKe7B
 UsKBdxZsmvyTDjqZ1HJvoVbye+cCh3+MzIZbE5LelJ/kgYUoGINkulNVhz7Frf7u7noq
 VQr5BZbdcnm+s5makdiue6nuwAkNk+NZiLCx4ueMXkvEycKHbK1J/DtQTZ8TqHNlMADR
 rDByeSLijOg+Nt6DzxjDkIInEcKayrnJGqtcPvUmBZLBG3MP2zbWkD8TqgzvZHjUEb/y
 /nNRbSkN1TD1C85it17wGjBLN29Cx/j6om9QWGBiK7EiEvl6JkwCo2lOypcA/mnqbk9T
 R/kQ==
X-Gm-Message-State: AJcUukfHdyWWBEPKUTNDMUau6Yh5WH1/UES0Z/+gkzWbETK9mB17NGBb
 LCDfB/iQA8LnGJl9iuirWdPFRRvS
X-Google-Smtp-Source: ALg8bN5Rc2l8bWM7uxkHK8LK4e398s3Iy/tXK9itkSm2yPC22Yk8baS7VKxthK4Bra16e8DuO0AC9w==
X-Received: by 2002:a17:902:1105:: with SMTP id
 d5mr14463670pla.47.1547219137463; 
 Fri, 11 Jan 2019 07:05:37 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([49.207.52.190])
 by smtp.gmail.com with ESMTPSA id h15sm98053997pgl.43.2019.01.11.07.05.35
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 11 Jan 2019 07:05:36 -0800 (PST)
Date: Fri, 11 Jan 2019 20:39:33 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
 hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie,
 linux@armlinux.org.uk, robin.murphy@arm.com
Subject: [PATCH 4/9] drm/rockchip/rockchip_drm_gem.c: Convert to use
 vm_insert_range
Message-ID: <20190111150933.GA2760@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_070538_575597_B53F2693 
X-CRM114-Status: GOOD (  12.15  )
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
Cc: linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Convert to use vm_insert_range() to map range of kernel
memory to user vma.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index a8db758..c9e207f 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -221,26 +221,13 @@ static int rockchip_drm_gem_object_mmap_iommu(struct drm_gem_object *obj,
 					      struct vm_area_struct *vma)
 {
 	struct rockchip_gem_object *rk_obj = to_rockchip_obj(obj);
-	unsigned int i, count = obj->size >> PAGE_SHIFT;
+	unsigned int count = obj->size >> PAGE_SHIFT;
 	unsigned long user_count = vma_pages(vma);
-	unsigned long uaddr = vma->vm_start;
-	unsigned long offset = vma->vm_pgoff;
-	unsigned long end = user_count + offset;
-	int ret;
 
 	if (user_count == 0)
 		return -ENXIO;
-	if (end > count)
-		return -ENXIO;
 
-	for (i = offset; i < end; i++) {
-		ret = vm_insert_page(vma, uaddr, rk_obj->pages[i]);
-		if (ret)
-			return ret;
-		uaddr += PAGE_SIZE;
-	}
-
-	return 0;
+	return vm_insert_range(vma, rk_obj->pages, count);
 }
 
 static int rockchip_drm_gem_object_mmap_dma(struct drm_gem_object *obj,
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
