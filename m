Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1E9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:57:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A960320851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pBZ6iQPN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LXH+LvpV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A960320851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=IguyLT5A7F0LlewrwzeeUFrIclHNZrJdU04KdMsKsRc=; b=pBZ6iQPNdlXiAcCZxVFQD9QsXv
	gAukaPOwcrXgoSj2RjJlXpOJ6iYGLjehsObKE1UgYSJzXWIo0wD2IBtqlGBdwREkMifoFJCR3HE1/
	qv8vDpSxwl1B1gFair2ty6m7HqDsSf4AaMSwCdZUJGdZWBdY6mQ4clL+5j7IDh/V2RnFWZ5Qzkxa5
	WOy3OlnAF35mnHHk3qNsHXqWQEz68t8GB40uNURyDhKxWePqNYNcJV3z2Aib8qkB+gMgS2bSUZrEB
	hs7yPbAOxbAU9SgqtMJu3H6SdU3CXWCFOWM0xtjfI9yWx4pFqpcGNmjej/eWx2fvVTdjk7HlAFeAR
	wFz1zD7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkEdu-0003gl-Qf; Thu, 17 Jan 2019 20:52:02 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkEcQ-0001sB-1O
 for linux-arm-kernel@bombadil.infradead.org; Thu, 17 Jan 2019 20:50:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YRn6NuYQt457afiP+6BWSm0tGpZGaC8UhbR3MF/CzM8=; b=LXH+LvpVgUtyuAahcn82m7K5d
 sVOS4v4NTaptJXoiw7z2rGAKTBa7CEevfot9pxM7Lsklu9O8smLclkfiW25vKhU/Nmawu4HRFkPPS
 OatiqbvjSiEAQNZPWxwmxKTYDBikULtVADQT53wA0E6MHLq4/jF29hdTKVVD6eV9a2RYGJ505kzhb
 b51sqTZPwjhWFJ9EtRW/aoShqEzUnHc3mq75Ahax4rFpIwFPmqDDGV8WyYeOMh6O8V7NYPfpyitux
 WnNE4jVKy7R3uIuyDHRarZei7PmsK04xAbkUxn3XPch7VoWRYrvttsRTc9E5Xl9v46WHwCAG7IJVx
 WmrOfErRQ==;
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkENY-0006md-QR
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 20:35:10 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 238D5169E;
 Thu, 17 Jan 2019 12:35:07 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 567A33F819;
 Thu, 17 Jan 2019 12:35:05 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v4 18/25] KVM: arm64: Enumerate SVE register indices for
 KVM_GET_REG_LIST
Date: Thu, 17 Jan 2019 20:33:32 +0000
Message-Id: <1547757219-19439-19-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1547757219-19439-1-git-send-email-Dave.Martin@arm.com>
References: <1547757219-19439-1-git-send-email-Dave.Martin@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_203509_163921_B83639D8 
X-CRM114-Status: GOOD (  19.00  )
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

This patch includes the SVE register IDs in the list returned by
KVM_GET_REG_LIST, as appropriate.

On a non-SVE-enabled vcpu, no new IDs are added.

On an SVE-enabled vcpu, IDs for the FPSIMD V-registers are removed
from the list, since userspace is required to access the Z-
registers instead to access their context.  For the variably-
sized SVE registers, the appropriate set of slice IDs are
enumerated, depending on the maximum vector length for the vcpu.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

Changes since RFC v3:

 * Don't enumerate FPSIMD V-regs for SVE vcpus.
