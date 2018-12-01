Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177DFC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 11:02:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D58312081D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 11:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z5k+XKY3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VDJw3KYI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D58312081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=4vPxd/c8uMUGpTBGLeKuOB0C43OqlfUnJHc1q2iDTvE=; b=Z5k+XKY35qGafm
	WJmfzrnrTpnpJ1rHXAKzkkDvRRyt7Gj40PELByH57LwKfcEBitKB6W48mMnjQxodLsC2y9WY+W2/b
	grJ7Qj5LVNCwsYJ50Bct6lLd9OwQ9OlgC0zJW1Z+1DYk0nAiGfUuyP/d+OQH+RqREJDxkDXdqhJXi
	4Nz9dtQy0jHdCz8WEkeiyj10UL06UAr9DB6xYX4PYGAi3hJhJxlCoWKSE9JPPY3EEk27JZa/7F4rH
	9gi1HCntVa4p3cY0n77M/ZQ/tTrxQUWa30jQXAm+w0SKT6QsESwMzqd0wIPE/8K0usoDUI0vgDBSG
	Y49dxnm7P1rLGXDKjFTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gT32B-0007CJ-M7; Sat, 01 Dec 2018 11:02:03 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gT329-0007Bp-42
 for linux-arm-kernel@lists.infradead.org; Sat, 01 Dec 2018 11:02:02 +0000
Received: by mail-wm1-x343.google.com with SMTP id q26so1299447wmf.5
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 01 Dec 2018 03:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pgxjcCZc9WjXCokd01RxR9GXzZIs2JBPDxDL9QyuihI=;
 b=VDJw3KYIHzCI+0Mgzhx5w4b+wdy2ap/R6Xe1uafYEMY/58MFL+yl3nQjpGlrZeM4ec
 EgIe7FrSYCuHdv7mjJpOjdEX/0RJMiJBbnQjo9tyuPjq752ou+ndXPdK2CFrRnGH0RN0
 phPnidvyvC3nhOjCs6Ybp/c7sT+Kreigm/1vc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pgxjcCZc9WjXCokd01RxR9GXzZIs2JBPDxDL9QyuihI=;
 b=c2iS15Ba5wbvVqi1W5lZmY4W98iIx/scF8k2KeBq4FYlUQ2kvn6AeTn1cZhdmCe0+0
 gROZeUUuGy0NY5fuMqi1+Rz1JEgYhbZawZ3YaTzX5CWMWQbslKvddXRJUtK37qDaGJMj
 Mcskhl37F06Ocs6Gm31gwZdMQzjojvMn3FUNtXqclaLRTTmLpLTuYAsib+kL9G09S5iy
 iDaTznft8Kfd3xMzFlFlpn15pjTiP1kqaklC8vLdW0kn2mXHpb26ckCw6UAXn1+HhFQI
 i+toxHKn2q7Nx0Ul7I+IPTUmmJo+mJ1/BD1D5sxgqKSWK03qoXTKzK0zExzDFTJ91gRR
 AVqw==
X-Gm-Message-State: AA+aEWYF36FBxhGHbYKFxal4zgMWtIm0EL28uEJA49GFgFav86L7mbwD
 p3ks4kiiYsTi+PHiyF+RDEAtTWcZg2Q=
X-Google-Smtp-Source: AFSGD/X8GDuQJ0f/50lk4InOLdfCWFyDROa7ccwTtYy5KDcXv8E6ULpriv9RYCVxzwCHSE9OxEX+rg==
X-Received: by 2002:a7b:cb09:: with SMTP id u9mr2024010wmj.8.1543662107216;
 Sat, 01 Dec 2018 03:01:47 -0800 (PST)
Received: from harold.home ([2a01:cb1d:112:6f00:edfb:24ff:63d6:53d9])
 by smtp.gmail.com with ESMTPSA id o15sm8217904wrp.12.2018.12.01.03.01.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 01 Dec 2018 03:01:46 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64/mm: use correct operators for string comparison in
 cache.S
Date: Sat,  1 Dec 2018 12:01:44 +0100
Message-Id: <20181201110144.15970-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181201_030201_176966_6BC37FF1 
X-CRM114-Status: GOOD (  11.74  )
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
Cc: catalin.marinas@arm.com, will.deacon@arm.com,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The GAS directives that are currently being used in dcache_by_line_op
rely on assembler behavior that is not documented, and probably not
guaranteed to produce the correct behavior going forward.

Currently, we end up with some undefined symbols in cache.o:

$ nm arch/arm64/mm/cache.o
	 ...
	 U civac
	 ...
	 U cvac
	 U cvap
	 U cvau

This is due to the fact that the comparisons used to select the
operation type in the dcache_by_line_op macro are comparing symbols
not strings, and even though it seems that GAS is doing the right
thing here (undefined symbols by the same name are equal to each
other), it seems unwise to rely on this.

So let's provide some definitions that are guaranteed to be distinct,
and make them local so they don't pollute the gobal symbol space.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/assembler.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 6142402c2eb4..d11c32df85c2 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -377,19 +377,24 @@ alternative_endif
  * 	size:		size of the region
  * 	Corrupts:	kaddr, size, tmp1, tmp2
  */
+	.set	.Lcvau,  0
+	.set	.Lcvac,  1
+	.set	.Lcvap,  2
+	.set	.Lcivac, 3
+
 	.macro dcache_by_line_op op, domain, kaddr, size, tmp1, tmp2
 	dcache_line_size \tmp1, \tmp2
 	add	\size, \kaddr, \size
 	sub	\tmp2, \tmp1, #1
 	bic	\kaddr, \kaddr, \tmp2
 9998:
-	.if	(\op == cvau || \op == cvac)
+	.if	(.L\op == .Lcvau || .L\op == .Lcvac)
 alternative_if_not ARM64_WORKAROUND_CLEAN_CACHE
 	dc	\op, \kaddr
 alternative_else
 	dc	civac, \kaddr
 alternative_endif
-	.elseif	(\op == cvap)
+	.elseif	(.L\op == .Lcvap)
 alternative_if ARM64_HAS_DCPOP
 	sys 3, c7, c12, 1, \kaddr	// dc cvap
 alternative_else
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
