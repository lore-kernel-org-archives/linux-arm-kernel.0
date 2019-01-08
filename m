Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B9BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:25:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F9FB20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ug4beJUO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F9FB20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=R57/6csP2kD4+3mP6vXSwkTjbqA0MDarVKxBxkZB+2U=; b=ug4beJUOI0rpsk
	H9CFU9CJ9FjcuO0bIzADfDNcx1a8+Zi2iA58Oip3/lQI7paMAnjbNsCfXk6YUUpsEgaGjasarB0d3
	/iJtV2GVNHSRfVPIIWJ/Fzk0PQ3v/XrJcbJGeCWVidl1Ei+ARZun6fRI72KAfe1z/tLy1MgCzefDn
	E0NIKxeJYRKibhTawgKWI35SA7FsrNPovUb7DixuR+MyNq4v3gRtmzKQCDWk1nuqlkydj64566Bdk
	RoQx7XLltlDyq5XBMWLahL8wekHAMRin1hEdqEwsGC2eti/1semAPSNMROMMyG0chJoxrh2tLW5Mx
	MVhR9JqHhw6qsxHCSaqg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggpVd-0007z8-K3; Tue, 08 Jan 2019 11:25:25 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggpVU-0007xu-GJ
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 11:25:18 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA97015BE;
 Tue,  8 Jan 2019 03:25:15 -0800 (PST)
