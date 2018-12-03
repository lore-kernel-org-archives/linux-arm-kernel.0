Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DF5C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:35:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D295320848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jpBN678P";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e7I7sEBg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D295320848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=+YeXa7XYgXEkhNDd5oiOqiBeWRpN0K2r3tcj7OY0dl8=; b=jpBN678P6WuMJ9
	kCJX7fwqF4md5E966Ay8BToIyqX54e9i/2GJxgg7mHPGQR+PdVSd2uamWfJ7hLRZnUXPMMTUVmTGX
	88qEiO2hwiBJMv7VylBIwpn0Ckzs3pU/Ro3Fp7ghb573IzGbJSBSlkzZzc4QjGcq4c9UgK59ikkTy
	AYdFAiMr9ojLA/biBGwWnu2CSW3zUyEyhMdVI30gE4mYS3C+Zr6opmzlNFghlmA9ejPpX3NqBGLv1
	midlHlUKWGvsjoI2y6yMYP/oiEJu83DKLB8hr9E0fV0OrYY7vAY/lsiqZTYIriYZxyX73N7pOMQUd
	MJL9L04+7lq+tysOh5lQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTt4I-0008P5-JK; Mon, 03 Dec 2018 18:35:42 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTt4G-0008MZ-2P
 for linux-arm-kernel@bombadil.infradead.org; Mon, 03 Dec 2018 18:35:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EKf3bahHNedI/cIii9YOGjTIT4I3Hwd9HsOInRrb/0s=; b=e7I7sEBgWBLGTO37hc9fjDRJHk
 C00XnBAIXHqiq4LFzdhF8cDXWLqeWoC7O+O5tx3XSlpQak70Ee9Ey6PzYZHaIZz5egf5waUWNrJcy
 aCmRLw0G9fF4s2NRv2Lin0UHUtaYEEBv/DHeqRJYn4gdqkUUjFLk91YzjfWrOBhxNmvKBNMxRVlB/
 PERuw8BNOQ+xyyc6mxo723Q8sTU9Bti2WBZy9atSBBldIv/PW3HchUwbUhsPY1eCCFsHg+wEHwyhl
 9Nu00XUE68RtFXjaQLnve6u5ER3ZY9G3VJKz92injxUAj4Pgmjxdp9QLVslryJ0PllFapYI75lrLu
 hHlvvG+g==;
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTt4C-0002Vr-Ib
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 18:35:38 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BE6B1688;
 Mon,  3 Dec 2018 10:35:25 -0800 (PST)
Received: from filthy-habits.cambridge.arm.com
 (filthy-habits.cambridge.arm.com [10.1.196.62])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C38613F59C;
 Mon,  3 Dec 2018 10:35:24 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: Advertise mitigation of Spectre-v2, or lack thereof
Date: Mon,  3 Dec 2018 18:35:12 +0000
Message-Id: <20181203183512.199024-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_183536_897231_4EB99CC6 
X-CRM114-Status: GOOD (  15.47  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

We currently have a list of CPUs affected by Spectre-v2, for which
we check that the firmware implements ARCH_WORKAROUND_1. It turns
out that not all firmwares do implement the required mitigation,
and that we fail to let the user know about it.

Instead, let's slightly revamp our checks, and let the user know
the status of the mitigation in the kernel log.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kernel/cpu_errata.c | 82 +++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index a509e35132d2..3a79088cbc22 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -182,15 +182,6 @@ static void  install_bp_hardening_cb(const struct arm64_cpu_capabilities *entry,
 				     const char *hyp_vecs_start,
 				     const char *hyp_vecs_end)
 {
-	u64 pfr0;
-
-	if (!entry->matches(entry, SCOPE_LOCAL_CPU))
-		return;
-
-	pfr0 = read_cpuid(ID_AA64PFR0_EL1);
-	if (cpuid_feature_extract_unsigned_field(pfr0, ID_AA64PFR0_CSV2_SHIFT))
-		return;
-
 	__install_bp_hardening_cb(fn, hyp_vecs_start, hyp_vecs_end);
 }
 
@@ -220,26 +211,51 @@ static void qcom_link_stack_sanitization(void)
 		     : "=&r" (tmp));
 }
 
