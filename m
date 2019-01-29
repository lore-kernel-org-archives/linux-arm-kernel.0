Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5772AC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:22:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26DB02177E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q36/PdYz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="d4+OnPTO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26DB02177E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=h0eLMk+F/7MLpdbVt8v2cn02FOsoOoMN9oAwl1Jsu9M=; b=q36/PdYzQqOwNC
	WrJurQbyDXhstA3d0h7f0x5GX+I6OCvJ/R1kEikuCxN9DOue2nPROK21mqV8VDx34oT/qXRGxyl5v
	6Z9hPoH/awSzujdssJcNqqwgzo4YDdNGtEnPdjjFxsIOflz+RuvNYd7bcLCX/pSPDvKIhMGd5GQHi
	x5xmr7SgxoEEUm6U+OcDm+9e84nJwEyJW3LSE3+79eSWNjXGyGeILe+oE4P9Zp/sGkFwK4/z9CS24
	9Q3SnFaz880tx/7sVBItHsHyIzfqvV0zQLnBTREXA/4YmNLBn1wPLhOe4GsjobQBbyY+4ohVeTMKP
	ifsW4u9zyPHPpkeIQ+4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goPb9-00035K-4q; Tue, 29 Jan 2019 09:22:27 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goPaj-0002iG-Hm
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 09:22:02 +0000
Received: by mail-wr1-x443.google.com with SMTP id 96so21197551wrb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 01:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AT1pMHI7CS7L1GDQ1CdeCVHhSeyLceYxSMxlS/ZwinY=;
 b=d4+OnPTOogcl0JqiSYwkTiQW+Q40cvQ2srmn39Gx0B+TBOTs5Z777ZKTrx0HDVVAfF
 gScRakUelxGfuFWq7TPypx2i07wN/6UoJNd7QMWW2pvrJ8biFwKLVLxLvbC4w2cutex1
 tLX1o2t26k2/k2zdRWVmxyogNrjpvdlguJhCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AT1pMHI7CS7L1GDQ1CdeCVHhSeyLceYxSMxlS/ZwinY=;
 b=rRqOEVwIVVyNRF1KatRzNY7MVgktxsnWEzzCp0DWl4EbAMjuCMeCj19TBNMJC2qj6A
 0d5x4aIS4LCFwwCXBNAYMGU/JA1f+y9ZAips/4Y50yV/l8WbDNSJ/rAIA+i15LOnm2HI
 f8ngmVtrRtzYyHKDqg+8l9hHuDwc15J3eOznHQJ5EJu8tO0zfs5az2vr9x9NTqrVVFj4
 2avz4o0JCSnia7MD7wp0ebY5OfbwV59iLCdfgDpHZRRTi6SCWIqGdIEpxNmlg4Np2TEz
 lz7Ndato+aea7LWRqzB55SRDD55cWZuri9fGjcTcc3mV2K2nTGdvA6bCteAgwi/1t7pp
 TfYg==
X-Gm-Message-State: AJcUuke1dwP5RUF29X/F1m0j8uLtUndBJtCnru3QFFjBvo2ZYLYg+x+e
 Jn1QgNHYJzZkO95m5xNXnp3R1w==
X-Google-Smtp-Source: ALg8bN7tKJi45OsTipSflBUM61b41FfWGEJNiJiOczJQE5lTOkFLF+dG0YHdxUhACK+FJ2udExhPfQ==
X-Received: by 2002:adf:8c09:: with SMTP id z9mr21352570wra.301.1548753720184; 
 Tue, 29 Jan 2019 01:22:00 -0800 (PST)
Received: from sudo.home ([2a01:cb1d:112:6f00:61d3:a2fc:db63:aa38])
 by smtp.gmail.com with ESMTPSA id x1sm28751755wru.34.2019.01.29.01.21.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 29 Jan 2019 01:21:59 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-efi@vger.kernel.org
Subject: [PATCH v2 1/2] x86: make ARCH_USE_MEMREMAP_PROT a generic Kconfig
 symbol
Date: Tue, 29 Jan 2019 10:21:49 +0100
Message-Id: <20190129092150.15184-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129092150.15184-1-ard.biesheuvel@linaro.org>
References: <20190129092150.15184-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_012201_581806_246F3B3A 
X-CRM114-Status: GOOD (  11.86  )
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
Cc: graeme.gregory@linaro.org, corbet@lwn.net, pjones@redhat.com,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-doc@vger.kernel.org,
 agraf@suse.de, leif.lindholm@linaro.org, mingo@redhat.com, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Turn ARCH_USE_MEMREMAP_PROT into a generic Kconfig symbol, and fix the
dependency expression to reflect that AMD_MEM_ENCRYPT depends on it,
instead of the other way around. This will permit ARCH_USE_MEMREMAP_PROT
to be selected by other architectures.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/Kconfig     | 3 +++
 arch/x86/Kconfig | 5 +----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 4cfb6de48f79..9f0213213da8 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -885,6 +885,9 @@ config HAVE_ARCH_PREL32_RELOCATIONS
 	  architectures, and don't require runtime relocation on relocatable
 	  kernels.
 
+config ARCH_USE_MEMREMAP_PROT
+	bool
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 26387c7bf305..c0e9a77dc089 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1510,6 +1510,7 @@ config AMD_MEM_ENCRYPT
 	bool "AMD Secure Memory Encryption (SME) support"
 	depends on X86_64 && CPU_SUP_AMD
 	select DYNAMIC_PHYSICAL_MASK
+	select ARCH_USE_MEMREMAP_PROT
 	---help---
 	  Say yes to enable support for the encryption of system memory.
 	  This requires an AMD processor that supports Secure Memory
@@ -1529,10 +1530,6 @@ config AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT
 	  If set to N, then the encryption of system memory can be
 	  activated with the mem_encrypt=on command line option.
 
-config ARCH_USE_MEMREMAP_PROT
-	def_bool y
-	depends on AMD_MEM_ENCRYPT
-
 # Common NUMA Features
 config NUMA
 	bool "Numa Memory Allocation and Scheduler Support"
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
