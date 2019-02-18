Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6697C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:53:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4FA92085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TXB1zJ4d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4FA92085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vI2FFY7Ss72crCHqSB8evmhfX06+041PeR8fcXnILTA=; b=TXB1zJ4dOfUL/E
	FDvHtsQFBL1cIq+jzaY+ONizdACOq0Yno05Yy1meYGoGlR+7nlzuCun31Gh8D8UkfwKTR0+YkL4wK
	sQlkGLLHK1MxHAg7tyJtMEW/nhniTM9PS7+1VgREHZrGRcnvGiXjNElwtjP7qH+9nW/xDga5gKOUh
	rBNp1F4TG1w1kg1QRzBH+HBG7M/nZglrDYU69a93hlCi7oxVh24LKlV5CmjT2t6IJ1e+18f7uaXpE
	GDUy8cNbsPsNqaImxwSU30BmCBQJrzgISDjbpkkQ35Jg81PAbmHhg3qzUwu8sNcNts2Dh4nrWABmO
	BpL/aOzLJFZFT/jYHKUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvqqj-0003E7-Td; Mon, 18 Feb 2019 21:53:17 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvqqf-0003Ch-Qj
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 21:53:16 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36D3E80D;
 Mon, 18 Feb 2019 13:53:10 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BC603F675;
 Mon, 18 Feb 2019 13:53:09 -0800 (PST)
Date: Mon, 18 Feb 2019 22:53:07 +0100
From: Christoffer Dall <christoffer.dall@arm.com>
To: Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCH v10 4/5] arm64: arm_pmu: Add support for
 exclude_host/exclude_guest attributes
Message-ID: <20190218215307.GA28113@e113682-lin.lund.arm.com>
References: <1547482308-29839-1-git-send-email-andrew.murray@arm.com>
 <1547482308-29839-5-git-send-email-andrew.murray@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547482308-29839-5-git-send-email-andrew.murray@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_135314_114788_50D25DDC 
X-CRM114-Status: GOOD (  31.61  )
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
 Julien Thierry <julien.thierry@arm.com>, Will Deacon <will.deacon@arm.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 14, 2019 at 04:11:47PM +0000, Andrew Murray wrote:
