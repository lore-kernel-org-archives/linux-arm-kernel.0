Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C567C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:00:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C65E214C1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Jzhd0fen";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bQGwIxIB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C65E214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EEu04qj/1WGDzf8QSI2ojg0FCXdAjQytcFKkWCEdUCA=; b=Jzhd0fenNO1NvJ
	7t8rrz4sBrpQ6lFRLKaCkhPnexqbFVWVqGtFow87FXsIpVgAKNaWttXWz4QGBnswD9y9XOO+rlvSE
	BlEQJ74HbQXbeE0PSGCczKF4NAJOpTaFpbq/E4QumN0W9RXLq29thRCansMN47fvqdfMi+OmpixGn
	/yHYFV1e8duEm/oIwWQjUXBqNf/NTBtR/H932Qo6Cxx6WNTWS4+WNFwxGHJwJ6eDPn9WfgVcehBHP
	POtbZEXG0s5y2hit4NxICVXRKzxWTSKIqQQfct+lgju8rhyP65sNtJOPx5zimw5YbJxyPRPTl+HDV
	8yYuZFMdmiiGgP138aIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUw4j-0004xq-PQ; Thu, 06 Dec 2018 16:00:29 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUw4A-0003Br-Il
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 15:59:56 +0000
Received: by mail-wm1-x344.google.com with SMTP id y185so14427578wmd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 07:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YAJ/pSqxHadg9FAalxrP9XtBWK91iIUrnuOMWYKHTIQ=;
 b=bQGwIxIBK0/KWy1ZsHZsbFC0w94wP01OxLh+vtw1bAeRhFTgOQJAMWKaoVcaUF7cZl
 lusOfufP8vuz4RrpEz6ugIwqp3RJ182W4P7mOp69ecMwFaYMJrPN5UzI1ZK73k+sd659
 MvVrQK0ljOjwxFk4GJiWJRA/VvjgBOWLtupSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YAJ/pSqxHadg9FAalxrP9XtBWK91iIUrnuOMWYKHTIQ=;
 b=IdG1vHpgn8WTLWkKKCDarEByqCxcSqQg+4WTrByR/qvoMWpWIgDlVMKOKIzrGy7IaT
 eyVWM+l51tIiY7ebt3TmjTyCo0nTWyuFoPLtvctJwIeT+SW233K+J+wIW7CDaGlnExiZ
 adOqoLf3M96D8kaL4ZsIU1Fs3TCk7mWqPZQx2gVxaXVQ2W7yDbvkqrIY0v2++0OFTg5O
 teZOBXYwWOvKzR1fJf4r8Yel4etJ3f8lBLXEZl1bZ1cpCpviWVx4D/FoKlhGf7aji0/9
 iLwuWBR2tc49H8Y6ipS/JRCMO4ElY1AKP21MBr06azLzhMtjSVVelhpow3pI+cDLz0un
 cQFQ==
X-Gm-Message-State: AA+aEWbqvPwQ4W16OH+lh1qzqXWn7D6VL8PH6ybmy2SscfSqe/x6kVfV
 lkhNWalttuJ+d/wnOXozaKQmjw==
X-Google-Smtp-Source: AFSGD/Uz7FkM93KEWIIiMgqx12qgI/PGpb5Q4lkjoKBx6o5w4iOeuACny/LZxt+3lyM9PK+a8jbVSg==
X-Received: by 2002:a1c:770c:: with SMTP id t12mr20471294wmi.101.1544111987884; 
 Thu, 06 Dec 2018 07:59:47 -0800 (PST)
Received: from localhost.localdomain
 (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr. [92.154.90.120])
 by smtp.gmail.com with ESMTPSA id y34sm1525233wrd.68.2018.12.06.07.59.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Dec 2018 07:59:47 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] arm64/mm: use string comparisons in dcache_by_line_op
Date: Thu,  6 Dec 2018 16:57:39 +0100
Message-Id: <20181206155739.20229-6-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206155739.20229-1-ard.biesheuvel@linaro.org>
References: <20181206155739.20229-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_075954_669454_8552ECDD 
X-CRM114-Status: GOOD (  13.13  )
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Suzuki Poulose <suzuki.poulose@arm.com>, Will Deacon <will.deacon@arm.com>,
 Robin Murphy <robin.murphy@arm.com>, Dave Martin <Dave.Martin@arm.com>,
 linux-arm-kernel@lists.infradead.org
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

So let's switch to conditional directives that are documented as
operating on strings. Since these cannot be combined like ordinary
arithmetic expressions, invert the comparison logic.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/assembler.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 09c5a5452f60..df3043e76e6a 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -383,21 +383,23 @@ alternative_endif
 	sub	\tmp2, \tmp1, #1
 	bic	\kaddr, \kaddr, \tmp2
 9998:
-	.if	(\op == cvau || \op == cvac)
+	.ifnc	\op, civac
+	.ifnc	\op, cvap
 alternative_if_not ARM64_WORKAROUND_CLEAN_CACHE
 	dc	\op, \kaddr
 alternative_else
 	dc	civac, \kaddr
 alternative_endif
-	.elseif	(\op == cvap)
+	.else
 alternative_cb arm64_handle_dc_cvap
 	dc	civac, \kaddr
 alternative_cb_alt
 	sys	3, c7, c12, 1, \kaddr	// dc cvap
 	dc	cvac, \kaddr
 alternative_cb_end
+	.endif
 	.else
-	dc	\op, \kaddr
+	dc	civac, \kaddr
 	.endif
 	add	\kaddr, \kaddr, \tmp1
 	cmp	\kaddr, \size
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
