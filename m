Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A92C5AC81
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:15:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96AF020850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aCmnLULP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96AF020850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=akrj5ik8/aRqHoH/mBxL+wYyp3XN9tvB+FHoU0byD3k=; b=aCmnLULPRv7oWa
	taa2Ysfn2vaMln+8RhU4v0rATNUfrpCs49dwti/1S2NZSk+3wp+VoETuaWFrtk11siasUJK7FL2oe
	JFQgiaEewjqLKwnJGQJFdZjCO2ghCxdoDvGJb7IrYs6sDxjPQAXFq5ZlpA6eWEKPJFKhIgRGzAD/C
	m/smdzRRUJhF9aNC52Mi4Ya27EenlTgwO3xGhe6mALfWys4WUpcT7xLEFRHSf9Ua1R5pkmOmB+OdC
	tMw3vOnLtRultC7WQdCaw65NrzhiUEWRGszWG9MURZTPlVOrTvVwLY2ozz9m8C20MAfDV/INxXMHG
	EuR4M5ge9yGgldec4Odg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkXjj-0000Mn-Bv; Fri, 18 Jan 2019 17:15:19 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkXjc-0008JY-3Q
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 17:15:15 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A0E280D;
 Fri, 18 Jan 2019 09:15:11 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 97CCB3F7BE; Fri, 18 Jan 2019 09:15:09 -0800 (PST)
Subject: Re: [PATCH v4 14/25] KVM: arm64/sve: Context switch the SVE registers
To: Dave Martin <Dave.Martin@arm.com>, kvmarm@lists.cs.columbia.edu
References: <1547757219-19439-1-git-send-email-Dave.Martin@arm.com>
 <1547757219-19439-15-git-send-email-Dave.Martin@arm.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <3bb2407f-a28d-6a6b-79ba-eda4c4194c80@arm.com>
