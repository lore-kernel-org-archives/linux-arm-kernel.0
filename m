Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677DCC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:21:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29DA920870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gXrJTeb7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KVR5amhX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29DA920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yBNLzx16fY7KziV5DOq5v2c3wCWNBphg8FDuQ2hRHoQ=; b=gXrJTeb7KY5Lp5
	V1doM0ScvvPb5L1v2Ay5LvGyzEUuzzUrYgYVUrAJPMqWyl82mCWkEd/VLYechZ2axXDrOFem2/Usb
	pkJnvRd9Gbkso3UZyou+nz30bWcBuDnapnZxTIVpvt9T1u9/bn+5JaQPYSs8ut6DmF6ASFWBjCpPH
	f1k58kwkHKgqqCAT/wthtnUksT/SmUJ2MLeZ2fAx76CD9ShS9w4q/NqqpLiZHXu0CFk48TILhMpyM
	eEK1sRru+L1mYvomgPgYZmCh403LX3LdolxPFkDWuhoTKHUTd9unsY3FOZl1C0gcr1NGxD1enY2Hr
	H/uMlE/TeC1Rw2ZhLKmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXUff-0007RB-NO; Thu, 13 Dec 2018 17:21:11 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXUfN-0007BA-Ro
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 17:20:55 +0000
Received: by mail-wr1-x444.google.com with SMTP id x10so2817914wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 13 Dec 2018 09:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3kU5A9Z2aTiJS/REKXgB3s9e5vNfCn6o+UyWBf65Za0=;
 b=KVR5amhXEn2pScWPCPmR2LKrv82Z5stuocDVaxtFDjBZ4j4rLtWiuL1vq2w3Rp5aW4
 fZYi4rxay+5/a2MiyxmJOYHndr45fGP6tAdGF1WEl906qUgyV3IPuTGMe7lxIxZsxlqJ
 xHlCli8ljdFUpT37uIgg7uQbpTASnuS3j/TfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3kU5A9Z2aTiJS/REKXgB3s9e5vNfCn6o+UyWBf65Za0=;
 b=afABgHLxujzQlJuG0+a5T9V8XdFmI/nLm1QzIB9ACJ/kRZokRHLL1THR2byRV7ZPz7
 eickGv6EfB6u3hP1Rk4+nrbgxOQb4IX8zFCFv0w0iXp8dMHGKtN0AR5jR9F1bi3lJ5HG
 JaUN6TkyM9iB2GmTMvug4EHWwCf98IHdPZcskIRmMgjKmVwX9yivPBRGHJ7zutGgM6Dv
 c5s4121Yqf5JLH6a1caM9X3xPIT7vkk5bIEcdhH7keJ5FoJFkGlhRvk6hiztUZnnmjs3
 Y8sSFFdoAEdN4R/fNPoylcLgVsujSmjjXFPNHQeWj1tjaj0dviw8LuMUotdRolUkcIPe
 k98g==
X-Gm-Message-State: AA+aEWYWZsGBfFD9HDvkCAdT5IAUE1ZU9RMcpNOEBEhAMCvX2ckDUYaX
 SYgP4owv/ABj/PutB/Oftx6MFJ/TgGEQgw==
X-Google-Smtp-Source: AFSGD/W/6wXCdP0wLDN1fEjald4j+PoVOdiYZnBJr+t6Cm0033e42NSDO/3BP8D9zxpOiyDr2ZIeaQ==
X-Received: by 2002:adf:e64d:: with SMTP id b13mr4570953wrn.276.1544721641942; 
 Thu, 13 Dec 2018 09:20:41 -0800 (PST)
Received: from localhost.localdomain
 (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr. [92.154.90.120])
 by smtp.gmail.com with ESMTPSA id q12sm2902753wrx.31.2018.12.13.09.20.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Dec 2018 09:20:41 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 1/4] arm64: kpti: enable KPTI only when KASLR is truly
 enabled.
Date: Thu, 13 Dec 2018 18:20:32 +0100
Message-Id: <20181213172036.14504-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181213172036.14504-1-ard.biesheuvel@linaro.org>
References: <20181213172036.14504-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_092053_892514_497500D8 
X-CRM114-Status: GOOD (  15.77  )
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
Cc: Robin Murphy <robin.murphy@arm.com>, John Garry <john.garry@huawei.com>,
 Will Deacon <will.deacon@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Kernels built with CONFIG_RANDOMIZE_BASE=y may run with KASLR disabled
when no RNG is provided by the firmware, or when it has been turned
off explicitly by putting 'nokaslr' on the command line.

In this case, there is no point in enabling KPTI on cores that have no
need for it otherwise, so take kaslr_offset() into account here.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/cpufeature.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index aec5ecb85737..ef8118274ca9 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -937,7 +937,7 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 	}
 
 	/* Useful for KASLR robustness */
-	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
+	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && kaslr_offset() > 0)
 		return true;
 
 	/* Don't force KPTI for CPUs that are not vulnerable */
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
