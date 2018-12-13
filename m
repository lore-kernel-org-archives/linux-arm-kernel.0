Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD77C67872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:21:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF75B20879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Jf/IYpJO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZKe+m4Mg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF75B20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CnHDSPf4xrkmV/B2FENtQHAdi3Dh6ytmqwGX2/wFAUg=; b=Jf/IYpJOABfM/N
	UoVFRe1Jho8zK4Y6clx88Dfxj0Xs/erHzcZawOHUIZOzLvCWNnuk4oXhCKcePMYAk2pjqs0grF3En
	yfSNo8ne02n/TugjZRyLzWpC2f2DvaXmALmflFRQH4zeomre7Dk+L6sNSPscRocD1AwH39igYn8wa
	tbQWTByBGBZ1hpqs5SRQA/zsXJKOsrXnuupTpkGjjxOChQjtxX29HIj5g+TFlq0Vls47CfksXBT1t
	qBHevE5zgQI1G7gDAJ5Ec7AGOliWVaAV9SuwgaBsDexxc7QecPSAjvnInKb91ogSgekFLlnqedi9O
	LSQEdm9Z12zBXNRBEHXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXUgI-00085g-C7; Thu, 13 Dec 2018 17:21:50 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXUfR-0007BF-Kb
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 17:21:08 +0000
Received: by mail-wm1-x342.google.com with SMTP id q26so3173190wmf.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 13 Dec 2018 09:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Tbch3xLF+M5jA4HSG7+rG1VY+S90zpEVNMyhSNqIGss=;
 b=ZKe+m4Mg7rP/DOIidkYfXtaZCZ/e/KMui+yjDwqdcRlbY5+6qXCFRHmaZ8AXokaB8v
 XUse906riwQipHYWvW7IeBCG6iZEAN0n+9220qPZB6qeQx9651RZg3x2X/HZZdVCDpx5
 5d2ppvjA42mfS3ccS4vZIQCDavN9OwtcswD+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Tbch3xLF+M5jA4HSG7+rG1VY+S90zpEVNMyhSNqIGss=;
 b=Ao49WOrJMKjU2qa7VwVRka7hpMelxTZ4znSbHrqnRSE1O1iIoYW3PkdNf6ohCW9b8E
 C0ijfCHKH9ITIXR/JgQHzWM5YoQsLqVWmYjAK8HXV4+yRD3qmCztKHP2ffralYe/GLFu
 2zqHNsh1Uaqe6sL/Pnkuoj/JYIbW3xe+9WOvc6Um0x401i64oG2nUrFFiri0dbttW++b
 9QTpjHoc37L0slIAtPGMRpa+lCWqLx1iqbLOCf9QH9xmQs3H9dwLeSpICywwUhGRvsYH
 50TLhdKeSjhdzD1Ktuv0Ar+okJ+mXoc0VjZWbIgL24/neAHC+KJYsuBk5uZrZzoKBP8q
 adOw==
X-Gm-Message-State: AA+aEWbpRBAhWF3lIwmPWnyy35GrFSqfwiFObpa8HCJD4T7z7+IjaZKS
 p21+Mz8caHYxXLslOTyo4XeY8hRKnj9WYg==
X-Google-Smtp-Source: AFSGD/VXj+yZZEpfabzrC0RWUskiRJl8wSPMg0qsU0VmQjWbodFsTZxZ1cIGylUX84pD+ogoLnxt9w==
X-Received: by 2002:a1c:ac42:: with SMTP id v63mr172508wme.119.1544721645560; 
 Thu, 13 Dec 2018 09:20:45 -0800 (PST)
Received: from localhost.localdomain
 (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr. [92.154.90.120])
 by smtp.gmail.com with ESMTPSA id q12sm2902753wrx.31.2018.12.13.09.20.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Dec 2018 09:20:44 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 4/4] arm64: kpti: use non-global mappings unless KPTI is
 forced off
Date: Thu, 13 Dec 2018 18:20:35 +0100
Message-Id: <20181213172036.14504-5-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181213172036.14504-1-ard.biesheuvel@linaro.org>
References: <20181213172036.14504-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_092058_008067_A5FA63A9 
X-CRM114-Status: GOOD (  22.19  )
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

KPTI requires non-global mappings but the converse is not true: we
can usually tolerate non-global mappings when KPTI is disabled (with
the exception of some ThunderX cores), but the increased TLB footprint
of kernel mappings may adversely affect performance in some cases.

So let's invert the early mapping logic to always create non-global
mappings unless KPTI was forced off, allowing us to get rid of the
costly and fragile remapping code that changes kernel mappings from
global to non-global at CPU feature detection time.

In cases where the increased TLB footprint does in fact cause performance
issues and Meltdown mitigations or KASLR are not required or desired,
kpti=off may be passed on the kernel command line to switch back
to global kernel mappings unconditionally.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/cpufeature.c |  27 ---
 arch/arm64/mm/mmu.c            |  15 +-
 arch/arm64/mm/proc.S           | 189 --------------------
 3 files changed, 10 insertions(+), 221 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 11ef6aadeb0c..649937753587 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -965,32 +965,6 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 	return !has_cpuid_feature(entry, scope);
 }
 
