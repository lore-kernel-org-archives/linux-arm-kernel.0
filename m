Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD29C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:11:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23E4120811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ALtqEyXv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23E4120811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GTmwCs9Wm5Eh5fywaouM2eXa1+4M34Osj5YQQI/wpp8=; b=ALtqEyXvjdvqdS
	69QDlsQwVAiqb+mxBPIGVwiMNFyU0scJGqiONhRCkqrMpEU4HRKJXLDEPPC+fZEF8XK9jcVcS/Psa
	bnpRMHPz+R7J0PIJxQSxlIy/C/IF7Gy10qFjed1RDeRoh6Q+R3L1lZTkLA8d2bXYtGvEJGxyE0zPy
	IObJoF+rF8cTe+zsSwaeGJoEPLrOKDlI5GisQ6dvhlSBpH0WthpCdLoa4GEk+84pbAc9NQxzXW/s8
	fEhlKs9rAqQeThM72JvyQqgSi+RV5eZnwtTj1AKee8pBGj9/x48jS12af79xPGmKRSB4WBriclC29
	288BG8oQ1m/3i/B/0HAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWhpF-0002D0-SL; Tue, 11 Dec 2018 13:11:49 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWhpC-0002CM-Bd
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 13:11:47 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62B6DEBD;
 Tue, 11 Dec 2018 05:11:35 -0800 (PST)
