Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129AAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:10:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBD2420855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AhgOD1ff";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wyRCtn1Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBD2420855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=QAlA8VXtS3Fr1H+jHaziD/7rEUxPI4wP8tsXScoAJNk=; b=AhgOD1ffnHykkQZ403lFS5kVN0
	xC1lKAo9EAMhf/MK63tbLzUok8uJh7ifMcCNjsJYgA3WQG9ZUFq6dYThFfBkkJtidFg6eYWT0YvVl
	dCg8q8JaObWSr+u3aT25od3fXgpi/DKvigxSF8JmmX309lkJ9/Y0ZBIHUCgyBP5dECN40QEsT/6K3
	k8aYzlIyEqRcnUQ3cBFQdPvD5zCBOBNZjjcsqUzY0kmVfZj1H7M+ku+PDNwvtxSIzc0lxHQuRZU8v
	cnWeqNJqveq7xT3VEtSHryssb0bZEKcKGu97nVXWgfMNNdTXrlAOhRQpYmFmFfjqYsoL6hrUvl2F3
	A36T+7WQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkEw2-0002kt-2c; Thu, 17 Jan 2019 21:10:46 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkEvz-0002kj-E7
 for linux-arm-kernel@bombadil.infradead.org; Thu, 17 Jan 2019 21:10:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OW6QbxRUnJYShbOPKi325I1GsbLT5Le8wCALTV1C4Cg=; b=wyRCtn1YoHr/WxfSIQ4W+vGZs
 wtUzF67nC1wkRwYJWDAryglPBKE/J133Kk7SNptpUcs5bkEWz2rfEzZZI2n29pVnHRr5/l/4Hak02
 yC6UkcXKnZPr3YQDwVVt7FdqrmSBdi/MxIOmr4VRxk67C6i0WGFHlQ7jA2mmQreNGKrTdpbL1aNKR
 jAaYITBzXSFnb8yvRHhSlJStxz4LR3QM+2wA/MqP5Sm4h3xk3Yec+IDXpMM+CIQkXbJo/dA3l+Eco
 w+Av4/PJV3icrBBma0/1wXJU4+CUZXmYjV2GEVllcjx1N9nwUsXtElnytMAfC4MKKCQQB2tt0Vt9M
 gaaJRtDCg==;
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkENi-0005l1-T5
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 20:35:20 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FD7016A3;
 Thu, 17 Jan 2019 12:35:15 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 83C693F819;
 Thu, 17 Jan 2019 12:35:13 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v4 22/25] KVM: arm64/sve: Allow userspace to enable SVE for
 vcpus
Date: Thu, 17 Jan 2019 20:33:36 +0000
Message-Id: <1547757219-19439-23-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1547757219-19439-1-git-send-email-Dave.Martin@arm.com>
References: <1547757219-19439-1-git-send-email-Dave.Martin@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_153519_115156_94056692 
X-CRM114-Status: GOOD (  22.98  )
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
 Will Deacon <will.deacon@arm.com>, Julien Grall <Julien.Grall@arm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Now that all the pieces are in place, this patch offers a new flag
KVM_ARM_VCPU_SVE that userspace can pass to KVM_ARM_VCPU_INIT to
turn on SVE for the guest, on a per-vcpu basis.

As part of this, support for initialisation and reset of the SVE
vector length set and registers is added in the appropriate places.
Allocation SVE registers is deferred until kvm_arm_vcpu_finalize(),
by which time the size of the registers is known.

Setting the vector lengths supported by the vcpu is considered
configuration of the emulated hardware rather than runtime
configuration, so no support is offered for changing the vector
lengths of an existing vcpu across reset.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/kvm_host.h |  2 +-
 arch/arm64/include/uapi/asm/kvm.h |  1 +
 arch/arm64/kvm/reset.c            | 78 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 82a99f6..f77b780 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -45,7 +45,7 @@
 
 #define KVM_MAX_VCPUS VGIC_V3_MAX_CPUS
 
