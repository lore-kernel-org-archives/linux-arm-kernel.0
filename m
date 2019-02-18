Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20E8C10F01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:12:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9101F217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CbT5TV6S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9101F217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:Subject:From:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=B0X6dayxBxCn4osIc4xmCiFGB/c/pPykxGcSYOtXLS8=; b=CbT5TV6SQE8Apu
	AQYIIznMuvo1wUGL83tiCIWf0lq2Fjd2FoZKrfM6qHTHR38syE6GK4lAHuA/2VRk79I7BviuPFduH
	UhVVDLpiAIgDp6hZOb7dI6+ni9WGvyTPOgVzuCr51vSax3nFjTxemIPWVGRwNl+UMLOE1JWMYuYhN
	7grzEHqj8ojD0pl4M4VjZsbpVnRtgX6qRjtM3iBQqAL4RWZDqeAw3YBpmaZDml15DJjEJNm0eE0bD
	SUGOQFo6h3QAEasshXjMbNsIWvp/NtF2eFUjVDgo6YBpaDGOpxOehfakPwqZc1Bj0XkQL5N6QyYv1
	Z+0WlPReVYyzEuNlH0eQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvkau-0007hd-GT; Mon, 18 Feb 2019 15:12:32 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvkao-0007hG-Hb
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 15:12:31 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA75EA78;
 Mon, 18 Feb 2019 07:12:24 -0800 (PST)
Received: from [192.168.3.111] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E02E3F675;
 Mon, 18 Feb 2019 07:12:23 -0800 (PST)
From: =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Subject: Re: [PATCH 11/14] KVM: arm/arm64: timer: Rework data structures for
 multiple timers
To: Christoffer Dall <christoffer.dall@arm.com>
References: <20190124140032.8588-1-christoffer.dall@arm.com>
 <20190124140032.8588-12-christoffer.dall@arm.com>
