Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCCCC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:21:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D2CD20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MgQVrpD8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="juK9YiLq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D2CD20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y13STmxZkJhf3f5iEFuUcbtni1m8wefZoNbR+3FGyLQ=; b=MgQVrpD8pcpLEv
	6nNnr1JzvjWIGKk6SEoUHwF555TnSy0wIhcniYVXgS+3EyLQT1opfl3jBapo2XlF9w42kk7lW78T3
	tKNSFCC6x5tEXUwtiJKCJcdzmPesjEKxpAASj9COPDrxL35FOsT6P4Ngdsb/t5v/Sg4gCLidAsfIK
	enWZT28VsBrbvJkMDQOCFiHYfR2GcSFfwMz7PrDb9aMWPVs+IUPeMfEr7P4I01kTRbJjYiy5aR+V/
	36QF6vi+ACho/L8EEn8b33gluHlbMUG4yKLJNk+s909I8sjD7srzgYOsNV1dUGF5TU0WOs1VCmlLs
	bAVl3hH6KGCBRWcRmDzA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXUft-0007e4-2c; Thu, 13 Dec 2018 17:21:25 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXUfP-0007BB-7s
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 17:20:56 +0000
Received: by mail-wr1-x441.google.com with SMTP id l9so2799850wrt.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 13 Dec 2018 09:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YJvOwVwCfOfBo2c0GhHmvY07l9vz/ddNv4xdwbKx6M0=;
 b=juK9YiLqlqreBKNbwkw2HcjeBCwxen35tZ0BCLy2uvOwcvZ122l85lmeBF/Qcuxgtj
 OFtW6HArUVjSSj4l/yrE3NGs+QRWRI/hMBkId+MiPPy+c5LlCieYFTCr0ZRU1sBWxmcU
 lQwSRQiVVnQGchzPb32Fmvgh0cpkZR3ZjjrJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YJvOwVwCfOfBo2c0GhHmvY07l9vz/ddNv4xdwbKx6M0=;
 b=mEzaI0aOaScdmO8nIsa/EDMp8G8pWVdD9YUDITcvOLSD2GZk43lSeW8df++Oc66vSW
 lWqropoMfSZRgYJHpPeLPqppiiM9i87Psm8mHyF2hjIHbTmeD2QNix0V0mYwE0p5ML9Y
 N8mmb7hhX1Bfg1yH2iRGJHfuaI3iDEMRjUF5vSqax5pp8qTEZfqCwtD9/3n05A3v2PA5
 6zBAGuDbH2pSAdB1gp/3lovSNT//gliJxN/1EF2UVe6PbxuE+AXRpvx/L5gLTwH7cyV1
 ELZ6HAGFbpSJZNmxAz0Jo/hSJ0/nvAyqOVxn6I61uJv1WI6U4NmzxrSORUkQV0xh/0xH
 KlCw==
X-Gm-Message-State: AA+aEWZuEWobtVRln8z9/fh5A3bAfaTlIR3lOQPwT1BCqBBHDVX/TeTP
 LcX4IO4VE7kFyfticETasFBOD8OlaT4DTw==
X-Google-Smtp-Source: AFSGD/XfYvj69DboSWkS6xBBxhVxKAGRWkb+0FgjmEUAVbBHzFt1uZdeXCztlVCj1hxL+EjHfMUlhQ==
X-Received: by 2002:adf:8264:: with SMTP id 91mr21055689wrb.312.1544721643300; 
 Thu, 13 Dec 2018 09:20:43 -0800 (PST)
Received: from localhost.localdomain
 (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr. [92.154.90.120])
 by smtp.gmail.com with ESMTPSA id q12sm2902753wrx.31.2018.12.13.09.20.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Dec 2018 09:20:42 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 2/4] arm64: kpti: add helper to decide whether nG mappings
 should be used early
