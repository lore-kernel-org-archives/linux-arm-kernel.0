Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B40CC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:47:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BCB52084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qe7EYcLU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BCB52084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yVARKucrh5QfxXGbPZZPxirQDS98FcE0MBi41/2Jj7s=; b=qe7EYcLU45vz4O
	oW9S5EbmuNowkbdLiO5n1cuzIXv9+EzLNEiJFoiXz/UTOwJM5HHfcECcBqf3AQakYhL7Zv7dctsxe
	weU5nd3vS+q7S20iCrp0qZxUFPCTrYLJIfidymRSwnOwjcAGKRDSBuSfwO8zaRyF7GEk++Z6tlMA0
	93cZz39oBvt2PV5fm92pphH41cRvZaIIQBdkuUS3atEqHOuRf1tuuscRk7XebfZ3xylkqzXRwJCJ6
	P+g0FecnOD6T7y95X2uzFxQ38KwvbomCbe0rHHpoGnZv4vfJAvixo+8Pg2fnq5MYa8tGkgZKfOCkT
	zkRia2tGSeBW/M0IqBww==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWVGb-0007Ah-01; Mon, 10 Dec 2018 23:47:13 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWVGX-0007AA-Rb
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 23:47:11 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD2E615AD;
 Mon, 10 Dec 2018 15:46:58 -0800 (PST)
Received: from localhost (unknown [10.37.6.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3543F3F6A8;
 Mon, 10 Dec 2018 15:46:58 -0800 (PST)
Date: Mon, 10 Dec 2018 23:46:56 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Christoffer Dall <christoffer.dall@arm.com>
Subject: Re: [PATCH v6 2/4] arm64: KVM: add accessors to track guest/host
 only counters
Message-ID: <20181210234655.GB13393@e119886-lin.cambridge.arm.com>
References: <1544435159-54781-1-git-send-email-andrew.murray@arm.com>
 <1544435159-54781-3-git-send-email-andrew.murray@arm.com>
 <20181210102634.GL30263@e113682-lin.lund.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181210102634.GL30263@e113682-lin.lund.arm.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_154709_906662_3A9E5E41 
X-CRM114-Status: GOOD (  29.57  )
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

On Mon, Dec 10, 2018 at 11:26:34AM +0100, Christoffer Dall wrote:
> On Mon, Dec 10, 2018 at 09:45:57AM +0000, Andrew Murray wrote:
> > In order to effeciently enable/disable guest/host only perf counters
> > at guest entry/exit we add bitfields to kvm_cpu_context for guest and
> > host events as well as accessors for updating them.
> > 
> > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> > ---
> >  arch/arm64/include/asm/kvm_host.h | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> > 
> > diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> > index 1550192..800c87b 100644
> > --- a/arch/arm64/include/asm/kvm_host.h
> > +++ b/arch/arm64/include/asm/kvm_host.h
> > @@ -203,6 +203,8 @@ struct kvm_cpu_context {
> >  	};
> >  
> >  	struct kvm_vcpu *__hyp_running_vcpu;
> > +	u32 events_host;
> > +	u32 events_guest;
> 
> This is confusing to me.
> 
> These values appear only to be used for the host instance, which makes
> me wonder why we add them to kvm_cpu_context, which is also used for the
> guest state?  Should we not instead consider moving them to their own

Indeed they are only used for the host instance (i.e. not arch.ctxt). I
hadn't realised the structure was used in other contexts. So it isn't
optimal to have additional fields that aren't always used.


> data structure and add a per-cpu data structure or something more fancy
> like having a new data structure, kvm_percpu_host_data, which contains
> the kvm_cpu_context and the events flags?

Using a percpu for the guest/host events was an approach I took prior to
sharing on the list - an additional hypervisor mapping is needed (such
that the percpu can be accessed from the hyp switch code) and I assume
there to be a very marginal additional amount of work resulting from it
switching between host/guest.

I also considered using the unused ctxt.sys_regs[PMCNTENSET_EL0] register
though this feels like a hack and would probably involve a system register
read in the switch code to read the current PMU state.

I attempted the fancy approach (see below) - the struct and variable
naming isn't ideal (virt/arm/arm.c defines kvm_cpu_context_t and of course
is shared with arm32). Also I updated asm-offsets.c to reflect the now
nested struct (for use with get_vcpu_ptr) - it's not strictly necessary
but adds robustness.

What are your thoughts on the best approach?

> 
> I don't know much about perf, but doesn't this design also imply that
> you can only set these modifiers at a per-cpu level, and not attach
> the modifiers to a task/vcpu or vm ?  Is that by design?

You can set these modifiers on a task and the perf core will take care of
disabling the perf_event when the task is scheduled in/out.


Here it is..


diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 800c87b..1f4a78a 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -203,11 +203,19 @@ struct kvm_cpu_context {
        };

        struct kvm_vcpu *__hyp_running_vcpu;
+};
+
+struct kvm_pmu_events {
        u32 events_host;
        u32 events_guest;
 };

