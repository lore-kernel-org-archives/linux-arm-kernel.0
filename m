Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72187C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:44:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40DBA20864
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LfPmuKLt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40DBA20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4I50rPtbT/ox6G8aRikexlF/vBDb36p+c2XuHiuzqBM=; b=LfPmuKLtwDfnus
	joI4tP1FTvC2Gnax8IBLElcsdqeuRjxCnghi63bNi7IjxvgIYJVHqeJnf7GkZXO20pr92C0G8K9zy
	jWSD+J1PcKeCMOrU7yj62nuqEXYIa2HeGds8YoE9Bt1Q/+gf4yes+6BwFuFNjf84hdc1iVHn2Z+CZ
	g1g6CLyiKNtfC+4tprXTu1oayeDcWOYW/9WFb6X14Oin3ijzOqN+MMbC24rK/IXSSfLeBYP+FTgVc
	u5jJ6mlH0ORiitqq0vuYBZ9dZhIy3IAdggsftQ1X9dIKSUOwmAhspVgnLXyHCk8+y6mq7z4ovoE8j
	B2nVVuCCRYa9AFCcmLQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTwxM-0005va-9e; Mon, 03 Dec 2018 22:44:48 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTwxI-0005ul-Ma
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 22:44:46 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFAA015AD;
 Mon,  3 Dec 2018 14:44:33 -0800 (PST)
Received: from localhost (unknown [10.37.6.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 344773F5AF;
 Mon,  3 Dec 2018 14:44:33 -0800 (PST)
Date: Mon, 3 Dec 2018 22:44:31 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v3 2/4] arm64: KVM: add accessors to track guest/host
 only counters
Message-ID: <20181203224430.GE16311@e119886-lin.cambridge.arm.com>
References: <1542885950-23816-3-git-send-email-andrew.murray@arm.com>
 <20181203143114.GA26831@arm.com>
 <20181203150551.GC16311@e119886-lin.cambridge.arm.com>
 <20181203165842.GB27796@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203165842.GB27796@arm.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_144444_749886_635B66D5 
X-CRM114-Status: GOOD (  25.59  )
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
 Julien Thierry <julien.thierry@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 04:58:43PM +0000, Will Deacon wrote:
> On Mon, Dec 03, 2018 at 03:05:52PM +0000, Andrew Murray wrote:
> > On Mon, Dec 03, 2018 at 02:31:14PM +0000, Will Deacon wrote:
> > > On Thu, Nov 22, 2018 at 11:25:48AM +0000, Andrew Murray wrote:
> > > > In order to effeciently enable/disable guest/host only perf counters
> > > > at guest entry/exit we add bitfields to kvm_cpu_context for guest and
> > > > host only events as well as accessors for updating them.
> > > > 
> > > > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> > > > ---
> > > >  arch/arm64/include/asm/kvm_host.h | 20 ++++++++++++++++++++
> > > >  1 file changed, 20 insertions(+)
> > > > 
> > > > diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> > > > index 1550192..4a828eb 100644
> > > > --- a/arch/arm64/include/asm/kvm_host.h
> > > > +++ b/arch/arm64/include/asm/kvm_host.h
> > > > @@ -203,6 +203,8 @@ struct kvm_cpu_context {
> > > >  	};
> > > >  
> > > >  	struct kvm_vcpu *__hyp_running_vcpu;
> > > > +	u32 events_host_only;
> > > > +	u32 events_guest_only;
> > > >  };
> > > >  
> > > >  typedef struct kvm_cpu_context kvm_cpu_context_t;
> > > > @@ -472,6 +474,24 @@ static inline int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu)
> > > >  {
> > > >  	return kvm_arch_vcpu_run_map_fp(vcpu);
> > > >  }
> > > > +static inline void kvm_clr_set_host_pmu_events(u32 clr, u32 set)
> > > > +{
> > > > +	kvm_cpu_context_t *ctx = this_cpu_ptr(&kvm_host_cpu_state);
> > > > +
> > > > +	ctx->events_host_only &= ~clr;
> > > > +	ctx->events_host_only |= set;
> > > > +}
> > > 
> > > Do you actually need this clr/set function, or can you just use the
> > > facilities provided by bitfield.h at the callsites?
> > 
> > This modifies events_{host|guest}_only which is conditionally defined
> > (CONFIG_KVM) yet used by arch/arm64/kernel/perf_events which is also
> > conditionally defined (CONFIG_HW_PERF_EVENTS). By moving this away
> > from the callsite we avoid a load of horrible #ifdef's and allow this
> > function to become a nop when KVM isn't enabled.
> > 
> > Is there value in updating this function to use set_bit/clear_bit
> > functions in bitops/atomic.h ?
> 
> You don't need the atomicity, so you'd be looking at the '__' variants
> instead. My main concern is that we're introducing a clr_set_* API which
> only ever clears or sets, so I think it's needlessly complicated. If you
> need two separate macros that are just #defined to __set_bit/__clear_bit
> or expand to nothing then that could work too.

Though it would be 4 macros - a set and clear for both events_host and
events_guest. Though with the proposed changes in the other patch, this
could end up being 3 macros seeing as we'd always clear both events_host
and events_guest at the same time.

Thanks,

Andrew Murray

> 
> Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
