Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E5BC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:35:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DC9C2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NOGiF2S5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC9C2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:Subject:From:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3W2dC9PC5L30+eCnI3KKT/OpgCYCx/BXWQsnPwM6Ppk=; b=NOGiF2S50CF5FA
	j0zYxh/NKeMK8uT+Rljei4Xfa5nyTJzhLMt8bNjHNVAt+R8o9ZiAsTKZK6IgM8xhyU5G4pHY5u2Sh
	gitUilf7HgUmLDgz6uIRaTl4necJ+DnZeeSfKdtGhePfiIn8NSjWYfogYNxAG78YRjAVSBiU3FSsf
	wCL4joGEFWDp9r3w30g4k+ntpDGLYH8EmtvIB6iW01FDFe5TGUiSL8HTxnHKLDPW3OzKu87wEMaRg
	M23fxM97T0fF9F/7E/DCZ+bgNiBAZjqIxYQjVpHkQxipeBVprh3ZpG2TscYJge0KYNawADx5z+s61
	+PsJ9z/+nBU9T2NiAEHw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtyR7-0003xY-4H; Wed, 13 Feb 2019 17:35:05 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtyR2-0003h0-Jb
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 17:35:02 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BA58A78;
 Wed, 13 Feb 2019 09:35:00 -0800 (PST)
Received: from [10.1.197.21] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 5964B3F675; Wed, 13 Feb 2019 09:34:58 -0800 (PST)
From: Kristina Martsenko <kristina.martsenko@arm.com>
Subject: Re: [PATCH v5 3/5] arm64/kvm: context-switch ptrauth registers
To: Amit Daniel Kachhap <amit.kachhap@arm.com>,
 linux-arm-kernel@lists.infradead.org
References: <1548658727-14271-1-git-send-email-amit.kachhap@arm.com>
 <1548658727-14271-4-git-send-email-amit.kachhap@arm.com>
