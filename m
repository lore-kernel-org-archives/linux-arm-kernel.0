Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA36C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:22:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AAAC20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S+YJJ1ll";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ouQOyufS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AAAC20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=E3FmVflkbeUUIiyLScPOc2Bp1D6q2OJTc4fWmy/QDw0=; b=S+YJJ1llOBmdTkB2NWPhClkMXZ
	riElHvpyWMKdqJzCUw7MelOOcKLs7kFFmL5uC+ISWMpF8iygj45wlCxx21ogMf9E8J1mPayP9VcrM
	RftfEW9j+kcFXYxVJRsJ/2z2mzyjaIX3wk/PCUyyKDFSEbUCRNJy1RJ1TkqFFPOc0EHtqw7XCV27J
	YLNGji9QDfuPdj+XXdXUupCUAVDDjiw+FmQ73mku2LgS0oSI39TvI9tPmYDApF9rPGh7CC6pSTgzd
	uMdgxh6Z+GO9gCgspNSAPTafd94TP40sHbQccvBh60KPPI7/STS4xyfh3wJJ4zPQ+EC9fhDpeLg5b
	Jp5kd8pA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUtcA-0003b1-N1; Thu, 06 Dec 2018 13:22:50 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUtbV-0002j4-C4
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 13:22:19 +0000
Received: by mail-pf1-x444.google.com with SMTP id c73so158991pfe.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 05:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=FifTGwX83EQ8+OEfJfdERX2ACrXZsduv44eJgHUH8jk=;
 b=ouQOyufSH1/uGjxiNK638Mg4OcgdV54+aK+ERvM9nuExiRVwlTnqiudVXzDF0hTPrM
 k5NzMIrpAxJuZq7GrSPO/e43Slpbs3AKzR7xiiNBOCFKHxRZPklchjWhyc2xpXShjz6w
 mY6WyhU5r39tlUPeSie4e/oiy09f0rti5h6M//m450EBt5M95D1Ms25b8W/FiuQXHwIV
 SR2envrTDTAFCluFNaxS6CXxHsqS12dWFc5nbwpE6Y9c+KqBvfln/JhX9h/fVksa4A6/
 DoegjgMPNn3sINWU37pGFc4UKOVj7fq3P8u4r6DlhQVTOtUYxhoL4Thigr4Hu0dIGTBC
 cdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=FifTGwX83EQ8+OEfJfdERX2ACrXZsduv44eJgHUH8jk=;
 b=glfF89jXBcSFQqTYk3ri9q1rfHrJrmOE67btR4nQvVIyqvIymOFvgNd5s+bUFx9H5Q
 3+Y+eMWXWzQA02FAhZegrpwSMPv9vURzsKnRUwfVP2MK1AsOpI41Ue96iU63Gk4uq8lm
 uEj/F/sjmn1UzpO+JDPR4X/vP4RMSKZIZxx3Oc4KOR0Ii40ZsUNVpHtIqlGb0Q+OqAiV
 ZfvFyuoIIsNAODo8JGNfjURxMuHuP2MNPNWtSOB2NlhXDTKUN0ymt+t8J4SBhP3e42Cb
 vuGhCpl1ZevfRphtrJ9G2B8DOO8B/+cKuJtkYSs5HC6E9WQZzpZciE348IFfXStQnh/m
 pA+Q==
X-Gm-Message-State: AA+aEWZCjPFtGAzpocN+qVZqkWPsXu1iZD0CfJxS1m18v6dUtMiey6kn
 fPjZBowjP0wKYOVGz10PgV4=
X-Google-Smtp-Source: AFSGD/XCYgp2n6afvG2NNG13lbKRDr+Z8n6ZKQ8J0OQOGaIotugH6znCCj6Lc0VvKfwDWXv900qNgQ==
X-Received: by 2002:a63:396:: with SMTP id 144mr24368991pgd.68.1544102518590; 
 Thu, 06 Dec 2018 05:21:58 -0800 (PST)
Received: from localhost.corp.microsoft.com
 ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
 by smtp.googlemail.com with ESMTPSA id y5sm2409246pge.49.2018.12.06.05.21.51
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 05:21:58 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [Resend PATCH V5 4/10] KVM/VMX: Add hv tlb range flush support
Date: Thu,  6 Dec 2018 21:21:07 +0800
Message-Id: <20181206132113.2691-5-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181206132113.2691-1-Tianyu.Lan@microsoft.com>
References: <20181206132113.2691-1-Tianyu.Lan@microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_052210_064146_F6CC80D7 
X-CRM114-Status: GOOD (  16.49  )
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
Cc: linux-mips@linux-mips.org, kvm@vger.kernel.org, rkrcmar@redhat.com,
 catalin.marinas@arm.com, will.deacon@arm.com, christoffer.dall@arm.com,
 paulus@ozlabs.org, hpa@zytor.com, kys@microsoft.com,
 kvmarm@lists.cs.columbia.edu, mpe@ellerman.id.au, x86@kernel.org,
 linux@armlinux.org.uk, michael.h.kelley@microsoft.com, mingo@redhat.com,
 benh@kernel.crashing.org, jhogan@kernel.org,
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

