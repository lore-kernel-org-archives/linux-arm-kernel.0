Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2000DC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:25:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6A01218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="isFkEjZy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A01218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RVkCydm+/f9kt69fRYjSZ+moVRu6ty01ju2uXn3WYzE=; b=isFkEjZy+rrTOOlxjPeThu5j/
	vJBnKPZL3xmLzmP9r2wytZaw74gxaGZ0lOC48k/HbRoJkGz2tgOP0liBdkhTz2Fos1BkdQCi5IFG5
	0Ue9TNm8AVaACsrOTrV85rI8wO6n5VSKTqkfkjVFTNXZQ2I2Ud/6VaJJmDMHi8xdY7i++wrXGpRpP
	I6mJotSTt9WiJzaSmaW3+Z6hNsaYQNX+b8X975xahAGRb5EBqKWDgoIlThVjRMV1x4ysMecraNLTm
	5mG7dbowMgDqWAbCAm8105HZyF1W+KYb0WzzBZ/glnFk+oPJGsYYeSdQg4Mc8FkIpuwsiI89H+dmi
	F+42MgjFw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmjgu-0001St-4x; Thu, 24 Jan 2019 18:25:28 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmjgq-0001SY-J6
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 18:25:25 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB75FA78;
 Thu, 24 Jan 2019 10:25:23 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54AC93F237;
 Thu, 24 Jan 2019 10:25:21 -0800 (PST)
Subject: Re: [PATCH v5 2/4] perf: add arm64 smmuv3 pmu driver
To: Andrew Murray <andrew.murray@arm.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
References: <20181130154751.28580-1-shameerali.kolothum.thodi@huawei.com>
 <20181130154751.28580-3-shameerali.kolothum.thodi@huawei.com>
 <20190122162351.GE8120@e119886-lin.cambridge.arm.com>
 <5FC3163CFD30C246ABAA99954A238FA83929855B@lhreml524-mbs.china.huawei.com>
 <20190123121406.GH8120@e119886-lin.cambridge.arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <f83054eb-3fe3-0041-7a9f-6f7e58cea5c8@arm.com>
Date: Thu, 24 Jan 2019 18:25:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190123121406.GH8120@e119886-lin.cambridge.arm.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_102524_643076_65685A97 
X-CRM114-Status: GOOD (  17.82  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "vkilari@codeaurora.org" <vkilari@codeaurora.org>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "neil.m.leeder@gmail.com" <neil.m.leeder@gmail.com>,
 "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>,
 "pabba@codeaurora.org" <pabba@codeaurora.org>,
 John Garry <john.garry@huawei.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "rruigrok@codeaurora.org" <rruigrok@codeaurora.org>,
 Linuxarm <linuxarm@huawei.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "Guohanjun \(Hanjun Guo\)" <guohanjun@huawei.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 23/01/2019 12:14, Andrew Murray wrote:
[...]
>>>> +static inline void smmu_pmu_counter_set_value(struct smmu_pmu
>>> *smmu_pmu,
>>>> +					      u32 idx, u64 value)
>>>> +{
>>>> +	if (smmu_pmu->counter_mask & BIT(32))
>>>> +		writeq(value, smmu_pmu->reloc_base + SMMU_PMCG_EVCNTR(idx,
>>> 8));
>>>> +	else
>>>> +		writel(value, smmu_pmu->reloc_base + SMMU_PMCG_EVCNTR(idx,
>>> 4));
>>>
>>> The arm64 IO macros use __force u32 and so it's probably OK to provide a 64
>>> bit
>>> value to writel. But you could use something like lower_32_bits for clarity.
>>
>> Yes, macro uses __force u32. I will change it to make it more clear though.

To be pedantic, the first cast which the value actually undergoes is to 
(__u32) ;)

Ultimately, __raw_writel() takes a u32, so in that sense it's never a 
problem to pass a u64, since unsigned truncation is well-defined in the 
C standard. The casting involved in the I/O accessors is mostly about 
going to an endian-specific type and back again.

[...]
>>>> +static void smmu_pmu_event_start(struct perf_event *event, int flags)
>>>> +{
>>>> +	struct smmu_pmu *smmu_pmu = to_smmu_pmu(event->pmu);
>>>> +	struct hw_perf_event *hwc = &event->hw;
>>>> +	int idx = hwc->idx;
>>>> +	u32 filter_span, filter_sid;
>>>> +	u32 evtyper;
>>>> +
>>>> +	hwc->state = 0;
>>>> +
>>>> +	smmu_pmu_set_period(smmu_pmu, hwc);
>>>> +
>>>> +	smmu_pmu_get_event_filter(event, &filter_span, &filter_sid);
>>>> +
>>>> +	evtyper = get_event(event) |
>>>> +		  filter_span << SMMU_PMCG_SID_SPAN_SHIFT;
>>>> +
>>>> +	smmu_pmu_set_evtyper(smmu_pmu, idx, evtyper);
>>>> +	smmu_pmu_set_smr(smmu_pmu, idx, filter_sid);
>>>> +	smmu_pmu_interrupt_enable(smmu_pmu, idx);
>>>> +	smmu_pmu_counter_enable(smmu_pmu, idx);
>>>> +}
>>>> +
>>>> +static void smmu_pmu_event_stop(struct perf_event *event, int flags)
>>>> +{
>>>> +	struct smmu_pmu *smmu_pmu = to_smmu_pmu(event->pmu);
>>>> +	struct hw_perf_event *hwc = &event->hw;
>>>> +	int idx = hwc->idx;
>>>> +
>>>> +	if (hwc->state & PERF_HES_STOPPED)
>>>> +		return;
>>>> +
>>>> +	smmu_pmu_counter_disable(smmu_pmu, idx);
>>>
>>> Is it intentional not to call smmu_pmu_interrupt_disable here?
>>
>> Yes, it is. Earlier patch had the interrupt toggling and Robin pointed out that
>> it is not really needed as counters are anyway stopped and explicitly disabling
>> may not solve the spurious interrupt case as well.
>>
> 
> Ah apologies for not seeing that in earlier reviews.

Hmm, I didn't exactly mean "keep enabling it every time an event is 
restarted and never disable it anywhere", though. I was thinking more 
along the lines of enabling in event_add() and disabling in event_del() 
(i.e. effectively tying it to allocation and deallocation of the counter).

Robin.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
