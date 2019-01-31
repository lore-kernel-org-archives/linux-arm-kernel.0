Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291AEC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:32:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED715218EA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qRUAUjdy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YwNcZEvA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED715218EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=magGR0xSNJQ4vSlLqXzwF7MIXtGc61gK0IrFGjyHKG4=; b=qRUAUjdyB0UC4d
	CkseNeKLEmGbN8M98/c/OoQ0zf8pwh6iT8w0eNe+cxweUQDh/zbIY5UCH3yvBW3BFyEuSWtFUJqx9
	VLyYf3eunupzT7lcFNKkNvvwLzZ+68lvY8su2DFP157AckP+3vJIY5v8x7EiNUJ+4BIBWIe3QrOFz
	zTNhNyNHgJ9HB9iBrajkM25aqGhDgS/sRNYSVksIubHv2cNYYMf5cWR6LewIYDg1XrGmcj4enll8X
	e+0ltPR38T6WV1WGK+UdFfqOlCRGFEIbIgNUCzqM/SOeIdigwR6hmcn8ZRKNMzD22hxkehsuKRBYv
	fmF0szF5/5KKfUuS+JbQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpFFy-0007oi-Pg; Thu, 31 Jan 2019 16:32:02 +0000
Received: from casper.infradead.org ([85.118.1.10])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpFFi-0007Oz-Su
 for linux-arm-kernel@bombadil.infradead.org; Thu, 31 Jan 2019 16:31:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M+TsMilQNTuuyVKsrVzk6Vm7JFKAVekeuOw9TIH19Fo=; b=YwNcZEvAAiN766mLMbpPFotDZZ
 CgtogTZ69TSPXsJ+rHRfsnjVEByhBVNFAvhBM3wnxON+Elq2X47aUrg+UWKsfw86T543Cncphp6QT
 nVTZOiiKuFrTCbrqM/DPrEZyPxeZLqRZqjytWNsCaaSPv+tewHTzbkukJOW8Z4tdAviRpp/NpGowH
 Qzk8NCaodYlvdfB7CProQgqDKyPd19xMoUzJBXSbJgyvNtHdaA3zDe8J9eBRH2tNugZFeu2fTtjwJ
 xf6VmKlhLqU7FJFJeU+hpxClr9uuDUzvLtw7dWsxFEWwJ0GRgLLqve5tPMcnutbXVdVB6sAwtmm0m
 4Tn4511Q==;
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpF6R-0002zF-Hc
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 16:22:14 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87ACD80D;
 Thu, 31 Jan 2019 08:22:10 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD7BB3F557;
 Thu, 31 Jan 2019 08:22:08 -0800 (PST)
Subject: Re: [PATCH v5 2/5] arm64/kvm: preserve host HCR_EL2/MDCR_EL2 value
To: Amit Daniel Kachhap <amit.kachhap@arm.com>
References: <1548658727-14271-1-git-send-email-amit.kachhap@arm.com>
 <1548658727-14271-3-git-send-email-amit.kachhap@arm.com>
From: James Morse <james.morse@arm.com>
Message-ID: <e773a26d-98d1-fc01-5c04-cd5a258d85ec@arm.com>
Date: Thu, 31 Jan 2019 16:22:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548658727-14271-3-git-send-email-amit.kachhap@arm.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_162212_039848_DCAC0241 
X-CRM114-Status: GOOD (  34.43  )
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

On 28/01/2019 06:58, Amit Daniel Kachhap wrote:
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
> For fetching HCR_EL2 during kvm initialisation, a hyp call is made using
> kvm_call_hyp and is helpful in NHVE case.

> For the hyp TLB maintenance code, __tlb_switch_to_host_vhe() is updated
> to toggle the TGE bit with a RMW sequence, as we already do in
> __tlb_switch_to_guest_vhe().


> While at it, host MDCR_EL2 value is fetched in a similar way and restored
> after every switch from host to guest. There should not be any change in
> functionality due to this.

Could this step be done as a separate subsequent patch? It would make review
easier! The MDCR stuff would be a simplification if done second, done in one go
like this its pretty noisy.

