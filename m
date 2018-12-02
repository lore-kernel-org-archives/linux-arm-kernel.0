Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F43C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 06:19:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21A7E206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 06:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JzL2UqWM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uy2BvgZZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21A7E206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=xZk8hOjUlTR9IlM12AognHsJl7P1bIz51rWxTqY8ZBM=; b=JzL2UqWMoMpOeY
	mKsF6MMYy4IhUwXA6vz/nJDAELp5EnvMFbz+S4c2kFfK0MXv4QdM/7tEp1ZiWM2ZU20BgtXxtmPs9
	e6hfWFjA/0Jns1gPDiXlQBPPv8E7LjvGXp5yxaLqxC5yG95osnsTuRCU/470V1cugwLtzn0MZF4gj
	8bGUlNrW5gl6+YeZfKWutuStYwd6d5bNTUJaVCPQkbOnimEqUwmNljjwrGDMOje1bUU1m11Ymnrw2
	HahGnHe3q4TiD9dZGzoAfON+bz7GFPFczK6W6Ui6A8a2ok5kvDgeu7UaKzw92NgNmBxbFH/2W+kou
	kEURIaRkQ9BGj2OQQ20Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTL6H-0002rM-JM; Sun, 02 Dec 2018 06:19:29 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTL6D-0002mn-A8; Sun, 02 Dec 2018 06:19:26 +0000
Received: by mail-pl1-x644.google.com with SMTP id t13so4805719ply.13;
 Sat, 01 Dec 2018 22:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=ng6k7XN2+E7qu+YJG+ewVaHjUak4Dnv0s5kVr6uQuLI=;
 b=Uy2BvgZZkqOXNK7hWBYo3ARMJUfASECRH1vDxiNUgHBWwBso/Dw5MVQ3h240LKOn9r
 NhpjK25eGn1477k5XxEo8EOyY+Y9o+E/DUJKbzrcAxAiamgY14sFBQ5e4pPJJZIPgx0x
 NzFau/vgdlUWyYjWlRMcagejTL6DGAwAmAsSxpCb68yXr9XBuwp/SaCrwZvvzqcGm0L3
 4PgcxWbXzJwKYve3R9DhlAzPDVVBxKO/xslBA5HeS47vJGvTrlgakEwa4L493x3uvLwo
 PdxNdGZOUlyPHJ+JMUkdbANMZcGvWiGUFFuBO0DsdK/adiQyQW7EAu9QSeBXHtYH1PiP
 vFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=ng6k7XN2+E7qu+YJG+ewVaHjUak4Dnv0s5kVr6uQuLI=;
 b=YYXgrEgVE0Hx/agaICeIIgsdXZXb7hprEcRiyLyaB/GkdWurwCONUcYEuwOIsqHZX1
 QH7mzHKYof6G85I0dFpY31cTbuEHMomJJrn4BDjYyQ6Q0BW4eHv8BbVfn0AVbcgeG/IG
 n8BhuE7CSFdFdRuDHYAllzUKcqvSxLpxdTcLxoMjJstKOYzzD068b+YUvftVhsh3eXCj
 tXXhMEByLwhLTeeUQrr46EM4GH57pm3VcjaAR9ve1sPD45shxZ7SAE5oz/oroubWTtCe
 NE9E3fc8m+iFmdtpcg+RJD26r2Rmxjjp40wM8gQXS9YeqHonFpYOC4UQQkt57Sg8pPEX
 Zfuw==
X-Gm-Message-State: AA+aEWaiEou4twM9pauvWKQ3FgOHOlu4XPRyqYHGj45dSCBnaa8QO4n4
 9bS57vIjlGdWPDfvJfLySZ4URaWz
X-Google-Smtp-Source: AFSGD/WRNjFD6zB7/hjn8Xn+aoz1dyOHhd/PEH2NIgt7PDmUyJF+fZfXXjivwgpQAMMMOqZJ+B9xkw==
X-Received: by 2002:a17:902:e085:: with SMTP id
 cb5mr11348736plb.24.1543731551018; 
 Sat, 01 Dec 2018 22:19:11 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.99.148])
 by smtp.gmail.com with ESMTPSA id n73sm14870007pfj.148.2018.12.01.22.19.09
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sat, 01 Dec 2018 22:19:10 -0800 (PST)
Date: Sun, 2 Dec 2018 11:52:55 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
 hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie
Subject: [PATCH v2 4/9] drm/rockchip/rockchip_drm_gem.c: Convert to use
 vm_insert_range
Message-ID: <20181202062255.GA3159@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181201_221925_411873_9CD992BF 
X-CRM114-Status: GOOD (  14.12  )
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
Tested-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index a8db758..2cb83bb 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -221,26 +221,10 @@ static int rockchip_drm_gem_object_mmap_iommu(struct drm_gem_object *obj,
 					      struct vm_area_struct *vma)
 {
 	struct rockchip_gem_object *rk_obj = to_rockchip_obj(obj);
-	unsigned int i, count = obj->size >> PAGE_SHIFT;
 	unsigned long user_count = vma_pages(vma);
-	unsigned long uaddr = vma->vm_start;
-	unsigned long offset = vma->vm_pgoff;
-	unsigned long end = user_count + offset;
-	int ret;
-
-	if (user_count == 0)
-		return -ENXIO;
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
+	return vm_insert_range(vma, vma->vm_start, rk_obj->pages,
+				user_count);
 }
 
 static int rockchip_drm_gem_object_mmap_dma(struct drm_gem_object *obj,
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
