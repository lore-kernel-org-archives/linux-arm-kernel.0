Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF74C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:41:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C61F2075B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K6SSzoFF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmsMeUBz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C61F2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=UZ+/dqtm+bcWffcCgatqhieFIgzS0PSjaLyFSVsrpus=; b=K6SSzoFF2EdAA6B+CnbI7gJ39T
	sd13YRdLHs+Ia0hVBnUn2qnqHqVRV9E76+Qom64ewhkuvpRgfO3wFNO0qJbWsNsxOjj3HnIxIBj+B
	7dzhuoEAhozhvKk9ol8xxT/q7yhVPm9PoTrXjxjiVjgpnFfrM41VRT/F+dYA+bEg6zM36kIvbJa4E
	0/jSzOoUqZJTnjaPdXTv13RRNDtc5HotiBa1Pgauxhj67pyC9Mtg9Q/yS3j0DljRbcMbpk6Xbmf90
	msFRXo4xqgTSFPwTzz78dr9RQCrEoEMGPbmo8PwW6qHBG4sxY/BC9JtULiQjlSc9Ej/3tPHmEiYvc
	Sf9dXX8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpkIy-0006th-0I; Sat, 02 Feb 2019 01:41:12 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpkHk-0004Vi-FU
 for linux-arm-kernel@lists.infradead.org; Sat, 02 Feb 2019 01:40:32 +0000
Received: by mail-pf1-x444.google.com with SMTP id h3so4110326pfg.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 17:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ncHRx3RUiEOWOAX5Gukbkm3enT6QMzHfm6n/G4i+bhI=;
 b=OmsMeUBzmFvHNDd7YKcgOCwIafvkVAE6LBEXIGoPD86pec1udYcFe1R5QFkC4T/juW
 g5LoQ3IuZqvbWA3aOn+CNIlATnxam+Sa/ePgtSadcLoYzOFn7PbUqdTjUWGuT/mm0+qQ
 KZBJoWXBENbKjLMxRUJz09LuduSa4FKXPTF6j98evc4PLWTYrk+9IN7uneI3oogzefFG
 oqNoymHcaycnKfZCYa3zP5UO9UxEB0AZYKnOOANg7+dko4NICPhKUs7cLj3d71zPpMHO
 fGqoXqZl/uE17yvE0IRFUL3QRkFj1xu+O4GdK3J8pP9mP7ijbLhrFdxNCa3/w6NkJZOt
 x9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ncHRx3RUiEOWOAX5Gukbkm3enT6QMzHfm6n/G4i+bhI=;
 b=dE6Pu5eKX0P64C9jAsxWIt13R2AniYOmGt4J5j4bY5vbUiyiRA2kL65QsnGOqY9mNa
 ISbba7OgPD2tsxwEnxB9KBr0Zllm7o9CQngYJbcYEBtp6/x59MkdRUtk+tRxaD+c25nr
 PvEdOkTTvy6WlefzrZKNe7hvG3LXu0M7yzLrqci3YSopAu6VVcQZB89e/jOYJwble5p9
 dWcES31uCIMADgAet++IyHwvKn2Hqm/p8t/Y+pLsGDMEB8zQnMufEkzD/6r3PI2Ph0qT
 uGGb/jZvoCk7muXqOB94MLDwAoC3IsejII0OiCEG4Jg54taI3zbv68HujGDpxCexFPRI
 grpg==
X-Gm-Message-State: AJcUukfRWg1PH4Mjfm6SyOguKMjYLNdcT5HJ14vV2TUBXgE1ZNj0CFxu
 Vk61wYyCIMyH8YieHDdQK18=
