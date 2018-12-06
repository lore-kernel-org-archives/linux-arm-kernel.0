Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F3DC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:21:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A31821479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ogdtvDpg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A31821479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yRNBV8lmHtxWmJnAAQCzWBY92C4BUf6x+UEbAbHTDGg=; b=ogdtvDpg0Jyr0M
	OMgOS7x0xt+opcmrc76jTuWmAPCrMlt1DI9Rdx/ZpSV1O2fiZMGN2JBmIn8kjib0A74ZpkrYRIKWw
	PRppNRJO+9UiDNGwEvMDZlRYXL32JY5wVzWymq38RRXj+H3pVSI/ZdoAYVOhzzeaPpl0fXIq343fG
	iOWmbUDuDCZb0aRo/rNEFytEdcKGa8rLgguIASIwkLbwR+sMVJb/c9Aishqu4UxafANg8e0nZSsaB
	LzOYTvFqQtEpjNAqLSRC9LRfU2P6TWdZNdVKIuC6kbsloUe7kHNWoPXdVTCFJwsGVr/XRCJ1Po9mV
	EKcp4NmFXfPezS70YzgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUzDB-0006J7-Br; Thu, 06 Dec 2018 19:21:25 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUzD8-0006Hc-Fn
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 19:21:23 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 807E41596;
 Thu,  6 Dec 2018 11:21:11 -0800 (PST)
Received: from localhost (unknown [10.37.6.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD5DB3F59C;
 Thu,  6 Dec 2018 11:21:10 -0800 (PST)
Date: Thu, 6 Dec 2018 19:21:09 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH v5 2/4] arm64: KVM: add accessors to track guest/host
 only counters
Message-ID: <20181206192108.GA51311@e119886-lin.cambridge.arm.com>
References: <1544023815-16958-1-git-send-email-andrew.murray@arm.com>
 <1544023815-16958-3-git-send-email-andrew.murray@arm.com>
 <97301473-69d0-9a0b-b957-5568a43a6551@arm.com>
 <fefadc01-05dd-f714-667e-71c3589083e7@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fefadc01-05dd-f714-667e-71c3589083e7@arm.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_112122_527891_4AC11832 
X-CRM114-Status: GOOD (  20.81  )
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
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 06, 2018 at 06:51:37PM +0000, Suzuki K Poulose wrote:
> 
> 
> On 06/12/2018 17:21, Suzuki K Poulose wrote:
> > Hi Andrew,
> > 
> > On 05/12/2018 15:30, Andrew Murray wrote:
> > > In order to effeciently enable/disable guest/host only perf counters
> > > at guest entry/exit we add bitfields to kvm_cpu_context for guest and
> > > host events as well as accessors for updating them.
> > > 
> > > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> > > ---
> > >    arch/arm64/include/asm/kvm_host.h | 24 ++++++++++++++++++++++++
> > >    1 file changed, 24 insertions(+)
> > > 
> > > diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> > > index 1550192..800c87b 100644
> > > --- a/arch/arm64/include/asm/kvm_host.h
> > > +++ b/arch/arm64/include/asm/kvm_host.h
> > > @@ -203,6 +203,8 @@ struct kvm_cpu_context {
> > >    	};
> > >    	struct kvm_vcpu *__hyp_running_vcpu;
> > > +	u32 events_host;
> > > +	u32 events_guest;
> > >    };
> > >    typedef struct kvm_cpu_context kvm_cpu_context_t;
> > > @@ -467,11 +469,33 @@ void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu);
> > >    void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu);
> > >    void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu);
> > > +#define KVM_PMU_EVENTS_HOST	1
> > > +#define KVM_PMU_EVENTS_GUEST	2
> > > +
> > >    #ifdef CONFIG_KVM /* Avoid conflicts with core headers if CONFIG_KVM=n */
> > >    static inline int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu)
> > >    {
> > >    	return kvm_arch_vcpu_run_map_fp(vcpu);
> > >    }
> > > +static inline void kvm_set_pmu_events(u32 set, int flags)
> > > +{
> > > +	kvm_cpu_context_t *ctx = this_cpu_ptr(&kvm_host_cpu_state);
> > > +
> > > +	if (flags & KVM_PMU_EVENTS_HOST)
> > > +		ctx->events_host |= set;
> > > +	if (flags & KVM_PMU_EVENTS_GUEST)
> > > +		ctx->events_guest |= set;
> > 
> > You seem to be passing a single flag at a time ever, in the next patch.
> > Either we can batch the calls in the next patch, or make this a real number and
> > not a flag. g.g, enum { HOST,  GUEST } or even a bool.
> > 
> > I think the former sounds better.
> 
> Having another look at patch-3, we can never club set() calls for host &
> guest events, we should go for the latter.

Well we could always do this..

        u32 flags = 0;
        if (!attr->exclude_host)
                flags |= KVM_PMU_EVENTS_HOST;
        if (!attr->exclude_guest)
                flags |= KVM_PMU_EVENTS_GUEST;

        kvm_set_pmu_events(counter_bits, flags);

Thanks,

Andrew Murray

> 
> Suzuki
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
