Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56A2C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:38:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B655620850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Eh6PpEBo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B655620850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=f9Ha5n5LtxRiODTIZmEuTcmEfExtXBVqz7XD3Uxw59A=; b=Eh6PpEBo9iM/mV
	OFymnyNHfnWPipBzJTKynd0Qrg8v8XRNrt3dwuPNSD9puBJjQi2rgBEtq7beMDnl90ztzdWq2+LMp
	wztOcGF2ozz8/jOzLV2kQp7E8r/mWzhTSWDExK31fP/iyVKX4kQgIeGpaROiDBzQbw9d5+yCjSclT
	Pj3JneWrAz3ASbKWxxdU8myvPvMS9k11MOMsIJkyRo9MxbCOmAbEv8/gpLjwg77ge4+BLPu6BNm28
	Nqrq+L2TvZ4V4OVjp0TuscklaaPKjjt1rs/O2Q58hUM9DZaqqx/u/qMheFimPV0L1/zI4nABbwgO4
	vkSEIsRcyr1z56ftGpOw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTwqo-0003EN-Qm; Mon, 03 Dec 2018 22:38:02 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTwql-0002e7-8h
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 22:38:00 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D53B615AD;
 Mon,  3 Dec 2018 14:37:47 -0800 (PST)
Received: from localhost (unknown [10.37.6.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BDCB3F5AF;
 Mon,  3 Dec 2018 14:37:47 -0800 (PST)
Date: Mon, 3 Dec 2018 22:37:45 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v3 3/4] arm64: arm_pmu: Add support for
 exclude_host/exclude_guest attributes
Message-ID: <20181203223744.GD16311@e119886-lin.cambridge.arm.com>
References: <1542885950-23816-1-git-send-email-andrew.murray@arm.com>
 <1542885950-23816-4-git-send-email-andrew.murray@arm.com>
 <20181203150413.GA27232@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203150413.GA27232@arm.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_143759_319668_6522D1E1 
X-CRM114-Status: GOOD (  37.19  )
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

On Mon, Dec 03, 2018 at 03:04:14PM +0000, Will Deacon wrote:
> Hi Andrew,
> 
> On Thu, Nov 22, 2018 at 11:25:49AM +0000, Andrew Murray wrote:
> > Add support for the :G and :H attributes in perf by handling the
> > exclude_host/exclude_guest event attributes.
> > 
> > We notify KVM of counters that we wish to be enabled or disabled on
> > guest entry/exit and thus defer from starting or stopping :G events
> > as per the events exclude_host attribute.
> > 
> > With both VHE and non-VHE we switch the counters between host/guest
> > at EL2. We are able to eliminate counters counting host events on
> > the boundaries of guest entry/exit when using :G by filtering out
> > EL2 for exclude_host. However when using :H unless exclude_hv is set
> > on non-VHE then there is a small blackout window at the guest
> > entry/exit where host events are not captured.
> > 
> > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> > ---
> >  arch/arm64/kernel/perf_event.c | 52 ++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 45 insertions(+), 7 deletions(-)
> 
> I've got a cold at the moment, so it could just be that, but I struggled to
> follow the logic in this patch. Comments below.
> 
> > diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> > index de564ae..e0619ba 100644
> > --- a/arch/arm64/kernel/perf_event.c
> > +++ b/arch/arm64/kernel/perf_event.c
> > @@ -26,6 +26,7 @@
> >  
> >  #include <linux/acpi.h>
> >  #include <linux/clocksource.h>
> > +#include <linux/kvm_host.h>
> >  #include <linux/of.h>
> >  #include <linux/perf/arm_pmu.h>
> >  #include <linux/platform_device.h>
> > @@ -647,11 +648,23 @@ static inline int armv8pmu_enable_counter(int idx)
> >  
> >  static inline void armv8pmu_enable_event_counter(struct perf_event *event)
> >  {
> > +	struct perf_event_attr *attr = &event->attr;
> >  	int idx = event->hw.idx;
> > +	u32 counter_bits = BIT(ARMV8_IDX_TO_COUNTER(idx));
> >  
> > -	armv8pmu_enable_counter(idx);
> >  	if (armv8pmu_event_is_chained(event))
> > -		armv8pmu_enable_counter(idx - 1);
> > +		counter_bits |= BIT(ARMV8_IDX_TO_COUNTER(idx - 1));
> > +
> > +	if (attr->exclude_host)
> > +		kvm_clr_set_guest_pmu_events(0, counter_bits);
> > +	if (attr->exclude_guest)
> > +		kvm_clr_set_host_pmu_events(0, counter_bits);
> 
> Hmm, so if I have both exclude_host and exclude_guest set then we'll set
> the counter in both events_host_only and events_guest_only, which is weird
> and probably not what you want.

perf_event_attr is passed from userspace, whilst the perf tool doesn't allow
you to set exclude_host and exclude_guest at the same time it's feasiable for
another user to do so. So indeed the current behaviour wouldn't be expected.

> 
> I think I'd find it easier to understand if you dropped the "only" suffix on
> the kvm masks, and you actually made the logic positive so that an event
> that counts in both host and guest has its bit set in both of the masks.

No problem. This actually fixes a bug when multiple events are enabled.

> 
> > +
> > +	if (!attr->exclude_host) {
> > +		armv8pmu_enable_counter(idx);
> > +		if (armv8pmu_event_is_chained(event))
> > +			armv8pmu_enable_counter(idx - 1);
> > +	}
> >  }
> >  
> >  static inline int armv8pmu_disable_counter(int idx)
> > @@ -664,11 +677,23 @@ static inline int armv8pmu_disable_counter(int idx)
> >  static inline void armv8pmu_disable_event_counter(struct perf_event *event)
> >  {
> >  	struct hw_perf_event *hwc = &event->hw;
> > +	struct perf_event_attr *attr = &event->attr;
> >  	int idx = hwc->idx;
> > +	u32 counter_bits = BIT(ARMV8_IDX_TO_COUNTER(idx));
> >  
> >  	if (armv8pmu_event_is_chained(event))
> > -		armv8pmu_disable_counter(idx - 1);
> > -	armv8pmu_disable_counter(idx);
> > +		counter_bits |= BIT(ARMV8_IDX_TO_COUNTER(idx - 1));
> > +
> > +	if (attr->exclude_host)
> > +		kvm_clr_set_guest_pmu_events(counter_bits, 0);
> > +	if (attr->exclude_guest)
> > +		kvm_clr_set_host_pmu_events(counter_bits, 0);
> > +
> > +	if (!attr->exclude_host) {
> > +		if (armv8pmu_event_is_chained(event))
> > +			armv8pmu_disable_counter(idx - 1);
> > +		armv8pmu_disable_counter(idx);
> > +	}
> 
> It looks like you're relying on the perf_event_attr remaining unchanged
> between the enable/disable calls for a given event. However, I'm not
> convinced that's the case -- have you checked that e.g.
> PERF_EVENT_IOC_MODIFY_ATTRIBUTES can't rewrite the thing behind your
> back?

Even better - I can unconditionally clear the counter_bits here seeing as the
event is being disabled.

> 
> >  }
> >  
> >  static inline int armv8pmu_enable_intens(int idx)
> > @@ -943,16 +968,25 @@ static int armv8pmu_set_event_filter(struct hw_perf_event *event,
> >  	 * Therefore we ignore exclude_hv in this configuration, since
> >  	 * there's no hypervisor to sample anyway. This is consistent
> >  	 * with other architectures (x86 and Power).
> > +	 *
> > +	 * To eliminate counting host events on the boundaries of
> > +	 * guest entry/exit we ensure EL2 is not included in hyp mode
> > +	 * with !exclude_host.
> >  	 */
> >  	if (is_kernel_in_hyp_mode()) {
> > -		if (!attr->exclude_kernel)
> > +		if (!attr->exclude_kernel && !attr->exclude_host)
> >  			config_base |= ARMV8_PMU_INCLUDE_EL2;
> 
> Do you know what perf passes by default here? I'm worried that we're
> introducing a user-visible change to existing programs by changing this
> check.

When running 'perf xxx' exclude_guest is set and exclude_host is unset. And the
opposite when running 'perf kvm xxx'. So for existing users that do not use
virtualisation then there is no change.

> 
> >  	} else {
> > -		if (attr->exclude_kernel)
> > -			config_base |= ARMV8_PMU_EXCLUDE_EL1;
> >  		if (!attr->exclude_hv)
> >  			config_base |= ARMV8_PMU_INCLUDE_EL2;
> >  	}
> > +
> > +	/*
> > +	 * Filter out !VHE kernels and guest kernels
> > +	 */
> > +	if (attr->exclude_kernel)
> > +		config_base |= ARMV8_PMU_EXCLUDE_EL1;
> 
> Why have you moved this hunk?

When guests use perf the guest PMU is emulated by KVM (virt/kvm/arm/pmu) and is
backed by host perf events, these events always have the exclude_host flag set.
Therefore to filter these kernel events we need to filter EL1. By moving this
hunk we ensure guest kernel filtering works even when the host is VHE. (The
side effect is that we unnecessarily filter EL1 on VHE host kernel events, but
this has no effect as no-one is using this except any guest.)

Thanks,

Andrew Murray

> 
> Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
