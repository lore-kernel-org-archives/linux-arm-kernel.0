Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92902C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:55:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AE95206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CEujf1Bs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uIGZ66sW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AE95206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=cgUgFWKAVqK/37ZWvSd3emnKfaynGLSx0UrHjHWr40U=; b=CEujf1BsgO1KejRxHH9QbtCLb8
	SLaJtuOB3Xnukip6+6HeZeVTvv1HIjcX3B2U+OeA0Rs76KlRsrRbv8A6Y49B/W+h+M+HgXbkkZIoG
	JMOvbfRfxWzRggx6U3GC9w0GfTI0gya9Wb7nvZ2VvInOK1twCZacMepgx+pNsnopT5qsaUylGj/Hh
	M5xagcNl/cM8lW6ttt+eC52p8JfVYwuNVBQLXhJ/jRuTj71erCB5ZAX9My5KHnBwbPR26cubzGV+K
	yMqA6VgrNeGDEFnTZiFJO/y3VNv39QZTCdOQxqYrZA582xv6zgnolPEbQE+6sgkMwbU0lxC2jLKE2
	Jv2a+ZuQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfLGX-0008M0-CN; Fri, 04 Jan 2019 08:55:41 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfLFi-0006MK-GH
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 08:55:07 +0000
Received: by mail-pf1-x443.google.com with SMTP id q1so17988835pfi.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 00:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=DbPYODlBh2cswgOkm5n3Xtx1VG29YKWZuHO2kRQx3jE=;
 b=uIGZ66sWc3MSyPixVlFIwqq9X9Xawe/7lcCM/24F9OUU1MhgIXXEp+AbmzflEK13nM
 2o+Z7uoAl1u/wmPUG3KdiBwSgFXXPl4EIy5LvDsMJPUd2xQxtWZR+TAhyRkwglbNz5am
 o/KasvYoE5o7W/xDHeUq9nW1U+hq6D2rEmY+fBsBoq/f34Ew+f9isuerC2+UXmqf/7xW
 VEHXij5Tmwcu8CH5Sve62zd3WlvJk2e1xqpMBDePH5ZEkitNlq/TWfWZEQBZXcHzrVop
 sJBt1UN3Ju9tBhxkEk4LYvpZdCJEK2L7xGpWi4h9Qu/xiaccyXt/cvhCySXdqM36T05O
 eX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=DbPYODlBh2cswgOkm5n3Xtx1VG29YKWZuHO2kRQx3jE=;
 b=LA9p9jr3UNipU9UK04ci7R7vNIC6TYJL9Q1JB2XyOVsY5yKGeZCsBrbHlYL8o+VCFM
 0ageQZE6hF/SQZ5XAbXSpD+vPQvn1XCxptraCu9/kTj9/gXVwFgdOK2OJr8WJ8qGHqSr
 YjKGzGuikuxbtNsrV1vzc4Uthys8U4b6j7xAn4wj1ghIQ8Yc04HCIuyBzBm2tf+ZW/D7
 nVAe19r0cX1fo/mkFxLKmkOtP9OKEuQbK6WMd/gdB9uxo4+ayDm97lFZ7bLlL++eMhyZ
 0MGR3yzIStPSVd7ndlbklxIpk0o1hdsFiBHrQKHMRRhOcmz8uihlGbRU0djW9b0NTSZU
 VafA==
X-Gm-Message-State: AA+aEWaygwVG3jZAk3RbmcjEhLqJ/0+nKHKxUM9SxuFPEUZQDc2T3m8q
 hhea1pUQvGoteoGTqf1auzk=
X-Google-Smtp-Source: ALg8bN4wIfpC3j2afh4wGFjYegQADeZ0K/ccHcj0qIsaA3H5W5N7IpT4CBOOzO8AUje2LUSMO2pDwg==
X-Received: by 2002:a62:1992:: with SMTP id 140mr51523150pfz.33.1546592089991; 
 Fri, 04 Jan 2019 00:54:49 -0800 (PST)