Organization: ARM Ltd.
Message-ID: <d44bd102-5ad6-6e08-5e47-8a8386a139c6@arm.com>
Date: Mon, 18 Feb 2019 15:10:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190124140032.8588-12-christoffer.dall@arm.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_071229_164968_AFDDD379 
X-CRM114-Status: GOOD (  28.43  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 24 Jan 2019 15:00:29 +0100
Christoffer Dall <christoffer.dall@arm.com> wrote:

Hi,

I already looked at most of these patches earlier, without finding
serious issues, but figured I would give those without any Reviewed-by:
or Acked-by: tags a closer look.
(This patch just carries a S-o-b: tag from Marc in the kvm-arm git repo.)

> Prepare for having 4 timer data structures (2 for now).
> 
> Change loaded to an enum so that we know not just whether *some* state
> is loaded on the CPU, but also *which* state is loaded.
> 
> Move loaded to the cpu data structure and not the individual timer
> structure, in preparation for assigning the EL1 phys timer as well.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  include/kvm/arm_arch_timer.h | 44 ++++++++++++++-------------
>  virt/kvm/arm/arch_timer.c    | 58 +++++++++++++++++++-----------------
>  2 files changed, 54 insertions(+), 48 deletions(-)
> 
> diff --git a/include/kvm/arm_arch_timer.h b/include/kvm/arm_arch_timer.h
> index d26b7fde9935..d40fe57a2d0d 100644
> --- a/include/kvm/arm_arch_timer.h
> +++ b/include/kvm/arm_arch_timer.h
> @@ -36,6 +36,8 @@ enum kvm_arch_timer_regs {
>  };
>  
>  struct arch_timer_context {
> +	struct kvm_vcpu			*vcpu;
> +
>  	/* Registers: control register, timer value */
>  	u32				cnt_ctl;
>  	u64				cnt_cval;
> @@ -43,32 +45,34 @@ struct arch_timer_context {
>  	/* Timer IRQ */
>  	struct kvm_irq_level		irq;
>  
> -	/*
> -	 * We have multiple paths which can save/restore the timer state
> -	 * onto the hardware, so we need some way of keeping track of
> -	 * where the latest state is.
> -	 *
> -	 * loaded == true:  State is loaded on the hardware registers.
> -	 * loaded == false: State is stored in memory.
> -	 */
> -	bool			loaded;
> -
>  	/* Virtual offset */
> -	u64			cntvoff;
> +	u64				cntvoff;
> +
> +	/* Emulated Timer (may be unused) */
> +	struct hrtimer			hrtimer;
> +};
> +
> +enum loaded_timer_state {
> +	TIMER_NOT_LOADED,
> +	TIMER_EL1_LOADED,

So this gets reverted in PATCH 13/14, and I don't see it reappearing in
the nv series later on.
Is that just needed for assigning the phys timer in the next patch, and
gets obsolete with the timer_map?
Or is this a rebase artefact and we don't actually need this?

The rest of the patch looks like valid transformations to me.

Cheers,
Andre.

>  };
>  
>  struct arch_timer_cpu {
> -	struct arch_timer_context	vtimer;
> -	struct arch_timer_context	ptimer;
> +	struct arch_timer_context timers[NR_KVM_TIMERS];
>  
>  	/* Background timer used when the guest is not running */
>  	struct hrtimer			bg_timer;
>  
> -	/* Physical timer emulation */
> -	struct hrtimer			phys_timer;
> -
>  	/* Is the timer enabled */
>  	bool			enabled;
> +
> +	/*
> +	 * We have multiple paths which can save/restore the timer state
> +	 * onto the hardware, and for nested virt the EL1 hardware timers can
> +	 * contain state from either the VM's EL1 timers or EL2 timers, so we
> +	 * need some way of keeping track of where the latest state is.
> +	 */
> +	enum loaded_timer_state loaded;
>  };
>  
>  int kvm_timer_hyp_init(bool);
> @@ -98,10 +102,10 @@ void kvm_timer_init_vhe(void);
>  
>  bool kvm_arch_timer_get_input_level(int vintid);
>  
> -#define vcpu_vtimer(v)	(&(v)->arch.timer_cpu.vtimer)
> -#define vcpu_ptimer(v)	(&(v)->arch.timer_cpu.ptimer)
> -#define vcpu_get_timer(v,t)					\
> -	(t == TIMER_VTIMER ? vcpu_vtimer(v) : vcpu_ptimer(v))
> +#define vcpu_timer(v)	(&(v)->arch.timer_cpu)
> +#define vcpu_get_timer(v,t)	(&vcpu_timer(v)->timers[(t)])
> +#define vcpu_vtimer(v)	(&(v)->arch.timer_cpu.timers[TIMER_VTIMER])
> +#define vcpu_ptimer(v)	(&(v)->arch.timer_cpu.timers[TIMER_PTIMER])
>  
>  u64 kvm_arm_timer_read_sysreg(struct kvm_vcpu *vcpu,
>  			      enum kvm_arch_timers tmr,
> diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
> index 9502bb91776b..8b0eca5fbad1 100644
> --- a/virt/kvm/arm/arch_timer.c
> +++ b/virt/kvm/arm/arch_timer.c
> @@ -184,13 +184,11 @@ static enum hrtimer_restart kvm_bg_timer_expire(struct hrtimer *hrt)
>  static enum hrtimer_restart kvm_phys_timer_expire(struct hrtimer *hrt)
>  {
>  	struct arch_timer_context *ptimer;
> -	struct arch_timer_cpu *timer;
>  	struct kvm_vcpu *vcpu;
>  	u64 ns;
>  
> -	timer = container_of(hrt, struct arch_timer_cpu, phys_timer);
> -	vcpu = container_of(timer, struct kvm_vcpu, arch.timer_cpu);
> -	ptimer = vcpu_ptimer(vcpu);
> +	ptimer = container_of(hrt, struct arch_timer_context, hrtimer);
> +	vcpu = ptimer->vcpu;
>  
>  	/*
>  	 * Check that the timer has really expired from the guest's
> @@ -209,9 +207,10 @@ static enum hrtimer_restart kvm_phys_timer_expire(struct hrtimer *hrt)
>  
>  static bool kvm_timer_should_fire(struct arch_timer_context *timer_ctx)
>  {
> +	struct arch_timer_cpu *timer = vcpu_timer(timer_ctx->vcpu);
>  	u64 cval, now;
>  
> -	if (timer_ctx->loaded) {
> +	if (timer->loaded == TIMER_EL1_LOADED) {
>  		u32 cnt_ctl;
>  
>  		/* Only the virtual timer can be loaded so far */
> @@ -280,7 +279,6 @@ static void kvm_timer_update_irq(struct kvm_vcpu *vcpu, bool new_level,
>  /* Schedule the background timer for the emulated timer. */
>  static void phys_timer_emulate(struct kvm_vcpu *vcpu)
>  {
> -	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
>  	struct arch_timer_context *ptimer = vcpu_ptimer(vcpu);
>  
>  	/*
> @@ -289,11 +287,11 @@ static void phys_timer_emulate(struct kvm_vcpu *vcpu)
>  	 * then we also don't need a soft timer.
>  	 */
>  	if (kvm_timer_should_fire(ptimer) || !kvm_timer_irq_can_fire(ptimer)) {
> -		soft_timer_cancel(&timer->phys_timer);
> +		soft_timer_cancel(&ptimer->hrtimer);
>  		return;
>  	}
>  
> -	soft_timer_start(&timer->phys_timer, kvm_timer_compute_delta(ptimer));
> +	soft_timer_start(&ptimer->hrtimer, kvm_timer_compute_delta(ptimer));
>  }
>  
>  /*
> @@ -303,7 +301,7 @@ static void phys_timer_emulate(struct kvm_vcpu *vcpu)
>   */
>  static void kvm_timer_update_state(struct kvm_vcpu *vcpu)
>  {
> -	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
> +	struct arch_timer_cpu *timer = vcpu_timer(vcpu);
>  	struct arch_timer_context *vtimer = vcpu_vtimer(vcpu);
>  	struct arch_timer_context *ptimer = vcpu_ptimer(vcpu);
>  	bool level;
> @@ -329,13 +327,13 @@ static void kvm_timer_update_state(struct kvm_vcpu *vcpu)
>  
>  static void vtimer_save_state(struct kvm_vcpu *vcpu)
>  {
> -	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
> +	struct arch_timer_cpu *timer = vcpu_timer(vcpu);
>  	struct arch_timer_context *vtimer = vcpu_vtimer(vcpu);
>  	unsigned long flags;
>  
>  	local_irq_save(flags);
>  
> -	if (!vtimer->loaded)
> +	if (timer->loaded == TIMER_NOT_LOADED)
>  		goto out;
>  
>  	if (timer->enabled) {
> @@ -347,7 +345,7 @@ static void vtimer_save_state(struct kvm_vcpu *vcpu)
>  	write_sysreg_el0(0, cntv_ctl);
>  	isb();
>  
> -	vtimer->loaded = false;
> +	timer->loaded = TIMER_NOT_LOADED;
>  out:
>  	local_irq_restore(flags);
>  }
> @@ -359,7 +357,7 @@ static void vtimer_save_state(struct kvm_vcpu *vcpu)
>   */
>  static void kvm_timer_blocking(struct kvm_vcpu *vcpu)
>  {
> -	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
> +	struct arch_timer_cpu *timer = vcpu_timer(vcpu);
>  	struct arch_timer_context *vtimer = vcpu_vtimer(vcpu);
>  	struct arch_timer_context *ptimer = vcpu_ptimer(vcpu);
>  
> @@ -379,20 +377,20 @@ static void kvm_timer_blocking(struct kvm_vcpu *vcpu)
>  
>  static void kvm_timer_unblocking(struct kvm_vcpu *vcpu)
>  {
> -	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
> +	struct arch_timer_cpu *timer = vcpu_timer(vcpu);
>  
>  	soft_timer_cancel(&timer->bg_timer);
>  }
>  
>  static void vtimer_restore_state(struct kvm_vcpu *vcpu)
>  {
> -	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
> +	struct arch_timer_cpu *timer = vcpu_timer(vcpu);
>  	struct arch_timer_context *vtimer = vcpu_vtimer(vcpu);
>  	unsigned long flags;
>  
>  	local_irq_save(flags);
>  
> -	if (vtimer->loaded)
> +	if (timer->loaded == TIMER_EL1_LOADED)
>  		goto out;
>  
>  	if (timer->enabled) {
> @@ -401,7 +399,7 @@ static void vtimer_restore_state(struct kvm_vcpu *vcpu)
>  		write_sysreg_el0(vtimer->cnt_ctl, cntv_ctl);
>  	}
>  
> -	vtimer->loaded = true;
> +	timer->loaded = TIMER_EL1_LOADED;
>  out:
>  	local_irq_restore(flags);
>  }
> @@ -462,7 +460,7 @@ static void kvm_timer_vcpu_load_nogic(struct kvm_vcpu *vcpu)
>  
>  void kvm_timer_vcpu_load(struct kvm_vcpu *vcpu)
>  {
> -	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
> +	struct arch_timer_cpu *timer = vcpu_timer(vcpu);
>  	struct arch_timer_context *vtimer = vcpu_vtimer(vcpu);
>  	struct arch_timer_context *ptimer = vcpu_ptimer(vcpu);
>  
> @@ -507,7 +505,8 @@ bool kvm_timer_should_notify_user(struct kvm_vcpu *vcpu)
>  
>  void kvm_timer_vcpu_put(struct kvm_vcpu *vcpu)
>  {
> -	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
> +	struct arch_timer_cpu *timer = vcpu_timer(vcpu);
> +	struct arch_timer_context *ptimer = vcpu_ptimer(vcpu);
>  
>  	if (unlikely(!timer->enabled))
>  		return;
> @@ -523,7 +522,7 @@ void kvm_timer_vcpu_put(struct kvm_vcpu *vcpu)
>  	 * In any case, we re-schedule the hrtimer for the physical timer when
>  	 * coming back to the VCPU thread in kvm_timer_vcpu_load().
>  	 */
> -	soft_timer_cancel(&timer->phys_timer);
> +	soft_timer_cancel(&ptimer->hrtimer);
>  
>  	if (swait_active(kvm_arch_vcpu_wq(vcpu)))
>  		kvm_timer_blocking(vcpu);
> @@ -559,7 +558,7 @@ static void unmask_vtimer_irq_user(struct kvm_vcpu *vcpu)
>  
>  void kvm_timer_sync_hwstate(struct kvm_vcpu *vcpu)
>  {
> -	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
> +	struct arch_timer_cpu *timer = vcpu_timer(vcpu);
>  
>  	if (unlikely(!timer->enabled))
>  		return;
> @@ -570,7 +569,7 @@ void kvm_timer_sync_hwstate(struct kvm_vcpu *vcpu)
>  
>  int kvm_timer_vcpu_reset(struct kvm_vcpu *vcpu)
>  {
> -	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
> +	struct arch_timer_cpu *timer = vcpu_timer(vcpu);
>  	struct arch_timer_context *vtimer = vcpu_vtimer(vcpu);
>  	struct arch_timer_context *ptimer = vcpu_ptimer(vcpu);
>  
> @@ -611,22 +610,25 @@ static void update_vtimer_cntvoff(struct kvm_vcpu *vcpu, u64 cntvoff)
>  
>  void kvm_timer_vcpu_init(struct kvm_vcpu *vcpu)
>  {
> -	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
> +	struct arch_timer_cpu *timer = vcpu_timer(vcpu);
>  	struct arch_timer_context *vtimer = vcpu_vtimer(vcpu);
>  	struct arch_timer_context *ptimer = vcpu_ptimer(vcpu);
>  
>  	/* Synchronize cntvoff across all vtimers of a VM. */
>  	update_vtimer_cntvoff(vcpu, kvm_phys_timer_read());
> -	vcpu_ptimer(vcpu)->cntvoff = 0;
> +	ptimer->cntvoff = 0;
>  
>  	hrtimer_init(&timer->bg_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
>  	timer->bg_timer.function = kvm_bg_timer_expire;
>  
> -	hrtimer_init(&timer->phys_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
> -	timer->phys_timer.function = kvm_phys_timer_expire;
> +	hrtimer_init(&ptimer->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
> +	ptimer->hrtimer.function = kvm_phys_timer_expire;
>  
>  	vtimer->irq.irq = default_vtimer_irq.irq;
>  	ptimer->irq.irq = default_ptimer_irq.irq;
> +
> +	vtimer->vcpu = vcpu;
> +	ptimer->vcpu = vcpu;
>  }
>  
>  static void kvm_timer_init_interrupt(void *info)
> @@ -859,7 +861,7 @@ int kvm_timer_hyp_init(bool has_gic)
>  
>  void kvm_timer_vcpu_terminate(struct kvm_vcpu *vcpu)
>  {
> -	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
> +	struct arch_timer_cpu *timer = vcpu_timer(vcpu);
>  
>  	soft_timer_cancel(&timer->bg_timer);
>  }
> @@ -903,7 +905,7 @@ bool kvm_arch_timer_get_input_level(int vintid)
>  
>  int kvm_timer_enable(struct kvm_vcpu *vcpu)
>  {
> -	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
> +	struct arch_timer_cpu *timer = vcpu_timer(vcpu);
>  	struct arch_timer_context *vtimer = vcpu_vtimer(vcpu);
>  	int ret;
>  


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