-bool kpti_applied = false;
-
-static void
-kpti_install_ng_mappings(const struct arm64_cpu_capabilities *__unused)
-{
-	typedef void (kpti_remap_fn)(int, int, phys_addr_t);
-	extern kpti_remap_fn idmap_kpti_install_ng_mappings;
-	kpti_remap_fn *remap_fn;
-
-	int cpu = smp_processor_id();
-
-	if (kpti_applied)
-		return;
-
-	remap_fn = (void *)__pa_symbol(idmap_kpti_install_ng_mappings);
-
-	cpu_install_idmap();
-	remap_fn(cpu, num_online_cpus(), __pa_symbol(swapper_pg_dir));
-	cpu_uninstall_idmap();
-
-	if (!cpu)
-		kpti_applied = true;
-
-	return;
-}
-
 static int __init parse_kpti(char *str)
 {
 	bool enabled;
@@ -1260,7 +1234,6 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.field_pos = ID_AA64PFR0_CSV3_SHIFT,
 		.min_field_value = 1,
 		.matches = unmap_kernel_at_el0,
-		.cpu_enable = kpti_install_ng_mappings,
 	},
 #endif
 	{
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index ab70834b45b8..74e27f4ae6ea 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -650,12 +650,17 @@ void __init paging_init(void)
 	pgd_t *pgdp = pgd_set_fixmap(__pa_symbol(swapper_pg_dir));
 	bool kpti_enabled;
 
-	/* create nG mappings if KPTI is enabled regardless of CPU features */
-	if (kpti_is_forced(&kpti_enabled) && kpti_enabled) {
-		extern bool kpti_applied;
-
+	/* create nG mappings unless KPTI is forced off */
+	if (!kpti_is_forced(&kpti_enabled) || kpti_enabled) {
+		/*
+		 * Set the capability so that PTE_MAYBE_NG will evaluate to
+		 * nG enabled. This capability will be cleared again in case
+		 * we decide not to enable KPTI after all at CPU feature
+		 * detection time, in which case we will end up running with
+		 * a mix of non-global and global kernel mappings but this
+		 * shouldn't hurt in practice.
+		 */
 		cpus_set_cap(ARM64_UNMAP_KERNEL_AT_EL0);
-		kpti_applied = true;
 	}
 
 	map_kernel(pgdp);
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 2c75b0b903ae..b80d4220f7d0 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -209,195 +209,6 @@ ENTRY(idmap_cpu_replace_ttbr1)
 ENDPROC(idmap_cpu_replace_ttbr1)
 	.popsection
 
-#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-	.pushsection ".idmap.text", "awx"
-
-	.macro	__idmap_kpti_get_pgtable_ent, type
-	dc	cvac, cur_\()\type\()p		// Ensure any existing dirty
-	dmb	sy				// lines are written back before
-	ldr	\type, [cur_\()\type\()p]	// loading the entry
-	tbz	\type, #0, skip_\()\type	// Skip invalid and
-	tbnz	\type, #11, skip_\()\type	// non-global entries
-	.endm
-
-	.macro __idmap_kpti_put_pgtable_ent_ng, type
-	orr	\type, \type, #PTE_NG		// Same bit for blocks and pages
-	str	\type, [cur_\()\type\()p]	// Update the entry and ensure
-	dmb	sy				// that it is visible to all
-	dc	civac, cur_\()\type\()p		// CPUs.
-	.endm
-
-/*
- * void __kpti_install_ng_mappings(int cpu, int num_cpus, phys_addr_t swapper)
- *
- * Called exactly once from stop_machine context by each CPU found during boot.
- */
-__idmap_kpti_flag:
-	.long	1
-ENTRY(idmap_kpti_install_ng_mappings)
-	cpu		.req	w0
-	num_cpus	.req	w1
-	swapper_pa	.req	x2
-	swapper_ttb	.req	x3
-	flag_ptr	.req	x4
-	cur_pgdp	.req	x5
-	end_pgdp	.req	x6
-	pgd		.req	x7
-	cur_pudp	.req	x8
-	end_pudp	.req	x9
-	pud		.req	x10
-	cur_pmdp	.req	x11
-	end_pmdp	.req	x12
-	pmd		.req	x13
-	cur_ptep	.req	x14
-	end_ptep	.req	x15
-	pte		.req	x16
-
-	mrs	swapper_ttb, ttbr1_el1
-	adr	flag_ptr, __idmap_kpti_flag
-
-	cbnz	cpu, __idmap_kpti_secondary
-
-	/* We're the boot CPU. Wait for the others to catch up */
-	sevl
-1:	wfe
-	ldaxr	w18, [flag_ptr]
-	eor	w18, w18, num_cpus
-	cbnz	w18, 1b
-
-	/* We need to walk swapper, so turn off the MMU. */
-	pre_disable_mmu_workaround
-	mrs	x18, sctlr_el1
-	bic	x18, x18, #SCTLR_ELx_M
-	msr	sctlr_el1, x18
-	isb
-
-	/* Everybody is enjoying the idmap, so we can rewrite swapper. */
-	/* PGD */
-	mov	cur_pgdp, swapper_pa
-	add	end_pgdp, cur_pgdp, #(PTRS_PER_PGD * 8)
-do_pgd:	__idmap_kpti_get_pgtable_ent	pgd
-	tbnz	pgd, #1, walk_puds
-next_pgd:
-	__idmap_kpti_put_pgtable_ent_ng	pgd
-skip_pgd:
-	add	cur_pgdp, cur_pgdp, #8
-	cmp	cur_pgdp, end_pgdp
-	b.ne	do_pgd
-
-	/* Publish the updated tables and nuke all the TLBs */
-	dsb	sy
-	tlbi	vmalle1is
-	dsb	ish
-	isb
-
-	/* We're done: fire up the MMU again */
-	mrs	x18, sctlr_el1
-	orr	x18, x18, #SCTLR_ELx_M
-	msr	sctlr_el1, x18
-	isb
-
-	/* Set the flag to zero to indicate that we're all done */
-	str	wzr, [flag_ptr]
-	ret
-
-	/* PUD */
-walk_puds:
-	.if CONFIG_PGTABLE_LEVELS > 3
-	pte_to_phys	cur_pudp, pgd
-	add	end_pudp, cur_pudp, #(PTRS_PER_PUD * 8)
-do_pud:	__idmap_kpti_get_pgtable_ent	pud
-	tbnz	pud, #1, walk_pmds
-next_pud:
-	__idmap_kpti_put_pgtable_ent_ng	pud
-skip_pud:
-	add	cur_pudp, cur_pudp, 8
-	cmp	cur_pudp, end_pudp
-	b.ne	do_pud
-	b	next_pgd
-	.else /* CONFIG_PGTABLE_LEVELS <= 3 */
-	mov	pud, pgd
-	b	walk_pmds
-next_pud:
-	b	next_pgd
-	.endif
-
-	/* PMD */
-walk_pmds:
-	.if CONFIG_PGTABLE_LEVELS > 2
-	pte_to_phys	cur_pmdp, pud
-	add	end_pmdp, cur_pmdp, #(PTRS_PER_PMD * 8)
-do_pmd:	__idmap_kpti_get_pgtable_ent	pmd
-	tbnz	pmd, #1, walk_ptes
-next_pmd:
-	__idmap_kpti_put_pgtable_ent_ng	pmd
-skip_pmd:
-	add	cur_pmdp, cur_pmdp, #8
-	cmp	cur_pmdp, end_pmdp
-	b.ne	do_pmd
-	b	next_pud
-	.else /* CONFIG_PGTABLE_LEVELS <= 2 */
-	mov	pmd, pud
-	b	walk_ptes
-next_pmd:
-	b	next_pud
-	.endif
-
-	/* PTE */
-walk_ptes:
-	pte_to_phys	cur_ptep, pmd
-	add	end_ptep, cur_ptep, #(PTRS_PER_PTE * 8)
-do_pte:	__idmap_kpti_get_pgtable_ent	pte
-	__idmap_kpti_put_pgtable_ent_ng	pte
-skip_pte:
-	add	cur_ptep, cur_ptep, #8
-	cmp	cur_ptep, end_ptep
-	b.ne	do_pte
-	b	next_pmd
-
-	/* Secondary CPUs end up here */
-__idmap_kpti_secondary:
-	/* Uninstall swapper before surgery begins */
-	__idmap_cpu_set_reserved_ttbr1 x18, x17
-
-	/* Increment the flag to let the boot CPU we're ready */
-1:	ldxr	w18, [flag_ptr]
-	add	w18, w18, #1
-	stxr	w17, w18, [flag_ptr]
-	cbnz	w17, 1b
-
-	/* Wait for the boot CPU to finish messing around with swapper */
-	sevl
-1:	wfe
-	ldxr	w18, [flag_ptr]
-	cbnz	w18, 1b
-
-	/* All done, act like nothing happened */
-	msr	ttbr1_el1, swapper_ttb
-	isb
-	ret
-
-	.unreq	cpu
-	.unreq	num_cpus
-	.unreq	swapper_pa
-	.unreq	swapper_ttb
-	.unreq	flag_ptr
-	.unreq	cur_pgdp
-	.unreq	end_pgdp
-	.unreq	pgd
-	.unreq	cur_pudp
-	.unreq	end_pudp
-	.unreq	pud
-	.unreq	cur_pmdp
-	.unreq	end_pmdp
-	.unreq	pmd
-	.unreq	cur_ptep
-	.unreq	end_ptep
-	.unreq	pte
-ENDPROC(idmap_kpti_install_ng_mappings)
-	.popsection
-#endif
-
 /*
  *	__cpu_setup
  *
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
