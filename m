Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3373C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:37:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B672F218DE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NuW+5KJB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jKKUdSL5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B672F218DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=m/8vg/9ZDnFVuz8kUrIH/N//C4ecSnIckL91yStVcKA=; b=NuW+5KJBZJnpSx
	gJGJ2pFQGkCCvyFa861ODHClsxUc2UxNfClNoE0yribQVBLC4hUrPZJV9vfiPYlge8JSCRQ4nc0PQ
	cNhbs4zdKBld3zQc/yf/T4qbDtiQZGmXO3PWHHuHZA94s7RR55FCRFt4VzpLXXMwpVjOu/nyq1ZzU
	h1iFB5HSTWK/VuNRPGjAT8NbSiZ3WHheUGkEsjx1KQdjUDvsnwXZDFAGc4YTW4ZEbdHAMb2iDHvOp
	LNJt7TzaN8kPJfZYqhct+WEym+yGwcJ1N7QpY45MwKEag+pF4slppxAozChcriL6YelgSquRoPs29
	Jwwi/O7J8RWvVXkwsfNg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfULt-00014q-Us; Fri, 04 Jan 2019 18:37:49 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfULc-0000ng-O5
 for linux-arm-kernel@bombadil.infradead.org; Fri, 04 Jan 2019 18:37:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dukm0j8kuO7eXwMQQOBQsrFv1Fl8kprD44zF+HZ9V4I=; b=jKKUdSL5V4b8DKw/80H+JLrTeN
 OZV+gbFiBBN9QQne/QOgz4zchWTsUg70n70gPHhYwvUIPatQ48bS/osC1C/JyEmteR+xJqD3OcdBp
 PEELNR15uplT8MHWwb0J5LNPIBP4+UZONuZPNX+mOknim4mOpAfHJ75aDGwjEtx37+gNREIMG8NNl
 mTQFQG0txF7d1oGKg9KgxxEfuD6sfQ10lQZl8n+g90pt/m9XwoKC5cpQ/GwCNcq50+3AKSE+CKnuj
 +3OHVvhbEi7MhtEsNCTmBU4wDg7Ot80hkzdNBn0+NDaKDSN/FMdB0LwVF0hfColbs1tyJDdP/cSyu
 bw9BHYiQ==;
Received: from foss.arm.com ([217.140.101.70])
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfTcJ-0006Eu-Th
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 17:50:44 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8336EBD;
 Fri,  4 Jan 2019 09:50:41 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1355C3F5D4;
 Fri,  4 Jan 2019 09:50:39 -0800 (PST)
Subject: Re: [PATCH v4 1/6] arm64/kvm: preserve host HCR_EL2 value
To: Amit Daniel Kachhap <amit.kachhap@arm.com>
References: <1545119810-12182-1-git-send-email-amit.kachhap@arm.com>
 <1545119810-12182-2-git-send-email-amit.kachhap@arm.com>
From: James Morse <james.morse@arm.com>
Message-ID: <47a81c5b-1b1b-2c87-8c90-af5ef63d1364@arm.com>
Date: Fri, 4 Jan 2019 17:50:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <1545119810-12182-2-git-send-email-amit.kachhap@arm.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_125044_164528_3B174503 
X-CRM114-Status: GOOD (  25.65  )
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
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Amit,

On 18/12/2018 07:56, Amit Daniel Kachhap wrote:
> When restoring HCR_EL2 for the host, KVM uses HCR_HOST_VHE_FLAGS, which
> is a constant value. This works today, as the host HCR_EL2 value is
> always the same, but this will get in the way of supporting extensions
> that require HCR_EL2 bits to be set conditionally for the host.
> 
> To allow such features to work without KVM having to explicitly handle
> every possible host feature combination, this patch has KVM save/restore
> the host HCR when switching to/from a guest HCR. The saving of the
> register is done once during cpu hypervisor initialization state and is
> just restored after switch from guest.
> 
> For fetching HCR_EL2 during kvm initilisation, a hyp call is made using

(initialisation)


> kvm_call_hyp and is helpful in NHVE case.
> 
> For the hyp TLB maintenance code, __tlb_switch_to_host_vhe() is updated
> to toggle the TGE bit with a RMW sequence, as we already do in
> __tlb_switch_to_guest_vhe().


> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index aea01a0..25ac9fa 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -73,6 +73,8 @@ extern void __vgic_v3_init_lrs(void);
>  
>  extern u32 __kvm_get_mdcr_el2(void);
>  
> +extern u64 __read_hyp_hcr_el2(void);

