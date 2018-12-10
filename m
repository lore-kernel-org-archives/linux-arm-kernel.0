Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDF2C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:15:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D083020870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A41v8UwZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D083020870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fA3emOmC5KXkxLFORdPpxO6dLxSs3Zs2NeBaXDTKzUg=; b=A41v8UwZG1YwP8
	oRhxcEehjc/EV5q/IM6xmg6vXvxxZzivzzZwDJHGZBNaW7yY+foDknd0qjMj7rUnheKekHt6rNY/F
	u/31jpAiKQBAW9daPYZ+cv9tjYGcvaIksVMtR5RtqfeDtsoOSFp3B8s2qjz/f9yDxiEaz4s3p+BEQ
	BCMaDSWUc8lHDMCREuCU7r0/2A5FC4pP5s2yzltfdikQqeb7u7yuw83+Q5qBWdbzV0e2qx3GjjStH
	30BMYxzNS6IBV3bZlUxQA0h2BY2lL67KqZ38WGAmqAEmIrL8ep4rkdWwcc4xUH6pS1EAMqSh41uDz
	ZiCJfalTautGl8DBQnFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWIbT-0007Wo-Bc; Mon, 10 Dec 2018 10:15:55 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWIbP-0007VD-KF
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 10:15:53 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FB471596;
 Mon, 10 Dec 2018 02:15:40 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94DA13F6A8;
 Mon, 10 Dec 2018 02:15:39 -0800 (PST)
Date: Mon, 10 Dec 2018 11:15:37 +0100
From: Christoffer Dall <christoffer.dall@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v3 6/8] arm64: KVM: Add synchronization on translation
 regime change for erratum 1165522
Message-ID: <20181210101537.GJ30263@e113682-lin.lund.arm.com>
References: <20181206173126.139877-1-marc.zyngier@arm.com>
 <20181206173126.139877-7-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181206173126.139877-7-marc.zyngier@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_021551_674608_48C4D616 
X-CRM114-Status: GOOD (  22.08  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, kvm@vger.kernel.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 James Morse <james.morse@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 06, 2018 at 05:31:24PM +0000, Marc Zyngier wrote:
> In order to ensure that slipping HCR_EL2.TGE is done at the right
> time when switching translation regime, let insert the required ISBs
> that will be patched in when erratum 1165522 is detected.
> 
> Take this opportunity to add the missing include of asm/alternative.h
> which was getting there by pure luck.
> 
> Reviewed-by: James Morse <james.morse@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/include/asm/kvm_hyp.h |  8 ++++++++
>  arch/arm64/kvm/hyp/switch.c      | 19 +++++++++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
> index 23aca66767f9..a80a7ef57325 100644
> --- a/arch/arm64/include/asm/kvm_hyp.h
> +++ b/arch/arm64/include/asm/kvm_hyp.h
> @@ -20,6 +20,7 @@
>  
>  #include <linux/compiler.h>
>  #include <linux/kvm_host.h>
> +#include <asm/alternative.h>
>  #include <asm/sysreg.h>
>  
>  #define __hyp_text __section(.hyp.text) notrace
> @@ -163,6 +164,13 @@ static __always_inline void __hyp_text __load_guest_stage2(struct kvm *kvm)
>  {
>  	write_sysreg(kvm->arch.vtcr, vtcr_el2);
>  	write_sysreg(kvm->arch.vttbr, vttbr_el2);
> +
> +	/*
> +	 * ARM erratum 1165522 requires the actual execution of the above
> +	 * before we can switch to the EL1/EL0 translation regime used by
> +	 * the guest.
> +	 */
> +	asm(ALTERNATIVE("nop", "isb", ARM64_WORKAROUND_1165522));
>  }
>  
>  #endif /* __ARM64_KVM_HYP_H__ */
> diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
> index a8fa61c68c32..31ee0bfc432f 100644
> --- a/arch/arm64/kvm/hyp/switch.c
> +++ b/arch/arm64/kvm/hyp/switch.c
> @@ -143,6 +143,14 @@ static void deactivate_traps_vhe(void)
>  {
>  	extern char vectors[];	/* kernel exception vectors */
>  	write_sysreg(HCR_HOST_VHE_FLAGS, hcr_el2);
> +
> +	/*
> +	 * ARM erratum 1165522 requires the actual execution of the above
> +	 * before we can switch to the EL2/EL0 translation regime used by
> +	 * the host.
> +	 */
> +	asm(ALTERNATIVE("nop", "isb", ARM64_WORKAROUND_1165522));
> +
>  	write_sysreg(CPACR_EL1_DEFAULT, cpacr_el1);
>  	write_sysreg(vectors, vbar_el1);
>  }
> @@ -499,6 +507,17 @@ int kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
>  
>  	sysreg_save_host_state_vhe(host_ctxt);
>  
> +	/*
> +	 * ARM erratum 1165522 requires us to configure both stage 1 and
> +	 * stage 2 translation for the guest context before we clear
> +	 * HCR_EL2.TGE.
> +	 *
> +	 * We have already configured the guest's stage 1 translation in
> +	 * kvm_vcpu_load_sysregs above.  We must now call __activate_vm
> +	 * before __activate_traps, because __activate_vm configures
> +	 * stage 2 translation, and __activate_traps clear HCR_EL2.TGE
> +	 * (among other things).
> +	 */
>  	__activate_vm(vcpu->kvm);
>  	__activate_traps(vcpu);
>  
> -- 
> 2.19.2
> 

Acked-by: Christoffer Dall <christoffer.dall@arm.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
