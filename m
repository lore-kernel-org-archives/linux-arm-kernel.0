Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6798C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:14:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85C3F206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Zq/Gl0lD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85C3F206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LEGT76htsD4m3vHMxJCsiMvKnF3mRVCdNbUkWhP1IJA=; b=Zq/Gl0lDizj+S4
	LRChVJ5Rva+gXiKhIiScTC7rO0zDrPn2d9Hg586ugHj3EBY/meQsUrMQ+adLEclXDEsDp8DYDhUB/
	GFKckb8NkrxTLuLWgpmDGJe8UahGAITdW1WxjY7Y0IOaz4ZhGhITr2JXn57se1UP9NWvrmzkJBcwf
	bDQWt8uPkti/9Wi1gvL9ueC0VnBtAvrlSFGjiVzjnzRc+xtsBncatVBlXmUcmFqeftQ2jKR7eCU4X
	FFSa0gEkEooSP9BX8bNKZAAASQO0efYOgRS0F8fUaF/9uS1Ps9UMd7Rd0zq98avmib0tWU4Nv8Qjl
	MD9gF5rz2jTV5GG/uQWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggqH9-0002Wi-Uh; Tue, 08 Jan 2019 12:14:31 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggqH6-0002W3-3B
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 12:14:29 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C68DC1596;
 Tue,  8 Jan 2019 04:14:27 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D80A3F70D;
 Tue,  8 Jan 2019 04:14:27 -0800 (PST)
Date: Tue, 8 Jan 2019 13:14:25 +0100
From: Christoffer Dall <christoffer.dall@arm.com>
To: Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCH v8 4/5] arm64: arm_pmu: Add support for
 exclude_host/exclude_guest attributes
Message-ID: <20190108121425.GO10769@e113682-lin.lund.arm.com>
References: <1544610573-28446-1-git-send-email-andrew.murray@arm.com>
 <1544610573-28446-5-git-send-email-andrew.murray@arm.com>
 <20181218120226.GC25383@e113682-lin.lund.arm.com>
 <20190104153205.GA31479@edgewater-inn.cambridge.arm.com>
 <20190108101843.GH10769@e113682-lin.lund.arm.com>
 <20190108112512.GA56789@e119886-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190108112512.GA56789@e119886-lin.cambridge.arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_041428_144240_0AF89613 
X-CRM114-Status: GOOD (  35.57  )
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