Date: Thu, 13 Dec 2018 18:20:33 +0100
Message-Id: <20181213172036.14504-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181213172036.14504-1-ard.biesheuvel@linaro.org>
References: <20181213172036.14504-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_092055_279870_4A6B953A 
X-CRM114-Status: GOOD (  18.64  )
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

idmap_kpti_install_ng_mappings() traverses all kernel page tables with
the caches off to replace global with non-global attributes, so that
KPTI may be enabled safely. This is costly, and can be avoided in
cases where we know we will be enabling KPTI regardless of whether any
cores are present that are susceptible to Meltdown.

So add a helper that tells us whether KPTI was force en/disabled, which
we will help use decide whether to use nG mappings when creating the
mappings of the kernel address space.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/cpufeature.h |  7 ++++
 arch/arm64/kernel/cpufeature.c      | 37 ++++++++++++++------
 2 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 7e2ec64aa414..91bcab94a725 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -558,6 +558,13 @@ static inline u32 id_aa64mmfr0_parange_to_phys_shift(int parange)
 	default: return CONFIG_ARM64_PA_BITS;
 	}
 }
+
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+extern bool kpti_is_forced(bool *enabled);
+#else
+static bool kpti_is_forced(bool *enabled) { return false; }
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index ef8118274ca9..ecd8c65dd2d7 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -908,13 +908,11 @@ has_useable_cnp(const struct arm64_cpu_capabilities *entry, int scope)
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 static int __kpti_forced; /* 0: not forced, >0: forced on, <0: forced off */
 
-static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
-				int scope)
+bool kpti_is_forced(bool *enabled)
 {
-	/* List of CPUs that are not vulnerable and don't need KPTI */
-	static const struct midr_range kpti_safe_list[] = {
-		MIDR_ALL_VERSIONS(MIDR_CAVIUM_THUNDERX2),
-		MIDR_ALL_VERSIONS(MIDR_BRCM_VULCAN),
+	static const struct midr_range kpti_blacklist[] = {
+		MIDR_RANGE(MIDR_THUNDERX, 0, 0, 1, 1),
+		MIDR_RANGE(MIDR_THUNDERX_81XX, 0, 0, 0, 0),
 		{ /* sentinel */ }
 	};
 	char const *str = "command line option";
@@ -924,8 +922,8 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 	 * ThunderX leads to apparent I-cache corruption of kernel text, which
 	 * ends as well as you might imagine. Don't even try.
 	 */
-	if (cpus_have_const_cap(ARM64_WORKAROUND_CAVIUM_27456)) {
-		str = "ARM64_WORKAROUND_CAVIUM_27456";
+	if (IS_ENABLED(CONFIG_CAVIUM_ERRATUM_27456) &&
+	    is_midr_in_range_list(read_cpuid_id(), kpti_blacklist)) {
 		__kpti_forced = -1;
 	}
 
@@ -933,12 +931,31 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 	if (__kpti_forced) {
 		pr_info_once("kernel page table isolation forced %s by %s\n",
 			     __kpti_forced > 0 ? "ON" : "OFF", str);
-		return __kpti_forced > 0;
+		*enabled = __kpti_forced > 0;
+		return true;
 	}
 
 	/* Useful for KASLR robustness */
-	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && kaslr_offset() > 0)
+	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && kaslr_offset() > 0) {
+		*enabled = true;
 		return true;
+	}
+	return false;
+}
+
+static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
+				int scope)
+{
+	/* List of CPUs that are not vulnerable and don't need KPTI */
+	static const struct midr_range kpti_safe_list[] = {
+		MIDR_ALL_VERSIONS(MIDR_CAVIUM_THUNDERX2),
+		MIDR_ALL_VERSIONS(MIDR_BRCM_VULCAN),
+		{ /* sentinel */ }
+	};
+	bool enabled;
+
+	if (kpti_is_forced(&enabled))
+		return enabled;
 
 	/* Don't force KPTI for CPUs that are not vulnerable */
 	if (is_midr_in_range_list(read_cpuid_id(), kpti_safe_list))
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
