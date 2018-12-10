Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B7FC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:26:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2B9F20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aLTzsLEI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B9F20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U4O78FJF9lvWy2qxgENUjOCbPXbOu5M4urQI1+nwj+k=; b=aLTzsLEIhZOO83
	/QrAQ2N6r+dQQO+T+I2pi74TKI/p1c1de1N/+fXSEJCGtTmNEfFbByD7svjhpUftHNnfWegzeTcjT
	Y75+zu5jdVAWB1w9rSpXeVcwWiC2Thd5YWleocygIaYT0RDMkSmrPleBXUIYFE+oZMuBeiXJCVEC1
	3MH+OL35fK8YIUmxXwQMqGTJJPS0ltE/ZGYCurLyDawrnRTCLV7o3byccmz+TG2YALDxXv5UFzqAO
	IVOnR4jczpyGD1qR6xpC9C00v5PNEfVrRA1WVs+zMCBgsCaac9peopTXaDXJ3yO35LM9OdJjFdJxD
	2zpOkLks6HrRAzaf45IA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWIm2-0005ZG-U4; Mon, 10 Dec 2018 10:26:50 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWIm0-0005YJ-2A
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 10:26:49 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 013ED1596;
 Mon, 10 Dec 2018 02:26:37 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 66DE13F6A8;
 Mon, 10 Dec 2018 02:26:36 -0800 (PST)
Date: Mon, 10 Dec 2018 11:26:34 +0100
From: Christoffer Dall <christoffer.dall@arm.com>
To: Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCH v6 2/4] arm64: KVM: add accessors to track guest/host
 only counters
Message-ID: <20181210102634.GL30263@e113682-lin.lund.arm.com>
References: <1544435159-54781-1-git-send-email-andrew.murray@arm.com>
 <1544435159-54781-3-git-send-email-andrew.murray@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544435159-54781-3-git-send-email-andrew.murray@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_022648_134588_E14F395F 
X-CRM114-Status: GOOD (  20.19  )
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
 Julien Thierry <julien.thierry@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will.deacon@arm.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 09:45:57AM +0000, Andrew Murray wrote:
> In order to effeciently enable/disable guest/host only perf counters
> at guest entry/exit we add bitfields to kvm_cpu_context for guest and
> host events as well as accessors for updating them.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> ---
>  arch/arm64/include/asm/kvm_host.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 1550192..800c87b 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -203,6 +203,8 @@ struct kvm_cpu_context {
>  	};
>  
>  	struct kvm_vcpu *__hyp_running_vcpu;
> +	u32 events_host;
> +	u32 events_guest;

This is confusing to me.

These values appear only to be used for the host instance, which makes
me wonder why we add them to kvm_cpu_context, which is also used for the
guest state?  Should we not instead consider moving them to their own
data structure and add a per-cpu data structure or something more fancy
like having a new data structure, kvm_percpu_host_data, which contains
the kvm_cpu_context and the events flags?

I don't know much about perf, but doesn't this design also imply that
you can only set these modifiers at a per-cpu level, and not attach
the modifiers to a task/vcpu or vm ?  Is that by design?


Thanks,

    Christoffer

>  };
>  
>  typedef struct kvm_cpu_context kvm_cpu_context_t;
> @@ -467,11 +469,33 @@ void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu);
>  void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu);
>  void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu);
>  
> +#define KVM_PMU_EVENTS_HOST	1
> +#define KVM_PMU_EVENTS_GUEST	2
> +
>  #ifdef CONFIG_KVM /* Avoid conflicts with core headers if CONFIG_KVM=n */
>  static inline int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu)
>  {
>  	return kvm_arch_vcpu_run_map_fp(vcpu);
>  }
> +static inline void kvm_set_pmu_events(u32 set, int flags)
> +{
> +	kvm_cpu_context_t *ctx = this_cpu_ptr(&kvm_host_cpu_state);
> +
> +	if (flags & KVM_PMU_EVENTS_HOST)
> +		ctx->events_host |= set;
> +	if (flags & KVM_PMU_EVENTS_GUEST)
> +		ctx->events_guest |= set;
> +}
> +static inline void kvm_clr_pmu_events(u32 clr)
> +{
> +	kvm_cpu_context_t *ctx = this_cpu_ptr(&kvm_host_cpu_state);
> +
> +	ctx->events_host &= ~clr;
> +	ctx->events_guest &= ~clr;
> +}
> +#else
> +static inline void kvm_set_pmu_events(u32 set, int flags) {}
> +static inline void kvm_clr_pmu_events(u32 clr) {}
>  #endif
>  
>  static inline void kvm_arm_vhe_guest_enter(void)
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