Received: from localhost (unknown [10.37.6.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E970F3F59C;
 Tue, 11 Dec 2018 05:11:34 -0800 (PST)
Date: Tue, 11 Dec 2018 13:11:33 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Christoffer Dall <christoffer.dall@arm.com>
Subject: Re: [PATCH v7 2/5] arm64: KVM: encapsulate kvm_cpu_context in
 kvm_host_data
Message-ID: <20181211131127.GE13393@e119886-lin.cambridge.arm.com>
References: <1544530420-1477-1-git-send-email-andrew.murray@arm.com>
 <1544530420-1477-3-git-send-email-andrew.murray@arm.com>
 <20181211122951.GY30263@e113682-lin.lund.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181211122951.GY30263@e113682-lin.lund.arm.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_051146_412128_6E969907 
X-CRM114-Status: GOOD (  27.32  )
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

On Tue, Dec 11, 2018 at 01:29:51PM +0100, Christoffer Dall wrote:
> On Tue, Dec 11, 2018 at 12:13:37PM +0000, Andrew Murray wrote:
> > The virt/arm core allocates a percpu structure as per the kvm_cpu_context_t
> > type, at present this is typedef'd to kvm_cpu_context and used to store
> > host cpu context. The kvm_cpu_context structure is also used elsewhere to
> > hold vcpu context. In order to use the percpu to hold additional future
> > host information we encapsulate kvm_cpu_context in a new structure.
> > 
> > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> > ---
> >  arch/arm64/include/asm/kvm_host.h | 8 ++++++--
> >  arch/arm64/kernel/asm-offsets.c   | 3 ++-
> >  virt/kvm/arm/arm.c                | 4 +++-
> >  3 files changed, 11 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> > index 1550192..bcf9d60 100644
> > --- a/arch/arm64/include/asm/kvm_host.h
> > +++ b/arch/arm64/include/asm/kvm_host.h
> > @@ -205,7 +205,11 @@ struct kvm_cpu_context {
> >  	struct kvm_vcpu *__hyp_running_vcpu;
> >  };
> >  
> > -typedef struct kvm_cpu_context kvm_cpu_context_t;
> > +struct kvm_host_data {
> > +	struct kvm_cpu_context __kvm_cpu_state;
> > +};
> > +
> > +typedef struct kvm_host_data kvm_cpu_context_t;
> 
> Now I'm confused based on the conversation on the last version.
> 
> I think it's bizarre to use the typedef to rename things in this way.
> 
> Can you please make this:
> 
>    struct kvm_cpu_context;
>    typedef struct kvm_cpu_context kvm_cpu_context_t;
> 
>    struct kvm_host_data;
>    typedef struct kvm_host_data kvm_host_data_t;
> 
> And change the code with the fallout from that.

I guess I was trying to avoid similar naming issues on arm32. If we
make the above changes (and thus the DEFINE_PER_CPU in virt/kvm/arm/arm.c)
then we need to change arm (arch/arm/include/asm/kvm_host.h) such that:

typedef struct kvm_cpu_context kvm_cpu_context_t;

becomes:

typedef struct kvm_cpu_context kvm_host_data_t;

though I guess this may be acceptable?


On a similar note the hunk in my last email on the previous thread
would cause a breakage on arm32:

@@ -374,7 +376,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
        }
 
        vcpu->cpu = cpu;
-       vcpu->arch.host_cpu_context = this_cpu_ptr(&kvm_host_cpu_state);
+       vcpu->arch.host_cpu_context = &cpu_ctxt->__kvm_cpu_state;
 
        kvm_arm_set_running_vcpu(vcpu);
        kvm_vgic_load(vcpu);

.. instead of this hunk I'll update the uses of host_cpu_context in the
arm64 code.

Thanks,

Andrew Murray


> 
> 
> >  
> >  struct kvm_vcpu_arch {
> >  	struct kvm_cpu_context ctxt;
> > @@ -241,7 +245,7 @@ struct kvm_vcpu_arch {
> >  	struct kvm_guest_debug_arch external_debug_state;
> >  
> >  	/* Pointer to host CPU context */
> > -	kvm_cpu_context_t *host_cpu_context;
> > +	struct kvm_cpu_context *host_cpu_context;
> >  
> >  	struct thread_info *host_thread_info;	/* hyp VA */
> >  	struct user_fpsimd_state *host_fpsimd_state;	/* hyp VA */
> > diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
> > index 323aeb5..da34022 100644
> > --- a/arch/arm64/kernel/asm-offsets.c
> > +++ b/arch/arm64/kernel/asm-offsets.c
> > @@ -142,7 +142,8 @@ int main(void)
> >    DEFINE(CPU_FP_REGS,		offsetof(struct kvm_regs, fp_regs));
> >    DEFINE(VCPU_FPEXC32_EL2,	offsetof(struct kvm_vcpu, arch.ctxt.sys_regs[FPEXC32_EL2]));
> >    DEFINE(VCPU_HOST_CONTEXT,	offsetof(struct kvm_vcpu, arch.host_cpu_context));
> > -  DEFINE(HOST_CONTEXT_VCPU,	offsetof(struct kvm_cpu_context, __hyp_running_vcpu));
> > +  DEFINE(HOST_CONTEXT_VCPU,	offsetof(struct kvm_cpu_context, __hyp_running_vcpu)
> > +				+ offsetof(struct kvm_host_data, __kvm_cpu_state));
> 
> This should be HOST_DATA_VCPU, then.
> 
> 
> Thanks,
> 
>     Christoffer
> 
> >  #endif
> >  #ifdef CONFIG_CPU_PM
> >    DEFINE(CPU_SUSPEND_SZ,	sizeof(struct cpu_suspend_ctx));
> > diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> > index 150c8a6..4f2e534 100644
> > --- a/virt/kvm/arm/arm.c
> > +++ b/virt/kvm/arm/arm.c
> > @@ -361,8 +361,10 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
> >  void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
> >  {
> >  	int *last_ran;
> > +	kvm_cpu_context_t *cpu_ctxt;
> >  
> >  	last_ran = this_cpu_ptr(vcpu->kvm->arch.last_vcpu_ran);
> > +	cpu_ctxt = this_cpu_ptr(&kvm_host_cpu_state);
> >  
> >  	/*
> >  	 * We might get preempted before the vCPU actually runs, but
> > @@ -374,7 +376,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
> >  	}
> >  
> >  	vcpu->cpu = cpu;
> > -	vcpu->arch.host_cpu_context = this_cpu_ptr(&kvm_host_cpu_state);
> > +	vcpu->arch.host_cpu_context = &cpu_ctxt->__kvm_cpu_state;
> >  
> >  	kvm_arm_set_running_vcpu(vcpu);
> >  	kvm_vgic_load(vcpu);
> > -- 
> > 2.7.4
> > 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