There ought to be some justification for moving hcr/mdcr into the cpu_context in
the commit message.


If you're keeping Mark's 'Signed-off-by' its would be normal to keep Mark as the
author in git. This shows up a an extra 'From:' when you post the patch, and
gets picked up when the maintainer runs git-am.

This patch has changed substantially from Mark's version:
https://lkml.org/lkml/2017/11/27/675

If you keep the signed-off-by, could you add a [note] in the signed-off area
with a terse summary. Something like:
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
[ Move hcr to cpu_context, added __cpu_copy_hyp_conf()]
> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>

(9c06602b1b92 is a good picked-at-random example for both of these)


> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index f5b79e9..2da6e43 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -80,6 +80,8 @@ extern void __vgic_v3_init_lrs(void);
>  
>  extern u32 __kvm_get_mdcr_el2(void);
>  
> +extern u64 __kvm_get_hcr_el2(void);

Do we need these in separate helpers? For non-vhe this means two separate trips
to EL2. Something like kvm_populate_host_context(void), and an __ version for
the bit at EL2?

We don't need to pass the host-context to EL2 as once kvm is loaded we can
access host per-cpu variables at EL2 using __hyp_this_cpu_read(). This will save
passing the vcpu around.


> @@ -458,6 +457,25 @@ int kvm_arm_vcpu_arch_has_attr(struct kvm_vcpu *vcpu,
>  
>  static inline void __cpu_init_stage2(void) {}
>  
> +/**
> + * __cpu_copy_hyp_conf - copy the boot hyp configuration registers
> + *
> + * It is called once per-cpu during CPU hyp initialisation.
> + */
> +static inline void __cpu_copy_hyp_conf(void)
> +{
> +	kvm_cpu_context_t *host_cxt = this_cpu_ptr(&kvm_host_cpu_state);
> +
> +	host_cxt->hcr_el2 = kvm_call_hyp(__kvm_get_hcr_el2);
> +
> +	/*
> +	 * Retrieve the initial value of mdcr_el2 so we can preserve
> +	 * MDCR_EL2.HPMN which has presumably been set-up by some
> +	 * knowledgeable bootcode.
> +	 */
> +	host_cxt->mdcr_el2 = kvm_call_hyp(__kvm_get_mdcr_el2);
> +}

Its strange to make this an inline in a header. kvm_arm_init_debug() is a
static-inline for arch/arm, but a regular C function for arch/arm64. Can't we do
the same?


> diff --git a/arch/arm64/kvm/hyp/sysreg-sr.c b/arch/arm64/kvm/hyp/sysreg-sr.c
> index 68d6f7c..22c854a 100644
> --- a/arch/arm64/kvm/hyp/sysreg-sr.c
> +++ b/arch/arm64/kvm/hyp/sysreg-sr.c
> @@ -316,3 +316,14 @@ void __hyp_text __kvm_enable_ssbs(void)
>  	"msr	sctlr_el2, %0"
>  	: "=&r" (tmp) : "L" (SCTLR_ELx_DSSBS));
>  }
> +
> +/**
> + * __read_hyp_hcr_el2 - Returns hcr_el2 register value
> + *
> + * This function acts as a function handler parameter for kvm_call_hyp and
> + * may be called from EL1 exception level to fetch the register value.
> + */
> +u64 __hyp_text __kvm_get_hcr_el2(void)
> +{
> +	return read_sysreg(hcr_el2);
> +}

While I'm all in favour of kernel-doc comments for functions, it may be
over-kill in this case!


> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index 9e350fd3..2d65ada 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -1327,10 +1327,10 @@ static void cpu_hyp_reinit(void)
>  	else
>  		cpu_init_hyp_mode(NULL);
>  
> -	kvm_arm_init_debug();
> -
>  	if (vgic_present)
>  		kvm_vgic_init_cpu_hardware();
> +
> +	__cpu_copy_hyp_conf();
>  }

Was there a reason to make this call later than it originally was?
(kvm_vgic_init_cpu_hardware() doesn't use any of those values, so its fine, just
curious!)


Thanks,

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
