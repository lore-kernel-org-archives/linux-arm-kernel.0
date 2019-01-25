Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CC8C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:22:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA9F0218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RSLL6muR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA9F0218D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QiwSeIQXZaBANr+P7LFzbYo2GHWinKbbWfsL2H01ZOo=; b=RSLL6muRku/cVb
	JZWnV6X28MKJFCG0IBAWdaR1L4Xbl2jOreXQlwbDjNlTU1/h8JWsW1QKv/V11tQlTAYRPXVbP+bxd
	VYyTFbL/GbU4VbZJnY1FYtwTnWgNvejQkgUHCCo/pCjbMth65mvQq6L1HB8mLii5CUq50zDOmAPjT
	YlYchvI9sTwkWMgBriB4DMZ3tIhI6DP09rd5byz8PgTrvoiKr8vW1JvhHNFT/C37spp19Yc2udNqQ
	+7GqomfhrJWFcofodfBShoAjrzCabXyhtQ6L9668Rl9jiRXNvgqQBwuPUJ5ZYeAEeqiuJERifnJts
	G4jNrsEA0U+sjgd288kA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmxhA-0006kY-2t; Fri, 25 Jan 2019 09:22:40 +0000
Received: from lhrrgout.huawei.com ([185.176.76.210] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmxh6-0006jD-8N
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 09:22:38 +0000
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.106])
 by Forcepoint Email with ESMTP id 0976B46FACFCFDBABD7C;
 Fri, 25 Jan 2019 09:22:31 +0000 (GMT)
Received: from LHREML524-MBS.china.huawei.com ([169.254.2.138]) by
 LHREML711-CAH.china.huawei.com ([10.201.108.34]) with mapi id 14.03.0415.000; 
 Fri, 25 Jan 2019 09:22:24 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Robin Murphy <robin.murphy@arm.com>, Andrew Murray <andrew.murray@arm.com>
Subject: RE: [PATCH v5 2/4] perf: add arm64 smmuv3 pmu driver
Thread-Topic: [PATCH v5 2/4] perf: add arm64 smmuv3 pmu driver
Thread-Index: AQHUiMReCYaliznTZUOBIOWTrrVwNqW7zC+AgAEf2sCAACyzAIAB+g2AgAD1H7A=
Date: Fri, 25 Jan 2019 09:22:23 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83929A9FE@lhreml524-mbs.china.huawei.com>
References: <20181130154751.28580-1-shameerali.kolothum.thodi@huawei.com>
 <20181130154751.28580-3-shameerali.kolothum.thodi@huawei.com>
 <20190122162351.GE8120@e119886-lin.cambridge.arm.com>
 <5FC3163CFD30C246ABAA99954A238FA83929855B@lhreml524-mbs.china.huawei.com>
 <20190123121406.GH8120@e119886-lin.cambridge.arm.com>
 <f83054eb-3fe3-0041-7a9f-6f7e58cea5c8@arm.com>