Date: Fri, 18 Jan 2019 17:15:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1547757219-19439-15-git-send-email-Dave.Martin@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_091512_299157_C292CF4D 
X-CRM114-Status: GOOD (  31.04  )
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
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Julien Grall <Julien.Grall@arm.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 17/01/2019 20:33, Dave Martin wrote:
> In order to give each vcpu its own view of the SVE registers, this
> patch adds context storage via a new sve_state pointer in struct
> vcpu_arch.  An additional member sve_max_vl is also added for each
> vcpu, to determine the maximum vector length visible to the guest
> and thus the value to be configured in ZCR_EL2.LEN while the is
> active.  This also determines the layout and size of the storage in
> sve_state, which is read and written by the same backend functions
> that are used for context-switching the SVE state for host tasks.
> 
> On SVE-enabled vcpus, SVE access traps are now handled by switching
> in the vcpu's SVE context and disabling the trap before returning
> to the guest.  On other vcpus, the trap is not handled and an exit
> back to the host occurs, where the handle_sve() fallback path
> reflects an undefined instruction exception back to the guest,
> consistently with the behaviour of non-SVE-capable hardware (as was
> done unconditionally prior to this patch).
> 
> No SVE handling is added on non-VHE-only paths, since VHE is an
> architectural and Kconfig prerequisite of SVE.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> 
> ---
> 
> Changes since RFC v3:
> 
>  * Ensure guest_has_sve is initialised before use.  Previously the
>    order of the code allowed this to be used before initilaisation
>    on some paths.  Mysteriously the compiler failed to warn.
> ---
>  arch/arm64/include/asm/kvm_host.h |  6 ++++
>  arch/arm64/kvm/fpsimd.c           |  5 +--
>  arch/arm64/kvm/hyp/switch.c       | 70 ++++++++++++++++++++++++++++++---------
>  3 files changed, 64 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index c32f195..77b6f3e 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -212,6 +212,8 @@ typedef struct kvm_cpu_context kvm_cpu_context_t;
>  
>  struct kvm_vcpu_arch {
>  	struct kvm_cpu_context ctxt;
> +	void *sve_state;
> +	unsigned int sve_max_vl;
>  
>  	/* HYP configuration */
>  	u64 hcr_el2;
> @@ -304,6 +306,10 @@ struct kvm_vcpu_arch {
>  	bool sysregs_loaded_on_cpu;
>  };
>  
> +/* Pointer to the vcpu's SVE FFR for sve_{save,load}_state() */
> +#define vcpu_sve_pffr(vcpu) ((void *)((char *)((vcpu)->arch.sve_state) + \
> +				      sve_ffr_offset((vcpu)->arch.sve_max_vl)))
> +
>  /* vcpu_arch flags field values: */
>  #define KVM_ARM64_DEBUG_DIRTY		(1 << 0)
>  #define KVM_ARM64_FP_ENABLED		(1 << 1) /* guest FP regs loaded */
> diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
> index 5ff2d90..9cc57d4 100644
> --- a/arch/arm64/kvm/fpsimd.c
> +++ b/arch/arm64/kvm/fpsimd.c
> @@ -87,10 +87,11 @@ void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
>  
>  	if (vcpu->arch.flags & KVM_ARM64_FP_ENABLED) {
>  		fpsimd_bind_state_to_cpu(&vcpu->arch.ctxt.gp_regs.fp_regs,
> -					 NULL, SVE_VL_MIN);
> +					 vcpu->arch.sve_state,
> +					 vcpu->arch.sve_max_vl);
>  
>  		clear_thread_flag(TIF_FOREIGN_FPSTATE);
> -		clear_thread_flag(TIF_SVE);
> +		update_thread_flag(TIF_SVE, vcpu_has_sve(vcpu));
>  	}
>  }
>  
> diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
> index 9f07403..f7a8e3b 100644
> --- a/arch/arm64/kvm/hyp/switch.c
> +++ b/arch/arm64/kvm/hyp/switch.c
> @@ -98,7 +98,10 @@ static void activate_traps_vhe(struct kvm_vcpu *vcpu)
>  	val = read_sysreg(cpacr_el1);
>  	val |= CPACR_EL1_TTA;
>  	val &= ~CPACR_EL1_ZEN;
> -	if (!update_fp_enabled(vcpu)) {
> +	if (update_fp_enabled(vcpu)) {
> +		if (vcpu_has_sve(vcpu))
> +			val |= CPACR_EL1_ZEN;
> +	} else {
>  		val &= ~CPACR_EL1_FPEN;
>  		__activate_traps_fpsimd32(vcpu);
>  	}
> @@ -313,26 +316,59 @@ static bool __hyp_text __populate_fault_info(struct kvm_vcpu *vcpu)
>  	return true;
>  }
>  
> -static bool __hyp_text __hyp_switch_fpsimd(struct kvm_vcpu *vcpu)
> +/*
> + * if () with a gating check for SVE support to minimise branch
> + * mispredictions in non-SVE systems.
> + * (system_supports_sve() is resolved at build time or via a static key.)
> + */
> +#define if_sve(cond) if (system_supports_sve() && (cond))

I really hate this kind of construct, as while it provides an apparent
benefit, it actually leads to code that is harder to read. Do we have
any data showing that this adversely impacts any known workload on
non-SVE systems, given how rarely this exception is triggered?

At any rate, I'd rather see system_supports_sve() as part of the condition.

