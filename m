Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22213C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:35:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9F9C21738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ho5yMAsr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F9C21738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Nko+KwavpVfsPdsXK2FXh+Ow+of4v2mVp0/uI01K1T4=; b=Ho5yMAsriNtZqa
	trC4RxSCkYuqaJSzyHESJ2bYN5ibKSS7pYPuq4dLoq9fKuaHmyq8coeANXXcm06n9vGDBNybQdNVg
	hwCl6igDpb+YAL2mVdvaI2xOmiZTNAEF5e7pZo1IrrIxhn5/Mu3ir+DxE+mTcgrTjfcfjo8OHX2ja
	3QnSoNUmd3rB/AOEzIz0dePtTXTqdhAAKO0txPYGKiCeik+n0bMY8ljYKCapLpMEZxStpbNmoXzzV
	1xl1/3ZPrWXRRjJMhjeaW9F7+lfuMOviWWTA3WaQzfAamm1+NkKVOAff7NkvZLQ2C3l8TmcLztrNh
	uNnpGM1q9Ao51S09Hl6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go80V-0004B5-EI; Mon, 28 Jan 2019 14:35:27 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go80R-0004Al-Qk
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 14:35:25 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3232180D;
 Mon, 28 Jan 2019 06:35:23 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 866533F589;
 Mon, 28 Jan 2019 06:35:21 -0800 (PST)
Subject: Re: [PATCH v5 4/5] arm64/kvm: add a userspace option to enable
 pointer authentication
To: Amit Daniel Kachhap <amit.kachhap@arm.com>,
 linux-arm-kernel@lists.infradead.org
References: <1548658727-14271-1-git-send-email-amit.kachhap@arm.com>
 <1548658727-14271-5-git-send-email-amit.kachhap@arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <f26304fc-3da7-d0a5-5469-4b2f44d8b996@arm.com>
Date: Mon, 28 Jan 2019 14:35:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1548658727-14271-5-git-send-email-amit.kachhap@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_063523_916698_E70376E5 
X-CRM114-Status: GOOD (  27.58  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Kristina Martsenko <kristina.martsenko@arm.com>,
 Dave Martin <Dave.Martin@arm.com>,
 Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
 kvmarm@lists.cs.columbia.edu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Amit,

On 28/01/2019 06:58, Amit Daniel Kachhap wrote:
> This feature will allow the KVM guest to allow the handling of
> pointer authentication instructions or to treat them as undefined
> if not set. It uses the existing vcpu API KVM_ARM_VCPU_INIT to
> supply this parameter instead of creating a new API.
> 
> A new register is not created to pass this parameter via
> SET/GET_ONE_REG interface as just a flag (KVM_ARM_VCPU_PTRAUTH)
> supplied is enough to enable this feature.
> 

I had a bit of trouble parsing this last sentence. I'd suggest rewording
it as "No additional register is created for the SET/GET_ONE_REG API,
instead just pass this parameter as a flag".

> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Kristina Martsenko <kristina.martsenko@arm.com>
> Cc: kvmarm@lists.cs.columbia.edu
> Cc: Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  Documentation/arm64/pointer-authentication.txt |  9 +++++----
>  Documentation/virtual/kvm/api.txt              |  4 ++++
>  arch/arm/include/asm/kvm_host.h                |  4 ++++
>  arch/arm64/include/asm/kvm_host.h              |  7 ++++---
>  arch/arm64/include/uapi/asm/kvm.h              |  1 +
>  arch/arm64/kvm/handle_exit.c                   |  3 ++-
>  arch/arm64/kvm/hyp/ptrauth-sr.c                | 13 +++++++++++++
>  arch/arm64/kvm/reset.c                         |  3 +++
>  include/uapi/linux/kvm.h                       |  1 +
>  9 files changed, 37 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/arm64/pointer-authentication.txt b/Documentation/arm64/pointer-authentication.txt
> index a25cd21..0529a7d 100644
> --- a/Documentation/arm64/pointer-authentication.txt
> +++ b/Documentation/arm64/pointer-authentication.txt
> @@ -82,7 +82,8 @@ pointers).
>  Virtualization
>  --------------
>  
> -Pointer authentication is not currently supported in KVM guests. KVM
> -will mask the feature bits from ID_AA64ISAR1_EL1, and attempted use of
> -the feature will result in an UNDEFINED exception being injected into
> -the guest.
> +Pointer authentication is enabled in KVM guest when virtual machine is
> +created by passing a flag (KVM_ARM_VCPU_PTRAUTH) requesting this feature
> +to be enabled. Without this flag, pointer authentication is not enabled
> +in KVM guests and attempted use of the feature will result in an UNDEFINED
> +exception being injected into the guest.
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index 356156f..1e646fb 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -2642,6 +2642,10 @@ Possible features:
>  	  Depends on KVM_CAP_ARM_PSCI_0_2.
>  	- KVM_ARM_VCPU_PMU_V3: Emulate PMUv3 for the CPU.
>  	  Depends on KVM_CAP_ARM_PMU_V3.
> +	- KVM_ARM_VCPU_PTRAUTH: Emulate Pointer authentication for the CPU.
> +	  Depends on KVM_CAP_ARM_PTRAUTH and only on arm64 architecture. If
> +	  set, then the KVM guest allows the execution of pointer authentication
> +	  instructions or treats them as undefined if not set.

I'd suggest "then the KVM guest allows the execution of pointer
authentication instructions. Otherwise, KVM treats these instructions as
undefined."

