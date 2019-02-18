Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9D6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:03:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12AF42147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UvCVevVk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12AF42147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Zq2hZbBsdH0CNNWUMG3lYRlWencA0VN+TTLo5jPQ+zo=; b=UvCVevVkYukfUO
	Kx+bk9LVvn15MSzf40hSn3JPZ9qcMEgZ0tolrFWUDHU2eEKuwYA4z9VAU4pSvzzFKUtCOfDRTpRLy
	Qykor4HhYsM+e4e7TirK68ierhj9cXybgb+Hzox5+pOOZ55wAkcpA0fvOa6UU/l0Kka8HdxhNVzMn
	uHV3xu67g5phkqtulBPtZwFkGmmtgUrv+qnYvomBoYJ7rfSvwM4oK0zci2Xj8QMH68m0XigiG0vYD
	zPofJpzmKiRUOKjLm7Ygq0McxuBH9fpG4FDS2Kwx3zaOZfhk3nXX+FX2V6FhWrG2HqbyZ4h55ZZqa
	mPFpVNvXULolx8bGkdfg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvhdy-0004yC-2w; Mon, 18 Feb 2019 12:03:30 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvhdv-0004xk-71
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 12:03:29 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B209180D;
 Mon, 18 Feb 2019 04:03:22 -0800 (PST)
Received: from localhost (unknown [10.37.6.16])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FA7E3F720;
 Mon, 18 Feb 2019 04:03:06 -0800 (PST)
Date: Mon, 18 Feb 2019 12:03:05 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH v2 5/5] KVM: arm/arm64: support chained PMU counters
Message-ID: <20190218120305.GH54124@e119886-lin.cambridge.arm.com>
References: <1549299218-44714-1-git-send-email-andrew.murray@arm.com>
 <1549299218-44714-6-git-send-email-andrew.murray@arm.com>
 <11a8c800-5c1d-08ce-9d85-402ca89727a3@arm.com>
 <236797c3-9f3a-91d4-c859-e8eb4d3eb3ee@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <236797c3-9f3a-91d4-c859-e8eb4d3eb3ee@arm.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_040327_269900_BBE815EA 
X-CRM114-Status: GOOD (  25.92  )
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
Cc: marc.zyngier@arm.com, kvmarm@lists.cs.columbia.edu,
 christoffer.dall@arm.com, linux-arm-kernel@lists.infradead.org,
 julien.thierry@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 14, 2019 at 11:42:15AM +0000, Suzuki K Poulose wrote:
> 
> 
> On 05/02/2019 14:33, Julien Thierry wrote:
> > Hi Andrew,
> > 
> > On 04/02/2019 16:53, Andrew Murray wrote:
> > > Emulate chained PMU counters by creating a single 64 bit event counter
> > > for a pair of chained KVM counters.
> > > 
> > > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> > > ---
> > >   include/kvm/arm_pmu.h |   1 +
> > >   virt/kvm/arm/pmu.c    | 321 +++++++++++++++++++++++++++++++++++++++++---------
> > >   2 files changed, 269 insertions(+), 53 deletions(-)
> > > 
> > > diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
> > > index b73f31b..8e691ee 100644
> > > --- a/include/kvm/arm_pmu.h
> > > +++ b/include/kvm/arm_pmu.h
> > > @@ -29,6 +29,7 @@ struct kvm_pmc {
> > >   	u8 idx;	/* index into the pmu->pmc array */
> > >   	struct perf_event *perf_event;
> > >   	u64 bitmask;
> > > +	u64 overflow_count;
> > >   };
> > >   struct kvm_pmu {
> > > diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
> > > index a64aeb2..9318130 100644
> > > --- a/virt/kvm/arm/pmu.c
> > > +++ b/virt/kvm/arm/pmu.c
> > > @@ -24,9 +24,25 @@
> > >   #include <kvm/arm_pmu.h>
> > >   #include <kvm/arm_vgic.h>
> > > +#define ARMV8_PMUV3_PERFCTR_CHAIN 0x1E
> > 
> > I find it a bit awkward to have this redefined here.
> > 
> > Maybe we could define a helper in kvm_host.h:
> > bool kvm_pmu_typer_is_chain(u64 typer);
> > 
> > That would always return false for arm32?
> 
> We don't support ARMv7 host, so that doesn't matter. But
> it is a good idea to wrap it in a function here.

I'm not sure kvm_host.h is the right place for this as this really relates
to the ARM PMU drivers. Seeing that armv8pmu_filter_match in
arch/arm64/kernel/perf_event.c would also benefit from this new function I'll
add it to arch/arm64/include/asm/perf_event.h and stub it out in arm_pmu.c
for the ARM32 case.

> 
> > >   		kvm_vcpu_kick(vcpu);
> > > @@ -440,6 +632,10 @@ static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64 select_idx)
> > >   	    select_idx != ARMV8_PMU_CYCLE_IDX)
> > >   		return;
> > > +	/* Handled by even event */
> > > +	if (eventsel == ARMV8_PMUV3_PERFCTR_CHAIN)
> > > +		return;
> > > +
> > >   	memset(&attr, 0, sizeof(struct perf_event_attr));
> > >   	attr.type = PERF_TYPE_RAW;
> > >   	attr.size = sizeof(attr);
> > > @@ -452,6 +648,9 @@ static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64 select_idx)
> > >   	attr.config = (select_idx == ARMV8_PMU_CYCLE_IDX) ?
> > >   		ARMV8_PMUV3_PERFCTR_CPU_CYCLES : eventsel;
> > > +	if (kvm_pmu_event_is_chained(vcpu, select_idx))
> > > +		attr.config1 |= 0x1;
> > 
> > I'm not very familiar with the usage of perf attributes configs, but is
> > there any chance we could name this flag? Even if only for the local
> > file? Something like PERF_ATTR_CFG1_KVM_PMU_CHAINED (unless there is an
> > existing naming convention for event attributes).
> 
> There is ARPMU_EVT_64BIT in "linux/perf/arm_pmu.h". But in general we don't
> specify where the Bit goes in (i.e, CFG1 etc).

I'll add PERF_ATTR_CFG1_KVM_PMU_CHAINED to this file as you suggest.

Thanks,

Andrew Murray

> 
> Cheers
> Suzuki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