> Add support for the :G and :H attributes in perf by handling the
> exclude_host/exclude_guest event attributes.
> 
> We notify KVM of counters that we wish to be enabled or disabled on
> guest entry/exit and thus defer from starting or stopping :G events
> as per the events exclude_host attribute.
> 
> With both VHE and non-VHE we switch the counters between host/guest
> at EL2. We are able to eliminate counters counting host events on
> the boundaries of guest entry/exit when using :G by filtering out
> EL2 for exclude_host. However when using :H unless exclude_hv is set
> on non-VHE then there is a small blackout window at the guest
> entry/exit where host events are not captured.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/kernel/perf_event.c | 53 ++++++++++++++++++++++++++++++++++++------
>  1 file changed, 46 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index 1c71796..21c6831 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -26,6 +26,7 @@
>  
>  #include <linux/acpi.h>
>  #include <linux/clocksource.h>
> +#include <linux/kvm_host.h>
>  #include <linux/of.h>
>  #include <linux/perf/arm_pmu.h>
>  #include <linux/platform_device.h>
> @@ -528,11 +529,27 @@ static inline int armv8pmu_enable_counter(int idx)
>  
>  static inline void armv8pmu_enable_event_counter(struct perf_event *event)
>  {
> +	struct perf_event_attr *attr = &event->attr;
>  	int idx = event->hw.idx;
> +	int flags = 0;
> +	u32 counter_bits = BIT(ARMV8_IDX_TO_COUNTER(idx));
>  
> -	armv8pmu_enable_counter(idx);
>  	if (armv8pmu_event_is_chained(event))
> -		armv8pmu_enable_counter(idx - 1);
> +		counter_bits |= BIT(ARMV8_IDX_TO_COUNTER(idx - 1));
> +
> +	if (!attr->exclude_host)
> +		flags |= KVM_PMU_EVENTS_HOST;
> +	if (!attr->exclude_guest)
> +		flags |= KVM_PMU_EVENTS_GUEST;
> +
> +	kvm_set_pmu_events(counter_bits, flags);
> +
> +	/* We rely on the hypervisor switch code to enable guest counters */
> +	if (!attr->exclude_host) {
> +		armv8pmu_enable_counter(idx);
> +		if (armv8pmu_event_is_chained(event))
> +			armv8pmu_enable_counter(idx - 1);
> +	}
>  }
>  
>  static inline int armv8pmu_disable_counter(int idx)
> @@ -545,11 +562,21 @@ static inline int armv8pmu_disable_counter(int idx)
>  static inline void armv8pmu_disable_event_counter(struct perf_event *event)
>  {
>  	struct hw_perf_event *hwc = &event->hw;
> +	struct perf_event_attr *attr = &event->attr;
>  	int idx = hwc->idx;
> +	u32 counter_bits = BIT(ARMV8_IDX_TO_COUNTER(idx));
>  
>  	if (armv8pmu_event_is_chained(event))
> -		armv8pmu_disable_counter(idx - 1);
> -	armv8pmu_disable_counter(idx);
> +		counter_bits |= BIT(ARMV8_IDX_TO_COUNTER(idx - 1));
> +
> +	kvm_clr_pmu_events(counter_bits);
> +
> +	/* We rely on the hypervisor switch code to disable guest counters */
> +	if (!attr->exclude_host) {
> +		if (armv8pmu_event_is_chained(event))
> +			armv8pmu_disable_counter(idx - 1);
> +		armv8pmu_disable_counter(idx);
> +	}
>  }
>  
>  static inline int armv8pmu_enable_intens(int idx)
> @@ -824,16 +851,25 @@ static int armv8pmu_set_event_filter(struct hw_perf_event *event,
>  	 * Therefore we ignore exclude_hv in this configuration, since
>  	 * there's no hypervisor to sample anyway. This is consistent
>  	 * with other architectures (x86 and Power).
> +	 *
> +	 * To eliminate counting host events on the boundaries of
					   ^comma

> +	 * guest entry/exit we ensure EL2 is not included in hyp mode
			   ^comma (or rework sentence)

What do you mean by "EL2 is not included in hyp mode" ??

> +	 * with !exclude_host.
>  	 */
>  	if (is_kernel_in_hyp_mode()) {
> -		if (!attr->exclude_kernel)
> +		if (!attr->exclude_kernel && !attr->exclude_host)
>  			config_base |= ARMV8_PMU_INCLUDE_EL2;
>  	} else {
> -		if (attr->exclude_kernel)
> -			config_base |= ARMV8_PMU_EXCLUDE_EL1;
>  		if (!attr->exclude_hv)
>  			config_base |= ARMV8_PMU_INCLUDE_EL2;
>  	}
> +
> +	/*
> +	 * Filter out !VHE kernels and guest kernels
> +	 */
> +	if (attr->exclude_kernel)
> +		config_base |= ARMV8_PMU_EXCLUDE_EL1;
> +

Let me see if I get this right:

	exclude_user:	VHE: Don't count EL0
			Non-VHE: Don't count EL0

	exclude_kernel: VHE: Don't count EL2 and don't count EL1
			Non-VHE: Don't count EL1

	exclude_hv:	VHE: No effect
			Non-VHE: Don't count EL2

	exclude_host:	VHE: Don't count EL2 + enable/disable on guest entry/exit
			Non-VHE: disable on guest entry/disable on guest entry/exit

And the logic I extract is that _user applies across both guest and
host, as does _kernel (regardless of the mode the kernel on the current
system runs in, might be only EL1, might be EL1 and EL2), and _hv is
specific to non-VHE systems to measure events in a specific piece of KVM
code that runs at EL2.

As I expressed before, that doesn't seem to be the intent behind the
exclude_hv flag, but I'm not sure how other architectures actually
implement things today, and even if it's a curiosity of the Arm
architecture and has value to non-VHE hypervisor hackers, and we don't
really have to care about uniformity with the other architectures, then
fine.

It has taken me a while to make sense of this code change, so I really
wish we can find a suitable place to document the semantics clearly for
perf users on arm64.

Now, another thing comes to mind:  Do we really need to enable and
disable anything on a VHE system on entry/exit to/from a guest?  Can we
instead do the following:

	exclude_host:	Disable EL2 counting
		     	Disable EL0 counting
		     	Enable EL0 counting on vcpu_load
		     	  (unless exclude_user is also set)
		     	Disable EL0 counting on vcpu_put

	exclude_guest:	Disable EL1 counting
		      	Disable EL0 counting on vcpu_load
		      	Enable EL0 counting on vcpu_put
			  (unless exclude_user is also set)

If that works, we can avoid the overhead in the critical path on VHE
systems and actually have slightly more accurate counting, leaving the
entry/exit operations to be specific to non-VHE.


Thanks,

    Christoffer

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