-#define KVM_VCPU_MAX_FEATURES 4
+#define KVM_VCPU_MAX_FEATURES 5
 
 #define KVM_REQ_SLEEP \
 	KVM_ARCH_REQ_FLAGS(0, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 6dfbfa3..fc613af 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -102,6 +102,7 @@ struct kvm_regs {
 #define KVM_ARM_VCPU_EL1_32BIT		1 /* CPU running a 32bit VM */
 #define KVM_ARM_VCPU_PSCI_0_2		2 /* CPU uses PSCI v0.2 */
 #define KVM_ARM_VCPU_PMU_V3		3 /* Support guest PMUv3 */
+#define KVM_ARM_VCPU_SVE		4 /* enable SVE for this CPU */
 
 struct kvm_vcpu_init {
 	__u32 target;
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 1379fb2..5ff2360 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -23,11 +23,13 @@
 #include <linux/kvm_host.h>
 #include <linux/kvm.h>
 #include <linux/hw_breakpoint.h>
+#include <linux/slab.h>
 
 #include <kvm/arm_arch_timer.h>
 
 #include <asm/cpufeature.h>
 #include <asm/cputype.h>
+#include <asm/fpsimd.h>
 #include <asm/ptrace.h>
 #include <asm/kvm_arm.h>
 #include <asm/kvm_asm.h>
@@ -98,11 +100,77 @@ int kvm_arch_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	return r;
 }
 
+static size_t vcpu_sve_state_size(struct kvm_vcpu *vcpu)
+{
+	if (WARN_ON(!sve_vl_valid(vcpu->arch.sve_max_vl)))
+		return 0;
+
+	return SVE_SIG_REGS_SIZE(sve_vq_from_vl(vcpu->arch.sve_max_vl));
+}
+
+static int kvm_reset_sve(struct kvm_vcpu *vcpu)
+{
+	unsigned int vq;
+
+	if (!system_supports_sve())
+		return -EINVAL;
+
+	/* If resetting an already-configured vcpu, just zero the SVE regs: */
+	if (vcpu->arch.sve_state) {
+		size_t size = vcpu_sve_state_size(vcpu);
+
+		if (!size)
+			return -EINVAL;
+
+		if (WARN_ON(!vcpu_has_sve(vcpu)))
+			return -EINVAL;
+
+		memset(vcpu->arch.sve_state, 0, size);
+		return 0;
+	}
+
+	if (WARN_ON(!sve_vl_valid(sve_max_vl)))
+		return -EINVAL;
+
+	/* If the full set of host vector lengths cannot be used, give up: */
+	if (sve_max_virtualisable_vl < sve_max_vl)
+		return -EINVAL;
+
+	/* Default to the set of vector lengths supported by the host */
+	vcpu->arch.sve_max_vl = sve_max_vl;
+	for (vq = SVE_VQ_MIN; vq <= sve_vq_from_vl(sve_max_vl); ++vq) {
+		unsigned int i = vq - SVE_VQ_MIN;
+
+		if (sve_vq_available(vq))
+			vcpu->arch.sve_vqs[i / 64] |= (u64)1 << (i % 64);
+	}
+
+	/*
+	 * Userspace can still customize the vector lengths by writing
+	 * KVM_REG_ARM64_SVE_VLS.  Allocation is deferred until
+	 * kvm_arm_vcpu_finalize(), which freezes the configuration.
+	 */
+	vcpu->arch.flags |= KVM_ARM64_GUEST_HAS_SVE;
+
+	return 0;
+}
+
 int kvm_arm_vcpu_finalize(struct kvm_vcpu *vcpu)
 {
 	if (likely(kvm_arm_vcpu_finalized(vcpu)))
 		return 0;
 
+	if (vcpu_has_sve(vcpu)) {
+		size_t size = vcpu_sve_state_size(vcpu);
+
+		if (!size)
+			return -EINVAL;
+
+		vcpu->arch.sve_state = kzalloc(size, GFP_KERNEL);
+		if (!vcpu->arch.sve_state)
+			return -ENOMEM;
+	}
+
 	vcpu->arch.flags |= KVM_ARM64_VCPU_FINALIZED;
 	return 0;
 }
@@ -113,12 +181,20 @@ int kvm_arm_vcpu_finalize(struct kvm_vcpu *vcpu)
  *
  * This function finds the right table above and sets the registers on
  * the virtual CPU struct to their architecturally defined reset
- * values.
+ * values, except for registers whose reset is deferred until
+ * kvm_arm_vcpu_finalize().
  */
 int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 {
+	int ret;
 	const struct kvm_regs *cpu_reset;
 
+	if (test_bit(KVM_ARM_VCPU_SVE, vcpu->arch.features)) {
+		ret = kvm_reset_sve(vcpu);
+		if (ret)
+			return ret;
+	}
+
 	switch (vcpu->arch.target) {
 	default:
 		if (test_bit(KVM_ARM_VCPU_EL1_32BIT, vcpu->arch.features)) {
-- 
2.1.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
