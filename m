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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F15AC4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:41:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F420E222A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M9SXOjH9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZBET/v+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F420E222A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=O61jEXtxrFACT2UV6AMuQzY81fJcfgL1qE8VONmjN/o=; b=M9SXOjH9fbg1Vs
	zV8aCgVz79/KaWBKSpRYePNrldf7bMJbMIgLjBPKioIHgOCfePB+kSB3ioupksJ2ra3kalsHYd86U
	ndpdyZKv6v2X6cbLiLobAHEeCthNQm3vZ9drmECxCmj49L0dkkOGd9DjCzvDrVt/KPRBnxgF7f8T5
	cH29zaPlB+0UOoN1Zgv08LhyZMXAlxdXQkAh1XqcDVgI6ZxiUp0z/dNK1rRpY3I2v7ZGwTSZKtQ/s
	Cb2g9df/XD32TRV1+pcq+Lu/6WXTgm+B0/xsuzpYCDpVFRdE8PFoxjROj3qbbtduZF9KVjIACAYdT
	xP6vREEyxIF99UCyesmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guTR6-0007Ev-TK; Fri, 15 Feb 2019 02:41:08 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guTR3-0007Df-GV; Fri, 15 Feb 2019 02:41:06 +0000
Received: by mail-pl1-x641.google.com with SMTP id e5so4180917plb.5;
 Thu, 14 Feb 2019 18:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=+cqpEOgVsQX6FuKbkjkqnPdK6JJEhfhSEvMIkCtIVgk=;
 b=PZBET/v+AvTm5uI6YhLQd/yhp9OJU4BXs5QA0Gv2/WEpddBD1QACIx3W+qj/R+DwpM
 B3BzpTqjks4wX/579seQjUOZNkBasPTeBbzS7Ts4S8uR/gAobhLKvuuBjPvnZ0p2M1+e
 UH/Gc2iPGBMYC4EV/ODk3qG1i7BTa624G4IbAyHgpQom75nwKU1TVfguAY8NM1SpQhag
 t/bnF90mVuhLmHwSRidYkQGL4uxY7KCT7jqdywdvHspXzYeX6exXlLeF+WVbzBFla7Za
 xrpAZoUBgGaI0ABuhCyNn+4AoykbvyaUO80m2jJbnwhHLhgC8kP1xoZ96ASplt0w6m2V
 UyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=+cqpEOgVsQX6FuKbkjkqnPdK6JJEhfhSEvMIkCtIVgk=;
 b=k5e7Hd9ubhEpkjhHYq2wW+FfuZopEhKvbQXZsxBU1AU9Ynk+2e3T+bTb4DCyeqiAdu
 5mW5tA4GquKc//yi+gDewc9jjumO2jikIhMQjYsD71VOk4QcnEkMeepvhqZFNsGd27xU
 4RTYRFNPIIjtbHYIUBdyG2stPOpwLZvnkPhn4sUC8800LocRp3anLy3fA9DSnHwr8QAA
 Z3jtykzUj5Vi/y4V7gig+dY3bvu7tjVymlmXcYICQIdqRqFx2k/pigP5gTravxGwbgpV
 HvWKLwKiJnRy2gnsF3sGBubNzslUWiqUcWi9P/gsLmxW+g91OmfnAd5Gh6aDBhZTUn/0
 oekg==
X-Gm-Message-State: AHQUAuYN5Pj98bGQEw/i6hlvN+v9wtjyfWLgHkIQ4gxeMCx2WVz/nyeP
 ui94bu9uiYidHx3l1QHL/10bWrMR
X-Google-Smtp-Source: AHgI3IZkR4bUjIEoJN1Iweg1I643mATKe+Qg6hd5B30hfMqsOz0sR+gJKonzI4eh8rnzPur2hIb3aQ==
X-Received: by 2002:a17:902:d83:: with SMTP id 3mr7519491plv.43.1550198464676; 
 Thu, 14 Feb 2019 18:41:04 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([49.207.53.51])
 by smtp.gmail.com with ESMTPSA id g87sm9521109pfe.43.2019.02.14.18.41.03
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 14 Feb 2019 18:41:03 -0800 (PST)
Date: Fri, 15 Feb 2019 08:15:24 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
 hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie,
 linux@armlinux.org.uk, robin.murphy@arm.com
Subject: [PATCH v4 4/9] drm/rockchip/rockchip_drm_gem.c: Convert to use
 vm_map_pages()
Message-ID: <20190215024524.GA26405@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_184105_549488_8F6D41D1 
X-CRM114-Status: GOOD (  13.14  )
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

Convert to use vm_map_pages() to map range of kernel
memory to user vma.

Tested on Rockchip hardware and display is working,
including talking to Lima via prime.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index a8db758..a2ebb08 100644
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
+	return vm_map_pages(vma, rk_obj->pages, count);
 }
 
 static int rockchip_drm_gem_object_mmap_dma(struct drm_gem_object *obj,
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
