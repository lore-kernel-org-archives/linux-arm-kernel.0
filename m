Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107D0C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:52:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4B362087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="prQeZdnQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hkKGJRhU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4B362087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OZvGWt36BJfvT9vMTrLRDKPYn6KYOhqmyE+roH/XZ2Y=; b=prQeZdnQlkr/UI
	6T+WRzuAMCyJDRaT41FA+twsYSt8UxQ8XMTzFcjfKM2oRjeFgaiazG7bYfpHSlnVPMgpKMUxcAK/8
	tCiaPHDK0wOkpoLKFzlrzagC+B5GiS05Je1LHrJIP8yM7uneNkb3S3D2kyQbEhRDm0JiRdKDTi8l5
	yI835ekdxkjwb7DCecotZoygjp5pj8ItKviGAboO8MWyDXkXc4ZuIB5Fff2+oHDlMqq3uFcYnYF5/
	ik/0ukCBqzXB2xVIyfsSnmlYptIkNBt41rovSJbfHbfXqKczDzfZpFHAz3e5yJCzRo6qWIklWMqNr
	CCDsVJYeFvC+J+BhUOdw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpAtE-0004VQ-Hs; Thu, 31 Jan 2019 11:52:16 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpAst-0004EC-H4
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 11:51:58 +0000
Received: by mail-wr1-x443.google.com with SMTP id t6so2894404wrr.12
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 03:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4/VoXADw9TGpzOH4HUtc8S5BN+42h6eZM7HvNc5Yxz4=;
 b=hkKGJRhUXfkhPW+avct+oPnArS8giyN/dEKIuCONEk4ShmT0Fz21/8a3dWm4ZSPVbA
 EDAYKN2j817R09yoDKUYTusd3oARfQe/6sgpJR6ndle2AS/vudHKrfa79wrg3L57fZTa
 b36KKOLKOOaD6VR+jQMFxUaab/HWTv8vS7/uM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4/VoXADw9TGpzOH4HUtc8S5BN+42h6eZM7HvNc5Yxz4=;
 b=M3yRCa8HVBdBKA6yAl9T5q6U6QU2RDGDmWtI19DzePKxi+FUu8DrIILD33Sp5uSXmw
 sDHXawuarAfvN1kjjJ/L8+SDL0VXBbG5GmujqwXgR9Dc3xgmDS0bPGibetBTqBsr+TBq
 avbJ7XMZ5pxz/FbWlCTz3pb/NhJuT9o6/9mNjgy2PM7lAoy0t/QfdgI4h5R1PuKi82RF
 cHCCr4wbJ1J4SWWFEHs5rfFtRvPJm+KYyPvN84nZ8Kj/IdG9BVb13d825feRlsBKFPGQ
 YAdjP7z2IS0x0DVtYcifnciYXvFuIUlB9jjUnE3Pa7DoQ4UyvcIsAqqu4yhxTyBS+6Tk
 z6lQ==
X-Gm-Message-State: AJcUukcHn2Eyf0bAeJMG5PuNw+xeHXYxbM6PrjYacZoq5vrc18zWuUXU
 8SH4UBNvpnCxRjPJ6Vkx2IszGQ==
X-Google-Smtp-Source: ALg8bN4U4ysoREZ4RhZglRbahqWwQUUmrWo4bQRYACvVUV2atEePFKX4tqLT0BqHidPvoHuITIeJBg==
X-Received: by 2002:a5d:530a:: with SMTP id e10mr35201107wrv.151.1548935512133; 
 Thu, 31 Jan 2019 03:51:52 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-39-7.w90-86.abo.wanadoo.fr. [90.86.94.7])
 by smtp.gmail.com with ESMTPSA id w10sm5807714wmb.1.2019.01.31.03.51.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 03:51:51 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-efi@vger.kernel.org
Subject: [PATCH v3 1/2] x86: make ARCH_USE_MEMREMAP_PROT a generic Kconfig
 symbol
Date: Thu, 31 Jan 2019 12:51:44 +0100
Message-Id: <20190131115145.4634-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131115145.4634-1-ard.biesheuvel@linaro.org>
References: <20190131115145.4634-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_035155_569102_93AA0C1C 
X-CRM114-Status: GOOD (  13.60  )
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, graeme.gregory@linaro.org,
 corbet@lwn.net, pjones@redhat.com, x86@kernel.org, linux-doc@vger.kernel.org,
 agraf@suse.de, leif.lindholm@linaro.org, mingo@redhat.com, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Turn ARCH_USE_MEMREMAP_PROT into a generic Kconfig symbol, and fix the
dependency expression to reflect that AMD_MEM_ENCRYPT depends on it,
instead of the other way around. This will permit ARCH_USE_MEMREMAP_PROT
to be selected by other architectures and other subsystems, such as
earlycon for efifb in a subsequent patch.

Note that this will cause the encryption related early memremap routines
in arch/x86/mm/ioremap.c to be built for 32-bit x86 as well, which triggers
the following warning:

     arch/x86//mm/ioremap.c: In function 'early_memremap_encrypted':
  >> arch/x86/include/asm/pgtable_types.h:193:27: warning: conversion from
                     'long long unsigned int' to 'long unsigned int' changes
                     value from '9223372036854776163' to '355' [-Woverflow]
      #define __PAGE_KERNEL_ENC (__PAGE_KERNEL | _PAGE_ENC)
                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~
     arch/x86//mm/ioremap.c:713:46: note: in expansion of macro '__PAGE_KERNEL_ENC'
       return early_memremap_prot(phys_addr, size, __PAGE_KERNEL_ENC);

which essentially means they are 64-bit only anyway. However, we cannot
make them dependent on CONFIG_ARCH_HAS_MEM_ENCRYPT, since that is always
defined, even for i386 (and changing that results in a slew of build errors)

So instead, build those routines only if CONFIG_AMD_MEM_ENCRYPT is
defined.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/Kconfig          | 3 +++
 arch/x86/Kconfig      | 5 +----
 arch/x86/mm/ioremap.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

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
index 15af091611e2..09c2c5600579 100644
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
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 5378d10f1d31..0029604af8a4 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -705,7 +705,7 @@ bool phys_mem_access_encrypted(unsigned long phys_addr, unsigned long size)
 	return arch_memremap_can_ram_remap(phys_addr, size, 0);
 }
 
-#ifdef CONFIG_ARCH_USE_MEMREMAP_PROT
+#ifdef CONFIG_AMD_MEM_ENCRYPT
 /* Remap memory with encryption */
 void __init *early_memremap_encrypted(resource_size_t phys_addr,
 				      unsigned long size)
@@ -747,7 +747,7 @@ void __init *early_memremap_decrypted_wp(resource_size_t phys_addr,
 
 	return early_memremap_prot(phys_addr, size, __PAGE_KERNEL_NOENC_WP);
 }
-#endif	/* CONFIG_ARCH_USE_MEMREMAP_PROT */
+#endif	/* CONFIG_AMD_MEM_ENCRYPT */
 
 static pte_t bm_pte[PAGE_SIZE/sizeof(pte_t)] __page_aligned_bss;
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