This patch is to register tlb_remote_flush_with_range callback with
hv tlb range flush interface.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
Change since v4:
	- Use new function kvm_fill_hv_flush_list_func() to fill flush
       request.
Change since v3:
	- Merge Vitaly's don't pass EPT configuration info to
vmx_hv_remote_flush_tlb() fix.
Change since v1:
	- Pass flush range with new hyper-v tlb flush struct rather
       than KVM tlb flush struct.
---
 arch/x86/kvm/vmx.c | 63 +++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 46 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 2356118ea440..bad2aa6c5ca1 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -1569,7 +1569,34 @@ static void check_ept_pointer_match(struct kvm *kvm)
 	to_kvm_vmx(kvm)->ept_pointers_match = EPT_POINTERS_MATCH;
 }
 
-static int vmx_hv_remote_flush_tlb(struct kvm *kvm)
+int kvm_fill_hv_flush_list_func(struct hv_guest_mapping_flush_list *flush,
+		void *data)
+{
+	struct kvm_tlb_range *range = data;
+
+	return hyperv_fill_flush_guest_mapping_list(flush, range->start_gfn,
+			range->pages);
+}
+
+static inline int __hv_remote_flush_tlb_with_range(struct kvm *kvm,
+		struct kvm_vcpu *vcpu, struct kvm_tlb_range *range)
+{
+	u64 ept_pointer = to_vmx(vcpu)->ept_pointer;
+
+	/*
+	 * FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE hypercall needs address
+	 * of the base of EPT PML4 table, strip off EPT configuration
+	 * information.
+	 */
+	if (range)
+		return hyperv_flush_guest_mapping_range(ept_pointer & PAGE_MASK,
+				kvm_fill_hv_flush_list_func, (void *)range);
+	else
+		return hyperv_flush_guest_mapping(ept_pointer & PAGE_MASK);
+}
+
+static int hv_remote_flush_tlb_with_range(struct kvm *kvm,
+		struct kvm_tlb_range *range)
 {
 	struct kvm_vcpu *vcpu;
 	int ret = -ENOTSUPP, i;
@@ -1579,29 +1606,26 @@ static int vmx_hv_remote_flush_tlb(struct kvm *kvm)
 	if (to_kvm_vmx(kvm)->ept_pointers_match == EPT_POINTERS_CHECK)
 		check_ept_pointer_match(kvm);
 
-	/*
-	 * FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE hypercall needs the address of the
-	 * base of EPT PML4 table, strip off EPT configuration information.
-	 * If ept_pointer is invalid pointer, bypass the flush request.
-	 */
 	if (to_kvm_vmx(kvm)->ept_pointers_match != EPT_POINTERS_MATCH) {
 		kvm_for_each_vcpu(i, vcpu, kvm) {
-			u64 ept_pointer = to_vmx(vcpu)->ept_pointer;
-
-			if (!VALID_PAGE(ept_pointer))
-				continue;
-
-			ret |= hyperv_flush_guest_mapping(
-				ept_pointer & PAGE_MASK);
+			/* If ept_pointer is invalid pointer, bypass flush request. */
+			if (VALID_PAGE(to_vmx(vcpu)->ept_pointer))
+				ret |= __hv_remote_flush_tlb_with_range(
+						kvm, vcpu, range);
 		}
 	} else {
-		ret = hyperv_flush_guest_mapping(
-			to_vmx(kvm_get_vcpu(kvm, 0))->ept_pointer & PAGE_MASK);
+		ret = __hv_remote_flush_tlb_with_range(kvm,
+				kvm_get_vcpu(kvm, 0), range);
 	}
 
 	spin_unlock(&to_kvm_vmx(kvm)->ept_pointer_lock);
 	return ret;
 }
+
+static int hv_remote_flush_tlb(struct kvm *kvm)
+{
+	return hv_remote_flush_tlb_with_range(kvm, NULL);
+}
 #else /* !IS_ENABLED(CONFIG_HYPERV) */
 static inline void evmcs_write64(unsigned long field, u64 value) {}
 static inline void evmcs_write32(unsigned long field, u32 value) {}
@@ -7971,8 +7995,11 @@ static __init int hardware_setup(void)
 
 #if IS_ENABLED(CONFIG_HYPERV)
 	if (ms_hyperv.nested_features & HV_X64_NESTED_GUEST_MAPPING_FLUSH
-	    && enable_ept)
-		kvm_x86_ops->tlb_remote_flush = vmx_hv_remote_flush_tlb;
+	    && enable_ept) {
+		kvm_x86_ops->tlb_remote_flush = hv_remote_flush_tlb;
+		kvm_x86_ops->tlb_remote_flush_with_range =
+				hv_remote_flush_tlb_with_range;
+	}
 #endif
 
 	if (!cpu_has_vmx_ple()) {
@@ -11612,6 +11639,8 @@ static struct kvm_vcpu *vmx_create_vcpu(struct kvm *kvm, unsigned int id)
 	vmx->nested.posted_intr_nv = -1;
 	vmx->nested.current_vmptr = -1ull;
 
+	vmx->ept_pointer = INVALID_PAGE;
+
 	vmx->msr_ia32_feature_control_valid_bits = FEATURE_CONTROL_LOCKED;
 
 	/*
-- 
2.14.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