X-Google-Smtp-Source: ALg8bN7tsH42VGjHxDpDzHBNGLVraHFnufB3G+lMQShhIiLqXFILDx/Wxg58PpFk+8c1cqzCFYtHzw==
X-Received: by 2002:a62:7dcb:: with SMTP id
 y194mr42103554pfc.113.1549071595849; 
 Fri, 01 Feb 2019 17:39:55 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
 by smtp.googlemail.com with ESMTPSA id d3sm9183425pgl.64.2019.02.01.17.39.48
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 01 Feb 2019 17:39:55 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH V2 9/10] KVM: Add flush parameter for kvm_age_hva()
Date: Sat,  2 Feb 2019 09:38:25 +0800
Message-Id: <20190202013825.51261-10-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190202013825.51261-1-Tianyu.Lan@microsoft.com>
References: <20190202013825.51261-1-Tianyu.Lan@microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_173956_974342_4B3820B3 
X-CRM114-Status: GOOD (  14.32  )
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

This patch is to add flush parameter for kvm_aga_hva() and move tlb
flush from kvm_mmu_notifier_clear_flush_young() to kvm_age_hva().
kvm_age_hva() can check whether tlb flush is necessary when
return value young is more than 0. Flush tlb if both conditions
are met.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/arm/include/asm/kvm_host.h     |  3 ++-
 arch/arm64/include/asm/kvm_host.h   |  3 ++-
 arch/mips/include/asm/kvm_host.h    |  3 ++-
 arch/mips/kvm/mmu.c                 | 11 +++++++++--
 arch/powerpc/include/asm/kvm_host.h |  3 ++-
 arch/powerpc/kvm/book3s.c           | 10 ++++++++--
 arch/powerpc/kvm/e500_mmu_host.c    |  3 ++-
 arch/x86/include/asm/kvm_host.h     |  3 ++-
 arch/x86/kvm/mmu.c                  | 10 ++++++++--
 virt/kvm/arm/mmu.c                  | 13 +++++++++++--
 virt/kvm/kvm_main.c                 |  6 ++----
 11 files changed, 50 insertions(+), 18 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index ca56537b61bc..b3c6a6db8173 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -229,7 +229,8 @@ int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
 
 unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu);
 int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices);
-int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end);
+int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end,
+		bool flush);
 int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
 
 struct kvm_vcpu *kvm_arm_get_running_vcpu(void);
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 7732d0ba4e60..182bbb2de60a 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -361,7 +361,8 @@ int __kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
 int kvm_unmap_hva_range(struct kvm *kvm,
 			unsigned long start, unsigned long end);
 int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
-int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end);
+int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end,
+		bool flush);
 int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
 
 struct kvm_vcpu *kvm_arm_get_running_vcpu(void);
diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index d2abd98471e8..e055f49532c8 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -937,7 +937,8 @@ enum kvm_mips_fault_result kvm_trap_emul_gva_fault(struct kvm_vcpu *vcpu,
 int kvm_unmap_hva_range(struct kvm *kvm,
 			unsigned long start, unsigned long end);
 int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
-int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end);
+int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end,
+		bool flush);
 int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
 
 /* Emulation */
diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index 97e538a8c1be..288a22d70cf8 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -579,9 +579,16 @@ static int kvm_test_age_hva_handler(struct kvm *kvm, gfn_t gfn, gfn_t gfn_end,
 	return pte_young(*gpa_pte);
 }
 
-int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end)
+int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end,
+		bool flush)
 {
-	return handle_hva_to_gpa(kvm, start, end, kvm_age_hva_handler, NULL);
+	int young = handle_hva_to_gpa(kvm, start, end,
+			kvm_age_hva_handler, NULL);
+
+	if (flush && young > 0)
+		kvm_flush_remote_tlbs(kvm);
+
+	return young;
 }
 
 int kvm_test_age_hva(struct kvm *kvm, unsigned long hva)
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 0f98f00da2ea..d160e6b8ccfb 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -70,7 +70,8 @@
 
 extern int kvm_unmap_hva_range(struct kvm *kvm,
 			       unsigned long start, unsigned long end);
-extern int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end);
+extern int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end,
+		       bool flush);
 extern int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
 extern int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
 
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index bd1a677dd9e4..09a67ebbde8a 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -841,9 +841,15 @@ int kvm_unmap_hva_range(struct kvm *kvm, unsigned long start, unsigned long end)
 	return kvm->arch.kvm_ops->unmap_hva_range(kvm, start, end);
 }
 
