Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848B2C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:41:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 558B12075B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kbYl9HO4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mETogsVp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 558B12075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=/qiadfES+nkXstW2i2KSQd3qmL2HZqWCMUisplO8TuQ=; b=kbYl9HO4pauZJz1R4JQCEoOuPK
	3rGYOpSw+M3SCZxFLnaLltZCnwkHGdOwLDitMl/B/0d9UT/p1ad2pETfNPQVV6t0DM38Hmevc1TdO
	jTmx8f6f6VarigZNI25O3aXhRpBkgKy/bNeq2Xh6sXfrcoHpd8+uKvyxJxYwe/2kvI9cKsBdwCvy8
	Lsv4W+SsLdhvQFFpKTasZk4dKvTPWEXzUdlPbow9ahabQj2cKqamRIljkg3dsn6a+WhBPkA9qsvSK
	WLz9HssrddET9fBypcIWRnADDXdvFJCFFsgshlXCMDCkIXC7kqI/ZAb1xYz7wjoyGXWeJjgG8lrWI
	bDjZ2EWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpkIj-0006eC-Sa; Sat, 02 Feb 2019 01:40:57 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpkHc-0004PY-IY
 for linux-arm-kernel@lists.infradead.org; Sat, 02 Feb 2019 01:40:21 +0000
Received: by mail-pf1-x441.google.com with SMTP id i12so4092558pfo.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 17:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=J0G5pUHhnRBECCI0xPIkQW74M8CRHN4x4Ep3m3tfVSg=;
 b=mETogsVpxhVfhsOmA0sb7uEV04lG52SniOT1AfmMw+0E+0y28BA+Nm2A13q1U/AIBf
 Rr21t1bTIOof/r1LaemaW+I+UzY6O/fgq9Iarhivf5oKCqcoaucWRahA0uGqb5l9h9FX
 gSrimShMJDyZd3Bx4H+UrqD4Ul2hZs53V++PPb+imTnEhAKo/FNhdQkxCDf8vO2nlswN
 CQMUIDmcqqsWZS+v7Jig+7d3Jhaq6JSuG5d5OEeyYSNC3G3eXaMQ4D8qslLyAB4+aV6V
 zvdT2zXWWPwfEY4BQMcJHh9qanl0OJiySvAfhPD21IlmfxwFy2DVfQKuWHZ8PzCF4/S6
 +LZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=J0G5pUHhnRBECCI0xPIkQW74M8CRHN4x4Ep3m3tfVSg=;
 b=h+ad0qsQb9cpvJdqqZFZ2iLVTrL0LXFnxHNuG8/G0npPwCgC5fKm1P/O0ne41k64us
 aIfCQbyjH/e3nq+YuhvV4qPNChSKUosr0uEQ9AoCLkW7vS533CdwfFra/bUgqTD+QjD9
 TReduS/0QAINLDUkW8HOHBFckMED2XK6364wzRAq/KMLlzG5GZ4nLHldxlorWmFTM6NS
 OvEFSer7WdYXAwxW3ggPgWSHa0Lr8RBO/IM0WB3+Ii04RPk/uJp8iLMXkqzSiqyC9aHn
 hHsI099xQeRvvIc/lChUlQA1WFfHTeB0ShCz1lwSiwb6KhE7oXNdw4O33Wa+DQ6VXebL
 ub1Q==
X-Gm-Message-State: AHQUAuaoPKsQQ4a+0JQhk2bwaumV2BvUPYB5TEPd33mA8vK6tSWGZRD0
 iOMcEDTgKtNlkyuvO52p3pk=
X-Google-Smtp-Source: AHgI3Iavh6/FqGMJR291IjbA0/Gk6zaWfaqjhYnIWMWgId13SG1KABXFEz08oX/WVS+zNawI0z8Azg==
X-Received: by 2002:a62:e012:: with SMTP id f18mr9115403pfh.119.1549071588175; 
 Fri, 01 Feb 2019 17:39:48 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
 by smtp.googlemail.com with ESMTPSA id d3sm9183425pgl.64.2019.02.01.17.39.40
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 01 Feb 2019 17:39:47 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH V2 8/10] KVM: Use tlb range flush in the
 kvm_vm_ioctl_get/clear_dirty_log()
