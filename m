Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968BCC4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:51:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66E5120855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cUasee8U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E5120855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NIzA8KU2UMEMbKJGI8MBBWUHLj/QJI5rJmY3j96MYe0=; b=cUasee8UGQ1A3P
	2SNFgGdm0/SPbdzkwtqxR43H4rizNPDuHQ/d5hKkEOxBqrsrTIMWFOWZ+axSKJ5rHSCZtRulpptFR
	Q2BWDa0DL+koU1+Eyoogxn1S+lPm2DUIw/bpJRJl+pFz4BNx4XRhRL4r0zJ7pveGkGv8UBBgJRekR
	zcd5eR1d/i0DMre7pfsKh5caF3mIh6htWcNRpzgNYa7gLMv9RinlLYkdXcorsl3nNFlJmNFRp7c6w
	pPwSFYwQd3AwqQ+3OP8q88ZHDD0ufv6ux1LS+AMhHHLjSSz1hzYp6gIuUH6aXOcmlypcshgJMaXRe
	IZPA/QvXKKHdY58DRpgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwqcj-00037d-Dw; Thu, 21 Feb 2019 15:50:57 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqbW-0000mK-Ts
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 15:49:44 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A0CBA78;
 Thu, 21 Feb 2019 07:49:40 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B1DB3F5C1;
 Thu, 21 Feb 2019 07:49:38 -0800 (PST)
Date: Thu, 21 Feb 2019 15:49:35 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Amit Daniel Kachhap <amit.kachhap@arm.com>
Subject: Re: [PATCH v6 1/6] arm64/kvm: preserve host HCR_EL2 value
Message-ID: <20190221154935.GU3567@e103592.cambridge.arm.com>
References: <1550568271-5319-1-git-send-email-amit.kachhap@arm.com>
 <1550568271-5319-2-git-send-email-amit.kachhap@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550568271-5319-2-git-send-email-amit.kachhap@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_074942_978283_210B9722 
X-CRM114-Status: GOOD (  29.81  )
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
 Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 19, 2019 at 02:54:26PM +0530, Amit Daniel Kachhap wrote:
> From: Mark Rutland <mark.rutland@arm.com>
> 
> When restoring HCR_EL2 for the host, KVM uses HCR_HOST_VHE_FLAGS, which
> is a constant value. This works today, as the host HCR_EL2 value is
> always the same, but this will get in the way of supporting extensions
> that require HCR_EL2 bits to be set conditionally for the host.
> 
> To allow such features to work without KVM having to explicitly handle
> every possible host feature combination, this patch has KVM save/restore
> for the host HCR when switching to/from a guest HCR. The saving of the
> register is done once during cpu hypervisor initialization state and is
> just restored after switch from guest.
> 
> For fetching HCR_EL2 during kvm initialisation, a hyp call is made using
> kvm_call_hyp and is helpful in NHVE case.

Minor nit: NVHE misspelled.  This looks a bit like it's naming an arch
feature rather than a kernel implementation detail though.  Maybe write
"non-VHE".

> For the hyp TLB maintenance code, __tlb_switch_to_host_vhe() is updated
> to toggle the TGE bit with a RMW sequence, as we already do in
> __tlb_switch_to_guest_vhe().
> 
> The value of hcr_el2 is now stored in struct kvm_cpu_context as both host
> and guest can now use this field in a common way.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> [Added __cpu_copy_hyp_conf, hcr_el2 field in struct kvm_cpu_context]
> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: kvmarm@lists.cs.columbia.edu
> ---
>  arch/arm/include/asm/kvm_host.h      |  2 ++
>  arch/arm64/include/asm/kvm_asm.h     |  2 ++
>  arch/arm64/include/asm/kvm_emulate.h | 22 +++++++++++-----------
>  arch/arm64/include/asm/kvm_host.h    | 13 ++++++++++++-
>  arch/arm64/include/asm/kvm_hyp.h     |  2 +-
>  arch/arm64/kvm/guest.c               |  2 +-
>  arch/arm64/kvm/hyp/switch.c          | 23 +++++++++++++----------
>  arch/arm64/kvm/hyp/sysreg-sr.c       | 21 ++++++++++++++++++++-
>  arch/arm64/kvm/hyp/tlb.c             |  6 +++++-
>  virt/kvm/arm/arm.c                   |  1 +
>  10 files changed, 68 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> index ca56537..05706b4 100644
> --- a/arch/arm/include/asm/kvm_host.h
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -273,6 +273,8 @@ static inline void __cpu_init_stage2(void)
>  	kvm_call_hyp(__init_stage2_translation);
>  }
>  
> +static inline void __cpu_copy_hyp_conf(void) {}
> +
>  static inline int kvm_arch_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  {
>  	return 0;
> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index f5b79e9..8acd73f 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -80,6 +80,8 @@ extern void __vgic_v3_init_lrs(void);
>  
>  extern u32 __kvm_get_mdcr_el2(void);
>  
> +extern void __kvm_populate_host_regs(void);
> +
>  /* Home-grown __this_cpu_{ptr,read} variants that always work at HYP */
>  #define __hyp_this_cpu_ptr(sym)						\
>  	({								\
> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> index 506386a..0dbe795 100644
> --- a/arch/arm64/include/asm/kvm_emulate.h
> +++ b/arch/arm64/include/asm/kvm_emulate.h
> @@ -50,25 +50,25 @@ void kvm_inject_pabt32(struct kvm_vcpu *vcpu, unsigned long addr);
>  
>  static inline bool vcpu_el1_is_32bit(struct kvm_vcpu *vcpu)
>  {
> -	return !(vcpu->arch.hcr_el2 & HCR_RW);
> +	return !(vcpu->arch.ctxt.hcr_el2 & HCR_RW);

Putting hcr_el2 into struct kvm_cpu_context creates a lot of splatter
here, and I'm wondering whether it's really necessary.  Otherwise,
we could just put the per-vcpu guest HCR_EL2 value in struct
kvm_vcpu_arch.

Is the *host* hcr_el2 value really different per-vcpu?  That looks
odd.  I would have thought this is fixed across the system at KVM
startup time.

Having a single global host hcr_el2 would also avoid the need for
__kvm_populate_host_regs(): instead, we just decide what HCR_EL2 is to
be ahead of time and set a global variable that we map into Hyp.


Or does the host HCR_EL2 need to vary at runtime for some reason I've
missed?

[...]

+void __hyp_text __kvm_populate_host_regs(void)
+{
+       struct kvm_cpu_context *host_ctxt;
+
+       if (has_vhe())
+               host_ctxt = this_cpu_ptr(&kvm_host_cpu_state);
+       else
+               host_ctxt = __hyp_this_cpu_ptr(kvm_host_cpu_state);

According to the comment by the definition of __hyp_this_cpu_ptr(), this
always works at Hyp.  I also see other calls with no fallback
this_cpu_ptr() call like we have here.

So, can we simply always call __hyp_this_cpu_ptr() here?

(I'm not familiar with this, myself.)

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