On Tue, Jan 08, 2019 at 11:25:13AM +0000, Andrew Murray wrote:
> On Tue, Jan 08, 2019 at 11:18:43AM +0100, Christoffer Dall wrote:
> > On Fri, Jan 04, 2019 at 03:32:06PM +0000, Will Deacon wrote:
> > > On Tue, Dec 18, 2018 at 01:02:26PM +0100, Christoffer Dall wrote:
> > > > On Wed, Dec 12, 2018 at 10:29:32AM +0000, Andrew Murray wrote:
> > > > > Add support for the :G and :H attributes in perf by handling the
> > > > > exclude_host/exclude_guest event attributes.
> > > > > 
> > > > > We notify KVM of counters that we wish to be enabled or disabled on
> > > > > guest entry/exit and thus defer from starting or stopping :G events
> > > > > as per the events exclude_host attribute.
> > > > > 
> > > > > With both VHE and non-VHE we switch the counters between host/guest
> > > > > at EL2. We are able to eliminate counters counting host events on
> > > > > the boundaries of guest entry/exit when using :G by filtering out
> > > > > EL2 for exclude_host. However when using :H unless exclude_hv is set
> > > > > on non-VHE then there is a small blackout window at the guest
> > > > > entry/exit where host events are not captured.
> > > > > 
> > > > > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> > > > > ---
> > > > >  arch/arm64/kernel/perf_event.c | 51 ++++++++++++++++++++++++++++++++++++------
> > > > >  1 file changed, 44 insertions(+), 7 deletions(-)
> > > > > 
> > > > > diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> > > > > index de564ae..4a3c73d 100644
> > > > > --- a/arch/arm64/kernel/perf_event.c
> > > > > +++ b/arch/arm64/kernel/perf_event.c
> > > > > @@ -26,6 +26,7 @@
> > > > >  
> > > > >  #include <linux/acpi.h>
> > > > >  #include <linux/clocksource.h>
> > > > > +#include <linux/kvm_host.h>
> > > > >  #include <linux/of.h>
> > > > >  #include <linux/perf/arm_pmu.h>
> > > > >  #include <linux/platform_device.h>
> > > > > @@ -647,11 +648,26 @@ static inline int armv8pmu_enable_counter(int idx)
> > > > >  
> > > > >  static inline void armv8pmu_enable_event_counter(struct perf_event *event)
> > > > >  {
> > > > > +	struct perf_event_attr *attr = &event->attr;
> > > > >  	int idx = event->hw.idx;
> > > > > +	int flags = 0;
> > > > > +	u32 counter_bits = BIT(ARMV8_IDX_TO_COUNTER(idx));
> > > > >  
> > > > > -	armv8pmu_enable_counter(idx);
> > > > >  	if (armv8pmu_event_is_chained(event))
> > > > > -		armv8pmu_enable_counter(idx - 1);
> > > > > +		counter_bits |= BIT(ARMV8_IDX_TO_COUNTER(idx - 1));
> > > > > +
> > > > > +	if (!attr->exclude_host)
> > > > > +		flags |= KVM_PMU_EVENTS_HOST;
> > > > > +	if (!attr->exclude_guest)
> > > > > +		flags |= KVM_PMU_EVENTS_GUEST;
> > > > > +
> > > > > +	kvm_set_pmu_events(counter_bits, flags);
> > > > > +
> > > > > +	if (!attr->exclude_host) {
> > > > > +		armv8pmu_enable_counter(idx);
> > > > > +		if (armv8pmu_event_is_chained(event))
> > > > > +			armv8pmu_enable_counter(idx - 1);
> > > > > +	}
> > > > >  }
> > > > >  
> > > > >  static inline int armv8pmu_disable_counter(int idx)
> > > > > @@ -664,11 +680,20 @@ static inline int armv8pmu_disable_counter(int idx)
> > > > >  static inline void armv8pmu_disable_event_counter(struct perf_event *event)
> > > > >  {
> > > > >  	struct hw_perf_event *hwc = &event->hw;
> > > > > +	struct perf_event_attr *attr = &event->attr;
> > > > >  	int idx = hwc->idx;
> > > > > +	u32 counter_bits = BIT(ARMV8_IDX_TO_COUNTER(idx));
> > > > >  
> > > > >  	if (armv8pmu_event_is_chained(event))
> > > > > -		armv8pmu_disable_counter(idx - 1);
> > > > > -	armv8pmu_disable_counter(idx);
> > > > > +		counter_bits |= BIT(ARMV8_IDX_TO_COUNTER(idx - 1));
> > > > > +
> > > > > +	kvm_clr_pmu_events(counter_bits);
> > > > > +
> > > > > +	if (!attr->exclude_host) {
> > > > > +		if (armv8pmu_event_is_chained(event))
> > > > > +			armv8pmu_disable_counter(idx - 1);
> > > > > +		armv8pmu_disable_counter(idx);
> > > > > +	}
> > > > >  }
> > > > >  
> > > > >  static inline int armv8pmu_enable_intens(int idx)
> > > > > @@ -943,16 +968,25 @@ static int armv8pmu_set_event_filter(struct hw_perf_event *event,
> > > > >  	 * Therefore we ignore exclude_hv in this configuration, since
> > > > >  	 * there's no hypervisor to sample anyway. This is consistent
> > > > >  	 * with other architectures (x86 and Power).
> > > > > +	 *
> > > > > +	 * To eliminate counting host events on the boundaries of
> > > > > +	 * guest entry/exit we ensure EL2 is not included in hyp mode
> > > > > +	 * with !exclude_host.
> > > > >  	 */
> > > > >  	if (is_kernel_in_hyp_mode()) {
> > > > > -		if (!attr->exclude_kernel)
> > > > > +		if (!attr->exclude_kernel && !attr->exclude_host)
> > > > >  			config_base |= ARMV8_PMU_INCLUDE_EL2;
> > > > >  	} else {
> > > > > -		if (attr->exclude_kernel)
> > > > > -			config_base |= ARMV8_PMU_EXCLUDE_EL1;
> > > > >  		if (!attr->exclude_hv)
> > > > >  			config_base |= ARMV8_PMU_INCLUDE_EL2;
> > > > 
> > > > I'm not sure about the current use of exclude_hv here.  The comment says
> > > > it's consistent with other architectures, but I can't find an example to
> > > > confirm this, and I don't think we have a comparable thing to the split
> > > > of the hypervisor between EL1 and EL2 we have on non-VHE.
> > > 
> > > FWIW, that comment came from this thread:
> > > 
> > > http://lists.infradead.org/pipermail/linux-arm-kernel/2017-April/503908.html
> > > 
> > > That was painful enough at the time, so I'd /really/ prefer not to change
> > > the semantics of this again if we can avoid it.
> > 
> > The comment makes sense for the is_kernel_in_hyp_mode() case.
> > 
> > However, for the !is_kernel_in_hyp_mode() case I can't see the current
> > behavior of exclude_hv being similar in other architectures.
> > 
> > I don't think the current semantics of excluding EL2 on a non-VHE host
> > system makes much sense, and I doubt anyone is using that for something
> > meaningful.  I think changing behavior for excldue_hv to depend on
> > is_hyp_mode_available rather than is_kernel_in_hyp_mode is the right
> > thing to do which would also align the semantics with other
> > architectures and between VHE and non-VHE.
> 
> Just for clarity, see below for the proposed patch - this disallows EL2
> counting for !VHE when we have the capability to be a KVM host.
> 

That was not what I meant.  I think you want to count EL1 and EL2
together on a non-VHE host system.

What I had in mind was more
something like the following (completely untested, of course):

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index e213f8e867f6..37648bedf8b0 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -948,6 +948,11 @@ static int armv8pmu_set_event_filter(struct hw_perf_event *event,
 	if (is_kernel_in_hyp_mode()) {
 		if (!attr->exclude_kernel)
 			config_base |= ARMV8_PMU_INCLUDE_EL2;
+	} else if (is_hyp_mode_available()) {
+		if (attr->exclude_kernel)
+			config_base |= ARMV8_PMU_EXCLUDE_EL1;
+		else
+			config_base |= ARMV8_PMU_INCLUDE_EL2;
 	} else {
 		if (attr->exclude_kernel)
 			config_base |= ARMV8_PMU_EXCLUDE_EL1;


Thanks,

    Christoffer

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
