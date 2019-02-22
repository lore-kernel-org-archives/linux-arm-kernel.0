Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5216C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:33:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 779F3206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ECyabzAT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 779F3206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2p1IWSIV2co5gHmARTvSerNoKEUDCHaMf3T9KAPSD7A=; b=ECyabzATuFZmcm
	MHDsfq1XIhK2P9BzdEx5G1uvyB/1ZP0i8/BWzvcUMqSN8jicjhZWD/quZi+WY3B+KbQvqEyHfIlet
	2SdT9N8+EQYMEODOpx5xBfEhcMTp9pQJRNfWR9V7ihI+CvDS5U6kkLmuzStSeWDKyoa/ViR5ypPLI
	hf6yrp4qKIVtC9/xW8tkDcJZeyBVPgcQ0MIq2fjqIkUYp31e9DqTBF/z+VA5kfx8qAthm6Na2/x1r
	Y4fSHLIqlrbgHqDva54xWhxyyPmOmcKpgCH1Q46mvO0wLmOXgZ87vLShkHpTTCC54Cz4fI31a12jU
	FRrH9XkyWpovmBqF0RXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxFdH-0003uB-IP; Fri, 22 Feb 2019 18:33:11 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxFdD-0003tp-23
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 18:33:09 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9711980D;
 Fri, 22 Feb 2019 10:33:04 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F2C13F5C1;
 Fri, 22 Feb 2019 10:33:03 -0800 (PST)
Date: Fri, 22 Feb 2019 18:32:27 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v3 1/2] KVM: arm/arm64: Add save/restore support for
 firmware workaround state
Message-ID: <20190222183227.1a78f998@donnerap.cambridge.arm.com>
In-Reply-To: <20190222172236.GC3567@e103592.cambridge.arm.com>
References: <20190222121818.30164-1-andre.przywara@arm.com>
 <20190222121818.30164-2-andre.przywara@arm.com>
 <20190222172236.GC3567@e103592.cambridge.arm.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_103307_112708_439FDAA3 
X-CRM114-Status: GOOD (  44.30  )
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
Cc: kvm@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Steven Price <steven.price@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 22 Feb 2019 17:22:37 +0000
Dave Martin <Dave.Martin@arm.com> wrote:

Hi Dave,

thanks for having a look!

