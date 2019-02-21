Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5490BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:24:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25D272083E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NY7A8aqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D272083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zVI5oJILbzeqxgqdFMyjufHuIUih5DDnZFRyOhL0Y9o=; b=NY7A8aqTfURV8Q
	jW29N3TM20M6w20KpmCjnoX0BdHZqmoQAChpII1YF9M3xjOFmlAXrG71FQ36Okh+hkopz9svmbOsx
	/MPHG0x+P87G7bs6usamnARkseHKJlQiM0Ikbu+VGiCCWNzM8RmZTeEVpWgTHasqT/oESM1vx071o
	7uvOJssZTbxnrx2bv7ph02pKNTCx1SUBITxLdvs87rmsXnbIP0cljMytZwiIz1kxFxAXhJ1L90xdo
	/u4Dj9YS1VQczQ3CeLqEXJmxNOA+mAej1huIJDVSSeWb/BSqrugPfgOvWmdgEjhNdz7x7fHVMvnO2
	NdazWd1Il6EifkvxsGNg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwqCW-0003lF-8m; Thu, 21 Feb 2019 15:23:52 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqCS-0003kq-Lx
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 15:23:50 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1F1815AB;
 Thu, 21 Feb 2019 07:23:45 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47DDA3F5C1;
 Thu, 21 Feb 2019 07:23:43 -0800 (PST)
Subject: Re: [PATCH v5 18/26] KVM: arm64/sve: Add SVE support to register
 access ioctl interface
To: Dave Martin <Dave.Martin@arm.com>, kvmarm@lists.cs.columbia.edu
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
 <1550519559-15915-19-git-send-email-Dave.Martin@arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <f6d9f731-e9f8-a54d-1165-2b188e22b4df@arm.com>
Date: Thu, 21 Feb 2019 15:23:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1550519559-15915-19-git-send-email-Dave.Martin@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_072348_732439_CBC6A586 
X-CRM114-Status: GOOD (  36.62  )
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
> This patch adds the following registers for access via the
> KVM_{GET,SET}_ONE_REG interface:
> 
>  * KVM_REG_ARM64_SVE_ZREG(n, i) (n = 0..31) (in 2048-bit slices)
>  * KVM_REG_ARM64_SVE_PREG(n, i) (n = 0..15) (in 256-bit slices)
>  * KVM_REG_ARM64_SVE_FFR(i) (in 256-bit slices)
> 
> In order to adapt gracefully to future architectural extensions,
> the registers are logically divided up into slices as noted above:
> the i parameter denotes the slice index.
> 
> This allows us to reserve space in the ABI for future expansion of
> these registers.  However, as of today the architecture does not
> permit registers to be larger than a single slice, so no code is
> needed in the kernel to expose additional slices, for now.  The
> code can be extended later as needed to expose them up to a maximum
> of 32 slices (as carved out in the architecture itself) if they
> really exist someday.
> 
> The registers are only visible for vcpus that have SVE enabled.
> They are not enumerated by KVM_GET_REG_LIST on vcpus that do not
> have SVE.
> 
> Accesses to the FPSIMD registers via KVM_REG_ARM_CORE is not
> allowed for SVE-enabled vcpus: SVE-aware userspace can use the
> KVM_REG_ARM64_SVE_ZREG() interface instead to access the same
> register state.  This avoids some complex and pointless emulation
> in the kernel to convert between the two views of these aliased
> registers.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> 
> ---
> 
> Changes since v4:
> 
>  * Add "BASE" #defines for the Z-reg and P-reg ranges in the KVM
>    register ID space, to make the 0x400 magic number a little less
>    cryptic.
> 
>  * Pull KVM_SVE_{Z,P}REG_SIZE defines from "KVM: arm64: Enumerate SVE
>    register indices for KVM_GET_REG_LIST", since we now use them here.
> 
>  * Simplify sve_reg_region(), and give up on the attempt to make
>    kreg_region a general thing: nothing else will use it for now,
>    anyway, so let's keep it as simple as possible.
> 
>  * Drop support for multiple slices per register.  This functionality
>    can be added back in later if needed, without ABI breaks.
> 
>  * Pull vcpu_sve_state_size() into kvm_host.h, from "KVM: arm64/sve:
>    Allow userspace to enable SVE for vcpus".  This is needed for use
>    with array_index_nospec() to determine the applicable buffer bounds.
>    To avoid circular header deependency issues, the function is also
>    converted into a macro, but is otherwise equivalent to the original
>    version.
> 
>  * Guard sve_state base offset in kernel memory with
>    array_index_nospec(), since it is generated from user data that can
>    put it out of range.
> 
>    (sve_state will get allocated with the corresponding size later in
>    the series.  For now, this code is dormant since no means is
>    provided for userspace to create SVE-enabled vcpus yet.)
> ---
>  arch/arm64/include/asm/kvm_host.h |  14 ++++
>  arch/arm64/include/uapi/asm/kvm.h |  17 +++++
>  arch/arm64/kvm/guest.c            | 138 ++++++++++++++++++++++++++++++++++----
>  3 files changed, 157 insertions(+), 12 deletions(-)
> 