Message-ID: <0a2df488-a80d-ef08-6241-7f4695f2a578@arm.com>
Date: Wed, 13 Feb 2019 17:34:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548658727-14271-4-git-send-email-amit.kachhap@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_093500_661224_DF6EC86C 
X-CRM114-Status: GOOD (  31.54  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Jones <drjones@redhat.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Christoffer Dall <christoffer.dall@arm.com>,
 kvmarm@lists.cs.columbia.edu,
 Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
 Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Amit,

(Please always Cc: everyone who commented on previous versions of the
series.)

On 28/01/2019 06:58, Amit Daniel Kachhap wrote:
> When pointer authentication is supported, a guest may wish to use it.
> This patch adds the necessary KVM infrastructure for this to work, with
> a semi-lazy context switch of the pointer auth state.
> 
> Pointer authentication feature is only enabled when VHE is built
> into the kernel and present into CPU implementation so only VHE code
> paths are modified.
> 
> When we schedule a vcpu, we disable guest usage of pointer
> authentication instructions and accesses to the keys. While these are
> disabled, we avoid context-switching the keys. When we trap the guest
> trying to use pointer authentication functionality, we change to eagerly
> context-switching the keys, and enable the feature. The next time the
> vcpu is scheduled out/in, we start again.
> 
> Pointer authentication consists of address authentication and generic
> authentication, and CPUs in a system might have varied support for
> either. Where support for either feature is not uniform, it is hidden
> from guests via ID register emulation, as a result of the cpufeature
> framework in the host.
> 
> Unfortunately, address authentication and generic authentication cannot
> be trapped separately, as the architecture provides a single EL2 trap
> covering both. If we wish to expose one without the other, we cannot
> prevent a (badly-written) guest from intermittently using a feature
> which is not uniformly supported (when scheduled on a physical CPU which
> supports the relevant feature). When the guest is scheduled on a
> physical CPU lacking the feature, these attempts will result in an UNDEF
> being taken by the guest.

[...]

>  /*
> + * Handle the guest trying to use a ptrauth instruction, or trying to access a
> + * ptrauth register.
> + */
> +void kvm_arm_vcpu_ptrauth_trap(struct kvm_vcpu *vcpu)
> +{
> +	if (has_vhe() && kvm_supports_ptrauth())
> +		kvm_arm_vcpu_ptrauth_enable(vcpu);
> +	else
> +		kvm_inject_undefined(vcpu);
> +}
> +
> +/*
>   * Guest usage of a ptrauth instruction (which the guest EL1 did not turn into
> - * a NOP).
> + * a NOP), or guest EL1 access to a ptrauth register.

Doesn't guest EL1 access of ptrauth registers go through trap_ptrauth
instead?

>   */
>  static int kvm_handle_ptrauth(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  {
> -	/*
> -	 * We don't currently support ptrauth in a guest, and we mask the ID
> -	 * registers to prevent well-behaved guests from trying to make use of
> -	 * it.
> -	 *
> -	 * Inject an UNDEF, as if the feature really isn't present.
> -	 */
> -	kvm_inject_undefined(vcpu);
> +	kvm_arm_vcpu_ptrauth_trap(vcpu);
>  	return 1;
>  }
>  

[...]

> +static __always_inline bool __hyp_text __ptrauth_is_enabled(struct kvm_vcpu *vcpu)
> +{
> +	return IS_ENABLED(CONFIG_ARM64_PTR_AUTH) &&
> +			vcpu->arch.ctxt.hcr_el2 & (HCR_API | HCR_APK);
> +}
> +
> +void __no_ptrauth __hyp_text __ptrauth_switch_to_guest(struct kvm_vcpu *vcpu,
> +					  struct kvm_cpu_context *host_ctxt,
> +					  struct kvm_cpu_context *guest_ctxt)
> +{
> +	if (!__ptrauth_is_enabled(vcpu))
> +		return;
> +
> +	ptrauth_keys_store((struct ptrauth_keys *) &host_ctxt->sys_regs[APIAKEYLO_EL1]);
> +	ptrauth_keys_switch((struct ptrauth_keys *) &guest_ctxt->sys_regs[APIAKEYLO_EL1]);
> +}
> +
> +void __no_ptrauth __hyp_text __ptrauth_switch_to_host(struct kvm_vcpu *vcpu,

We don't call this code in the !VHE case anymore, so are the __hyp_text
annotations still needed?

> +					 struct kvm_cpu_context *host_ctxt,
> +					 struct kvm_cpu_context *guest_ctxt)
> +{
> +	if (!__ptrauth_is_enabled(vcpu))
> +		return;
> +
> +	ptrauth_keys_store((struct ptrauth_keys *) &guest_ctxt->sys_regs[APIAKEYLO_EL1]);
> +	ptrauth_keys_switch((struct ptrauth_keys *) &host_ctxt->sys_regs[APIAKEYLO_EL1]);
> +}

[...]

> @@ -1040,14 +1066,6 @@ static u64 read_id_reg(struct sys_reg_desc const *r, bool raz)
>  			kvm_debug("SVE unsupported for guests, suppressing\n");
>  
>  		val &= ~(0xfUL << ID_AA64PFR0_SVE_SHIFT);
> -	} else if (id == SYS_ID_AA64ISAR1_EL1) {
> -		const u64 ptrauth_mask = (0xfUL << ID_AA64ISAR1_APA_SHIFT) |
> -					 (0xfUL << ID_AA64ISAR1_API_SHIFT) |
> -					 (0xfUL << ID_AA64ISAR1_GPA_SHIFT) |
> -					 (0xfUL << ID_AA64ISAR1_GPI_SHIFT);
> -		if (val & ptrauth_mask)
> -			kvm_debug("ptrauth unsupported for guests, suppressing\n");
> -		val &= ~ptrauth_mask;

If all CPUs support address authentication, but no CPUs support generic
authentication, then I think the guest will still see address auth in
the ID register and try to use it, but since kvm_supports_ptrauth() ==
false, then kvm will enable trapping and inject an undef. So I think we
still need to zero the ID register bits here if !kvm_supports_ptrauth().

In the following patch, I think we also need to zero the bits if
!kvm_arm_vcpu_ptrauth_allowed(), as done in v4 [1], because otherwise
the guest will see that ptrauth is available, but will receive an undef
when it tries to use it.

Regarding the patch in v4, most of the work is passing the vcpu down to
read_id_reg(). Dave has a similar patch in his SVE series [2]. I think
it might make sense to rebase onto that patch and mention that patch as
a dependency in the cover letter.

[1] https://lore.kernel.org/linux-arm-kernel/1545119810-12182-5-git-send-email-amit.kachhap@arm.com/
[2] https://lore.kernel.org/linux-arm-kernel/1547757219-19439-11-git-send-email-Dave.Martin@arm.com/

Thanks,
Kristina

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
