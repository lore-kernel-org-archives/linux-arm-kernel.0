Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63878C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:08:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3093320868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b5U79HNh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIQOY0tm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3093320868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Uc+JLdPOsLc2nFySydk9b6Y6GH5KLFqcfNc+QN4+57o=; b=b5U79HNhXznaHQ
	SSPExeQ3hqa9Xpix75AgKDWlSZjHdrSEF81LwU+lNRTwhdZiknpb85iLhACa4enP8WAZWPHvcLtxA
	AjNP4avmOmayZk/dTL2gvgNVW3jPsmTxTRjFQdOzSY/+hiWUcKtKpit1nk9eTPrFFrHyXsOIn0lKl
	iG90hnIaJu+dQwBvmZ7Qpc9DNw4gZUu6yumdrjbEuvmuDke1+XhC9q4uw3jhpKk9woqU5laxqJ2tw
	EXEOkDw+4zFxWh1skRyWELDeoX0wrRGo2GwTuTVTUupgyyRS+aTgigC+zCW3kbi0aYvZo/dCzpLSD
	NEyFYeFzomQk4kWT0OpA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSiWi-0003g5-DB; Fri, 30 Nov 2018 13:08:12 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSiWe-0003fM-N1
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 13:08:10 +0000
Received: by mail-it1-x142.google.com with SMTP id b5so9076249iti.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 05:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=h8pKBeOuwTikYlorB91FmoUiTxhqiL4qehSgHonMLb4=;
 b=fIQOY0tm5ZCElFlZ/nvV35ISSNKK+0FDGgQF5e+ZDfKMzVMFEeYk85pIykIGnF0Ea1
 5CPPG/buG5hb/EoyCdax26OAzasfNtw4m0NqaiBA1QNST1bCTZlW2Xwt6bJh6+XDPEhd
 6nhh4897ovZNakxrE/8O9k0+yXb2sPB4ginD+r5Xf5vf00skWctIkV+m7lqR2Axtv2Y5
 2Mxo19fBYoNvqUfIJqJi039MkVAGcKsixtmz4eDTZVLJ2kP0j9l9F+cCcEjrWq0PATIS
 vl4dyKjwKQYeflu2Ue6ZrgMrzxW3MX247GbBN2ZHdYRRDZmmKHsqH47G0ozV72Rr/GIK
 fkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=h8pKBeOuwTikYlorB91FmoUiTxhqiL4qehSgHonMLb4=;
 b=a45bJH2aAcJP7XbTJHdtgZr2EstGrBKta1UqnW71sh9tqVccA0bfGF47kZ5zHz+kfn
 tLe9m5mIJ5VdhgvAL8bUuvgo8VmDUEWAlR2HiEV3jypsebYDiQfPJIFfYXdHnE4xykxd
 O2G6vQXS37/COIgIpMr8ogP70LvPQ9cbXYGyIjpKE1CUAyF/C8trV534qZb7xtC+QgNH
 9TisT2Qo3iT191flR2fzVuHCFbipdPPkSuI7G9Hre57pnCklCKK1aElBJOjDB+sbIH1u
 x3to9qAJaBZrdoX2H7XXWCfgbW8apufKqbFQsG77WBAFrdFYZppMnkAKTegQA9mzaGPR
 SVxw==
X-Gm-Message-State: AA+aEWb0Hy8y9coDJ5ZCyq87goUxO1G93g0nWO+Hi+M7ABHo3cjPArYR
 fXKZHgrGFZxbXqBkvcrjZQRN1YtLGH4=
X-Google-Smtp-Source: AFSGD/WCid7UE5Z2k2c24Gtc02zLuJbX5OiBySZCn3H83hHTdU3C7nT8V1JAy+bu6Pc8uUjaDzWj4g==
X-Received: by 2002:a02:c943:: with SMTP id u3mr4963045jao.96.1543583276550;
 Fri, 30 Nov 2018 05:07:56 -0800 (PST)
Received: from njones-pc.lpdev.prtdev.lexmark.com ([192.146.101.90])
 by smtp.gmail.com with ESMTPSA id f5sm2104270ion.10.2018.11.30.05.07.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 30 Nov 2018 05:07:55 -0800 (PST)
From: Nathan Jones <nathanj439@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3] ARM: dma-mapping: fix potential uninitialized return
Date: Fri, 30 Nov 2018 08:07:13 -0500
Message-Id: <20181130130712.1307-1-nathanj439@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181128185910.5778-1-nathanj439@gmail.com>
References: <20181128185910.5778-1-nathanj439@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_050808_780571_89E01399 
X-CRM114-Status: GOOD (  14.74  )
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
Cc: Nathan Jones <nathanj439@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

While trying to use the dma_mmap_*() interface, it was noticed that this
interface returns strange values when passed an incorrect length.

If neither of the if() statements fire then the return value is
uninitialized. In the worst case it returns 0 which means the caller
will think the function succeeded.

Fixes: 1655cf8829d8 ("ARM: dma-mapping: Remove traces of NOMMU code")
Signed-off-by: Nathan Jones <nathanj439@gmail.com>
Acked-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/mm/dma-mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 661fe48ab78d..78de138aa66d 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -829,7 +829,7 @@ static int __arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		 unsigned long attrs)
 {
-	int ret;
+	int ret = -ENXIO;
 	unsigned long nr_vma_pages = vma_pages(vma);
 	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	unsigned long pfn = dma_to_pfn(dev, dma_addr);
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