---
 arch/arm64/kvm/guest.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index b8f9c1e..2d248e7 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -234,6 +234,11 @@ struct kreg_region {
 
 #define SVE_NUM_SLICES (1 << SVE_REG_SLICE_BITS)
 
+#define KVM_SVE_ZREG_SIZE KVM_REG_SIZE(KVM_REG_ARM64_SVE_ZREG(0, 0))
+#define KVM_SVE_PREG_SIZE KVM_REG_SIZE(KVM_REG_ARM64_SVE_PREG(0, 0))
+#define KVM_SVE_SLICES(vcpu) \
+	DIV_ROUND_UP((vcpu)->arch.sve_max_vl, KVM_SVE_ZREG_SIZE)
+
 static int sve_reg_region(struct kreg_region *b,
 			  const struct kvm_vcpu *vcpu,
 			  const struct kvm_one_reg *reg)
@@ -251,7 +256,7 @@ static int sve_reg_region(struct kreg_region *b,
 	if (reg->id >= KVM_REG_ARM64_SVE_ZREG(0, 0) &&
 	    reg->id <= KVM_REG_ARM64_SVE_ZREG(SVE_NUM_ZREGS - 1,
 					      SVE_NUM_SLICES - 1)) {
-		slice_size = KVM_REG_SIZE(KVM_REG_ARM64_SVE_ZREG(0, 0));
+		slice_size = KVM_SVE_ZREG_SIZE;
 
 		/* Compute start and end of the register: */
 		offset = SVE_SIG_ZREG_OFFSET(vq, reg_num) - SVE_SIG_REGS_OFFSET;
@@ -263,7 +268,7 @@ static int sve_reg_region(struct kreg_region *b,
 		   reg->id <= KVM_REG_ARM64_SVE_FFR(SVE_NUM_SLICES - 1)) {
 		/* (FFR is P16 for our purposes) */
 
-		slice_size = KVM_REG_SIZE(KVM_REG_ARM64_SVE_PREG(0, 0));
+		slice_size = KVM_SVE_PREG_SIZE;
 
 		/* Compute start and end of the register: */
 		offset = SVE_SIG_PREG_OFFSET(vq, reg_num) - SVE_SIG_REGS_OFFSET;
@@ -358,6 +363,14 @@ static int copy_core_reg_indices(const struct kvm_vcpu *vcpu,
 			continue;
 		}
 
+		/*
+		 * The KVM_REG_ARM64_SVE regs must be used instead of
+		 * KVM_REG_ARM_CORE for accessing the FPSIMD V-registers on
+		 * SVE-enabled vcpus:
+		 */
+		if (vcpu_has_sve(vcpu) && core_reg_offset_is_vreg(i))
+			continue;
+
 		if (uind) {
 			if (put_user(reg, *uind))
 				return -EFAULT;
@@ -428,6 +441,44 @@ static int get_timer_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	return copy_to_user(uaddr, &val, KVM_REG_SIZE(reg->id)) ? -EFAULT : 0;
 }
 
+static unsigned long num_sve_regs(const struct kvm_vcpu *vcpu)
+{
+	unsigned int slices;
+
+	if (!vcpu_has_sve(vcpu))
+		return 0;
+
+	slices = KVM_SVE_SLICES(vcpu);
+	return slices * (SVE_NUM_PREGS + SVE_NUM_ZREGS + 1 /* FFR */);
+}
+
+static int copy_sve_reg_indices(const struct kvm_vcpu *vcpu, u64 __user **uind)
+{
+	unsigned int slices, i, n;
+
+	if (!vcpu_has_sve(vcpu))
+		return 0;
+
+	slices = KVM_SVE_SLICES(vcpu);
+
+	for (i = 0; i < slices; i++) {
+		for (n = 0; n < SVE_NUM_ZREGS; n++) {
+			if (put_user(KVM_REG_ARM64_SVE_ZREG(n, i), (*uind)++))
+				return -EFAULT;
+		}
+
+		for (n = 0; n < SVE_NUM_PREGS; n++) {
+			if (put_user(KVM_REG_ARM64_SVE_PREG(n, i), (*uind)++))
+				return -EFAULT;
+		}
+
+		if (put_user(KVM_REG_ARM64_SVE_FFR(i), (*uind)++))
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
 /**
  * kvm_arm_num_regs - how many registers do we present via KVM_GET_ONE_REG
  *
@@ -438,6 +489,7 @@ unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu)
 	unsigned long res = 0;
 
 	res += num_core_regs(vcpu);
+	res += num_sve_regs(vcpu);
 	res += kvm_arm_num_sys_reg_descs(vcpu);
 	res += kvm_arm_get_fw_num_regs(vcpu);
 	res += NUM_TIMER_REGS;
@@ -458,6 +510,10 @@ int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
 	if (ret < 0)
 		return ret;
 
+	ret = copy_sve_reg_indices(vcpu, &uindices);
+	if (ret)
+		return ret;
+
 	ret = kvm_arm_copy_fw_reg_indices(vcpu, uindices);
 	if (ret)
 		return ret;
-- 
2.1.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
