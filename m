Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56AAC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:56:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9576B217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JEzgYRQA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LG75W+vS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9576B217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=xteNDgrkPLYYoF4Hf/vnKOVxq95EKJjLF+CJ+j9AyEg=; b=JEzgYRQA+mpVfz35x4QkzJfvut
	e247CQEU9u81SJpUnF57GWxjNoAnzBmo7qnwbcJ1z3KRRpeyN6ytQ5i0kd3SkqoSvQra46TaP6T14
	wLa/LEjC2GYMwe1TkbYpoood7xNm8IJaVzmi9GMPONLk/hMrPOwl5Ofqkfy4s6Bixttx2yZ0O87ur
	ywgz+4K3MoPrA2laRUcipRkCP3b5AilGDVfuROF+ei0p3htU1Bu5+/2PXOU+eN0y84HdF/g++2b+P
	R3AC6cuJXOiBXDrMHgYp0D5SWlpOI0k7g6gOITOcQw5O/QKRWANXkBuvqu9LlmnXrPRPWEHr1LAgK
	4HmzBN/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvp21-0008P5-Dk; Mon, 18 Feb 2019 19:56:49 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvp00-0005Ck-Mx
 for linux-arm-kernel@bombadil.infradead.org; Mon, 18 Feb 2019 19:54:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qFmejAfScTZyZcZc5IW1S5jUQVxgh7WLALlBombMnb4=; b=LG75W+vSD22MMtAEtplPpykN/
 zXBx/FcPWQwvfDKb5BsL9WTx/RpWkXZTyJw/C4DwWf7FAt3R+lGakSmu9yJOvJvxG59miKpgAR1NI
 6taXNaNQM4QLkmbIpLoItkaFclP3WYMwB/3pF8soA5kMacfxAwuZJRIGuUl0NcVHYMjL3k3xiiaRI
 FTe0x2I6AsxpuCQBcH0dZNfP8/JBuTYZCNg+DX65YE6KXht+LGhoZ2RHmaewbyVMk83uKGgduzdf1
 lmIKhxeVhBAjNsof64KY02yAMKCzZoiumbT/EsmH1OkuXu0RVB2EMot9M+3i0Ev8YJXTLMzaGn/zY
 OmLySNjfw==;
Received: from foss.arm.com ([217.140.101.70])
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvozv-0003pZ-Fk
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 19:54:42 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 921A71C2B;
 Mon, 18 Feb 2019 11:54:14 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A3EB63FBA7;
 Mon, 18 Feb 2019 11:54:12 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v5 21/26] KVM: arm/arm64: Add hook to finalize the vcpu
 configuration
Date: Mon, 18 Feb 2019 19:52:34 +0000
Message-Id: <1550519559-15915-22-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_145441_827989_DDACF79D 
X-CRM114-Status: GOOD (  15.85  )
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Okamoto Takayuki <tokamoto@jp.fujitsu.com>,
 Christoffer Dall <cdall@kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Zhang Lei <zhang.lei@jp.fujitsu.com>,
 Julien Grall <julien.grall@arm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Some aspects of vcpu configuration can't be completed inside
KVM_VCPU_INIT, but still change API behaviour visible to userspace.

Where such configuration choices affect the register list visible
to userspace, we will need to track whether we have made a
commitment to userspace regarding the list of vcpu registers.

This patch adds a new hook kvm_arm_vcpu_finalize() to capture this
commitment, along with a corresponding check
kvm_arm_vcpu_finalized().  We commit to the register list when
userspace reads it via KVM_GET_REG_LIST, or when the vcpu is fired
up via KVM_RUN.

kvm_arm_vcpu_finalize() is currently a no-op, but future patches
will amend this to handle SVE on arm64.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm/include/asm/kvm_host.h   | 4 ++++
 arch/arm64/include/asm/kvm_host.h | 4 ++++
 virt/kvm/arm/arm.c                | 8 ++++++++
 3 files changed, 16 insertions(+)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index ca56537..ab7c76b 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -360,4 +360,8 @@ static inline int kvm_arm_setup_stage2(struct kvm *kvm, unsigned long type)
 	return 0;
 }
 
+/* Commit to the set of vcpu registers currently configured: */
+static inline int kvm_arm_vcpu_finalize(struct kvm_vcpu *vcpu) { return 0; }
+#define kvm_arm_vcpu_finalized(vcpu) true
+
 #endif /* __ARM_KVM_HOST_H__ */
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index d233855..015c2578 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -553,4 +553,8 @@ void kvm_arch_free_vm(struct kvm *kvm);
 
 int kvm_arm_setup_stage2(struct kvm *kvm, unsigned long type);
 
+/* Commit to the set of vcpu registers currently configured: */
+static inline int kvm_arm_vcpu_finalize(struct kvm_vcpu *vcpu) { return 0; }
+#define kvm_arm_vcpu_finalized(vcpu) true
+
 #endif /* __ARM64_KVM_HOST_H__ */
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 9e350fd3..12f9dc2 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -560,6 +560,10 @@ static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu)
 	if (likely(vcpu->arch.has_run_once))
 		return 0;
 
+	ret = kvm_arm_vcpu_finalize(vcpu);
+	if (ret)
+		return ret;
+
 	vcpu->arch.has_run_once = true;
 
 	if (likely(irqchip_in_kernel(kvm))) {
@@ -1121,6 +1125,10 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		if (unlikely(!kvm_vcpu_initialized(vcpu)))
 			break;
 
+		r = kvm_arm_vcpu_finalize(vcpu);
+		if (r)
+			break;
+
 		r = -EFAULT;
 		if (copy_from_user(&reg_list, user_list, sizeof(reg_list)))
 			break;
-- 
2.1.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
