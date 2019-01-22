Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F8FC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:10:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0DC720870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cZwe2IoQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0DC720870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ugLmCgdU+cKI/vqlhm0cAwmd1SA8TgrgHnened5YXyA=; b=cZwe2IoQH3H8L2FzPd06PCNa2
	SgCPyvYwe1WZK6EUXznZRL9RzYHanEbvn8S6aZxPxzHuVqMpUIyInxIIfLl0I2Na+lDmTnEoKvWn/
	NJsAJJS3noNiSoCNoqT1nUsZvhkdn2aEhIPq8NjDWNVWWZnFCY7107dwh4RhKY2kk2xkTtJLnQOc1
	bJBkXjTDg3YQi+xGMA5WFoOi1abd5RyMoM20bKb0cvgcvae86wvvLgct4LJJSi8TYl0FVcAFojnV4
	AMwxV+7WwSXDzTKJNSMIdQx3GC691kl+KxfuSFzUeDTRY5FrJPx5P2UUsiTmmJv0LXKDGt0iIxjDL
	2KnkhRk4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gm4Fi-0000Qp-CV; Tue, 22 Jan 2019 22:10:38 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gm4Ff-0000QN-3W
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 22:10:36 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5725A78;
 Tue, 22 Jan 2019 14:10:33 -0800 (PST)
Received: from [10.37.10.44] (unknown [10.37.10.44])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B7D33F5C1;
 Tue, 22 Jan 2019 14:10:32 -0800 (PST)
Subject: Re: [PATCH 3/4] KVM: arm/arm64: lazily create perf events on enable
To: andrew.murray@arm.com, christoffer.dall@arm.com, marc.zyngier@arm.com
References: <1548154197-5470-1-git-send-email-andrew.murray@arm.com>
 <1548154197-5470-4-git-send-email-andrew.murray@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <82bb5635-0bca-8326-03e1-084792dd939d@arm.com>
Date: Tue, 22 Jan 2019 22:12:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1548154197-5470-4-git-send-email-andrew.murray@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_141035_158533_3ECBF0DD 
X-CRM114-Status: GOOD (  28.17  )
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
Cc: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Andrew,

On 01/22/2019 10:49 AM, Andrew Murray wrote:
> To prevent re-creating perf events everytime the counter registers
> are changed, let's instead lazily create the event when the event
> is first enabled and destroy it when it changes.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>


> ---
>   virt/kvm/arm/pmu.c | 114 ++++++++++++++++++++++++++++++++++++-----------------
>   1 file changed, 78 insertions(+), 36 deletions(-)
> 
> diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
> index 4464899..1921ca9 100644
> --- a/virt/kvm/arm/pmu.c
> +++ b/virt/kvm/arm/pmu.c
> @@ -24,8 +24,11 @@
>   #include <kvm/arm_pmu.h>
>   #include <kvm/arm_vgic.h>
>   
> -static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64 data,
> -				      u64 select_idx);
> +static void kvm_pmu_reenable_enabled_single(struct kvm_vcpu *vcpu, u64 pair);

I find the approach good. However the function names are a bit odd and
it makes the code read a bit difficult.

I think we could :

1) Rename the existing
  kvm_pmu_{enable/disable}_counter => kvm_pmu_{enable/disable}_[mask or 
counters ]
as they operate on a set of counters (as a mask) instead of a single
counter.
And then you may be able to drop "_single" from
kvm_pmu_{enable/disable}_counter"_single() functions below, which makes
better sense for what they do.

> +static void kvm_pmu_counter_create_enabled_perf_event(struct kvm_vcpu *vcpu,
> +						      u64 select_idx);

Could we simply keep kvm_pmu_counter_create_event() and add a comment 
above the function explaining that the events are enabled as they are
created lazily ?