-int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end)
+int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end,
+		bool flush)
 {
-	return kvm->arch.kvm_ops->age_hva(kvm, start, end);
+	int young = kvm->arch.kvm_ops->age_hva(kvm, start, end);
+
+	if (flush && young > 0)
+		kvm_flush_remote_tlbs(kvm);
+
+	return young;
 }
 
 int kvm_test_age_hva(struct kvm *kvm, unsigned long hva)
diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
index c3f312b2bcb3..e2f6c23ec39a 100644
--- a/arch/powerpc/kvm/e500_mmu_host.c
+++ b/arch/powerpc/kvm/e500_mmu_host.c
@@ -745,7 +745,8 @@ int kvm_unmap_hva_range(struct kvm *kvm, unsigned long start, unsigned long end)
 	return 0;
 }
 
-int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end)
+int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end,
+		bool flush)
 {
 	/* XXX could be more clever ;) */
 	return 0;
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 9d858d68c17a..4233481a202d 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1519,7 +1519,8 @@ asmlinkage void kvm_spurious_fault(void);
 
 #define KVM_ARCH_WANT_MMU_NOTIFIER
 int kvm_unmap_hva_range(struct kvm *kvm, unsigned long start, unsigned long end);
-int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end);
+int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end,
+		bool flush);
 int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
 int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
 int kvm_cpu_has_injectable_intr(struct kvm_vcpu *v);
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 63b3e36530e3..50b8417a8c21 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1977,9 +1977,15 @@ static void rmap_recycle(struct kvm_vcpu *vcpu, u64 *spte, gfn_t gfn)
 			KVM_PAGES_PER_HPAGE(sp->role.level));
 }
 
-int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end)
+int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end,
+		bool flush)
 {
-	return kvm_handle_hva_range(kvm, start, end, 0, kvm_age_rmapp);
+	int young = kvm_handle_hva_range(kvm, start, end, 0, kvm_age_rmapp);
+
+	if (flush && young > 0)
+		kvm_flush_remote_tlbs(kvm);
+
+	return young;
 }
 
 int kvm_test_age_hva(struct kvm *kvm, unsigned long hva)
diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index fbdf3ac2f001..3483ca11865b 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -2107,12 +2107,21 @@ static int kvm_test_age_hva_handler(struct kvm *kvm, gpa_t gpa, u64 size, void *
 		return pte_young(*pte);
 }
 
-int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end)
+int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end,
+		bool flush)
 {
+	int young;
+
 	if (!kvm->arch.pgd)
 		return 0;
 	trace_kvm_age_hva(start, end);
-	return handle_hva_to_gpa(kvm, start, end, kvm_age_hva_handler, NULL);
+
+	young = handle_hva_to_gpa(kvm, start, end, kvm_age_hva_handler, NULL);
+
+	if (flush && young > 0)
+		kvm_flush_remote_tlbs(kvm);
+
+	return young;
 }
 
 int kvm_test_age_hva(struct kvm *kvm, unsigned long hva)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index b2097fa4b618..2bdc827b9ee9 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -428,9 +428,7 @@ static int kvm_mmu_notifier_clear_flush_young(struct mmu_notifier *mn,
 	idx = srcu_read_lock(&kvm->srcu);
 	spin_lock(&kvm->mmu_lock);
 
-	young = kvm_age_hva(kvm, start, end);
-	if (young)
-		kvm_flush_remote_tlbs(kvm);
+	young = kvm_age_hva(kvm, start, end, true);
 
 	spin_unlock(&kvm->mmu_lock);
 	srcu_read_unlock(&kvm->srcu, idx);
@@ -461,7 +459,7 @@ static int kvm_mmu_notifier_clear_young(struct mmu_notifier *mn,
 	 * cadence. If we find this inaccurate, we might come up with a
 	 * more sophisticated heuristic later.
 	 */
-	young = kvm_age_hva(kvm, start, end);
+	young = kvm_age_hva(kvm, start, end, false);
 	spin_unlock(&kvm->mmu_lock);
 	srcu_read_unlock(&kvm->srcu, idx);
 
-- 
2.14.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