> On Fri, Feb 22, 2019 at 12:18:17PM +0000, Andre Przywara wrote:
> > KVM implements the firmware interface for mitigating cache speculation
> > vulnerabilities. Guests may use this interface to ensure mitigation is
> > active.
> > If we want to migrate such a guest to a host with a different support
> > level for those workarounds, migration might need to fail, to ensure that
> > critical guests don't loose their protection.
> > 
> > Introduce a way for userland to save and restore the workarounds state.
> > On restoring we do checks that make sure we don't downgrade our
> > mitigation level.
> > 
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  arch/arm/include/asm/kvm_emulate.h   |  10 +++
> >  arch/arm/include/uapi/asm/kvm.h      |  10 +++
> >  arch/arm64/include/asm/kvm_emulate.h |  14 ++++
> >  arch/arm64/include/uapi/asm/kvm.h    |   9 ++
> >  virt/kvm/arm/psci.c                  | 119 +++++++++++++++++++++++----
> >  5 files changed, 146 insertions(+), 16 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
> > index 8927cae7c966..663a02d7e6f4 100644
> > --- a/arch/arm/include/asm/kvm_emulate.h
> > +++ b/arch/arm/include/asm/kvm_emulate.h
> > @@ -283,6 +283,16 @@ static inline unsigned long kvm_vcpu_get_mpidr_aff(struct kvm_vcpu *vcpu)
> >  	return vcpu_cp15(vcpu, c0_MPIDR) & MPIDR_HWID_BITMASK;
> >  }
> >  
> > +static inline bool kvm_arm_get_vcpu_workaround_2_flag(struct kvm_vcpu *vcpu)
> > +{
> > +	return false;
> > +}
> > +
> > +static inline void kvm_arm_set_vcpu_workaround_2_flag(struct kvm_vcpu *vcpu,
> > +						      bool flag)
> > +{
> > +}
> > +
> >  static inline void kvm_vcpu_set_be(struct kvm_vcpu *vcpu)
> >  {
> >  	*vcpu_cpsr(vcpu) |= PSR_E_BIT;
> > diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
> > index 4602464ebdfb..ba4d2afe65e3 100644
> > --- a/arch/arm/include/uapi/asm/kvm.h
> > +++ b/arch/arm/include/uapi/asm/kvm.h
> > @@ -214,6 +214,16 @@ struct kvm_vcpu_events {
> >  #define KVM_REG_ARM_FW_REG(r)		(KVM_REG_ARM | KVM_REG_SIZE_U64 | \
> >  					 KVM_REG_ARM_FW | ((r) & 0xffff))
> >  #define KVM_REG_ARM_PSCI_VERSION	KVM_REG_ARM_FW_REG(0)
> > +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1	KVM_REG_ARM_FW_REG(1)
> > +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_AVAIL	0
> > +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_AVAIL	1
> > +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_UNAFFECTED	2
> > +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2	KVM_REG_ARM_FW_REG(2)
> > +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_AVAIL	0
> > +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_UNKNOWN	1
> > +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_AVAIL	2
> > +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_UNAFFECTED	3
> > +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_ENABLED	(1U << 4)  
> 
> Why 4?  How could the system be less affected than "UNAFFECTED"?  (And
> if not, why do we need space to insert extra values?)  Mixing read-only
> system-description info with mutable guest state in this register feels
> a bit odd, but we probably don't win much by making it a separate
> register either.

For workaround 2 the guest has the ability to opt out of the (costly)
mitigation. This bit 4 holds that state for the VCPU. As this is somewhat orthogonal to the *level*, I didn't want to fiddle this bit into the encoding.

> Possibly we could drop the _REG from the #defines that are not reg IDs,
> since KVM_REG_* are all reg IDs today.
> 
> But it works either way.
> 
> 
> Without a clear definition of what these values mean, I worry about ABI
> drift.  But if we don't expect these to evolve it's probably low-risk.

See the Documentation patch. I found it odd to have it first in the
series, describing something that is not yet implemented.

> >  /* Device Control API: ARM VGIC */
> >  #define KVM_DEV_ARM_VGIC_GRP_ADDR	0
> > diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> > index d3842791e1c4..c00c17c9adb6 100644
> > --- a/arch/arm64/include/asm/kvm_emulate.h
> > +++ b/arch/arm64/include/asm/kvm_emulate.h
> > @@ -348,6 +348,20 @@ static inline unsigned long kvm_vcpu_get_mpidr_aff(struct kvm_vcpu *vcpu)
> >  	return vcpu_read_sys_reg(vcpu, MPIDR_EL1) & MPIDR_HWID_BITMASK;
> >  }
> >  
> > +static inline bool kvm_arm_get_vcpu_workaround_2_flag(struct kvm_vcpu *vcpu)
> > +{
> > +	return vcpu->arch.workaround_flags & VCPU_WORKAROUND_2_FLAG;
> > +}
> > +
> > +static inline void kvm_arm_set_vcpu_workaround_2_flag(struct kvm_vcpu *vcpu,
> > +						      bool flag)
> > +{
> > +	if (flag)
> > +		vcpu->arch.workaround_flags |= VCPU_WORKAROUND_2_FLAG;
> > +	else
> > +		vcpu->arch.workaround_flags &= ~VCPU_WORKAROUND_2_FLAG;
> > +}
> > +
> >  static inline void kvm_vcpu_set_be(struct kvm_vcpu *vcpu)
> >  {
> >  	if (vcpu_mode_is_32bit(vcpu)) {
> > diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> > index 97c3478ee6e7..367e96fe654e 100644
> > --- a/arch/arm64/include/uapi/asm/kvm.h
> > +++ b/arch/arm64/include/uapi/asm/kvm.h
> > @@ -225,6 +225,15 @@ struct kvm_vcpu_events {
> >  #define KVM_REG_ARM_FW_REG(r)		(KVM_REG_ARM64 | KVM_REG_SIZE_U64 | \
> >  					 KVM_REG_ARM_FW | ((r) & 0xffff))
> >  #define KVM_REG_ARM_PSCI_VERSION	KVM_REG_ARM_FW_REG(0)
> > +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1	KVM_REG_ARM_FW_REG(1)
> > +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_AVAIL	0
> > +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_AVAIL	1
> > +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2	KVM_REG_ARM_FW_REG(2)
> > +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_AVAIL	0
> > +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_UNKNOWN	1
> > +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_AVAIL	2
> > +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_UNAFFECTED	3
> > +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_ENABLED     (1U << 4)
> >  
> >  /* Device Control API: ARM VGIC */
> >  #define KVM_DEV_ARM_VGIC_GRP_ADDR	0
> > diff --git a/virt/kvm/arm/psci.c b/virt/kvm/arm/psci.c
> > index 9b73d3ad918a..97d2d13756f6 100644
> > --- a/virt/kvm/arm/psci.c
> > +++ b/virt/kvm/arm/psci.c
> > @@ -445,42 +445,97 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
> >  
> >  int kvm_arm_get_fw_num_regs(struct kvm_vcpu *vcpu)
> >  {
> > -	return 1;		/* PSCI version */
> > +	return 3;		/* PSCI version and two workaround registers */  
> 
> Meh.  But this is no worse than the way we do it elsewhere.
> 
> >  }
> >  
> >  int kvm_arm_copy_fw_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
> >  {
> > -	if (put_user(KVM_REG_ARM_PSCI_VERSION, uindices))
> > +	if (put_user(KVM_REG_ARM_PSCI_VERSION, uindices++))
> >  		return -EFAULT;
> >  
> > +	if (put_user(KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1, uindices++))
> > +		return -EFAULT;
> > +
> > +	if (put_user(KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2, uindices++))
> > +		return -EFAULT;
> > +
> > +	return 0;
> > +}
> > +
> > +#define KVM_REG_FEATURE_LEVEL_WIDTH	4
> > +#define KVM_REG_FEATURE_LEVEL_MASK	(BIT(KVM_REG_FEATURE_LEVEL_WIDTH) - 1)  
> 
> Nit: Maybe use GENMASK?

Yeah, but it would need to be GENMASK(KVM_REG_FEATURE_LEVEL_WIDTH - 1, 0),
which is not really more readable, also breaks 80 columns ;-)

> > +
> > +/*
> > + * Convert the workaround level into an easy-to-compare number, where
> > higher
> > + * values mean better protection.
> > + */
> > +static int get_kernel_wa_level(u64 regid)
> > +{
> > +	switch (regid) {
> > +	case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1:
> > +		if (kvm_arm_harden_branch_predictor())
> > +			return
> > KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_AVAIL;
> > +		else
> > +			return
> > KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_AVAIL;
> > +	case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2:
> > +		switch (kvm_arm_have_ssbd()) {
> > +		case KVM_SSBD_FORCE_DISABLE:
> > +			return
> > KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_AVAIL;
> > +		case KVM_SSBD_KERNEL:
> > +			return
> > KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_AVAIL;
> > +		case KVM_SSBD_FORCE_ENABLE:
> > +		case KVM_SSBD_MITIGATED:
> > +			return
> > KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_UNAFFECTED;
> > +		case KVM_SSBD_UNKNOWN:
> > +		default:
> > +			return
> > KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_UNKNOWN;
> > +		}
> > +	}
> > +
> >  	return 0;
> >  }
> >  
> >  int kvm_arm_get_fw_reg(struct kvm_vcpu *vcpu, const struct
> > kvm_one_reg *reg) {
> > -	if (reg->id == KVM_REG_ARM_PSCI_VERSION) {
> > -		void __user *uaddr = (void __user *)(long)reg->addr;
> > -		u64 val;
> > +	void __user *uaddr = (void __user *)(long)reg->addr;  
> 
> (Why (long), I wonder?  Anyway, no bother.)

Just copied from above. You need some cast to a pointer-sized integer for
32-bit. uintptr_t doesn't seem too popular in the kernel.
 
> > +	u64 val;
> >  
> > +	switch (reg->id) {
> > +	case KVM_REG_ARM_PSCI_VERSION:
> >  		val = kvm_psci_version(vcpu, vcpu->kvm);
> > -		if (copy_to_user(uaddr, &val, KVM_REG_SIZE(reg->id)))
> > -			return -EFAULT;
> > -
> > -		return 0;
> > +		break;
> > +	case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1:
> > +		val = get_kernel_wa_level(reg->id) &
> > KVM_REG_FEATURE_LEVEL_MASK;
> > +		break;
> > +	case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2:
> > +		val = get_kernel_wa_level(reg->id) &
> > KVM_REG_FEATURE_LEVEL_MASK;
> > +		if (kvm_arm_have_ssbd() == KVM_SSBD_KERNEL &&
> > +		    kvm_arm_get_vcpu_workaround_2_flag(vcpu))
> > +			val |=
> > KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_ENABLED;
> > +		break;
> > +	default:
> > +		return -EINVAL;  
> 
> Hmmm, it could be more reasonable to return -ENOENT.  But this precedent
> may be established now.

Good point. For non-existent sysregs we return -ENOENT, indeed. So I think
we should follow this here as well. Don't think it's a regression to
switch now.

> Anyway, userspace is unlikely to make any useful distinction between
> these two errors.
> 
> >  	}
> >  
> > -	return -EINVAL;  
> 
> You could try a BUILD_BUG_ON(KVM_REG_SIZE(reg->id) == sizeof(val)).
> 
> I suspect gcc may not be quite bright enough to spot that condition is
> compiletime-constant, but if it does then so much the better.
> 
> Not sure it's worth a runtime check though.

Do we rely on them being 64 bit, actually? Not sure we would be checking
something useful here.

> > +	if (copy_to_user(uaddr, &val, KVM_REG_SIZE(reg->id)))
> > +		return -EFAULT;
> > +
> > +	return 0;
> >  }
> >  
> >  int kvm_arm_set_fw_reg(struct kvm_vcpu *vcpu, const struct
> > kvm_one_reg *reg) {
> > -	if (reg->id == KVM_REG_ARM_PSCI_VERSION) {
> > -		void __user *uaddr = (void __user *)(long)reg->addr;
> > -		bool wants_02;
> > -		u64 val;
> > +	void __user *uaddr = (void __user *)(long)reg->addr;
> > +	u64 val;
> > +	int wa_level;
> > +
> > +	if (copy_from_user(&val, uaddr, KVM_REG_SIZE(reg->id)))
> > +		return -EFAULT;
> >  
> > -		if (copy_from_user(&val, uaddr,
> > KVM_REG_SIZE(reg->id)))
> > -			return -EFAULT;
> > +	switch (reg->id) {
> > +	case KVM_REG_ARM_PSCI_VERSION:
> > +	{
> > +		bool wants_02;
> >  
> >  		wants_02 = test_bit(KVM_ARM_VCPU_PSCI_0_2,
> > vcpu->arch.features); 
> > @@ -497,6 +552,38 @@ int kvm_arm_set_fw_reg(struct kvm_vcpu *vcpu,
> > const struct kvm_one_reg *reg) vcpu->kvm->arch.psci_version = val;
> >  			return 0;
> >  		}
> > +		break;
> > +	}
> > +
> > +	case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1:
> > +		wa_level = val & KVM_REG_FEATURE_LEVEL_MASK;  
> 
> Should we require the other bits to be zero?
> 
> Providing we never add anything else to this register we will get away
> with it, but it would be cleaner to police the extra bits here and in
> similar places.

Mmh, I remember we are strict about this in other places, and I think I
had some check in an earlier version, so might indeed be useful to have.

> > +
> > +		/* For now we only accept the very same workaround
> > level. */
> > +		if (get_kernel_wa_level(reg->id) != wa_level)
> > +			return -EINVAL;
> > +
> > +		return 0;
> > +
> > +	case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2:
> > +		wa_level = val & KVM_REG_FEATURE_LEVEL_MASK;  
> 
> Ditto...
> 
> > +
> > +		if (get_kernel_wa_level(reg->id) < wa_level)
> > +			return -EINVAL;  
> 
> Is the SMCCC_ARCH_WORKAROUND_2 interface definitely always available to
> the guest even when in the get_kernel_wa_level() == _UNAFFECTED case?
> 
> With wa_level == _AVAIL, the guest assumes that the interface is there.
> 
> (This may be fine; I'm just not so aware of the history.)

If I understand arch/arm64/kvm/hyp/hyp-entry.S:el1_hvc_guest correctly, we
do.
 
> > +
> > +		if (kvm_arm_have_ssbd() != KVM_SSBD_KERNEL)
> > +			return 0;  
> 
> (val & KVM_REG_FEATURE_LEVEL_MASK) could still be _NOT_AVAIL or _UNKNOWN
> here, yet we still attempt to call kvm_arm_set_vcpu_workaround_2_flag()
> based on the user's KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_ENABLED bit.

Not sure I understand. If wa_level is not _AVAIL or _UNAFFECTED, we just
fall through the switch/case below without doing anything. So what do I
miss here?

> Should we?  I'm not clear on what the sematics should be for this case.
> 
> > +
> > +		switch (wa_level) {
> > +		case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_AVAIL:
> > +			kvm_arm_set_vcpu_workaround_2_flag(vcpu,
> > +			    val &
> > KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_ENABLED);
> > +			break;
> > +		case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_UNAFFECTED:
> > +			kvm_arm_set_vcpu_workaround_2_flag(vcpu,
> > true);
> > +			break;
> > +		}  
> 
> This has the odd effect that userspace can bypass PSCI/SMCCC and twiddle
> this bit directly via KVM_SET_ONE_REG.  I'm not sure this matters, and
> it may even be useful.  A bit unexpected though.  Are there any pitfalls
> here I've not thought of?

I think that userland can generally have more "power" than the guest,
which is fine, since it's under the host's admin control. Is there any
threat scenario would should be worried about? And what could be the
solution?

> > +
> > +		return 0;  
> 
> The logic overall feels a bit fragile and arbitrary, though given what
> it is describing, we may not be able to do a whole lot better.

Given that it was a lot worse before, I am now quite happy with it ;-)

> Do we trust the user-supplied val more than we should?

I think we allow QEMU to treat its guest badly ...

> [...]
> 
> Overall, the code looks reasonable; my comments are pretty much nits.

Thanks,
Andre.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
