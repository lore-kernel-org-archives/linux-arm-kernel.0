Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F74EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:49:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3051320818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sqJOr6zU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3051320818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sFFVpWF+tXlPfu2tIscD2r2EAfAqRYOhbpfzsKvVsuQ=; b=sqJOr6zUZ1+gcw
	CCUvs+BpesdM+73hFJSzGC0OYQqNhSoFrGCxl7qT1gFuIS7Qj41qXRX/fGVQaKSzScWJBIB3L9TUu
	bTw7nTcMe400ztoPL+tuiBkbROhPi6CE8Ur2NNkgvv4iqxj4b8z6dXdZn+fPeJjo7ZIl+pbYw9+YI
	U/kCALmWc29j2DhzoKO0cXZdjd97aHNL6/ZhR6Ua86JyMQvWzSmXBMTGH+hanZw+32h0O37tLtk+r
	xKWGgBQWTAdG4+ox4hxVy82URRy/Sx0vmnvjC8koaDHLYyps6wOTRKZ1fs3ov6KsUN2CVAH4nTfpq
	FRP4aHFTRsHeCzmNB5Fw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwsTA-00018w-Eh; Thu, 21 Feb 2019 17:49:12 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwsT6-00018E-HI
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 17:49:10 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E36180D;
 Thu, 21 Feb 2019 09:49:08 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BBFF3F5C1;
 Thu, 21 Feb 2019 09:49:02 -0800 (PST)
Subject: Re: [PATCH v5 22/26] KVM: arm64/sve: Add pseudo-register for the
 guest's vector lengths
To: Dave Martin <Dave.Martin@arm.com>, kvmarm@lists.cs.columbia.edu
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
 <1550519559-15915-23-git-send-email-Dave.Martin@arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <34b7691f-7acb-c9aa-6e53-2857e429f148@arm.com>
Date: Thu, 21 Feb 2019 17:48:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1550519559-15915-23-git-send-email-Dave.Martin@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_094908_585404_B6CA2877 
X-CRM114-Status: GOOD (  39.33  )
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
Cc: Okamoto Takayuki <tokamoto@jp.fujitsu.com>,
 Christoffer Dall <cdall@kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Zhang Lei <zhang.lei@jp.fujitsu.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Dave,

