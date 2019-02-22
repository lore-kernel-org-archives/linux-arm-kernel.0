Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1090BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:05:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2C8920878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CRGPxT6R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2C8920878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TtR1x/yF25hdBSQKkplOpyGHKI4wJPO+6F32av9v0BI=; b=CRGPxT6R8hWAt6
	56Qccms/8+aEaUxZs9MayEz+p/7Z79a0p+1tcP5898uF61UDPuvaIv9+FB/FvKaUhKTjaspf6sq56
	UyRHWyTsjcUYf8dyixsdLjHSUhDSWuCFgrXy57j4q187RgGtPv1JQmB97t/QSEYXFe0+fEcGdislH
	FainrpxAGv64PVxscDhnWg0pYOtFRnEI5R+M6V+PtlM5Jb7+eKgRbzV9aWZ6OAs5zCkkL4DleHpeD
	BxC12N+gGyfmO+2OSakLzgqNwCquU79uC2IB8mgv3LwZdo2R25zx3TEOnOuwQ2zw76uAVLz14Lx/q
	KS9S7w+wj8uS1C9LuG6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx6lo-0004Sd-HO; Fri, 22 Feb 2019 09:05:24 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx6ll-0004SH-B4
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 09:05:22 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A695380D;
 Fri, 22 Feb 2019 01:05:20 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 034343F703;
 Fri, 22 Feb 2019 01:05:18 -0800 (PST)
Subject: Re: [PATCH v5 23/26] KVM: arm64/sve: Allow userspace to enable SVE
 for vcpus
To: Dave Martin <Dave.Martin@arm.com>, kvmarm@lists.cs.columbia.edu
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
 <1550519559-15915-24-git-send-email-Dave.Martin@arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <88f7a00d-019a-5ed3-5a80-6032775dc5c5@arm.com>
Date: Fri, 22 Feb 2019 09:05:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1550519559-15915-24-git-send-email-Dave.Martin@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_010521_393621_6E386C82 
X-CRM114-Status: GOOD (  26.05  )
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
> Now that all the pieces are in place, this patch offers a new flag
> KVM_ARM_VCPU_SVE that userspace can pass to KVM_ARM_VCPU_INIT to
> turn on SVE for the guest, on a per-vcpu basis.
> 
> As part of this, support for initialisation and reset of the SVE
> vector length set and registers is added in the appropriate places.
> Allocation SVE registers is deferred until kvm_arm_vcpu_finalize(),
> by which time the size of the registers is known.
> 
> Setting the vector lengths supported by the vcpu is considered
> configuration of the emulated hardware rather than runtime
> configuration, so no support is offered for changing the vector
> lengths of an existing vcpu across reset.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> 
> ---
> 
> Changes since v4:
> 
>  * Pull out vcpu_sve_state_size(), for use earlier in the series.
> 
>  * Remove unnecessary vcpu->arch.sve_vqs[], and clamp maximum guest
>    vector length to 256 bytes for forwards compatibility.
> 
>    (See "KVM: arm64/sve: Add pseudo-register for the guest's vector
>    lengths".)
> 
>  * Minor tidyups to make some checks less verbose.
> ---
>  arch/arm64/include/asm/kvm_host.h |  2 +-
>  arch/arm64/include/uapi/asm/kvm.h |  1 +
>  arch/arm64/kvm/reset.c            | 70 ++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 71 insertions(+), 2 deletions(-)
> 

[...]

> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> index 7ff1bd4..6963b7e 100644
> --- a/arch/arm64/include/uapi/asm/kvm.h
> +++ b/arch/arm64/include/uapi/asm/kvm.h
> @@ -102,6 +102,7 @@ struct kvm_regs {
>  #define KVM_ARM_VCPU_EL1_32BIT		1 /* CPU running a 32bit VM */
>  #define KVM_ARM_VCPU_PSCI_0_2		2 /* CPU uses PSCI v0.2 */
>  #define KVM_ARM_VCPU_PMU_V3		3 /* Support guest PMUv3 */
> +#define KVM_ARM_VCPU_SVE		4 /* enable SVE for this CPU */
>  
>  struct kvm_vcpu_init {
>  	__u32 target;
> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> index 1379fb2..e67cd2e 100644
> --- a/arch/arm64/kvm/reset.c
> +++ b/arch/arm64/kvm/reset.c

[...]

> @@ -98,11 +100,69 @@ int kvm_arch_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  	return r;
>  }
>  
> +static int kvm_reset_sve(struct kvm_vcpu *vcpu)
> +{
> +	if (!system_supports_sve())
> +		return -EINVAL;
> +
> +	/* If resetting an already-configured vcpu, just zero the SVE regs: */
> +	if (vcpu->arch.sve_state) {
> +		size_t size = vcpu_sve_state_size(vcpu);
> +
> +		if (!size || WARN_ON(!vcpu_has_sve(vcpu)))
> +			return -EINVAL;
> +
> +		memset(vcpu->arch.sve_state, 0, size);
> +		return 0;
> +	}
> +
> +	if (WARN_ON(!sve_vl_valid(sve_max_vl)))
> +		return -EINVAL;
> +
> +	/* If the full set of host vector lengths cannot be used, give up: */
> +	if (sve_max_virtualisable_vl < sve_max_vl)
> +		return -EINVAL;
> +
> +	/* Default to the set of vector lengths supported by the host */
> +	vcpu->arch.sve_max_vl = sve_max_vl;
> +
> +	/*
> +	 * The get_sve_reg()/set_sve_reg() ioctl interface will need
> +	 * to be extended with multiple register slice support in
> +	 * order to support vector lengths greater than
> +	 * SVE_VL_ARCH_MAX:
> +	 */
> +	if (WARN_ONCE(vcpu->arch.sve_max_vl > SVE_VL_ARCH_MAX,
> +		      "KVM: SVE vector length for guests limited to %d bytes\n",
> +		      SVE_VL_ARCH_MAX))
> +		vcpu->arch.sve_max_vl = SVE_VL_ARCH_MAX;
> +
> +	/*
> +	 * Userspace can still customize the vector lengths by writing
> +	 * KVM_REG_ARM64_SVE_VLS.  Allocation is deferred until
> +	 * kvm_arm_vcpu_finalize(), which freezes the configuration.
> +	 */
> +	vcpu->arch.flags |= KVM_ARM64_GUEST_HAS_SVE;
> +
> +	return 0;
> +}
> +
>  int kvm_arm_vcpu_finalize(struct kvm_vcpu *vcpu)
>  {
>  	if (likely(kvm_arm_vcpu_finalized(vcpu)))
>  		return 0;
>  
> +	if (vcpu_has_sve(vcpu)) {
> +		size_t size = vcpu_sve_state_size(vcpu);
> +
> +		if (!size)
> +			return -EINVAL;
> +
> +		vcpu->arch.sve_state = kzalloc(size, GFP_KERNEL);

We should probably free this in kvm_arch_vcpu_free().

Cheers,

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
