Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAFAC282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:00:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AECB20836
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="spWTF6cP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTkvJIhi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AECB20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=O61jEXtxrFACT2UV6AMuQzY81fJcfgL1qE8VONmjN/o=; b=spWTF6cPMeYkeP
	y2ZP0Q1UimiaIHF7l0/y9T66lnw2rfc5heW1gD22DHXvIz/gtXTwNJsDIo06UfcDrWZKlFc2AjXFN
	Py86wVMi62gQHP+7gTqseIN895RubtbIYEMMpIh/aqwZzSs/J7acqzfntN5f/s0isxzMOQXHl8cSW
	3sxrAtS3JgHEbAlqOyQKxEG38yub+A0o6CF9Q+FuAUaacU0gq/6PUkRC21tRwoe9eMIR1WVnp2UJ+
	6myprOUVrcjC1fqeowmo8ais9nlNLE6I5gSDhYMaC4wD5NSW2uLBe5tyLEADz3HUNjlU5+3chH40N
	b0MyVgQuvmZHTmiwF0LQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtv5M-0007yM-RO; Wed, 13 Feb 2019 14:00:24 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtv5I-0007wq-1J; Wed, 13 Feb 2019 14:00:22 +0000
Received: by mail-pf1-x441.google.com with SMTP id n74so1174352pfi.9;
 Wed, 13 Feb 2019 06:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=+cqpEOgVsQX6FuKbkjkqnPdK6JJEhfhSEvMIkCtIVgk=;
 b=FTkvJIhiZxuB2UN3OVrDxEf8j3emEZw9A9itD1oPd+tVJ0e8g/nDyZISMfbdyXaAP6
 Ku+f1/oU09s8dZXMCE15EC/lZ4jhE9XpyVezCzRAsRLdy/21AR6rTdyIxoZbfsMxmQYr
 o1QFAdcjEMZ4hpVPbwUZfbKD3bP3YaF5W6bCDSkoV9uE7cMXX9QTOFBJsVTZFBub3vD/
 tLP1kpXdfL6PFeEz95+peYCFGB2V3ZREDDgo2MiHR2YRRTInP7Ujlzf+v8xIEwW/acLG
 YYBPMe+meJlZK/PpLg21XpK/Zqy+ohSuq8qV9XGFBs8K15TIr80jXNZJz+mddYFSLU45
 kSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=+cqpEOgVsQX6FuKbkjkqnPdK6JJEhfhSEvMIkCtIVgk=;
 b=o2ogiSPuioy2ru/8jKNJnr7dfx5yy+zKxRwlbtz/yS/4mfn3Mbc6qQEh4Zm65Dsmr4
 0Cg5IpDmB6Eb9yCCNqZadM73c7le1fH+Q+9WjUmgVOb+5j6yI3iLSUq03Pyc+9TH02Fz
 cv93vyRYOU9jav9XLBqLRULn3t6Z5yR4LCj8qSco3E0kbE2ThNSRahn8vUcsYgzFN1Aj
 NAWbbLPgHweF7r64nRf3EXOWT7CNrFSkYzq2rXOhsGXwM6mFmtuld26pxi4Rg6mOPHAr
 N3idijDEWu6P0d+2LCugQ2X+oFt/hefQvwN893nxh1P/1LBVNzFviYK0LE03pB8rdJMC
 lYBw==
X-Gm-Message-State: AHQUAuYVSZzkVOrDxkC0Frx9wF7807YGNwubPDe5MZOA/KW8OXWMaWpf
 zlneUEC4nAYpzZs2eusjblqxXFMp
X-Google-Smtp-Source: AHgI3IYGzYQtaDAzpRnw4j6/fnsbGP2OWM7ItsKgcpabtFzajnCQ7pxNpaBmZJle8XOTxzleQFh85A==
X-Received: by 2002:a63:5442:: with SMTP id e2mr628034pgm.282.1550066419102;
 Wed, 13 Feb 2019 06:00:19 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([49.207.48.54])
 by smtp.gmail.com with ESMTPSA id o2sm27521833pfa.149.2019.02.13.06.00.17
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 13 Feb 2019 06:00:18 -0800 (PST)
Date: Wed, 13 Feb 2019 19:34:36 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
 hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie,
 linux@armlinux.org.uk, robin.murphy@arm.com
Subject: [PATCH v3 4/9] drm/rockchip/rockchip_drm_gem.c: Convert to use
 vm_map_pages()
Message-ID: <20190213140436.GA22010@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_060020_080811_06A6B77F 
X-CRM114-Status: GOOD (  13.24  )
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
