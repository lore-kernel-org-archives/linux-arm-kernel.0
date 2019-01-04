Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57061C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:56:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 251A9206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ScMfrM3o";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSNQv0ht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 251A9206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=vHmm/x1px2TWf9IeykMOgP5Bl/WG0d1DI57+PhhvW3Q=; b=ScMfrM3oW6r53+NqWGm4EYpCqV
	mDkDSiTPCnRpJArV3llbXpaONkf+dRf1RpaHcf8fy7T9x7rpD1zY/eUSaOHKmzUCENlyKKHNxE/Pn
	mEbAQdAG3j2wNKcIgM1RDjhGHuBdLgY4odF805H79CmxJ8IdXa4D2ZNmOxZ0fs+NVQDYOcC5v/haB
	CPO6Zh536SIEFy9BWbr3bMSK5yXZIeR/4lcwSOdeaq+78PsIG77dHxlZMVCSAmtEEU1xB8MIWONJm
	5O8WCN/ykZYztz7gzH4weYTfYvRohDU9eQ/XNg8sUwIrkz8OTP8ZtZ6eekVyfL5YI/2p2fMMAGR3S
	VAeBbEUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfLHE-0000Vp-Fv; Fri, 04 Jan 2019 08:56:24 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfLFx-0006hK-EC
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 08:55:20 +0000
Received: by mail-pl1-x643.google.com with SMTP id e11so17152964plt.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 00:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=VAVkaVsyvHGb3944LCTx3RYQpKB8eIkyndjj2Ikvaks=;
 b=JSNQv0hto48d+cy9OmeC8+vpqtt4/8EI9u9HIqEmmUbj6f2TxB9IIfx/sXfdswigSu
 EfVz+80dJ8PkWlx+96miP5z94XhYM+ykxX3Fmq4clNe8KPorrdKxjWxhLblkovBxKOoE
 xNYBVIAgaXQScDW+EAKSKC9Vr5FCyiuV4d9SXDVbYKPiXlyZHItxqT9jBQmvUlY+lIX6
 QQxwdeg3r8Jc/hvz7dkxYLqoh+osKRZY5AyLcBIZ0cLUIsntPEjJnC3IB6sc65dcu4X5
 0h2aJEJSkwZD10HfzE989QUcENXgc2JHiKAXwoElzz9FnMX6UUYrCm3geYrKeF6nQ2K2
 q/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=VAVkaVsyvHGb3944LCTx3RYQpKB8eIkyndjj2Ikvaks=;
 b=pVIbsGf2XMRaWAphuEz65o6Z3kKFGeYAh8nNQYpRDRj2+joQs7UofaVf01PA2/v7ki
 605nXb3klp/YHR5Yuljiygz0AVsYY6ADcznKVHhnamNcKevEBv0Ky5ny5wV6Wouq+g/Y
 Sg+C2IH1CEe4p/7sbANBMZhQYBYc6sx/RSSjV+ca9IA7t5VuJkYn6n64eljcYOREVq/u
 h8LbCyyxr29n4onYD+Smy5UDtWpZCdK2AvNUxFFUBGarqT8l9VPT4RmvDGstQmCKmTE4
 wi8vlHjyay44u9HjtsDSjxel/xzr5Ztkgi0lsdWVBfHAQbYa9TjzYSMim1LrmepFLS3b
 MhPg==
X-Gm-Message-State: AJcUukfZFpJ5xdlRrCQdrZpwmudiT6/fJz3CnwRPZhKsvz1PI+HImXDB
 Ro5cFK74pMhpMG0GJhh1azo=
X-Google-Smtp-Source: ALg8bN4OjtFEk71VDHPjiuzCk2TCpCOEwCai/Wt7CBSpw62HsAigCPIHdjQRvUBI364td6kTt3nr6A==
X-Received: by 2002:a17:902:7882:: with SMTP id
 q2mr51489397pll.305.1546592104889; 
 Fri, 04 Jan 2019 00:55:04 -0800 (PST)
Received: from localhost.corp.microsoft.com
 ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
 by smtp.googlemail.com with ESMTPSA id i21sm99772145pgm.17.2019.01.04.00.54.57
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Jan 2019 00:55:04 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH 6/11] KVM/MMU: Flush tlb with range list in sync_page()
Date: Fri,  4 Jan 2019 16:54:00 +0800
Message-Id: <20190104085405.40356-7-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
References: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_005506_198727_A948029E 
X-CRM114-Status: GOOD (  12.74  )
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

This patch is to flush tlb via flush list function.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/paging_tmpl.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/paging_tmpl.h b/arch/x86/kvm/paging_tmpl.h
index 833e8855bbc9..866ccdea762e 100644
--- a/arch/x86/kvm/paging_tmpl.h
+++ b/arch/x86/kvm/paging_tmpl.h
@@ -973,6 +973,7 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
 	bool host_writable;
 	gpa_t first_pte_gpa;
 	int set_spte_ret = 0;
+	LIST_HEAD(flush_list);
 
 	/* direct kvm_mmu_page can not be unsync. */
 	BUG_ON(sp->role.direct);
@@ -980,6 +981,7 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
 	first_pte_gpa = FNAME(get_level1_sp_gpa)(sp);
 
 	for (i = 0; i < PT64_ENT_PER_PAGE; i++) {
+		int tmp_spte_ret = 0;
 		unsigned pte_access;
 		pt_element_t gpte;
 		gpa_t pte_gpa;
@@ -1029,14 +1031,24 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
 
 		host_writable = sp->spt[i] & SPTE_HOST_WRITEABLE;
 
-		set_spte_ret |= set_spte(vcpu, &sp->spt[i],
+		tmp_spte_ret = set_spte(vcpu, &sp->spt[i],
 					 pte_access, PT_PAGE_TABLE_LEVEL,
 					 gfn, spte_to_pfn(sp->spt[i]),
 					 true, false, host_writable);
+
+		if (kvm_available_flush_tlb_with_range()
+		    && (tmp_spte_ret & SET_SPTE_NEED_REMOTE_TLB_FLUSH)) {
+			struct kvm_mmu_page *leaf_sp = page_header(sp->spt[i]
+					& PT64_BASE_ADDR_MASK);
+			list_add(&leaf_sp->flush_link, &flush_list);
+		}
+
+		set_spte_ret |= tmp_spte_ret;
+
 	}
 
 	if (set_spte_ret & SET_SPTE_NEED_REMOTE_TLB_FLUSH)
-		kvm_flush_remote_tlbs(vcpu->kvm);
+		kvm_flush_remote_tlbs_with_list(vcpu->kvm, &flush_list);
 
 	return nr_present;
 }
-- 
2.14.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