> +
> +/* Check for an FPSIMD/SVE trap and handle as appropriate */
> +static bool __hyp_text __hyp_handle_fpsimd(struct kvm_vcpu *vcpu)
>  {
> -	struct user_fpsimd_state *host_fpsimd = vcpu->arch.host_fpsimd_state;
> +	u8 trap_class;
> +	bool guest_has_sve;
>  
> -	if (has_vhe())
> -		write_sysreg(read_sysreg(cpacr_el1) | CPACR_EL1_FPEN,
> -			     cpacr_el1);
> -	else
> +	if (!system_supports_fpsimd())
> +		return false;
> +
> +	guest_has_sve = vcpu_has_sve(vcpu);
> +	trap_class = kvm_vcpu_trap_get_class(vcpu);
> +
> +	if (trap_class == ESR_ELx_EC_FP_ASIMD)
> +		goto handle;
> +
> +	if_sve (guest_has_sve && trap_class == ESR_ELx_EC_SVE)
> +		goto handle;
> +
> +	return false;

In the end, this is the stuff we want to handle quickly: nothing to do
at all. Given that vcpu_has_sve() is already gated by
system_supports_sve(), I'm pretty sure that there is no difference in
code generation between your if_sve() construct and a simple if().

> +
> +handle:
> +	/* The trap is an FPSIMD/SVE trap: switch the context */
> +
> +	if (has_vhe()) {
> +		u64 reg = read_sysreg(cpacr_el1) | CPACR_EL1_FPEN;
> +
> +		if_sve (guest_has_sve)
> +			reg |= CPACR_EL1_ZEN;
> +
> +		write_sysreg(reg, cpacr_el1);
> +	} else {
>  		write_sysreg(read_sysreg(cptr_el2) & ~(u64)CPTR_EL2_TFP,
>  			     cptr_el2);
> +	}
>  
>  	isb();
>  
>  	if (vcpu->arch.flags & KVM_ARM64_FP_HOST) {
> +		struct user_fpsimd_state *host_fpsimd =
> +			vcpu->arch.host_fpsimd_state;
> +

Single line, please. Or split declaration and assignment.

>  		/*
>  		 * In the SVE case, VHE is assumed: it is enforced by
>  		 * Kconfig and kvm_arch_init().
>  		 */
> -		if (system_supports_sve() &&
> -		    (vcpu->arch.flags & KVM_ARM64_HOST_SVE_IN_USE)) {
> +		if_sve (vcpu->arch.flags & KVM_ARM64_HOST_SVE_IN_USE) {
>  			struct thread_struct *thread = container_of(
>  				host_fpsimd,
>  				struct thread_struct, uw.fpsimd_state);
> @@ -345,10 +381,14 @@ static bool __hyp_text __hyp_switch_fpsimd(struct kvm_vcpu *vcpu)
>  		vcpu->arch.flags &= ~KVM_ARM64_FP_HOST;
>  	}
>  
> -	__fpsimd_restore_state(&vcpu->arch.ctxt.gp_regs.fp_regs);
> -
> -	if (vcpu_has_sve(vcpu))
> +	if_sve (guest_has_sve) {
> +		sve_load_state(vcpu_sve_pffr(vcpu),
> +			       &vcpu->arch.ctxt.gp_regs.fp_regs.fpsr,
> +			       sve_vq_from_vl(vcpu->arch.sve_max_vl) - 1);
>  		write_sysreg_s(vcpu->arch.ctxt.sys_regs[ZCR_EL1], SYS_ZCR_EL12);
> +	} else {
> +		__fpsimd_restore_state(&vcpu->arch.ctxt.gp_regs.fp_regs);
> +	}
>  
>  	/* Skip restoring fpexc32 for AArch64 guests */
>  	if (!(read_sysreg(hcr_el2) & HCR_RW))
> @@ -384,10 +424,10 @@ static bool __hyp_text fixup_guest_exit(struct kvm_vcpu *vcpu, u64 *exit_code)
>  	 * and restore the guest context lazily.
>  	 * If FP/SIMD is not implemented, handle the trap and inject an
>  	 * undefined instruction exception to the guest.
> +	 * Similarly for trapped SVE accesses.
>  	 */
> -	if (system_supports_fpsimd() &&
> -	    kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_FP_ASIMD)
> -		return __hyp_switch_fpsimd(vcpu);
> +	if (__hyp_handle_fpsimd(vcpu))
> +		return true;
>  
>  	if (!__populate_fault_info(vcpu))
>  		return true;
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