-static void
-enable_smccc_arch_workaround_1(const struct arm64_cpu_capabilities *entry)
+/*
+ * List of CPUs where we need to issue a psci call to
+ * harden the branch predictor.
+ */
+static const struct midr_range arm64_bp_harden_smccc_cpus[] = {
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
+	MIDR_ALL_VERSIONS(MIDR_BRCM_VULCAN),
+	MIDR_ALL_VERSIONS(MIDR_CAVIUM_THUNDERX2),
+	MIDR_ALL_VERSIONS(MIDR_QCOM_FALKOR_V1),
+	MIDR_ALL_VERSIONS(MIDR_QCOM_FALKOR),
+	MIDR_ALL_VERSIONS(MIDR_NVIDIA_DENVER),
+	{},
+};
+
+static bool
+has_smccc_arch_workaround_1(const struct arm64_cpu_capabilities *entry,
+			    int scope)
 {
 	bp_hardening_cb_t cb;
 	void *smccc_start, *smccc_end;
 	struct arm_smccc_res res;
 	u32 midr = read_cpuid_id();
 
-	if (!entry->matches(entry, SCOPE_LOCAL_CPU))
-		return;
+	if (WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible()))
+		return false;
+
+	if (cpuid_feature_extract_unsigned_field(read_cpuid(ID_AA64PFR0_EL1),
+						 ID_AA64PFR0_CSV2_SHIFT))
+		return false;
+	
+	if (!is_midr_in_range_list(midr, arm64_bp_harden_smccc_cpus))
+		return false;
 
 	if (psci_ops.smccc_version == SMCCC_VERSION_1_0)
-		return;
+		goto fail;
 
 	switch (psci_ops.conduit) {
 	case PSCI_CONDUIT_HVC:
 		arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
 				  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
 		if ((int)res.a0 < 0)
-			return;
+			goto fail;
 		cb = call_hvc_arch_workaround_1;
 		/* This is a guest, no need to patch KVM vectors */
 		smccc_start = NULL;
@@ -250,14 +266,14 @@ enable_smccc_arch_workaround_1(const struct arm64_cpu_capabilities *entry)
 		arm_smccc_1_1_smc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
 				  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
 		if ((int)res.a0 < 0)
-			return;
+			goto fail;
 		cb = call_smc_arch_workaround_1;
 		smccc_start = __smccc_workaround_1_smc_start;
 		smccc_end = __smccc_workaround_1_smc_end;
 		break;
 
 	default:
-		return;
+		goto fail;
 	}
 
 	if (((midr & MIDR_CPU_MODEL_MASK) == MIDR_QCOM_FALKOR) ||
@@ -266,7 +282,11 @@ enable_smccc_arch_workaround_1(const struct arm64_cpu_capabilities *entry)
 
 	install_bp_hardening_cb(entry, cb, smccc_start, smccc_end);
 
-	return;
+	return true;
+
+fail:
+	pr_warn_once("ARM_SMCCC_ARCH_WORKAROUND_1 missing from firmware\n");
+	return false;
 }
 #endif	/* CONFIG_HARDEN_BRANCH_PREDICTOR */
 
@@ -539,27 +559,6 @@ multi_entry_cap_cpu_enable(const struct arm64_cpu_capabilities *entry)
 			caps->cpu_enable(caps);
 }
 
-#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
-
-/*
- * List of CPUs where we need to issue a psci call to
- * harden the branch predictor.
- */
-static const struct midr_range arm64_bp_harden_smccc_cpus[] = {
-	MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
-	MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
-	MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
-	MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
-	MIDR_ALL_VERSIONS(MIDR_BRCM_VULCAN),
-	MIDR_ALL_VERSIONS(MIDR_CAVIUM_THUNDERX2),
-	MIDR_ALL_VERSIONS(MIDR_QCOM_FALKOR_V1),
-	MIDR_ALL_VERSIONS(MIDR_QCOM_FALKOR),
-	MIDR_ALL_VERSIONS(MIDR_NVIDIA_DENVER),
-	{},
-};
-
-#endif
-
 #ifdef CONFIG_HARDEN_EL2_VECTORS
 
 static const struct midr_range arm64_harden_el2_vectors[] = {
@@ -712,9 +711,10 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 #endif
 #ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
 	{
+		.desc = "Branch predictor hardening",
 		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
-		.cpu_enable = enable_smccc_arch_workaround_1,
-		ERRATA_MIDR_RANGE_LIST(arm64_bp_harden_smccc_cpus),
+		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
+		.matches = has_smccc_arch_workaround_1,
 	},
 #endif
 #ifdef CONFIG_HARDEN_EL2_VECTORS
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