Received: from localhost (unknown [10.37.6.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B94A3F70D;
 Tue,  8 Jan 2019 03:25:15 -0800 (PST)
Date: Tue, 8 Jan 2019 11:25:13 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Christoffer Dall <christoffer.dall@arm.com>
Subject: Re: [PATCH v8 4/5] arm64: arm_pmu: Add support for
 exclude_host/exclude_guest attributes
Message-ID: <20190108112512.GA56789@e119886-lin.cambridge.arm.com>
References: <1544610573-28446-1-git-send-email-andrew.murray@arm.com>
 <1544610573-28446-5-git-send-email-andrew.murray@arm.com>
 <20181218120226.GC25383@e113682-lin.lund.arm.com>
 <20190104153205.GA31479@edgewater-inn.cambridge.arm.com>
 <20190108101843.GH10769@e113682-lin.lund.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190108101843.GH10769@e113682-lin.lund.arm.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_032516_557539_5AC76DAD 
X-CRM114-Status: GOOD (  42.27  )
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

On Tue, Jan 08, 2019 at 11:18:43AM +0100, Christoffer Dall wrote:
> On Fri, Jan 04, 2019 at 03:32:06PM +0000, Will Deacon wrote:
> > On Tue, Dec 18, 2018 at 01:02:26PM +0100, Christoffer Dall wrote:
> > > On Wed, Dec 12, 2018 at 10:29:32AM +0000, Andrew Murray wrote:
> > > > Add support for the :G and :H attributes in perf by handling the
> > > > exclude_host/exclude_guest event attributes.
> > > > 
> > > > We notify KVM of counters that we wish to be enabled or disabled on
> > > > guest entry/exit and thus defer from starting or stopping :G events
> > > > as per the events exclude_host attribute.
> > > > 
> > > > With both VHE and non-VHE we switch the counters between host/guest
> > > > at EL2. We are able to eliminate counters counting host events on
> > > > the boundaries of guest entry/exit when using :G by filtering out
> > > > EL2 for exclude_host. However when using :H unless exclude_hv is set
> > > > on non-VHE then there is a small blackout window at the guest
> > > > entry/exit where host events are not captured.
> > > > 
> > > > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> > > > ---
> > > >  arch/arm64/kernel/perf_event.c | 51 ++++++++++++++++++++++++++++++++++++------
> > > >  1 file changed, 44 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> > > > index de564ae..4a3c73d 100644
> > > > --- a/arch/arm64/kernel/perf_event.c
> > > > +++ b/arch/arm64/kernel/perf_event.c
> > > > @@ -26,6 +26,7 @@
> > > >  
> > > >  #include <linux/acpi.h>
> > > >  #include <linux/clocksource.h>
> > > > +#include <linux/kvm_host.h>
> > > >  #include <linux/of.h>
> > > >  #include <linux/perf/arm_pmu.h>
> > > >  #include <linux/platform_device.h>
> > > > @@ -647,11 +648,26 @@ static inline int armv8pmu_enable_counter(int idx)
> > > >  
> > > >  static inline void armv8pmu_enable_event_counter(struct perf_event *event)
> > > >  {
> > > > +	struct perf_event_attr *attr = &event->attr;
> > > >  	int idx = event->hw.idx;
> > > > +	int flags = 0;
> > > > +	u32 counter_bits = BIT(ARMV8_IDX_TO_COUNTER(idx));
> > > >  
> > > > -	armv8pmu_enable_counter(idx);
> > > >  	if (armv8pmu_event_is_chained(event))
> > > > -		armv8pmu_enable_counter(idx - 1);
> > > > +		counter_bits |= BIT(ARMV8_IDX_TO_COUNTER(idx - 1));
> > > > +
> > > > +	if (!attr->exclude_host)
> > > > +		flags |= KVM_PMU_EVENTS_HOST;
> > > > +	if (!attr->exclude_guest)
> > > > +		flags |= KVM_PMU_EVENTS_GUEST;
> > > > +
> > > > +	kvm_set_pmu_events(counter_bits, flags);
> > > > +
> > > > +	if (!attr->exclude_host) {
> > > > +		armv8pmu_enable_counter(idx);
> > > > +		if (armv8pmu_event_is_chained(event))
> > > > +			armv8pmu_enable_counter(idx - 1);
> > > > +	}
> > > >  }
> > > >  
> > > >  static inline int armv8pmu_disable_counter(int idx)
> > > > @@ -664,11 +680,20 @@ static inline int armv8pmu_disable_counter(int idx)
> > > >  static inline void armv8pmu_disable_event_counter(struct perf_event *event)
> > > >  {
> > > >  	struct hw_perf_event *hwc = &event->hw;
> > > > +	struct perf_event_attr *attr = &event->attr;
> > > >  	int idx = hwc->idx;
> > > > +	u32 counter_bits = BIT(ARMV8_IDX_TO_COUNTER(idx));
> > > >  
> > > >  	if (armv8pmu_event_is_chained(event))
> > > > -		armv8pmu_disable_counter(idx - 1);
> > > > -	armv8pmu_disable_counter(idx);
> > > > +		counter_bits |= BIT(ARMV8_IDX_TO_COUNTER(idx - 1));
> > > > +
> > > > +	kvm_clr_pmu_events(counter_bits);
> > > > +
> > > > +	if (!attr->exclude_host) {
> > > > +		if (armv8pmu_event_is_chained(event))
> > > > +			armv8pmu_disable_counter(idx - 1);
> > > > +		armv8pmu_disable_counter(idx);
> > > > +	}
> > > >  }
> > > >  
> > > >  static inline int armv8pmu_enable_intens(int idx)
> > > > @@ -943,16 +968,25 @@ static int armv8pmu_set_event_filter(struct hw_perf_event *event,
> > > >  	 * Therefore we ignore exclude_hv in this configuration, since
> > > >  	 * there's no hypervisor to sample anyway. This is consistent
> > > >  	 * with other architectures (x86 and Power).
> > > > +	 *
> > > > +	 * To eliminate counting host events on the boundaries of
> > > > +	 * guest entry/exit we ensure EL2 is not included in hyp mode
> > > > +	 * with !exclude_host.
> > > >  	 */
> > > >  	if (is_kernel_in_hyp_mode()) {
> > > > -		if (!attr->exclude_kernel)
> > > > +		if (!attr->exclude_kernel && !attr->exclude_host)
> > > >  			config_base |= ARMV8_PMU_INCLUDE_EL2;
> > > >  	} else {
> > > > -		if (attr->exclude_kernel)
> > > > -			config_base |= ARMV8_PMU_EXCLUDE_EL1;
> > > >  		if (!attr->exclude_hv)
> > > >  			config_base |= ARMV8_PMU_INCLUDE_EL2;
> > > 
> > > I'm not sure about the current use of exclude_hv here.  The comment says
> > > it's consistent with other architectures, but I can't find an example to
> > > confirm this, and I don't think we have a comparable thing to the split
> > > of the hypervisor between EL1 and EL2 we have on non-VHE.
> > 
> > FWIW, that comment came from this thread:
> > 
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2017-April/503908.html
> > 
> > That was painful enough at the time, so I'd /really/ prefer not to change
> > the semantics of this again if we can avoid it.
> 
> The comment makes sense for the is_kernel_in_hyp_mode() case.
> 
> However, for the !is_kernel_in_hyp_mode() case I can't see the current
> behavior of exclude_hv being similar in other architectures.
> 
> I don't think the current semantics of excluding EL2 on a non-VHE host
> system makes much sense, and I doubt anyone is using that for something
> meaningful.  I think changing behavior for excldue_hv to depend on
> is_hyp_mode_available rather than is_kernel_in_hyp_mode is the right
> thing to do which would also align the semantics with other
> architectures and between VHE and non-VHE.

Just for clarity, see below for the proposed patch - this disallows EL2
counting for !VHE when we have the capability to be a KVM host.

Subject: [PATCH] arm64: arm_pmu: Disallow EL2 counting on !VHE unless guest

When the kernel runs without VHE support it runs at EL1. However it switches
to EL2 when switching to and from KVM guests. The exclude_hv flag (for a !VHE
kernel) will include EL2 counting. The exclude_hv flag is intended to count
events associated with the hypervisor for the current instance, not the
overhead of the current instance's guests.

Let's disallow EL2 counting for !VHE when we know that we have the capability
to be a KVM host (by virtue that we booted in EL2) and thus probably aren't
a guest ourselves.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 arch/arm64/kernel/perf_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 1620a37..bd3f6ca 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -832,7 +832,7 @@ static int armv8pmu_set_event_filter(struct hw_perf_event *event,
        } else {
                if (attr->exclude_kernel)
                        config_base |= ARMV8_PMU_EXCLUDE_EL1;
-               if (!attr->exclude_hv)
+               if (!attr->exclude_hv && !is_hyp_mode_is_available())
                        config_base |= ARMV8_PMU_INCLUDE_EL2;
        }
        if (attr->exclude_user)
-- 
2.7.4

My only doubt about this is as follows. If, on a KVM host you run this:

perf stat -e cycles:H lkvm run ...

then on the VHE host the cycles reported represents the entire non-guest cycles
associated with running the guest.

On a !VHE, the cycles reported exclude EL2 (with or without this patch) and
thus you don't get a representation of all the non-guest cycles associated with
the guest. However without this patch you could at least still run:

perf stat -e cycles:H -e cycles:h lkvm run ...

and then add the two cycle counts together to get something comparative with
the VHE host.

If the above patch represents the desired semantics, then perhaps we must count
both EL1 and *EL2* for !exclude_kernel on !VHE. In fact I think we should do
this anyway and remove a little complexity from armv8pmu_set_event_filter.
Thoughts?

Thanks,

Andrew Murray

> 
> 
> Thanks,
> 
>     Christoffer

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