How come this isn't __kvm_get_hcr_el2() like mdcr?


> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 52fbc82..1b9eed9 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -196,13 +196,17 @@ enum vcpu_sysreg {
>  
>  #define NR_COPRO_REGS	(NR_SYS_REGS * 2)
>  
> +struct kvm_cpu_init_host_regs {
> +	u64 hcr_el2;
> +};
> +
>  struct kvm_cpu_context {
>  	struct kvm_regs	gp_regs;
>  	union {
>  		u64 sys_regs[NR_SYS_REGS];
>  		u32 copro[NR_COPRO_REGS];
>  	};
> -
> +	struct kvm_cpu_init_host_regs init_regs;
>  	struct kvm_vcpu *__hyp_running_vcpu;
>  };

Hmm, so we grow every vcpu's struct kvm_cpu_context with some host-only registers...


> @@ -211,7 +215,7 @@ typedef struct kvm_cpu_context kvm_cpu_context_t;
>  struct kvm_vcpu_arch {
>  	struct kvm_cpu_context ctxt;
>  
> -	/* HYP configuration */
> +	/* Guest HYP configuration */
>  	u64 hcr_el2;
>  	u32 mdcr_el2;

... but they aren't actually host-only.


I think it would be tidier to move these two into struct kvm_cpu_context (not as
some init_host state), as both host and vcpu's have these values.
You could then add the mdcr_el2 stashing to your __cpu_copy_host_registers()
too. This way they both work in the same way, otherwise one is per-cpu, the
other is in a special bit of only the host's kvm_cpu_context.


> diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
> index f6e02cc..85a2a5c 100644
> --- a/arch/arm64/kvm/hyp/switch.c
> +++ b/arch/arm64/kvm/hyp/switch.c
> @@ -139,15 +139,15 @@ static void __hyp_text __activate_traps(struct kvm_vcpu *vcpu)
>  		__activate_traps_nvhe(vcpu);
>  }
>  
> -static void deactivate_traps_vhe(void)
> +static void deactivate_traps_vhe(struct kvm_cpu_context *host_ctxt)
>  {
>  	extern char vectors[];	/* kernel exception vectors */
> -	write_sysreg(HCR_HOST_VHE_FLAGS, hcr_el2);
> +	write_sysreg(host_ctxt->init_regs.hcr_el2, hcr_el2);
>  	write_sysreg(CPACR_EL1_DEFAULT, cpacr_el1);
>  	write_sysreg(vectors, vbar_el1);
>  }
>  
> -static void __hyp_text __deactivate_traps_nvhe(void)
> +static void __hyp_text __deactivate_traps_nvhe(struct kvm_cpu_context *host_ctxt)
>  {
>  	u64 mdcr_el2 = read_sysreg(mdcr_el2);
>  
> @@ -157,12 +157,15 @@ static void __hyp_text __deactivate_traps_nvhe(void)
>  	mdcr_el2 |= MDCR_EL2_E2PB_MASK << MDCR_EL2_E2PB_SHIFT;
>  
>  	write_sysreg(mdcr_el2, mdcr_el2);

Strangely we try to rebuild the host's mdcr value here. If we had the host mdcr
value in host_ctxt we could restore it directly.


> -	write_sysreg(HCR_HOST_NVHE_FLAGS, hcr_el2);
> +	write_sysreg(host_ctxt->init_regs.hcr_el2, hcr_el2);
>  	write_sysreg(CPTR_EL2_DEFAULT, cptr_el2);
>  }

>  static void __hyp_text __deactivate_traps(struct kvm_vcpu *vcpu)
>  {
> +	struct kvm_cpu_context *host_ctxt;
> +
> +	host_ctxt = vcpu->arch.host_cpu_context;
>  	/*
>  	 * If we pended a virtual abort, preserve it until it gets
>  	 * cleared. See D1.14.3 (Virtual Interrupts) for details, but
> @@ -173,9 +176,9 @@ static void __hyp_text __deactivate_traps(struct kvm_vcpu *vcpu)
>  		vcpu->arch.hcr_el2 = read_sysreg(hcr_el2);
>  
>  	if (has_vhe())
> -		deactivate_traps_vhe();
> +		deactivate_traps_vhe(host_ctxt);
>  	else
> -		__deactivate_traps_nvhe();
> +		__deactivate_traps_nvhe(host_ctxt);
>  }

(Alternatively each of these deactivate_traps() calls could retrieve the
host_ctxt directly as its a per-cpu variable, but as we have the struct vcpu
here, this is probably better.)


Thanks,

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