>  
>  
>  4.83 KVM_ARM_PREFERRED_TARGET
> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> index b200c14..b6950df 100644
> --- a/arch/arm/include/asm/kvm_host.h
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -346,6 +346,10 @@ static inline int kvm_arm_have_ssbd(void)
>  static inline void kvm_vcpu_load_sysregs(struct kvm_vcpu *vcpu) {}
>  static inline void kvm_vcpu_put_sysregs(struct kvm_vcpu *vcpu) {}
>  static inline void kvm_arm_vcpu_ptrauth_reset(struct kvm_vcpu *vcpu) {}
> +static inline bool kvm_arm_vcpu_ptrauth_allowed(struct kvm_vcpu *vcpu)
> +{
> +	return false;
> +}
>  
>  #define __KVM_HAVE_ARCH_VM_ALLOC
>  struct kvm *kvm_arch_alloc_vm(void);
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index c798d0c..4a6ec40 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -43,7 +43,7 @@
>  
>  #define KVM_MAX_VCPUS VGIC_V3_MAX_CPUS
>  
> -#define KVM_VCPU_MAX_FEATURES 4
> +#define KVM_VCPU_MAX_FEATURES 5
>  
>  #define KVM_REQ_SLEEP \
>  	KVM_ARCH_REQ_FLAGS(0, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
> @@ -453,14 +453,15 @@ static inline bool kvm_arch_requires_vhe(void)
>  
>  void kvm_arm_vcpu_ptrauth_enable(struct kvm_vcpu *vcpu);
>  void kvm_arm_vcpu_ptrauth_disable(struct kvm_vcpu *vcpu);
> +bool kvm_arm_vcpu_ptrauth_allowed(struct kvm_vcpu *vcpu);
>  
>  static inline void kvm_arm_vcpu_ptrauth_reset(struct kvm_vcpu *vcpu)
>  {
>  	/* Disable ptrauth and use it in a lazy context via traps */
> -	if (has_vhe() && kvm_supports_ptrauth())
> +	if (has_vhe() && kvm_supports_ptrauth()
> +			&& kvm_arm_vcpu_ptrauth_allowed(vcpu))
>  		kvm_arm_vcpu_ptrauth_disable(vcpu);
>  }
> -
>  void kvm_arm_vcpu_ptrauth_trap(struct kvm_vcpu *vcpu);
>  
>  static inline void kvm_arch_hardware_unsetup(void) {}
> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> index 97c3478..5f82ca1 100644
> --- a/arch/arm64/include/uapi/asm/kvm.h
> +++ b/arch/arm64/include/uapi/asm/kvm.h
> @@ -102,6 +102,7 @@ struct kvm_regs {
>  #define KVM_ARM_VCPU_EL1_32BIT		1 /* CPU running a 32bit VM */
>  #define KVM_ARM_VCPU_PSCI_0_2		2 /* CPU uses PSCI v0.2 */
>  #define KVM_ARM_VCPU_PMU_V3		3 /* Support guest PMUv3 */
> +#define KVM_ARM_VCPU_PTRAUTH		4 /* VCPU uses address authentication */
>  
>  struct kvm_vcpu_init {
>  	__u32 target;
> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> index 5b980e7..c0e5dcd 100644
> --- a/arch/arm64/kvm/handle_exit.c
> +++ b/arch/arm64/kvm/handle_exit.c
> @@ -179,7 +179,8 @@ static int handle_sve(struct kvm_vcpu *vcpu, struct kvm_run *run)
>   */
>  void kvm_arm_vcpu_ptrauth_trap(struct kvm_vcpu *vcpu)
>  {
> -	if (has_vhe() && kvm_supports_ptrauth())
> +	if (has_vhe() && kvm_supports_ptrauth()
> +			&& kvm_arm_vcpu_ptrauth_allowed(vcpu))
>  		kvm_arm_vcpu_ptrauth_enable(vcpu);
>  	else
>  		kvm_inject_undefined(vcpu);
> diff --git a/arch/arm64/kvm/hyp/ptrauth-sr.c b/arch/arm64/kvm/hyp/ptrauth-sr.c
> index 0576c01..369624f 100644
> --- a/arch/arm64/kvm/hyp/ptrauth-sr.c
> +++ b/arch/arm64/kvm/hyp/ptrauth-sr.c
> @@ -42,3 +42,16 @@ void __no_ptrauth __hyp_text __ptrauth_switch_to_host(struct kvm_vcpu *vcpu,
>  	ptrauth_keys_store((struct ptrauth_keys *) &guest_ctxt->sys_regs[APIAKEYLO_EL1]);
>  	ptrauth_keys_switch((struct ptrauth_keys *) &host_ctxt->sys_regs[APIAKEYLO_EL1]);
>  }
> +
> +/**
> + * kvm_arm_vcpu_ptrauth_allowed - checks if ptrauth feature is present in vcpu
> + *
> + * @vcpu: The VCPU pointer
> + *
> + * This function will be used to enable/disable ptrauth in guest as configured
> + * by the KVM userspace API.
> + */
> +bool kvm_arm_vcpu_ptrauth_allowed(struct kvm_vcpu *vcpu)

Nit: I find the "allowed" a bit strange. Maybe something like
"kvm_arm_vcpu_has_ptrauth()" ?

> +{
> +	return test_bit(KVM_ARM_VCPU_PTRAUTH, vcpu->arch.features);
> +}
> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> index b72a3dd..987e0c3c 100644
> --- a/arch/arm64/kvm/reset.c
> +++ b/arch/arm64/kvm/reset.c
> @@ -91,6 +91,9 @@ int kvm_arch_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  	case KVM_CAP_ARM_VM_IPA_SIZE:
>  		r = kvm_ipa_limit;
>  		break;
> +	case KVM_CAP_ARM_PTRAUTH:
> +		r = kvm_supports_ptrauth();

Even if we don't have VHE?

Cheers,

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
