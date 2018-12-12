Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE5CC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:46:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1998920870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tyjyStLW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1998920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=e7tXCwMktR5pWF9HEIYb3FwSVvtQuHcQNg4Kz1rrrTM=; b=tyjyStLWzRU995
	2gFBeOAECNjOv1FkjJf9Gub8fYmdeG0uEH/O3XW6u+Tuzo+Yu4FxOvtyNJcNgUIpcVXwSR9t7zdov
	MxySFIR3CJ4zNbFxuFoX1N/dRs7Fm9C/5JdqPq4i5n4JijHVku5MYVdG9TU2yFu6+yXa2O6JqGUB4
	LJpO6FT2msfKzLCzzVIvvoJ3Doe8osCIFctokJTahHFZmXSeP8APHQle0j4mB6iyoZyfOxjPhcLYL
	nWUhTdRU5bzk/TnzKV51ZVOk/dxIJDKf56KyvwTlrGoMUEJTUuR+cOU+ooi48IXoHlBQJzKTPBZ44
	faIFojS3SbEfDFeWLrgg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX5mO-0000gz-66; Wed, 12 Dec 2018 14:46:28 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX5mF-0000fq-PF
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 14:46:25 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54D6E80D;
 Wed, 12 Dec 2018 06:46:09 -0800 (PST)
Received: from localhost (unknown [10.37.6.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0BDB3F59C;
 Wed, 12 Dec 2018 06:46:08 -0800 (PST)
Date: Wed, 12 Dec 2018 14:46:06 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH v8 5/5] arm64: KVM: Enable support for :G/:H perf event
 modifiers
Message-ID: <20181212144606.GB48249@e119886-lin.cambridge.arm.com>
References: <1544610573-28446-1-git-send-email-andrew.murray@arm.com>
 <1544610573-28446-6-git-send-email-andrew.murray@arm.com>
 <9aaf29ba-b320-fb5e-cbc8-3e6067e3ef26@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9aaf29ba-b320-fb5e-cbc8-3e6067e3ef26@arm.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_064619_826989_B83A4F45 
X-CRM114-Status: GOOD (  23.03  )
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

On Wed, Dec 12, 2018 at 10:53:35AM +0000, Suzuki K Poulose wrote:
> 
> 
> On 12/12/2018 10:29, Andrew Murray wrote:
> > Enable/disable event counters as appropriate when entering and exiting
> > the guest to enable support for guest or host only event counting.
> > 
> > For both VHE and non-VHE we switch the counters between host/guest at
> > EL2. EL2 is filtered out by the PMU when we are using the :G modifier.
> > 
> > The PMU may be on when we change which counters are enabled however
> > we avoid adding an isb as we instead rely on existing context
> > synchronisation events: the isb in kvm_arm_vhe_guest_exit for VHE and
> > the eret from the hvc in kvm_call_hyp.
> > 
> > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> > ---
> >   arch/arm64/kvm/hyp/switch.c | 52 +++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 52 insertions(+)
> > 
> > diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
> > index d496ef5..9732ef7 100644
> > --- a/arch/arm64/kvm/hyp/switch.c
> > +++ b/arch/arm64/kvm/hyp/switch.c
> > @@ -373,6 +373,46 @@ static bool __hyp_text __hyp_switch_fpsimd(struct kvm_vcpu *vcpu)
> >   	return true;
> >   }
> > +static bool __hyp_text __pmu_switch_to_guest(struct kvm_cpu_context *host_ctxt)
> > +{
> > +	struct kvm_host_data *host;
> > +	struct kvm_pmu_events *pmu;
> > +	u32 clr, set;
> > +
> > +	host = container_of(host_ctxt, struct kvm_host_data, host_ctxt);
> > +	pmu = &host->pmu_events;
> > +
> > +	clr = pmu->events_host & ~pmu->events_guest;
> > +	set = pmu->events_guest & ~pmu->events_host;
> 
> It may make sense to add in a comment explaining why we only set:
> 
> 	events_guest & ~events_host
> 

Yes I'll add a comment, especially as I've just spend 5 minutes trying to
remember why I did this.

Instead of assigning 'pmu->events_guest & ~pmu->events_host' to 'set' we
could have just assigned 'pmu->events_guest'. However consider the scenario
where an event is enabled for both host and guest - this would have resulted
in us always writing the (already set) bit to the system register. Therefore
with my approach we can potentially avoid any system register writes on a 
hypervisor switch when the only events enabled are those for both host and
guest.

Thanks,

Andrew Murray

> Either way:
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