[...]

> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index f491456..8cfa889 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c

[...]

> @@ -211,6 +217,114 @@ static int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>  	return err;
>  }
>  
> +#define SVE_REG_SLICE_SHIFT	0
> +#define SVE_REG_SLICE_BITS	5
> +#define SVE_REG_ID_SHIFT	(SVE_REG_SLICE_SHIFT + SVE_REG_SLICE_BITS)
> +#define SVE_REG_ID_BITS		5
> +
> +#define SVE_REG_SLICE_MASK					\
> +	GENMASK(SVE_REG_SLICE_SHIFT + SVE_REG_SLICE_BITS - 1,	\
> +		SVE_REG_SLICE_SHIFT)
> +#define SVE_REG_ID_MASK							\
> +	GENMASK(SVE_REG_ID_SHIFT + SVE_REG_ID_BITS - 1, SVE_REG_ID_SHIFT)
> +
> +#define SVE_NUM_SLICES (1 << SVE_REG_SLICE_BITS)
> +
> +#define KVM_SVE_ZREG_SIZE KVM_REG_SIZE(KVM_REG_ARM64_SVE_ZREG(0, 0))
> +#define KVM_SVE_PREG_SIZE KVM_REG_SIZE(KVM_REG_ARM64_SVE_PREG(0, 0))
> +
> +struct sve_state_region {

This sve_state_region feels a bit too generic too me.

So far it is only used to access a single (slice of a) register at a
time. Is there a plan to use it for more?

Otherwise I'd suggest at least naming it something like sve_reg_region,
sve_reg_mem_region or sve_reg_mem_desc.


> +	unsigned int koffset;	/* offset into sve_state in kernel memory */
> +	unsigned int klen;	/* length in kernel memory */
> +	unsigned int upad;	/* extra trailing padding in user memory */
> +};
> +
> +/* Get sanitised bounds for user/kernel SVE register copy */
> +static int sve_reg_region(struct sve_state_region *region,

I feel that sve_reg_to_region or sve_reg_get_region would be a clearer name.

Cheers,

Julien

> +			  struct kvm_vcpu *vcpu,
> +			  const struct kvm_one_reg *reg)
> +{
> +	/* reg ID ranges for Z- registers */
> +	const u64 zreg_id_min = KVM_REG_ARM64_SVE_ZREG(0, 0);
> +	const u64 zreg_id_max = KVM_REG_ARM64_SVE_ZREG(SVE_NUM_ZREGS - 1,
> +						       SVE_NUM_SLICES - 1);
> +
> +	/* reg ID ranges for P- registers and FFR (which are contiguous) */
> +	const u64 preg_id_min = KVM_REG_ARM64_SVE_PREG(0, 0);
> +	const u64 preg_id_max = KVM_REG_ARM64_SVE_FFR(SVE_NUM_SLICES - 1);
> +
> +	unsigned int vq;
> +	unsigned int reg_num;
> +
> +	unsigned int reqoffset, reqlen; /* User-requested offset and length */
> +	unsigned int maxlen; /* Maxmimum permitted length */
> +
> +	size_t sve_state_size;
> +
> +	/* Only the first slice ever exists, for now: */
> +	if ((reg->id & SVE_REG_SLICE_MASK) != 0)
> +		return -ENOENT;
> +
> +	vq = sve_vq_from_vl(vcpu->arch.sve_max_vl);
> +
> +	reg_num = (reg->id & SVE_REG_ID_MASK) >> SVE_REG_ID_SHIFT;
> +
> +	if (reg->id >= zreg_id_min && reg->id <= zreg_id_max) {
> +		reqoffset = SVE_SIG_ZREG_OFFSET(vq, reg_num) -
> +				SVE_SIG_REGS_OFFSET;
> +		reqlen = KVM_SVE_ZREG_SIZE;
> +		maxlen = SVE_SIG_ZREG_SIZE(vq);
> +	} else if (reg->id >= preg_id_min && reg->id <= preg_id_max) {
> +		reqoffset = SVE_SIG_PREG_OFFSET(vq, reg_num) -
> +				SVE_SIG_REGS_OFFSET;
> +		reqlen = KVM_SVE_PREG_SIZE;
> +		maxlen = SVE_SIG_PREG_SIZE(vq);
> +	} else {
> +		return -ENOENT;
> +	}
> +
> +	sve_state_size = vcpu_sve_state_size(vcpu);
> +	if (!sve_state_size)
> +		return -EINVAL;
> +
> +	region->koffset = array_index_nospec(reqoffset, sve_state_size);
> +	region->klen = min(maxlen, reqlen);
> +	region->upad = reqlen - region->klen;
> +
> +	return 0;
> +}
> +
> +static int get_sve_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
> +{
> +	struct sve_state_region region;
> +	char __user *uptr = (char __user *)reg->addr;
> +
> +	if (!vcpu_has_sve(vcpu) || sve_reg_region(&region, vcpu, reg))
> +		return -ENOENT;
> +
> +	if (copy_to_user(uptr, vcpu->arch.sve_state + region.koffset,
> +			 region.klen) ||
> +	    clear_user(uptr + region.klen, region.upad))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +static int set_sve_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
> +{
> +	struct sve_state_region region;
> +	const char __user *uptr = (const char __user *)reg->addr;
> +
> +	if (!vcpu_has_sve(vcpu) || sve_reg_region(&region, vcpu, reg))
> +		return -ENOENT;
> +
> +	if (copy_from_user(vcpu->arch.sve_state + region.koffset, uptr,
> +			   region.klen))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
>  int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>  {
>  	return -EINVAL;
> @@ -371,12 +485,12 @@ int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>  	if ((reg->id & ~KVM_REG_SIZE_MASK) >> 32 != KVM_REG_ARM64 >> 32)
>  		return -EINVAL;
>  
> -	/* Register group 16 means we want a core register. */
> -	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_CORE)
> -		return get_core_reg(vcpu, reg);
> -
> -	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_FW)
> -		return kvm_arm_get_fw_reg(vcpu, reg);
> +	switch (reg->id & KVM_REG_ARM_COPROC_MASK) {
> +	case KVM_REG_ARM_CORE:	return get_core_reg(vcpu, reg);
> +	case KVM_REG_ARM_FW:	return kvm_arm_get_fw_reg(vcpu, reg);
> +	case KVM_REG_ARM64_SVE:	return get_sve_reg(vcpu, reg);
> +	default: break; /* fall through */
> +	}
>  
>  	if (is_timer_reg(reg->id))
>  		return get_timer_reg(vcpu, reg);
> @@ -390,12 +504,12 @@ int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>  	if ((reg->id & ~KVM_REG_SIZE_MASK) >> 32 != KVM_REG_ARM64 >> 32)
>  		return -EINVAL;
>  
> -	/* Register group 16 means we set a core register. */
> -	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_CORE)
> -		return set_core_reg(vcpu, reg);
> -
> -	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_FW)
> -		return kvm_arm_set_fw_reg(vcpu, reg);
> +	switch (reg->id & KVM_REG_ARM_COPROC_MASK) {
> +	case KVM_REG_ARM_CORE:	return set_core_reg(vcpu, reg);
> +	case KVM_REG_ARM_FW:	return kvm_arm_set_fw_reg(vcpu, reg);
> +	case KVM_REG_ARM64_SVE:	return set_sve_reg(vcpu, reg);
> +	default: break; /* fall through */
> +	}
>  
>  	if (is_timer_reg(reg->id))
>  		return set_timer_reg(vcpu, reg);
> 

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
