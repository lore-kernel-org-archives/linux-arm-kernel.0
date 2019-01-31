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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2344C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:06:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B233F2184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TO/GKMx1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJa1+zh8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B233F2184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=gQmFQ+6xaAhKhgVMscv6B2vZ4IX116pWMmgheNWKtkU=; b=TO/GKMx18rdtWC
	+oYVcKy0oLk3lt01WP61ONGfvrO0m/hrKI0D6oQHVtaqcKJ0q3sK5jXXFRY9WRVo8z5lopF+S/Yu4
	/vpHpts48eFvYIujQunHbja4I5uHhGaZ9fWNQsOaZMpypEIz1cVsh3Ft4ONxPKsr8wrY4OUbstYAd
	qySDv5rAJw0BoPiwogHkJmqOzrZLFlFl8ZCbobuMRwYyt3cUwTkj+ry1+rkstYCUPuMHkzA3JtJIG
	NRADaOCA3uhIBQn5IYxhERWSd2i5aSmJTRKSVkvjwhBo9NaVCa35qHvV+E7sSbKv2qWjigpwANLRu
	YkV/rQEDD7qtEzpJH73A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp2gS-0003bp-HG; Thu, 31 Jan 2019 03:06:32 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp2gO-0003b3-Oj; Thu, 31 Jan 2019 03:06:30 +0000
Received: by mail-pg1-x544.google.com with SMTP id v28so726805pgk.10;
 Wed, 30 Jan 2019 19:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=fve/F1/lKXEnfpzre5B+d6239UbIM50sDNUC8vj1UvQ=;
 b=VJa1+zh8xHi3tI1io1YyR1jW4Ql0L2HM/0G/TqGLCYIRuEUfaDMSQLwWgfnv/q2VCK
 iMQgvcHSc2/MMEr41Z3VcXIJpBynXvCLMm+MCb5Ony0kLh1P+43S1EyOZ0c2VVcXfUDi
 zyUHlPc92S25kuxJL0xxi6q5K7621sWC7v7ZPljG/f/9EmAD7+iDx7aFSG3OZ8ScP0cF
 VzOGvcgsG44tSmhzqBnqDDYP/OTdVImNeD06R22jMcUhnzLmqtpjiveuyfIVjBd7x9Me
 M4s/fGqqA5tbzFW8w6RcVcyXN17XcXe3Wf1t1LgEPIqHODKKlYApfWHRPjE12iaJHekM
 stRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=fve/F1/lKXEnfpzre5B+d6239UbIM50sDNUC8vj1UvQ=;
 b=TLXTejb8fwcyKw8SWf8YWTTL9Vnu0VRbcLQTgsZMhp936WLyOZSHO6yiX9M+mqDl8N
 Kmdfnag1qXDCP8hu3wTWjLs0GX037ZiQ2vMH49aNVDTAq4E4VjA6K0HHTGVsHfoD1VI2
 HUtmQD3Y+y46mzcJMdP+9mPJ1Y4lInZ5c6FjL9He+QxXOYo/YusoklUC9oQA+EhOMXxr
 AQWZD+T8Tl+m3KFk16o/XV2FYJP0O9ZvptFKSGr9pwtQebrVsC2mQHcufy7BGAl87TLy
 MtmsEeeczKISS95ESzN8a/L9PST1qRWTocabsedjSdpPvvGWLMw4s31PRhOIvBw1a4yJ
 ScpQ==
X-Gm-Message-State: AJcUukezcA1vu24iBZu5/jUGs9ghi2jvBsFeGxqhX2Ipx1N3C8n/+rin
 lV/gHlXIXX+EBgRjp/BffZ3hzes+
X-Google-Smtp-Source: ALg8bN6rRzXK6nfBRBSHhIlA85333gGdTjbHnrt6wuJpi13BssALmTS8VMglE5ur30io8jYwjS7LDQ==
X-Received: by 2002:a62:1f9d:: with SMTP id l29mr33146546pfj.14.1548903987795; 
 Wed, 30 Jan 2019 19:06:27 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([106.51.20.103])
 by smtp.gmail.com with ESMTPSA id v2sm4236663pgs.0.2019.01.30.19.06.26
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 30 Jan 2019 19:06:27 -0800 (PST)
Date: Thu, 31 Jan 2019 08:40:40 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
 hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie,
 linux@armlinux.org.uk, robin.murphy@arm.com
Subject: [PATCHv2 4/9] drm/rockchip/rockchip_drm_gem.c: Convert to use
 vm_insert_range
Message-ID: <20190131031040.GA2320@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_190628_799033_1AE5E4AF 
X-CRM114-Status: GOOD (  12.16  )
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