-typedef struct kvm_cpu_context kvm_cpu_context_t;
+struct kvm_host_data {
+       struct kvm_cpu_context __kvm_cpu_state;
+       struct kvm_pmu_events pmu_events;
+};
+
+typedef struct kvm_host_data kvm_cpu_context_t;

 struct kvm_vcpu_arch {
        struct kvm_cpu_context ctxt;
@@ -243,7 +251,7 @@ struct kvm_vcpu_arch {
        struct kvm_guest_debug_arch external_debug_state;

        /* Pointer to host CPU context */
-       kvm_cpu_context_t *host_cpu_context;
+       struct kvm_cpu_context *host_cpu_context;

        struct thread_info *host_thread_info;   /* hyp VA */
        struct user_fpsimd_state *host_fpsimd_state;    /* hyp VA */
@@ -482,16 +490,16 @@ static inline void kvm_set_pmu_events(u32 set, int flags)
        kvm_cpu_context_t *ctx = this_cpu_ptr(&kvm_host_cpu_state);

        if (flags & KVM_PMU_EVENTS_HOST)
-               ctx->events_host |= set;
+               ctx->pmu_events.events_host |= set;
        if (flags & KVM_PMU_EVENTS_GUEST)
-               ctx->events_guest |= set;
+               ctx->pmu_events.events_guest |= set;
 }
 static inline void kvm_clr_pmu_events(u32 clr)
 {
        kvm_cpu_context_t *ctx = this_cpu_ptr(&kvm_host_cpu_state);

-       ctx->events_host &= ~clr;
-       ctx->events_guest &= ~clr;
+       ctx->pmu_events.events_host &= ~clr;
+       ctx->pmu_events.events_guest &= ~clr;
 }
 #else
 static inline void kvm_set_pmu_events(u32 set, int flags) {}
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 323aeb5..da34022 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -142,7 +142,8 @@ int main(void)
   DEFINE(CPU_FP_REGS,          offsetof(struct kvm_regs, fp_regs));
   DEFINE(VCPU_FPEXC32_EL2,     offsetof(struct kvm_vcpu, arch.ctxt.sys_regs[FPEXC32_EL2]));
   DEFINE(VCPU_HOST_CONTEXT,    offsetof(struct kvm_vcpu, arch.host_cpu_context));
-  DEFINE(HOST_CONTEXT_VCPU,    offsetof(struct kvm_cpu_context, __hyp_running_vcpu));
+  DEFINE(HOST_CONTEXT_VCPU,    offsetof(struct kvm_cpu_context, __hyp_running_vcpu)
+                               + offsetof(struct kvm_host_data, __kvm_cpu_state));
 #endif
 #ifdef CONFIG_CPU_PM
   DEFINE(CPU_SUSPEND_SZ,       sizeof(struct cpu_suspend_ctx));
diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index e505cad..5f0d571 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -375,8 +375,14 @@ static bool __hyp_text __hyp_switch_fpsimd(struct kvm_vcpu *vcpu)

 static bool __hyp_text __pmu_switch_to_guest(struct kvm_cpu_context *host_ctxt)
 {
-       u32 clr = host_ctxt->events_host & ~host_ctxt->events_guest;
-       u32 set = host_ctxt->events_guest & ~host_ctxt->events_host;
+       struct kvm_host_data *host;
+       struct kvm_pmu_events *events;
+
+       host = container_of(host_ctxt, struct kvm_host_data, __kvm_cpu_state);
+       pmu = &host_data->pmu_events;
+
+       u32 clr = pmu->events_host & ~pmu->events_guest;
+       u32 set = pmu->events_guest & ~pmu->events_host;

        if (clr)
                write_sysreg(clr, pmcntenclr_el0);
@@ -389,8 +395,11 @@ static bool __hyp_text __pmu_switch_to_guest(struct kvm_cpu_context *host_ctxt)

 static void __hyp_text __pmu_switch_to_host(struct kvm_cpu_context *host_ctxt)
 {
-       u32 clr = host_ctxt->events_guest & ~host_ctxt->events_host;
-       u32 set = host_ctxt->events_host & ~host_ctxt->events_guest;
+       struct kvm_host_data *host = container_of(host_ctxt, struct kvm_host_data, __kvm_cpu_state);
+       struct kvm_pmu_events *pmu = &host->pmu_events;
+
+       u32 clr = pmu->events_guest & ~pmu->events_host;
+       u32 set = pmu->events_host & ~pmu->events_guest;

        if (clr)
                write_sysreg(clr, pmcntenclr_el0);
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 150c8a6..6ba7de1 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -374,7 +374,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
        }

        vcpu->cpu = cpu;
-       vcpu->arch.host_cpu_context = this_cpu_ptr(&kvm_host_cpu_state);
+       vcpu->arch.host_cpu_context = &(this_cpu_ptr(&kvm_host_cpu_state)->__kvm_cpu_state);

        kvm_arm_set_running_vcpu(vcpu);
        kvm_vgic_load(vcpu);

Thanks,

Andrew Murray



> 
> 
> Thanks,
> 
>     Christoffer
> 
> >  };
> >  
> >  typedef struct kvm_cpu_context kvm_cpu_context_t;
> > @@ -467,11 +469,33 @@ void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu);
> >  void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu);
> >  void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu);
> >  
> > +#define KVM_PMU_EVENTS_HOST	1
> > +#define KVM_PMU_EVENTS_GUEST	2
> > +
> >  #ifdef CONFIG_KVM /* Avoid conflicts with core headers if CONFIG_KVM=n */
> >  static inline int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu)
> >  {
> >  	return kvm_arch_vcpu_run_map_fp(vcpu);
> >  }
> > +static inline void kvm_set_pmu_events(u32 set, int flags)
> > +{
> > +	kvm_cpu_context_t *ctx = this_cpu_ptr(&kvm_host_cpu_state);
> > +
> > +	if (flags & KVM_PMU_EVENTS_HOST)
> > +		ctx->events_host |= set;
> > +	if (flags & KVM_PMU_EVENTS_GUEST)
> > +		ctx->events_guest |= set;
> > +}
> > +static inline void kvm_clr_pmu_events(u32 clr)
> > +{
> > +	kvm_cpu_context_t *ctx = this_cpu_ptr(&kvm_host_cpu_state);
> > +
> > +	ctx->events_host &= ~clr;
> > +	ctx->events_guest &= ~clr;
> > +}
> > +#else
> > +static inline void kvm_set_pmu_events(u32 set, int flags) {}
> > +static inline void kvm_clr_pmu_events(u32 clr) {}
> >  #endif
> >  
> >  static inline void kvm_arm_vhe_guest_enter(void)
> > -- 
> > 2.7.4
> > 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
