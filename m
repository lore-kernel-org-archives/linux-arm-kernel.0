Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0E0C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:21:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B02C20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R1sjdBFG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EO8B54+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B02C20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Nyvw5GeTbfP5ISiwcxpUPGUE7VNQ4ggWGa7CrmWNfXM=; b=R1sjdBFG6c1yJw
	ByzBjluuDr6FUsemASYZDrcaUaaivEfVntFs4D7iJo4636/5vtGjXfq8pUJn1ZwcJQ6560AGxyYgw
	AsC/gXbEq5f29cvgRCG3gf82J6UlmeRcYPFydVGvVTHRhL56rihU6ox+3ucM8lIx8lUORgnsjXwVR
	CHzHXMto2Hgy/N/BSAqTLZw7MhgRBz+snkJOrN2AAeInSwjYzwdtShOtVnjfrBurS2xSIYOCano5V
	VJMWyjS7HcQxD8hT1785goxiXfGmtftplUFZ5JnFjioKm6hA0E2bpXu4TEyM5kAbjYRTbtXPgs81Z
	YQLymjgV8UNgCfJz8rOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXUg5-0007so-V4; Thu, 13 Dec 2018 17:21:37 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXUfQ-0007BC-Bf
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 17:21:00 +0000
Received: by mail-wr1-x443.google.com with SMTP id v13so2836476wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 13 Dec 2018 09:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PfN4/9eI1NIZOQUGnM6jMBmFJSgj4lLHz8nP2g1zbqo=;
 b=EO8B54+mJRDGEX1JaupC3h2MbD0JMZNcOIQpnnKumX9w2nlzg0l61hHweqDWihCLsC
 qnmRGL9y79O5pPWlco7a9CmsMQy447e34vx8mUx13c9RJYWfJTwcgCK+VOJPHiYEBrh3
 2n6gnNxo8opla3vaYcXt0vYLp1l/t9b0t/UPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PfN4/9eI1NIZOQUGnM6jMBmFJSgj4lLHz8nP2g1zbqo=;
 b=fpfkQAyPSqMw/Tmr4S/58zoFMJ/ZlhelxKQIVlCWZ1oXkjE7b4I3gPF+mxyQxreNem
 k0JtpNalUgtda5rsozMUMtNGqKjF7Z9BRmvvhjuSmx48svB1e1gAfXnO+4ol+d4htEOa
 QkOrOYg9QGwZwiUc8cKTztwxf3EeNibfoQHEwhRyTcI7ocwgdRMwkuuKFnpNvSXsYCin
 H+6x8RUFJijCr0mOjE9/hFXFopH9UzptyAq5RYFcL7KkMLIvmb6GtNbryMwAwcwneoQB
 adQGsUPNKFTjLzR79KDtf3XIUDUDsrWX13wjYMZbgOFNooKb6iFGwlhYoYa/414kdySK
 HR+Q==
X-Gm-Message-State: AA+aEWbWLl4cETMiZWxu4kiWbIPpt9ZtV7DtwsUhwSYzCZajckt9uH7h
 KEcHEFfhQ0ortlhoDiyGiO2Xs6fKkwBIDQ==
X-Google-Smtp-Source: AFSGD/UFzD47UVpN70e+KLDKu6QirlzTQqexSB0qzWKD6SG3CB0a1C9WwYguvDIv6qKfNcLpo/oqmA==
X-Received: by 2002:a05:6000:51:: with SMTP id
 k17mr20731523wrx.259.1544721644399; 
 Thu, 13 Dec 2018 09:20:44 -0800 (PST)
Received: from localhost.localdomain
 (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr. [92.154.90.120])
 by smtp.gmail.com with ESMTPSA id q12sm2902753wrx.31.2018.12.13.09.20.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Dec 2018 09:20:43 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 3/4] arm64: kpti: use nG mappings from the outset if kpti
 is force enabled
Date: Thu, 13 Dec 2018 18:20:34 +0100
Message-Id: <20181213172036.14504-4-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181213172036.14504-1-ard.biesheuvel@linaro.org>
References: <20181213172036.14504-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_092056_628379_3A0EAD57 
X-CRM114-Status: GOOD (  15.22  )
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

Instead of relying on a slow asm routine executing from the idmap to
change all global mappings into non-global ones, just apply non-global
mappings from the outset if KPTI is going to be enabled regardless of
CPU capabilities (i.e, when running with KASLR enabled)

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/cpufeature.c | 3 ++-
 arch/arm64/mm/mmu.c            | 9 +++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index ecd8c65dd2d7..11ef6aadeb0c 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -965,6 +965,8 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 	return !has_cpuid_feature(entry, scope);
 }
 
+bool kpti_applied = false;
+
 static void
 kpti_install_ng_mappings(const struct arm64_cpu_capabilities *__unused)
 {
@@ -972,7 +974,6 @@ kpti_install_ng_mappings(const struct arm64_cpu_capabilities *__unused)
 	extern kpti_remap_fn idmap_kpti_install_ng_mappings;
 	kpti_remap_fn *remap_fn;
 
-	static bool kpti_applied = false;
 	int cpu = smp_processor_id();
 
 	if (kpti_applied)
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index d1d6601b385d..ab70834b45b8 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -648,6 +648,15 @@ static void __init map_kernel(pgd_t *pgdp)
 void __init paging_init(void)
 {
 	pgd_t *pgdp = pgd_set_fixmap(__pa_symbol(swapper_pg_dir));
+	bool kpti_enabled;
+
+	/* create nG mappings if KPTI is enabled regardless of CPU features */
+	if (kpti_is_forced(&kpti_enabled) && kpti_enabled) {
+		extern bool kpti_applied;
+
+		cpus_set_cap(ARM64_UNMAP_KERNEL_AT_EL0);
+		kpti_applied = true;
+	}
 
 	map_kernel(pgdp);
 	map_mem(pgdp);
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
