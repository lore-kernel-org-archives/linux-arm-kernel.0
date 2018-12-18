Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD5FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:25:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D2A421871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KTkiXTM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D2A421871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OHJrMkAGdmIyDQ8X14RHRzi4YL+YvT0T8rGS3uRI9lQ=; b=KTkiXTM69fjRmP
	8ov/ywroEtUKCE3dOR2Kk1Vl9wsKctK+9EcPMV2UewdVzL13e70sEPOii8lQeyZp3QejYtPnl+fFG
	MT9pXCfvBW4X9crP4buD/IvrI8A51lbhfhTpBpjN1TeP7+cgEObn+MV1z6l5y9IHIRj7jpTxsi4TD
	d40KfKY3juT6rbKatZNlLgjbtNj1cr+kXhx7Wv/AYVuPAlU9iMQIwwAOK6Tdi4Iv00CBJXU0BfSwo
	6T2ZjuTiNUNeH+jTfwA/iRUL0J2tgv8a1ZT56t5qZH5Y7hdNRy6uehXTljCd1ifcqmvKJsNMHN8er
	+YI1NStpbw1xP5du8Ypg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZFNi-0006OJ-30; Tue, 18 Dec 2018 13:25:54 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZFNc-0006N9-EU
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 13:25:52 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B423015AB;
 Tue, 18 Dec 2018 05:25:34 -0800 (PST)
Received: from localhost (unknown [10.37.6.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43AAA3F575;
 Tue, 18 Dec 2018 05:25:34 -0800 (PST)
Date: Tue, 18 Dec 2018 13:25:32 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Christoffer Dall <christoffer.dall@arm.com>
Subject: Re: [PATCH v8 4/5] arm64: arm_pmu: Add support for
 exclude_host/exclude_guest attributes
Message-ID: <20181218132531.GF47018@e119886-lin.cambridge.arm.com>
References: <1544610573-28446-1-git-send-email-andrew.murray@arm.com>
 <1544610573-28446-5-git-send-email-andrew.murray@arm.com>
 <20181218120226.GC25383@e113682-lin.lund.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181218120226.GC25383@e113682-lin.lund.arm.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_052550_421724_94AD26D8 
X-CRM114-Status: GOOD (  34.69  )
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
 Catalin Marinas <catalin.marinas@arm.com>, joro@8bytes.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will.deacon@arm.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 18, 2018 at 01:02:26PM +0100, Christoffer Dall wrote:
> On Wed, Dec 12, 2018 at 10:29:32AM +0000, Andrew Murray wrote:
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
> >  arch/arm64/kernel/perf_event.c | 51 ++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 44 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> > index de564ae..4a3c73d 100644
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
> > @@ -647,11 +648,26 @@ static inline int armv8pmu_enable_counter(int idx)
> >  
> >  static inline void armv8pmu_enable_event_counter(struct perf_event *event)
> >  {
> > +	struct perf_event_attr *attr = &event->attr;
> >  	int idx = event->hw.idx;
> > +	int flags = 0;
> > +	u32 counter_bits = BIT(ARMV8_IDX_TO_COUNTER(idx));
> >  
> > -	armv8pmu_enable_counter(idx);
> >  	if (armv8pmu_event_is_chained(event))
> > -		armv8pmu_enable_counter(idx - 1);
> > +		counter_bits |= BIT(ARMV8_IDX_TO_COUNTER(idx - 1));
> > +
> > +	if (!attr->exclude_host)
> > +		flags |= KVM_PMU_EVENTS_HOST;
> > +	if (!attr->exclude_guest)
> > +		flags |= KVM_PMU_EVENTS_GUEST;
> > +
> > +	kvm_set_pmu_events(counter_bits, flags);
> > +
> > +	if (!attr->exclude_host) {
> > +		armv8pmu_enable_counter(idx);
> > +		if (armv8pmu_event_is_chained(event))
> > +			armv8pmu_enable_counter(idx - 1);
> > +	}
> >  }
> >  
> >  static inline int armv8pmu_disable_counter(int idx)
> > @@ -664,11 +680,20 @@ static inline int armv8pmu_disable_counter(int idx)
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
> > +	kvm_clr_pmu_events(counter_bits);
> > +
> > +	if (!attr->exclude_host) {
> > +		if (armv8pmu_event_is_chained(event))
> > +			armv8pmu_disable_counter(idx - 1);
> > +		armv8pmu_disable_counter(idx);
> > +	}
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
> >  	} else {
> > -		if (attr->exclude_kernel)
> > -			config_base |= ARMV8_PMU_EXCLUDE_EL1;
> >  		if (!attr->exclude_hv)
> >  			config_base |= ARMV8_PMU_INCLUDE_EL2;
> 
> I'm not sure about the current use of exclude_hv here.  The comment says
> it's consistent with other architectures, but I can't find an example to
> confirm this, and I don't think we have a comparable thing to the split
> of the hypervisor between EL1 and EL2 we have on non-VHE.
> 
> Joerg told me the semantics were designed to be:
> 
> 	exclude_hv: When running as a guest, stop counting events when
> 		    the HV runs.

Can the definition of "guest" here refer to both type 1 and type 2
hypervisor guests? Or do we assume type 1 only?

> 
> 	exclude_host: When Linux runs as a HV itself, only count events
> 	              while a guest is running.
> 
> 	exclude_guest: When Linux runs as a HV, only count events when
> 	               running in host mode.
> 
> (But tools/perf/design.txt does not really confirm this).
> 
> On arm64 that would mean:
> 
> 	exclude_hv: As a host, no effect.
> 		    As a guest, set the counter to include EL2 for a
> 		    hypervisor to emulate.

If guest means either type 1 or type 2 guest, then we allow KVM guests
to understand their individual HV overhead. We can do this by counting
EL2 events whilst pinned to the KVM task.

Though more correctly we should count EL2 *and EL1* events whilst pinned
to the KVM task and whilst running outside of the guest. This then
covers both !VHE and VHE and allows for fair comparasion between !VHE
and VHE systems.

This then gives us the unique benefit of the type 2 host being able to
examine the hypervisor overhead of its individual guests.

The only issue here is that the type 2 host wouldn't be able to examine
the HV overhead of all its guests across the system as you wouldn't be
able to rely on the perf task pinning to distinguish between EL1 from
host and EL1 from guests in a !VHE system. I'm not sure the best way
to overcome this limitation.

> 
> 	exclude_host: As a guest, has no effect.
> 		      Don't count EL1 host or EL2, but count EL1 guest
> 		      by enabling EL1 counting at EL2 when entering a
> 		      guest, and disabling EL1 counting when returning
> 		      from a guest.
> 
> 	exclude_guest: As a guest, has no effect.  As a host, disable
> 		       EL1 counting at EL2 when entering a guest.
> 
> Not sure if we break anything by changing the behavior on arm64 now, but
> I really doubt that being able to exclude an arbitrary part (the one tha
> happens to run in EL2 on non-VHE systems) is meaningful, and the fact
> that behavior and semantics change depending on the version of the
> underlying CPU is not great, if what you care about is understanding the
> system's performance.

This is a bit strange. It's arbitary as it only represents a bit of the
HV overhead - this is solved though by counting the whole overhead (EL1
and EL2 instead (but only counting outside the guest and pinned to the
guest tasks).

> 
> Thoughts?
> 

Though if I've understood you correctly, you're suggesting that the only
time we count EL2 is when exclude_hv is not set on the immediate guest
of a type 1 hypervisor?

Thanks,

Andrew Murray

> 
> Thanks,
> 
>     Christoffer

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