> +static void kvm_pmu_stop_counter(struct kvm_vcpu *vcpu, struct kvm_pmc *pmc);
> +
>   /**
>    * kvm_pmu_get_counter_value - get PMU counter value
>    * @vcpu: The vcpu pointer
> @@ -59,18 +62,16 @@ u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u64 select_idx)
>    */
>   void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu, u64 select_idx, u64 val)
>   {
> -	u64 reg, data;
> +	u64 reg;
> +	struct kvm_pmu *pmu = &vcpu->arch.pmu;
> +	struct kvm_pmc *pmc = &pmu->pmc[select_idx];
>   
>   	reg = (select_idx == ARMV8_PMU_CYCLE_IDX)
>   	      ? PMCCNTR_EL0 : PMEVCNTR0_EL0 + select_idx;
>   	__vcpu_sys_reg(vcpu, reg) += (s64)val - kvm_pmu_get_counter_value(vcpu, select_idx);
>   
> -	reg = (select_idx == ARMV8_PMU_CYCLE_IDX)
> -	      ? PMCCFILTR_EL0 : PMEVTYPER0_EL0 + select_idx;
> -	data = __vcpu_sys_reg(vcpu, reg + select_idx);
> -
> -	/* Recreate the perf event to reflect the updated sample_period */
> -	kvm_pmu_create_perf_event(vcpu, data, select_idx);
> +	kvm_pmu_stop_counter(vcpu, pmc);
> +	kvm_pmu_reenable_enabled_single(vcpu, select_idx);
>   }
>   
>   /**
> @@ -88,6 +89,7 @@ static void kvm_pmu_release_perf_event(struct kvm_pmc *pmc)
>   
>   /**
>    * kvm_pmu_stop_counter - stop PMU counter
> + * @vcpu: The vcpu pointer
>    * @pmc: The PMU counter pointer
>    *
>    * If this counter has been configured to monitor some event, release it here.
> @@ -150,6 +152,25 @@ u64 kvm_pmu_valid_counter_mask(struct kvm_vcpu *vcpu)
>   }
>   
>   /**
> + * kvm_pmu_enable_counter_single - create/enable a unpaired counter
> + * @vcpu: The vcpu pointer
> + * @select_idx: The counter index
> + */
> +static void kvm_pmu_enable_counter_single(struct kvm_vcpu *vcpu, u64 select_idx)
> +{
> +	struct kvm_pmu *pmu = &vcpu->arch.pmu;
> +	struct kvm_pmc *pmc = &pmu->pmc[select_idx];
> +
> +	if (!pmc->perf_event) {
> +		kvm_pmu_counter_create_enabled_perf_event(vcpu, select_idx);
> +	} else if (pmc->perf_event) {
> +		perf_event_enable(pmc->perf_event);
> +		if (pmc->perf_event->state != PERF_EVENT_STATE_ACTIVE)
> +			kvm_debug("fail to enable perf event\n");

nit: failed

> +	}
> +}
> +
> +/**
>    * kvm_pmu_enable_counter - enable selected PMU counter

nit: This is a bit misleading. We could be enabling a set of counters.
Please could we update the comment.

>    * @vcpu: The vcpu pointer
>    * @val: the value guest writes to PMCNTENSET register
> @@ -159,8 +180,6 @@ u64 kvm_pmu_valid_counter_mask(struct kvm_vcpu *vcpu)
>   void kvm_pmu_enable_counter(struct kvm_vcpu *vcpu, u64 val)
>   {
>   	int i;
> -	struct kvm_pmu *pmu = &vcpu->arch.pmu;
> -	struct kvm_pmc *pmc;
>   
>   	if (!(__vcpu_sys_reg(vcpu, PMCR_EL0) & ARMV8_PMU_PMCR_E) || !val)
>   		return;
> @@ -169,16 +188,44 @@ void kvm_pmu_enable_counter(struct kvm_vcpu *vcpu, u64 val)
>   		if (!(val & BIT(i)))
>   			continue;
>   
> -		pmc = &pmu->pmc[i];
> -		if (pmc->perf_event) {
> -			perf_event_enable(pmc->perf_event);
> -			if (pmc->perf_event->state != PERF_EVENT_STATE_ACTIVE)
> -				kvm_debug("fail to enable perf event\n");
> -		}
> +		kvm_pmu_enable_counter_single(vcpu, i);
>   	}
>   }
>   
>   /**
> + * kvm_pmu_reenable_enabled_single - reenable a counter if it should be enabled
> + * @vcpu: The vcpu pointer
> + * @select_idx: The counter index
> + */
> +static void kvm_pmu_reenable_enabled_single(struct kvm_vcpu *vcpu,
> +					    u64 select_idx)
> +{
> +	u64 mask = kvm_pmu_valid_counter_mask(vcpu);
> +	u64 set = __vcpu_sys_reg(vcpu, PMCNTENSET_EL0) & mask;
> +
> +	if (!(__vcpu_sys_reg(vcpu, PMCR_EL0) & ARMV8_PMU_PMCR_E))
> +		return;
> +
> +	if (set & BIT(select_idx))
> +		kvm_pmu_enable_counter_single(vcpu, select_idx);

Could we not reuse kvm_pmu_enable_counter() here :
	i.e,
static inline void kvm_pmu_reenable_counter(struct kvm_vcpu *vcpu, u64
						select_idx)
{
	kvm_pmu_enable_counter(vcpu, BIT(select_idx));
}

> +}
> +
> +/**
> + * kvm_pmu_disable_counter - disable selected PMU counter

Stale comment

> + * @vcpu: The vcpu pointer
> + * @pmc: The counter to dissable

nit: s/dissable/disable/

> + */
> +static void kvm_pmu_disable_counter_single(struct kvm_vcpu *vcpu,
> +					   u64 select_idx)
> +{
> +	struct kvm_pmu *pmu = &vcpu->arch.pmu;
> +	struct kvm_pmc *pmc = &pmu->pmc[select_idx];
> +
> +	if (pmc->perf_event)
> +		perf_event_disable(pmc->perf_event);
> +}
> +
> +/**
>    * kvm_pmu_disable_counter - disable selected PMU counter

While you are at this, please could you make the comment a bit more
clear. i.e, we disable a set of PMU counters not a single one.

Suzuki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
