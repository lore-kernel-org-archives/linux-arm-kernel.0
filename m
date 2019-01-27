Return-Path: <SRS0=mu0f=QD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6911C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 08:29:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93D42214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 08:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mElXApVa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z6pC8HdZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93D42214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=PChs9u0uz3MVlu2lnOlf288B5T1aIGBRsY6nWpSwCFA=; b=mElXApVabDaCMh
	SKzLL1TYEtcFht19t9ZnnDIMs/tRKy+Zg3st+moKA2Q3E0+ndUPWMz8MXwPVIhp7LepyvXp4L24Kb
	jM6SdgU5D6UJeP1cOwufGtBqwW/iOeBvp2aPc52wblZUJ+/OHEIN3/WboFRcoj/9VySBaYZq49hH+
	yD1Q/sWxXg0TAQevEXtIq/6KcI75CvsCkIAxDNnEEUCXEY6osANmnHS/ylK3MFGd1G8LTPlBxLug3
	3jLH2cmA5SFNlAxrOIWmjJL0+lrltGcwq5V/YL98I5pXD1uo0fCDQogtycINQ0mZuRqdWajL/9UFs
	wHic0Kp4Q49jn0GH5t5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnfp8-0001AL-Tw; Sun, 27 Jan 2019 08:29:50 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnfp6-00019w-C4
 for linux-arm-kernel@lists.infradead.org; Sun, 27 Jan 2019 08:29:50 +0000
Received: by mail-wr1-x443.google.com with SMTP id 96so14581765wrb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 27 Jan 2019 00:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Pcz3APvMfrAaCnd4rFCsM9XQr9R81TbDRa9rzor92zE=;
 b=Z6pC8HdZqyTNII1AxdK5JVy4mxJEMJAaVCRMYfmPnfFyKmCW9VksTk6xtanGgEWsnm
 /2D7ijl5KBeSqcOxtd1FVtdfMRAgePMB/7VV2Eh/CHwHUWpAV9KITfXn3XJzJx+1+5dv
 XVMOR2iPKxyoPDlsZtFehKhBNVxubKTp0oaZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Pcz3APvMfrAaCnd4rFCsM9XQr9R81TbDRa9rzor92zE=;
 b=swnXhHJck0w9foYnzhbuJB0p6+MrxUsQKqniEDkKQjVCReosw3SXJyY7YJ94q5yuZE
 SvVBCKz4GMkZiuAUeRqTJv/1A6C73qnTar+DSnuUvEXJjS+8AYnih9cPoCJAl8ajQFIq
 zITpf9VBoTvjbZ4X4UpZUyJup2m6m0T2AjikwpKqIXz3pQtb9l2jqe65/f61AGwKTg1J
 Apx2Mk2Ix5Y0GEZbMfTglygs8Dkd/wI3EeFwoEJ70Uo1oatwjiciXzeTQwfKj3zn0W/w
 JJoEWcM1ASzGaKMearzPEyKhOaUqDiAZDIYGLf/lN5XTNhCJ8V26+qADgppQ0caJTeUP
 jE5w==
X-Gm-Message-State: AJcUukfGDrd6jkIdR8MosTNheVcjqYzx9oOy/KgrtkUhybq246M4zsWk
 4kC90U5HEmYTFL8ZKZ+WFq6v7i/+bbsRDA==
X-Google-Smtp-Source: ALg8bN7myPNpp+4hoakbGcUIL9vlMcOq4GjW80QNsFkwQYMG8fQf408388vXsjYN5zVCyToGNApLzw==
X-Received: by 2002:adf:b102:: with SMTP id l2mr16906631wra.296.1548577786162; 
 Sun, 27 Jan 2019 00:29:46 -0800 (PST)
Received: from sudo.home ([2a01:cb1d:112:6f00:887d:32e9:9391:d3bf])
 by smtp.gmail.com with ESMTPSA id s66sm59019402wmf.34.2019.01.27.00.29.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 27 Jan 2019 00:29:45 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: kaslr: ensure randomized quantities are clean also
 when kaslr is off
Date: Sun, 27 Jan 2019 09:29:42 +0100
Message-Id: <20190127082942.21998-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190127_002948_420242_BCEB92FC 
X-CRM114-Status: GOOD (  11.65  )
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
Cc: catalin.marinas@arm.com, will.deacon@arm.com, stable@vger.kernel.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Commit 1598ecda7b23 ("arm64: kaslr: ensure randomized quantities are
clean to the PoC") added cache maintenance to ensure that global
variables set by the kaslr init routine are not wiped clean due to
cache invalidation occurring during the second round of page table
creation.

However, if kaslr_early_init() exits early with no randomization
being applied (either due to the lack of a seed, or because the user
has disabled kaslr explicitly), no cache maintenance is performed,
leading to the same issue we attempted to fix earlier, as far as the
module_alloc_base variable is concerned.

Note that module_alloc_base cannot be initialized statically, because
that would cause it to be subject to a R_AARCH64_RELATIVE relocation,
causing it to be overwritten by the second round of KASLR relocation
processing.

Fixes: f80fb3a3d508 ("arm64: add support for kernel ASLR")
Cc: <stable@vger.kernel.org> # v4.6+
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/kaslr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index ba6b41790fcd..b09b6f75f759 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -88,6 +88,7 @@ u64 __init kaslr_early_init(u64 dt_phys)
 	 * we end up running with module randomization disabled.
 	 */
 	module_alloc_base = (u64)_etext - MODULES_VSIZE;
+	__flush_dcache_area(&module_alloc_base, sizeof(module_alloc_base));
 
 	/*
 	 * Try to map the FDT early. If this fails, we simply bail,
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