Received: from localhost.corp.microsoft.com
 ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
 by smtp.googlemail.com with ESMTPSA id i21sm99772145pgm.17.2019.01.04.00.54.42
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Jan 2019 00:54:49 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH 4/11] KVM/MMU: Introduce tlb flush with range list
Date: Fri,  4 Jan 2019 16:53:58 +0800
Message-Id: <20190104085405.40356-5-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
References: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_005450_781609_3F73D00B 
X-CRM114-Status: GOOD (  13.41  )
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
Cc: kvm@vger.kernel.org, rkrcmar@redhat.com, catalin.marinas@arm.com,
 will.deacon@arm.com, christoffer.dall@arm.com, paulus@ozlabs.org,
 hpa@zytor.com, kys@microsoft.com, kvmarm@lists.cs.columbia.edu,
 mpe@ellerman.id.au, x86@kernel.org, linux@armlinux.org.uk,
 michael.h.kelley@microsoft.com, mingo@redhat.com, benh@kernel.crashing.org,
 jhogan@kernel.org, linux-mips@vger.kernel.org,
 Lan Tianyu <Tianyu.Lan@microsoft.com>, marc.zyngier@arm.com,
 kvm-ppc@vger.kernel.org, bp@alien8.de, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 ralf@linux-mips.org, paul.burton@mips.com, pbonzini@redhat.com,
 vkuznets@redhat.com, linuxppc-dev@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

This patch is to introduce tlb flush with range list interface and use
struct kvm_mmu_page as list entry. Use flush list function in the
kvm_mmu_commit_zap_page().

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/include/asm/kvm_host.h |  7 +++++++
 arch/x86/kvm/mmu.c              | 24 +++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 78d2a6714c3b..22dbaa8fba32 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -316,6 +316,12 @@ struct kvm_rmap_head {
 
 struct kvm_mmu_page {
 	struct list_head link;
+
+	/*
+	 * Tlb flush with range list uses struct kvm_mmu_page as list entry
+	 * and all list operations should be under protection of mmu_lock.
+	 */
+	struct list_head flush_link;
 	struct hlist_node hash_link;
 	bool unsync;
 
@@ -443,6 +449,7 @@ struct kvm_mmu {
 struct kvm_tlb_range {
 	u64 start_gfn;
 	u64 pages;
+	struct list_head *flush_list;
 };
 
 enum pmc_type {
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 068694fa2371..d3272c5066ea 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -289,6 +289,17 @@ static void kvm_flush_remote_tlbs_with_address(struct kvm *kvm,
 
 	range.start_gfn = start_gfn;
 	range.pages = pages;
+	range.flush_list = NULL;
+
+	kvm_flush_remote_tlbs_with_range(kvm, &range);
+}
+
+static void kvm_flush_remote_tlbs_with_list(struct kvm *kvm,
+		struct list_head *flush_list)
+{
+	struct kvm_tlb_range range;
+
+	range.flush_list = flush_list;
 
 	kvm_flush_remote_tlbs_with_range(kvm, &range);
 }
@@ -2708,6 +2719,7 @@ static void kvm_mmu_commit_zap_page(struct kvm *kvm,
 				    struct list_head *invalid_list)
 {
 	struct kvm_mmu_page *sp, *nsp;
+	LIST_HEAD(flush_list);
 
 	if (list_empty(invalid_list))
 		return;
@@ -2721,7 +2733,17 @@ static void kvm_mmu_commit_zap_page(struct kvm *kvm,
 	 * In addition, kvm_flush_remote_tlbs waits for all vcpus to exit
 	 * guest mode and/or lockless shadow page table walks.
 	 */
-	kvm_flush_remote_tlbs(kvm);
+	if (kvm_available_flush_tlb_with_range()) {
+		list_for_each_entry(sp, invalid_list, link)
+			if (sp->sptep && is_last_spte(*sp->sptep,
+			    sp->role.level))
+				list_add(&sp->flush_link, &flush_list);
+
+		if (!list_empty(&flush_list))
+			kvm_flush_remote_tlbs_with_list(kvm, &flush_list);
+	} else {
+		kvm_flush_remote_tlbs(kvm);
+	}
 
 	list_for_each_entry_safe(sp, nsp, invalid_list, link) {
 		WARN_ON(!sp->role.invalid || sp->root_count);
-- 
2.14.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
