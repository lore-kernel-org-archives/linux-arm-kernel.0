Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D80C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 22:00:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0012B2146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 22:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xnun2GnF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0012B2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=x37xtWghSlZ2xJDEq9HG4cwuZesB3j2Tg4QVoV0YsoM=; b=Xnun2GnFjJ0eE6
	hZDgg+OBnR84STjfAwxOHjJ9P5yFLFGuyphNXRt76bxinGwKdPYD4EjmEDast+665U/GTwiLca++X
	otS5WQUxNKfx8GE0lFYZgt5NzQpEpMPZAtZzBH7b67Wd1QtMyiq3UI4kzCvzoY+SawOnQ25UwoHvn
	cfcsqln3p5UKS6NhBgX4JNDTXNvpX1cVuCkOFn+QHRKVLUy1+DAH+PS70b1y8cmImQDyGIIvWenTA
	Dhxt/wCblQ5nRgKMma6k3hh+HjmjjcQDvinA+kGqxYtgwSwi4WzjdfeTQ8tjo32IgJIbBbVfUdWQO
	hO7tqI3v9oiuyXfy14zg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvqxf-0006oP-Fn; Mon, 18 Feb 2019 22:00:27 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvqxb-0006ny-Ax
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 22:00:25 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FA9580D;
 Mon, 18 Feb 2019 14:00:22 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94ADB3F675;
 Mon, 18 Feb 2019 14:00:21 -0800 (PST)
Date: Mon, 18 Feb 2019 23:00:19 +0100
From: Christoffer Dall <christoffer.dall@arm.com>
To: Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCH v10 5/5] arm64: KVM: Enable support for :G/:H perf event
 modifiers
Message-ID: <20190218220019.GB28113@e113682-lin.lund.arm.com>
References: <1547482308-29839-1-git-send-email-andrew.murray@arm.com>
 <1547482308-29839-6-git-send-email-andrew.murray@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547482308-29839-6-git-send-email-andrew.murray@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_140023_389380_0AF75519 
X-CRM114-Status: GOOD (  26.07  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Julien Thierry <julien.thierry@arm.com>, Will Deacon <will.deacon@arm.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 14, 2019 at 04:11:48PM +0000, Andrew Murray wrote:
> Enable/disable event counters as appropriate when entering and exiting
> the guest to enable support for guest or host only event counting.
> 
> For both VHE and non-VHE we switch the counters between host/guest at
> EL2. EL2 is filtered out by the PMU when we are using the :G modifier.

I don't think the last part is strictly true as per the former patch on
a non-vhe system if you have the :h modifier, so maybe just leave that
out of the commit message.

> 
> The PMU may be on when we change which counters are enabled however
> we avoid adding an isb as we instead rely on existing context
> synchronisation events: the isb in kvm_arm_vhe_guest_exit for VHE and
> the eret from the hvc in kvm_call_hyp.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/kvm/hyp/switch.c | 60 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
> index b0b1478..9018fb3 100644
> --- a/arch/arm64/kvm/hyp/switch.c
> +++ b/arch/arm64/kvm/hyp/switch.c
> @@ -357,6 +357,54 @@ static bool __hyp_text __hyp_switch_fpsimd(struct kvm_vcpu *vcpu)
>  	return true;
>  }
>  
> +static bool __hyp_text __pmu_switch_to_guest(struct kvm_cpu_context *host_ctxt)
> +{
> +	struct kvm_host_data *host;
> +	struct kvm_pmu_events *pmu;
> +	u32 clr, set;
> +
> +	host = container_of(host_ctxt, struct kvm_host_data, host_ctxt);
> +	pmu = &host->pmu_events;
> +
> +	/* We can potentially avoid a sysreg write by only changing bits that
> +	 * differ between the guest/host. E.g. where events are enabled in
> +	 * both guest and host
> +	 */

super nit: kernel coding style requires 'wings' on both side of a
multi-line comment.  Only if you respin anyhow.

> +	clr = pmu->events_host & ~pmu->events_guest;
> +	set = pmu->events_guest & ~pmu->events_host;
> +
> +	if (clr)
> +		write_sysreg(clr, pmcntenclr_el0);
> +
> +	if (set)
> +		write_sysreg(set, pmcntenset_el0);
> +
> +	return (clr || set);
> +}
> +
> +static void __hyp_text __pmu_switch_to_host(struct kvm_cpu_context *host_ctxt)
> +{
> +	struct kvm_host_data *host;
> +	struct kvm_pmu_events *pmu;
> +	u32 clr, set;
> +
> +	host = container_of(host_ctxt, struct kvm_host_data, host_ctxt);
> +	pmu = &host->pmu_events;
> +
> +	/* We can potentially avoid a sysreg write by only changing bits that
> +	 * differ between the guest/host. E.g. where events are enabled in
> +	 * both guest and host
> +	 */

ditto

> +	clr = pmu->events_guest & ~pmu->events_host;
> +	set = pmu->events_host & ~pmu->events_guest;
> +
> +	if (clr)
> +		write_sysreg(clr, pmcntenclr_el0);
> +
> +	if (set)
> +		write_sysreg(set, pmcntenset_el0);
> +}
> +
>  /*
>   * Return true when we were able to fixup the guest exit and should return to
>   * the guest, false when we should restore the host state and return to the
> @@ -464,12 +512,15 @@ int kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_cpu_context *host_ctxt;
>  	struct kvm_cpu_context *guest_ctxt;
> +	bool pmu_switch_needed;
>  	u64 exit_code;
>  
>  	host_ctxt = vcpu->arch.host_cpu_context;
>  	host_ctxt->__hyp_running_vcpu = vcpu;
>  	guest_ctxt = &vcpu->arch.ctxt;
>  
> +	pmu_switch_needed = __pmu_switch_to_guest(host_ctxt);
> +
>  	sysreg_save_host_state_vhe(host_ctxt);
>  
>  	/*
> @@ -511,6 +562,9 @@ int kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
>  
>  	__debug_switch_to_host(vcpu);
>  
> +	if (pmu_switch_needed)
> +		__pmu_switch_to_host(host_ctxt);
> +
>  	return exit_code;
>  }
>  
> @@ -519,6 +573,7 @@ int __hyp_text __kvm_vcpu_run_nvhe(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_cpu_context *host_ctxt;
>  	struct kvm_cpu_context *guest_ctxt;
> +	bool pmu_switch_needed;
>  	u64 exit_code;
>  
>  	vcpu = kern_hyp_va(vcpu);
> @@ -527,6 +582,8 @@ int __hyp_text __kvm_vcpu_run_nvhe(struct kvm_vcpu *vcpu)
>  	host_ctxt->__hyp_running_vcpu = vcpu;
>  	guest_ctxt = &vcpu->arch.ctxt;
>  
> +	pmu_switch_needed = __pmu_switch_to_guest(host_ctxt);
> +
>  	__sysreg_save_state_nvhe(host_ctxt);
>  
>  	__activate_vm(kern_hyp_va(vcpu->kvm));
> @@ -573,6 +630,9 @@ int __hyp_text __kvm_vcpu_run_nvhe(struct kvm_vcpu *vcpu)
>  	 */
>  	__debug_switch_to_host(vcpu);
>  
> +	if (pmu_switch_needed)
> +		__pmu_switch_to_host(host_ctxt);
> +
>  	return exit_code;
>  }
>  
> -- 
> 2.7.4
> 

Thanks,

    Christoffer

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
