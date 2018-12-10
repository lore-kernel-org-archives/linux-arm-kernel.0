Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3484C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:32:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7400020821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qQXaHLlr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oa4spL2m";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="i4eCm5aU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7400020821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v/9lTC9drSkHB24REn6uWjBJQi4IofCTAmHTlRMBJr4=; b=qQXaHLlrlwU3Yh
	ICUYeNEmWzIltm/N7/Efo8nb4qVtVXNvYSJLZHOTU2tSUuehat9DKyqi/zMqno2ZbvU3WwAqp5MBK
	PIXw01i5GvphHgpHXrxLdb5CTQ0nG6q3QefbgSBjwnBvM0MRAdW1rRFLmVn5Hd4pKV93EEA7/XuUe
	SaZzdh4Kk+HQLnxfQ2ZLpeLXYKhciCs4SB5xY/o5UDobFeDZ6yzYNu0IB7J7fpobvnyuDwIJ7CRqQ
	F/iAz4m3g1ZE9BHzgRtJSCbr/6QlIIbxKNlIV00rBdR74gJUpRcLrN72RcZjyjro6WSBRMFgNBMMe
	YJbvJqhVg84uJ4sHmFow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWOTX-0004Mj-HJ; Mon, 10 Dec 2018 16:32:07 +0000
Received: from merlin.infradead.org ([205.233.59.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWORz-0002sP-5l
 for linux-arm-kernel@bombadil.infradead.org; Mon, 10 Dec 2018 16:30:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FZC+I94o2oQFpPWLrl1OyOn6ypfdxhQaD8xW0QYVrtU=; b=oa4spL2mcbQLpEy0K2vR/6FtCF
 L5jnjx4bYrntmP4tFlJobhvqpUdxpS9ShvPNhEHenFqvs9QDlKuxlMFrMmL/aFxjavatq2KSs1cbX
 CFQhXJWJlPhNbYgaV1lQ4Xh6kYmOInEqDdiqUi6WysbU4DYuAMIcXL4/oQM17+CxsZln62/yLEivD
 gkDDKPIJtcATPGnrHwZBh1K6+R1KPqrV40Zc6NuwD8QIe4vw/kl2MasvKaXVjIDPyEDfErF7d7yox
 a7UWhzuALuuJT/sykDqbfsZ15+pW+wAriIGTv14t2ib3JKrJBysrcS8kmJtFF3kXrsw47mx2ADSiR
 Hen/ncJA==;
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWORw-00051X-T9
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 16:30:29 +0000
Received: by mail-wr1-x444.google.com with SMTP id u3so11163285wrs.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 08:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FZC+I94o2oQFpPWLrl1OyOn6ypfdxhQaD8xW0QYVrtU=;
 b=i4eCm5aUVP/p8ZtODkhqo9HY53XV5peD3zCDOZnbt5I5tRQHBEqxkIBW14+BsfLKEa
 9Ey59SBko2jnCL+0y3R4TSzSGj/wtc5xeivVPUxkRf+kIJQVO9n28F1NpVxMzDxD8lPP
 IaPg9qQlNxQI0p/7fkLIopnwqigTKWRsvq7VE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FZC+I94o2oQFpPWLrl1OyOn6ypfdxhQaD8xW0QYVrtU=;
 b=esflZFoWG1B1J4E71KBj/SfEALj6Y0S7h2AU9TCMTplcFX2D+Fmc/AkQfkNrhc+iD5
 c2po9M5eFvq8rBdQ/TP63P3bDmCxBcLZgmaUvZc+s/MOanJQXvFRSeWA8QuYiCC4pDaQ
 oU5MhfQ9MuGqc8BCfpbQjDT3+j9EF3tU2quSGhuLq4yRBWl0oRxG14ZPOf4VJkUFMbQ7
 2YPF7oDLQonYUh+q9WOEzX5TBSX3+9sciE7oyTTK8jYQH62uXb0mlmUjTkHwSJDOUTIl
 j5K9uDFeQWQQbf5ndabxRKHYJ9EK9K4P9OsY2ryq+R1YbhbN1jkwr4YpH3RyJt8giTW/
 EiXA==
X-Gm-Message-State: AA+aEWaRzCWTpWYmYqYOZ8crB50i0D5k6J6uJDgQwPoutQ+aIawNF7Om
 XcQRwk9PHw5xLV9NPCi4A/FIZjTbn/eBcg==
X-Google-Smtp-Source: AFSGD/UKX9zDsllvninVIdV5isW/249IxFqmb+p5xRc50uvZTFd+5lO09Euw6Qqa1Y5RwhTAX1i5dg==
X-Received: by 2002:a5d:4a45:: with SMTP id v5mr9937015wrs.7.1544459414717;
 Mon, 10 Dec 2018 08:30:14 -0800 (PST)
Received: from localhost.localdomain
 (astlambert-681-1-52-199.w90-86.abo.wanadoo.fr. [90.86.17.199])
 by smtp.gmail.com with ESMTPSA id i186sm3480531wmd.19.2018.12.10.08.30.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 08:30:13 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/4] efi/arm: apply persistent memory reservations during
 paging_init()
Date: Mon, 10 Dec 2018 17:29:48 +0100
Message-Id: <20181210162949.8597-4-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181210162949.8597-1-ard.biesheuvel@linaro.org>
References: <20181210162949.8597-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_113028_956125_100ED195 
X-CRM114-Status: GOOD (  13.88  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>, linux-efi@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The new memory EFI reservation feature we introduced to allow memory
reservations to persist across kexec may trigger an unbounded number
of calls to memblock_reserve(). The memblock subsystem can deal with
this fine, but not before memblock resizing is enabled, which we can
only do after paging_init(), when the memory we reallocate the array
into is actually mapped.

So  on ARM, call the broken out efi_apply_persistent_mem_reservations()
after memblock resizing has been enabled but before the early memremap
support that we rely on has been taken down.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/mm/mmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 078f82f89fe5..8ecffb8c0c0b 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -9,6 +9,7 @@
  */
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/efi.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/mman.h>
@@ -1629,6 +1630,7 @@ void __init paging_init(const struct machine_desc *mdesc)
 	memblock_set_current_limit(arm_lowmem_limit);
 	memblock_allow_resize();
 	dma_contiguous_remap();
+	efi_apply_persistent_mem_reservations();
 	early_ioremap_reset();
 	early_fixmap_shutdown();
 	devicemaps_init(mdesc);
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
