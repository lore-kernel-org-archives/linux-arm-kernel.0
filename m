Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5324CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:19:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14AB5206A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e28c6AyH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDTJCfgn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14AB5206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Yec4eyG+EPeXh/w0g/br8qXQGdkFsR9Uzr39DjHNZTk=; b=e28c6AyHlAc0L2
	cgJdhbToBM5Hhsh1mBAtU6W+Qj1lFvHRl/kTk/n9wcXByKsvqVItdcHWlF/JCoqeCuiIZMeNeRFn2
	ZUdrW91Nk347aESCZDWXRhsot/guj7kQfP+vTm5sdZmJ/EkJvz/ARJgl23RyCeQqU2u4SqGpVHcRR
	Z4wOJ1/AcXKCJHr/bU19Tytg7yJGCRK1vdUAGlHShgplxtJB148FQI0Gi1tZb5lViAUAWZtGSAJcY
	q0Xop0/HuHDALin5bIy6nDmRUMfwu/jA3ooSpqqEtB/8hw2GlX/BCKsmErO+3dSshOrV2CGEhbMoE
	IPCl/K8A9vi2yby6oPGA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYzMq-0007Lz-QA; Mon, 17 Dec 2018 20:19:56 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYzMm-0007KV-UM; Mon, 17 Dec 2018 20:19:54 +0000
Received: by mail-pl1-x641.google.com with SMTP id y1so6640800plp.9;
 Mon, 17 Dec 2018 12:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=vHtNG5YY7oqAEcnnEFXV1qkzWXHTgkZmEB/ZXAxtcsE=;
 b=HDTJCfgnh+j0eG6OnfEpzoBfilcO9b+44SSH+rczBsLIYMzVoHJCuW+pyMCFqzu1V/
 Zy29YyLtOwX2UDdP/SXCBW97juLvRF2DVYMvTzi4i7gL6TPz9Limk1pxhoJF2ZR2gdCa
 7tJqkTGxerJpUQ4Okn3XGjeaWWgwbzll56yffTbkYAxyfBuv/nGBVByby04RrCEOGLBh
 iw4KiWfDMyasNKW7SRmZWh7oGNwhOdjF9l+eHcRuO4ZmQmXbT2DzCdawrCDVnJ6qPfsO
 1gQeUUbdnGeiVu6w6a6Y+0opTR0MRZS8NcET2Nm32kXGicA27G+cCt8iUbI/NAzK56ww
 TNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=vHtNG5YY7oqAEcnnEFXV1qkzWXHTgkZmEB/ZXAxtcsE=;
 b=BiHVa6ESXg/6tzcoGrAe2zEkzOWJXOFY29Uer91yOv90o+Y0xVT1D+y5iZeI2tfoNc
 qQryFKdOaDoj33AhAqfsjijksHdYVid1QrsoMC5f5gnlbfLsATapWs5nJuEH0ceaPuBB
 iFa+k0S5wetutvCm4qj5nICwe2pNIgchYvz6PKoUbSOCHW9H5OoEFa2i+IhAkIsh9VxB
 N6CaskddPTzsWiNpYNGanyLgTAscmKXsiNQr7/9hUPsG88H9tq73u65jC6hVfNMZBVyq
 pCd1OZl0l2GmDXmr+Y1TMExusXaul4HsrQ8Rhkk+jxHaRrVFCDAOAVsZZeMlKaUfy1hF
 A2YQ==
X-Gm-Message-State: AA+aEWaZo+nAvN7XvimveYWJnoWHfrtdUXTwieeQVckm1kyhqGPJiKgw
 KJFnwM/sr6l5Y52jAtM4LBngB/Nl
X-Google-Smtp-Source: AFSGD/VztJFrJiCc5TxrvjdoAMM5foV3+t6D91QTlRMzDwrlUkxArWBo7WpY83vLc2dZ2XXJU04Cxw==
X-Received: by 2002:a17:902:8a8a:: with SMTP id
 p10mr14060709plo.50.1545077982019; 
 Mon, 17 Dec 2018 12:19:42 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.98.208])
 by smtp.gmail.com with ESMTPSA id u87sm31872783pfi.2.2018.12.17.12.19.40
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 17 Dec 2018 12:19:41 -0800 (PST)
Date: Tue, 18 Dec 2018 01:53:34 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
 hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie
Subject: [PATCH v4 4/9] drm/rockchip/rockchip_drm_gem.c: Convert to use
 vm_insert_range
Message-ID: <20181217202334.GA11758@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_121952_977908_F19DE372 
X-CRM114-Status: GOOD (  14.57  )
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
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index a8db758..8279084 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -221,26 +221,11 @@ static int rockchip_drm_gem_object_mmap_iommu(struct drm_gem_object *obj,
 					      struct vm_area_struct *vma)
 {
 	struct rockchip_gem_object *rk_obj = to_rockchip_obj(obj);
-	unsigned int i, count = obj->size >> PAGE_SHIFT;
 	unsigned long user_count = vma_pages(vma);
-	unsigned long uaddr = vma->vm_start;
 	unsigned long offset = vma->vm_pgoff;
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
+	return vm_insert_range(vma, vma->vm_start, rk_obj->pages + offset,
+				user_count - offset);
 }
 
 static int rockchip_drm_gem_object_mmap_dma(struct drm_gem_object *obj,
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