On 18/02/2019 19:52, Dave Martin wrote:
> This patch adds a new pseudo-register KVM_REG_ARM64_SVE_VLS to
> allow userspace to set and query the set of vector lengths visible
> to the guest, along with corresponding storage in struct
> kvm_vcpu_arch.
> 
> In the future, multiple register slices per SVE register may be
> visible through the ioctl interface.  Once the set of slices has
> been determined we would not be able to allow the vector length set
> to be changed any more, in order to avoid userspace seeing
> inconsistent sets of registers.  For this reason, this patch adds
> support to track vcpu finalization explicitly, and enforce proper
> sequencing of ioctls.
> 
> The new pseudo-register is not exposed yet.  Subsequent patches
> will allow SVE to be turned on for guest vcpus, making it visible.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> 
> ---
> 
> Changes since v4:
> 
>  * Add a UAPI header comment indicating the pseudo-register status of
>    KVM_REG_ARM64_SVE_VLS.
> 
>  * Get rid of the sve_vqs[] array from struct kvm_vcpu_arch.  This
>    array is pointless, because its contents must match the host's
>    internal sve_vq_map anyway, up to vcpu->arch.sve_max_vl.
> 
>    The ioctl register accessors are slow-path code, so we can decode
>    or reconstruct sve_vqs[] on demand instead, for exchange with
>    userspace.
> 
>  * For compatibility with potential future architecture extensions,
>    enabling vector lengths above 256 bytes for the guest is explicitly
>    disallowed now (because the code for exposing additional bits
>    through ioctl is currently missing).  This can be addressed later
>    if/when needed.
> 
> Note:
> 
>  * I defensively pass an array by pointer here, to help avoid
>    accidentally breaking assumptions during future maintenance.
> 
>    Due to (over?)zealous constification, this causes the following
>    sparse warning.  I think this is sparse getting confused: I am not
>    relying on any kernel-specific semantics here, and GCC generates no
>    warning.
> 
> +arch/arm64/kvm/guest.c:33: warning: incorrect type in argument 1 (different modifiers)
> +arch/arm64/kvm/guest.c:33:    expected unsigned long long const [usertype] ( *const vqs )[8]
> +arch/arm64/kvm/guest.c:33:    got unsigned long long [usertype] ( * )[8]
> 
> ---
>  arch/arm64/include/asm/kvm_host.h |   7 ++-
>  arch/arm64/include/uapi/asm/kvm.h |   4 ++
>  arch/arm64/kvm/guest.c            | 124 ++++++++++++++++++++++++++++++++++++--
>  arch/arm64/kvm/reset.c            |   9 +++
>  4 files changed, 136 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 015c2578..e53119a 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -24,6 +24,7 @@
>  
>  #include <linux/bitmap.h>
>  #include <linux/types.h>
> +#include <linux/kernel.h>
>  #include <linux/kvm_types.h>
>  #include <asm/cpufeature.h>
>  #include <asm/daifflags.h>
> @@ -331,6 +332,7 @@ struct kvm_vcpu_arch {
>  #define KVM_ARM64_HOST_SVE_IN_USE	(1 << 3) /* backup for host TIF_SVE */
>  #define KVM_ARM64_HOST_SVE_ENABLED	(1 << 4) /* SVE enabled for EL0 */
>  #define KVM_ARM64_GUEST_HAS_SVE		(1 << 5) /* SVE exposed to guest */
> +#define KVM_ARM64_VCPU_FINALIZED	(1 << 6) /* vcpu config completed */
>  
>  #define vcpu_has_sve(vcpu) (system_supports_sve() && \
>  			    ((vcpu)->arch.flags & KVM_ARM64_GUEST_HAS_SVE))
> @@ -554,7 +556,8 @@ void kvm_arch_free_vm(struct kvm *kvm);
>  int kvm_arm_setup_stage2(struct kvm *kvm, unsigned long type);
>  
>  /* Commit to the set of vcpu registers currently configured: */
> -static inline int kvm_arm_vcpu_finalize(struct kvm_vcpu *vcpu) { return 0; }
> -#define kvm_arm_vcpu_finalized(vcpu) true
> +int kvm_arm_vcpu_finalize(struct kvm_vcpu *vcpu);
> +#define kvm_arm_vcpu_finalized(vcpu) \
> +	((vcpu)->arch.flags & KVM_ARM64_VCPU_FINALIZED)
>  
>  #endif /* __ARM64_KVM_HOST_H__ */
> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> index ced760c..7ff1bd4 100644
> --- a/arch/arm64/include/uapi/asm/kvm.h
> +++ b/arch/arm64/include/uapi/asm/kvm.h
> @@ -243,6 +243,10 @@ struct kvm_vcpu_events {
>  					 ((n) << 5) | (i))
>  #define KVM_REG_ARM64_SVE_FFR(i)	KVM_REG_ARM64_SVE_PREG(16, i)
>  
> +/* Vector lengths pseudo-register: */
> +#define KVM_REG_ARM64_SVE_VLS		(KVM_REG_ARM64 | KVM_REG_ARM64_SVE | \
> +					 KVM_REG_SIZE_U512 | 0xffff)
> +
>  /* Device Control API: ARM VGIC */
>  #define KVM_DEV_ARM_VGIC_GRP_ADDR	0
>  #define KVM_DEV_ARM_VGIC_GRP_DIST_REGS	1
> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index 4a2ad60..5f48c17 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c
> @@ -217,6 +217,81 @@ static int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>  	return err;
>  }
>  
> +#define vq_word(vq) (((vq) - SVE_VQ_MIN) / 64)
> +#define vq_mask(vq) ((u64)1 << ((vq) - SVE_VQ_MIN) % 64)
> +
> +static bool vq_present(
> +	const u64 (*const vqs)[DIV_ROUND_UP(SVE_VQ_MAX - SVE_VQ_MIN + 1, 64)],
> +	unsigned int vq)
> +{
> +	return (*vqs)[vq_word(vq)] & vq_mask(vq);
> +}
> +
> +static int get_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
> +{
> +	unsigned int max_vq, vq;
> +	u64 vqs[DIV_ROUND_UP(SVE_VQ_MAX - SVE_VQ_MIN + 1, 64)];
> +
> +	if (WARN_ON(!sve_vl_valid(vcpu->arch.sve_max_vl)))
> +		return -EINVAL;
> +
> +	memset(vqs, 0, sizeof(vqs));
> +
> +	max_vq = sve_vq_from_vl(vcpu->arch.sve_max_vl);
> +	for (vq = SVE_VQ_MIN; vq <= max_vq; ++vq)
> +		if (sve_vq_available(vq))
> +			vqs[vq_word(vq)] |= vq_mask(vq);
> +
> +	BUILD_BUG_ON(sizeof(vqs) != KVM_REG_SIZE(reg->id));

reg->id is not know at build time. From my understanding of
BUILD_BUG_ON(), things actually ends up evaluated at runtime but I'm not
sure what happens when doing sizeof(char[1- 2*0]) at runtime.

Anyway, I don't think this is intended.

> +	if (copy_to_user((void __user *)reg->addr, vqs, sizeof(vqs)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +static int set_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
> +{
> +	unsigned int max_vq, vq;
> +	u64 vqs[DIV_ROUND_UP(SVE_VQ_MAX - SVE_VQ_MIN + 1, 64)];
> +
> +	if (kvm_arm_vcpu_finalized(vcpu))
> +		return -EPERM; /* too late! */
> +
> +	if (WARN_ON(vcpu->arch.sve_state))
> +		return -EINVAL;
> +
> +	BUILD_BUG_ON(sizeof(vqs) != KVM_REG_SIZE(reg->id));

Same as above.

> +	if (copy_from_user(vqs, (const void __user *)reg->addr, sizeof(vqs)))
> +		return -EFAULT;
> +
> +	max_vq = 0;
> +	for (vq = SVE_VQ_MIN; vq <= SVE_VQ_MAX; ++vq)
> +		if (vq_present(&vqs, vq))
> +			max_vq = vq;
> +
> +	/*
> +	 * The get_sve_reg()/set_sve_reg() ioctl interface will need
> +	 * to be extended with multiple register slice support in
> +	 * order to support vector lengths greater than
> +	 * SVE_VL_ARCH_MAX:
> +	 */
> +	if (WARN_ONCE(sve_vl_from_vq(max_vq) > SVE_VL_ARCH_MAX,
> +		      "KVM: Requested vector length not supported yet\n"))
> +		return -EINVAL;
> +
> +	for (vq = SVE_VQ_MIN; vq <= max_vq; ++vq)
> +		if (vq_present(&vqs, vq) != sve_vq_available(vq))
> +			return -EINVAL;
> +
> +	/* Can't run with no vector lengths at all: */
> +	if (max_vq < SVE_VQ_MIN)
> +		return -EINVAL;
> +
> +	vcpu->arch.sve_max_vl = sve_vl_from_vq(max_vq);
> +
> +	return 0;
> +}
> +
>  #define SVE_REG_SLICE_SHIFT	0
>  #define SVE_REG_SLICE_BITS	5
>  #define SVE_REG_ID_SHIFT	(SVE_REG_SLICE_SHIFT + SVE_REG_SLICE_BITS)
> @@ -297,9 +372,21 @@ static int sve_reg_region(struct sve_state_region *region,
>  static int get_sve_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>  {
>  	struct sve_state_region region;
> +	int ret;
>  	char __user *uptr = (char __user *)reg->addr;
>  
> -	if (!vcpu_has_sve(vcpu) || sve_reg_region(&region, vcpu, reg))
> +	if (!vcpu_has_sve(vcpu))
> +		return -ENOENT;
> +
> +	if (reg->id == KVM_REG_ARM64_SVE_VLS)
> +		return get_sve_vls(vcpu, reg);
> +
> +	/* Finalize the number of slices per SVE register: */
> +	ret = kvm_arm_vcpu_finalize(vcpu);

Having this here feels a bit random...

I'd suggest considering the pseudo-register outside of the SVE co-proc,
as part of a set of registers that do not finalize a vcpu when accessed.
All other registers (even non-sve ones) would finalize the vcpu when
accessed from userland.

Does that make sense?


> +	if (ret)
> +		return ret;
> +
> +	if (sve_reg_region(&region, vcpu, reg))
>  		return -ENOENT;
>  
>  	if (copy_to_user(uptr, vcpu->arch.sve_state + region.koffset,
> @@ -313,9 +400,21 @@ static int get_sve_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>  static int set_sve_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>  {
>  	struct sve_state_region region;
> +	int ret;
>  	const char __user *uptr = (const char __user *)reg->addr;
>  
> -	if (!vcpu_has_sve(vcpu) || sve_reg_region(&region, vcpu, reg))
> +	if (!vcpu_has_sve(vcpu))
> +		return -ENOENT;
> +
> +	if (reg->id == KVM_REG_ARM64_SVE_VLS)
> +		return set_sve_vls(vcpu, reg);
> +
> +	/* Finalize the number of slices per SVE register: */
> +	ret = kvm_arm_vcpu_finalize(vcpu);
> +	if (ret)
> +		return ret;
> +
> +	if (sve_reg_region(&region, vcpu, reg))
>  		return -ENOENT;
>  
>  	if (copy_from_user(vcpu->arch.sve_state + region.koffset, uptr,
> @@ -452,30 +551,43 @@ static unsigned long num_sve_regs(const struct kvm_vcpu *vcpu)
>  	if (!vcpu_has_sve(vcpu))
>  		return 0;
>  
> -	return slices * (SVE_NUM_PREGS + SVE_NUM_ZREGS + 1 /* FFR */);
> +	return slices * (SVE_NUM_PREGS + SVE_NUM_ZREGS + 1 /* FFR */)
> +		+ 1; /* KVM_REG_ARM64_SVE_VLS */
>  }
>  
>  static int copy_sve_reg_indices(const struct kvm_vcpu *vcpu, u64 __user **uind)
>  {
>  	/* Only the first slice ever exists, for now */
>  	const unsigned int slices = 1;
> +	u64 reg;
>  	unsigned int i, n;
>  
>  	if (!vcpu_has_sve(vcpu))
>  		return 0;
>  
> +	/*
> +	 * Enumerate this first, so that userspace can save/restore in
> +	 * the order reported by KVM_GET_REG_LIST:
> +	 */
> +	reg = KVM_REG_ARM64_SVE_VLS;
> +	if (put_user(reg, (*uind)++))
> +		return -EFAULT;
> +
>  	for (i = 0; i < slices; i++) {
>  		for (n = 0; n < SVE_NUM_ZREGS; n++) {
> -			if (put_user(KVM_REG_ARM64_SVE_ZREG(n, i), (*uind)++))
> +			reg = KVM_REG_ARM64_SVE_ZREG(n, i);
> +			if (put_user(reg, (*uind)++))
>  				return -EFAULT;
>  		}
>  
>  		for (n = 0; n < SVE_NUM_PREGS; n++) {
> -			if (put_user(KVM_REG_ARM64_SVE_PREG(n, i), (*uind)++))
> +			reg = KVM_REG_ARM64_SVE_PREG(n, i);
> +			if (put_user(reg, (*uind)++))
>  				return -EFAULT;
>  		}
>  
> -		if (put_user(KVM_REG_ARM64_SVE_FFR(i), (*uind)++))
> +		reg = KVM_REG_ARM64_SVE_FFR(i);
> +		if (put_user(reg, (*uind)++))
>  			return -EFAULT;
>  	}
>  
> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> index b72a3dd..1379fb2 100644
> --- a/arch/arm64/kvm/reset.c
> +++ b/arch/arm64/kvm/reset.c
> @@ -98,6 +98,15 @@ int kvm_arch_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  	return r;
>  }
>  
> +int kvm_arm_vcpu_finalize(struct kvm_vcpu *vcpu)
> +{
> +	if (likely(kvm_arm_vcpu_finalized(vcpu)))
> +		return 0;
> +
> +	vcpu->arch.flags |= KVM_ARM64_VCPU_FINALIZED;
> +	return 0;
> +}
> +

I think that the introduction of this flag and setting it should be part
of the previous patch.

Cheers,

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