In-Reply-To: <f83054eb-3fe3-0041-7a9f-6f7e58cea5c8@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.237]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_012236_440795_D671DCDB 
X-CRM114-Status: GOOD (  21.19  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy@arm.com]
> Sent: 24 January 2019 18:25
> To: Andrew Murray <andrew.murray@arm.com>; Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>
> Cc: lorenzo.pieralisi@arm.com; mark.rutland@arm.com;
> vkilari@codeaurora.org; neil.m.leeder@gmail.com;
> jean-philippe.brucker@arm.com; pabba@codeaurora.org; John Garry
> <john.garry@huawei.com>; will.deacon@arm.com; rruigrok@codeaurora.org;
> Linuxarm <linuxarm@huawei.com>; linux-kernel@vger.kernel.org;
> linux-acpi@vger.kernel.org; Guohanjun (Hanjun Guo)
> <guohanjun@huawei.com>; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH v5 2/4] perf: add arm64 smmuv3 pmu driver
> 
> On 23/01/2019 12:14, Andrew Murray wrote:
> [...]
> >>>> +static inline void smmu_pmu_counter_set_value(struct smmu_pmu
> >>> *smmu_pmu,
> >>>> +					      u32 idx, u64 value)
> >>>> +{
> >>>> +	if (smmu_pmu->counter_mask & BIT(32))
> >>>> +		writeq(value, smmu_pmu->reloc_base +
> SMMU_PMCG_EVCNTR(idx,
> >>> 8));
> >>>> +	else
> >>>> +		writel(value, smmu_pmu->reloc_base +
> SMMU_PMCG_EVCNTR(idx,
> >>> 4));
> >>>
> >>> The arm64 IO macros use __force u32 and so it's probably OK to provide a
> 64
> >>> bit
> >>> value to writel. But you could use something like lower_32_bits for clarity.
> >>
> >> Yes, macro uses __force u32. I will change it to make it more clear though.
> 
> To be pedantic, the first cast which the value actually undergoes is to
> (__u32) ;)
> 
> Ultimately, __raw_writel() takes a u32, so in that sense it's never a
> problem to pass a u64, since unsigned truncation is well-defined in the
> C standard. The casting involved in the I/O accessors is mostly about
> going to an endian-specific type and back again.
> 
> [...]
> >>>> +static void smmu_pmu_event_start(struct perf_event *event, int flags)
> >>>> +{
> >>>> +	struct smmu_pmu *smmu_pmu = to_smmu_pmu(event->pmu);
> >>>> +	struct hw_perf_event *hwc = &event->hw;
> >>>> +	int idx = hwc->idx;
> >>>> +	u32 filter_span, filter_sid;
> >>>> +	u32 evtyper;
> >>>> +
> >>>> +	hwc->state = 0;
> >>>> +
> >>>> +	smmu_pmu_set_period(smmu_pmu, hwc);
> >>>> +
> >>>> +	smmu_pmu_get_event_filter(event, &filter_span, &filter_sid);
> >>>> +
> >>>> +	evtyper = get_event(event) |
> >>>> +		  filter_span << SMMU_PMCG_SID_SPAN_SHIFT;
> >>>> +
> >>>> +	smmu_pmu_set_evtyper(smmu_pmu, idx, evtyper);
> >>>> +	smmu_pmu_set_smr(smmu_pmu, idx, filter_sid);
> >>>> +	smmu_pmu_interrupt_enable(smmu_pmu, idx);
> >>>> +	smmu_pmu_counter_enable(smmu_pmu, idx);
> >>>> +}
> >>>> +
> >>>> +static void smmu_pmu_event_stop(struct perf_event *event, int flags)
> >>>> +{
> >>>> +	struct smmu_pmu *smmu_pmu = to_smmu_pmu(event->pmu);
> >>>> +	struct hw_perf_event *hwc = &event->hw;
> >>>> +	int idx = hwc->idx;
> >>>> +
> >>>> +	if (hwc->state & PERF_HES_STOPPED)
> >>>> +		return;
> >>>> +
> >>>> +	smmu_pmu_counter_disable(smmu_pmu, idx);
> >>>
> >>> Is it intentional not to call smmu_pmu_interrupt_disable here?
> >>
> >> Yes, it is. Earlier patch had the interrupt toggling and Robin pointed out that
> >> it is not really needed as counters are anyway stopped and explicitly
> disabling
> >> may not solve the spurious interrupt case as well.
> >>
> >
> > Ah apologies for not seeing that in earlier reviews.
> 
> Hmm, I didn't exactly mean "keep enabling it every time an event is
> restarted and never disable it anywhere", though. I was thinking more
> along the lines of enabling in event_add() and disabling in event_del()
> (i.e. effectively tying it to allocation and deallocation of the counter).
> 

Right. I missed the point that it was not disabled at all!. I will rearrange it 
to _add/_del path. 

Thanks for all the comments. I am planning to send out a v6 soon. 
Between, did you get a chance to take a look at patch #4 (HiSilicon erratum one) ? 
Appreciate if you could take a look and let me know before v6.

Thanks,
Shameer

 
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