Date: Sat,  2 Feb 2019 09:38:24 +0800
Message-Id: <20190202013825.51261-9-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190202013825.51261-1-Tianyu.Lan@microsoft.com>
References: <20190202013825.51261-1-Tianyu.Lan@microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_173948_931989_DFCBA807 
X-CRM114-Status: GOOD (  13.38  )
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

This patch is to use tlb range flush to flush memslot's in the
kvm_vm_ioctl_get/clear_dirty_log() instead of flushing tlbs
of entire ept page table when range flush is available.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/mmu.c |  8 +-------
 arch/x86/kvm/mmu.h |  7 +++++++
 arch/x86/kvm/x86.c | 16 ++++++++++++----
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 6b5e9bed6665..63b3e36530e3 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -264,12 +264,6 @@ static void mmu_spte_set(u64 *sptep, u64 spte);
 static union kvm_mmu_page_role
 kvm_mmu_calc_root_page_role(struct kvm_vcpu *vcpu);
 
-
-static inline bool kvm_available_flush_tlb_with_range(void)
-{
-	return kvm_x86_ops->tlb_remote_flush_with_range;
-}
-
 static void kvm_flush_remote_tlbs_with_range(struct kvm *kvm,
 		struct kvm_tlb_range *range)
 {
@@ -282,7 +276,7 @@ static void kvm_flush_remote_tlbs_with_range(struct kvm *kvm,
 		kvm_flush_remote_tlbs(kvm);
 }
 
-static void kvm_flush_remote_tlbs_with_address(struct kvm *kvm,
+void kvm_flush_remote_tlbs_with_address(struct kvm *kvm,
 		u64 start_gfn, u64 pages)
 {
 	struct kvm_tlb_range range;
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index c7b333147c4a..dddab78d8ed8 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -63,6 +63,13 @@ void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 bool kvm_can_do_async_pf(struct kvm_vcpu *vcpu);
 int kvm_handle_page_fault(struct kvm_vcpu *vcpu, u64 error_code,
 				u64 fault_address, char *insn, int insn_len);
+void kvm_flush_remote_tlbs_with_address(struct kvm *kvm,
+				u64 start_gfn, u64 pages);
+
+static inline bool kvm_available_flush_tlb_with_range(void)
+{
+	return kvm_x86_ops->tlb_remote_flush_with_range;
+}
 
 static inline unsigned int kvm_mmu_available_pages(struct kvm *kvm)
 {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3d32b8f5728d..0f70e07abfa1 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4445,9 +4445,13 @@ int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
 	 * kvm_mmu_slot_remove_write_access().
 	 */
 	lockdep_assert_held(&kvm->slots_lock);
-	if (flush)
-		kvm_flush_remote_tlbs(kvm);
+	if (flush) {
+		struct kvm_memory_slot *memslot = kvm_get_memslot(kvm,
+				log->slot);
 
+		kvm_flush_remote_tlbs_with_address(kvm, memslot->base_gfn,
+				memslot->npages);
+	}
 	mutex_unlock(&kvm->slots_lock);
 	return r;
 }
@@ -4472,9 +4476,13 @@ int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm, struct kvm_clear_dirty_log *lo
 	 * kvm_mmu_slot_remove_write_access().
 	 */
 	lockdep_assert_held(&kvm->slots_lock);
-	if (flush)
-		kvm_flush_remote_tlbs(kvm);
+	if (flush) {
+		struct kvm_memory_slot *memslot = kvm_get_memslot(kvm,
+				log->slot);
 
+		kvm_flush_remote_tlbs_with_address(kvm, memslot->base_gfn,
+				memslot->npages);
+	}
 	mutex_unlock(&kvm->slots_lock);
 	return r;
 }
-- 
2.14.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
