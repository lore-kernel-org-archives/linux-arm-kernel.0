Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B907FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:24:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8372A20863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XtG94GSs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hucB6Zuv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8372A20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=bagWTDm2icnDmfOjdgKqxTUzRdZha/3wydTxBVuZB2c=; b=XtG
	94GSsZoSQ3H5vzjt6gbE9vDnCzXs2t7qGJCrSpAs5qsZxXAYEgTzGQX2kmNBiGerGmHbcjAD3DSqB
	+hMg9IUNTfoe34iiNOmkUWByFh1HNVOBqGujHkwBe9MOP6AazmMvDo3fQfnFBUlONVYlhEcdDhbmn
	bOjenangUb4nX1tbRiN/pfNbTeHfcVfORPCa8u0AqZsrItFRQ1q1gDRvo5Wns2X/FRPS55H55Rhwp
	LWgUhtSvwWrC6kjgVapsL2SQDlTbZlZ2Y2EArt1dQoICQt+hN+VAJTQynQSLIDgBIMyMXdNKsM/4W
	Mp49VDo4ZhGrgexA4PDNCSFbVXcA1Ew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyjGn-0006ic-I6; Tue, 26 Feb 2019 20:24:05 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyjGl-0006iJ-7o
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 20:24:04 +0000
Received: by mail-pl1-x641.google.com with SMTP id y10so6793107plp.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 12:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=LHcV9KuFyIJphllsynnPnDHUrB3QRBV9lgjkjWwozRg=;
 b=hucB6ZuvoWE9TEWY2htIei8RkTzM2hmLBhHSw0+HB0nfK6vUAVOovNLWtg7WtRWL4U
 +CWVJKszW7INsKyLM2guejrQ6EiuPVBYaXVrLrzrRMAljLid6bsdVXmIPlG/CvRSOoPJ
 Igm2xYMpWa5+Fx1FOjwENpVYuhULjKb3hB2935HCXThpDE5FO1IT7klmQ/LbkvSChOnV
 fayzqbFcvyLbow1u0cquI7U4zXxrSifAGx1UAXjp1/7pvWfwitA+4hpBQ08/LVjX8nRB
 D+7Wy+/AhNiPPr9wPaEKYZKlzALBaSlZ1qyupPQltTikxKbCIZWZUipWR12K/BDpDYIj
 oBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=LHcV9KuFyIJphllsynnPnDHUrB3QRBV9lgjkjWwozRg=;
 b=Ye1aUQo14OexP9UiDTUzpXwS/L+tsRpGxcqxMTxeZzDAfMOdAQGIedAg2nF5CyoFVp
 42tRYpQ3vB69oXCdQijE1DWCRBjU6aXMuQOzUJwprf+PhG8FaFCpkx5gI633FsGufD2/
 nD/21Z/E83I2u3zocnKGjY1cM6ur3OUsnAdqb6NxA823pow8Q5yZin7GSXQR+QliNyp1
 0xyEa1MVR32oJgTf4XOIsFlO7vg5GXtHKxT39OEUCIT7DtPrPK//mFX4HItxAm9iUcGa
 kacn1mKhxgL8YynquSS7LpeC5IamnfgSbUL98Vrnox184HkkyfqbwempJbzYe94otW9h
 MIow==
X-Gm-Message-State: AHQUAubO4qVDqmiGzmOXQCh9ooPY8/o+5ULwh0sf488YRZKsPKq9vzLx
 nthZ7mmYM7OFmutPfvCGnXc=
X-Google-Smtp-Source: AHgI3IZ3++oASqlaSmz7L1lvzECC+qTYDnoPN+pBRQ3likXjsPclEKW4se6zSk9ZBGyuOEpHZxt+3A==
X-Received: by 2002:a17:902:20c3:: with SMTP id
 v3mr7475180plg.268.1551212642071; 
 Tue, 26 Feb 2019 12:24:02 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id v186sm294240pfv.184.2019.02.26.12.24.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Feb 2019 12:24:01 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
 tony@atomide.com
Subject: [PATCH] Revert "dma-contiguous: do not allocate a single page from
 CMA area"
Date: Tue, 26 Feb 2019 12:23:27 -0800
Message-Id: <20190226202327.5349-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_122403_304738_A546ADDE 
X-CRM114-Status: GOOD (  11.11  )
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
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 dri-devel@lists.freedesktop.org, sre@kernel.org, tomi.valkeinen@ti.com,
 laurent.pinchart@ideasonboard.com, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This reverts commit d222e42e88168fd67e6d131984b86477af1fc256.

The original change breaks omap dss:
    omapdss_dispc 58001000.dispc:
        dispc_errata_i734_wa_init: dma_alloc_writecombine failed

Let's revert it first and then find a safer solution instead.

Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
Tony,
	
Would you please test and verify? Thanks!

 kernel/dma/contiguous.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 09074bd04793..b2a87905846d 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -186,32 +186,16 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
  *
  * This function allocates memory buffer for specified device. It uses
  * device specific contiguous memory area if available or the default
- * global one.
- *
- * However, it skips one-page size of allocations from the global area.
- * As the addresses within one page are always contiguous, so there is
- * no need to waste CMA pages for that kind; it also helps reduce the
- * fragmentations in the CMA area. So a caller should be the rebounder
- * in such case to allocate a normal page upon NULL return value.
- *
- * Requires architecture specific dev_get_cma_area() helper function.
+ * global one. Requires architecture specific dev_get_cma_area() helper
+ * function.
  */
 struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
 				       unsigned int align, bool no_warn)
 {
-	struct cma *cma;
-
 	if (align > CONFIG_CMA_ALIGNMENT)
 		align = CONFIG_CMA_ALIGNMENT;
 
-	if (dev && dev->cma_area)
-		cma = dev->cma_area;
-	else if (count > 1)
-		cma = dma_contiguous_default_area;
-	else
-		return NULL;
-
-	return cma_alloc(cma, count, align, no_warn);
+	return cma_alloc(dev_get_cma_area(dev), count, align, no_warn);
 }
 
 /**
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
