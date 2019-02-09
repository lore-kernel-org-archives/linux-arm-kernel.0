Return-Path: <SRS0=BTYN=QQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF96C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:35:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E658214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hyaxX57B";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uQbVWXFe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E658214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:Date:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=KTLVwowuAZY1aRW9GKAntUCRZBpMwnycUd99CgB7Tik=; b=hyaxX57BLtED4H
	23s8j9phpGVY+sAC/0AH068up1PvBPVd8CpOq8S0pZMiOboKRO5WNuhHwuNULomujihOngZ3AzPbF
	PXfjjDmkWd89oI2AllL4eRVCZy2cnzhFozVbUOC1SRtfzxAU+7rSxjQtTp8R40N8Ooejgowap1X9O
	5ncG3h52f04LOo5cuRdBxgyOr715VXWeQJYcmp69ev6F5mA9NF83QZcLlXs78z+jqTSpQ4MYCLYh1
	XbMdxjywplBab3Jkr8ZTIuBUlfXgyKMRUi8AlWGH8Fk8HBX7FCavEzZ4fjbhDtL9n+xV5Emv2zeYG
	j7wxaJQhsZRnBfreDTng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsXSw-00027E-4g; Sat, 09 Feb 2019 18:35:02 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsXSr-00026p-CI
 for linux-arm-kernel@lists.infradead.org; Sat, 09 Feb 2019 18:34:58 +0000
Received: by mail-wm1-x342.google.com with SMTP id y185so9995719wmd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 09 Feb 2019 10:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:user-agent:mime-version
 :content-transfer-encoding;
 bh=SYxH1yx8PgayeikM4YgapG+FoS6nT4L4Mzor/Idpn2g=;
 b=uQbVWXFeij5Y5/wN+V5RzqQE5hPfuateLFSf1seTvd4L9cKgzxXZ0YjW8VlFsh9w5G
 ApYjmCuLtrUogmbge27IP93g0rgjPVO313Dk8WI2ekC8NUJdzpVrxyYJrAs5zKHeNmyH
 c/2ViAUSkvW5NWUDHWbVIAUQB+uQFA7rtuaysZiO4ltidS1ABAmlwMpzAULTny2eLBof
 6aayIQyQkiPMiDEoS4yUSjdaLiU7SamB4pc44dE13izM5dmpHoKINOknh2bK66qv5pj0
 ASqRwxca22tDGjKaG0ki5ze49uqoSWhF+Cwxi4LJpQ7QfWSLdjfOAniCzxzCK6yBJg5Q
 YWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
 :mime-version:content-transfer-encoding;
 bh=SYxH1yx8PgayeikM4YgapG+FoS6nT4L4Mzor/Idpn2g=;
 b=I3qT5d8FUZEzFrspCEH+A7BGhJpf5xqO2BDG8FyMup5Li4HpPXOCBzIFXDNstyQlHA
 OprTccCBpKLeDFHAKlt8uq1Og61TjxuqYH33jytSbBfep7TuXI0pfv5PnLw9qU7Dkhvl
 K/JBaVMmP8feaIma36itRnbZolg2ArTf2HLM8aloIISMMtf3HjE/v0rODTKuy1jv10G6
 Ck1JcI+4J1S29Wi+Vt0zFNoR7BAM6EV60Wl8r0Y+PlkmQlhJLc/umlgOYlKmKgdlasrd
 LbIpudqYjnxKx7Btxd8tMZxBfr3g9W9MtiF31hZSsJQP3Jihr1CD0w+2H7Rd14kWT6tj
 iW9A==
X-Gm-Message-State: AHQUAubfaZ2WDFmdD2mcEMDgwDJDeiLiqqA2e6XWQwEig+TlZX/UHI+B
 0SNvojUlogb8GF+uFkVUTBM=
X-Google-Smtp-Source: AHgI3IaWBOsRg6JmG8tOQzmAPqqQR8GvhejxcmrsGr121gaQd0LtmpQLBdlBIX+wJVJW12C+eXIwfQ==
X-Received: by 2002:adf:c5cc:: with SMTP id v12mr20698627wrg.176.1549737294680; 
 Sat, 09 Feb 2019 10:34:54 -0800 (PST)
Received: from [192.168.1.100] ([93.51.16.173])
 by smtp.gmail.com with ESMTPSA id s187sm3064346wms.8.2019.02.09.10.34.53
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 09 Feb 2019 10:34:54 -0800 (PST)
Message-ID: <68b71c15f32341468a868f6418e4fcb375bc49ba.camel@gmail.com>
Subject: [PATCH] arm64/io: Don't use WZR in writel
From: AngeloGioacchino Del Regno <kholk11@gmail.com>
To: AngeloGioacchino Del Regno <kholk11@gmail.com>, Jens Axboe
 <axboe@kernel.dk>,  Will Deacon <will.deacon@arm.com>, Catalin Marinas
 <catalin.marinas@arm.com>
Date: Sat, 09 Feb 2019 19:34:53 +0100
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190209_103457_420430_423B0066 
X-CRM114-Status: GOOD (  13.71  )
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
Cc: linux-arm-msm@vger.kernel.org,
 AngeloGioacchino Del Regno <kholk11@gmail.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From 33fb6d036de273bb71ac1c67d7a91b7a5148e659 Mon Sep 17 00:00:00 2001
From: "Angelo G. Del Regno" <kholk11@gmail.com>
Date: Sat, 9 Feb 2019 18:56:46 +0100
Subject: [PATCH] arm64/io: Don't use WZR in writel

This is a partial revert of commit ee5e41b5f21a
("arm64/io: Allow I/O writes to use {W,X}ZR")

When we try to use the zero register directly on some SoCs,
their security will make them freeze due to a firmware bug.
This behavior is seen with the arm-smmu driver freezing on
TLBI and TLBSYNC on MSM8996, MSM8998, SDM630, SDM660.

Allocating a temporary register to store the zero for the
write actually solves the issue on these SoCs.

Signed-off-by: Angelo G. Del Regno <kholk11@gmail.com>
---
 arch/arm64/include/asm/io.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index ee723835c1f4..a0a6d1aeb670 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -49,7 +49,7 @@ static inline void __raw_writew(u16 val, volatile void __iomem *addr)
 #define __raw_writel __raw_writel
 static inline void __raw_writel(u32 val, volatile void __iomem *addr)
 {
-	asm volatile("str %w0, [%1]" : : "rZ" (val), "r" (addr));
+	asm volatile("str %w0, [%1]" : : "r" (val), "r" (addr));
 }
 
 #define __raw_writeq __raw_writeq
-- 
2.19.1



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
