Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C29C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:49:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B45872171F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sBNEqxpq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B45872171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5xL/L/b1mJyEtvT0x7cpKwUPAteGwSkDr2/NEFMkvxs=; b=sBNEqxpqi8Z3TJ
	9+EhSOK4G9lhDSeXiiyW+DeWs+uNSfrjfqWzwSWUKxZW1xO1bt1zP12hiZMTnfPqIq0xT2lTqlTNQ
	fMHJH61dx1m7QBGbUvCrTEcQsF4a8H0HVQBpkS77JFwtesPp/1iMLJPdfwpsSExAPAUqOmda4yUR0
	nsquPIHb8Q1Buf2AlFvN/VJhztKE9eGGl3+6J7LJSjg2pXGwQe1WBuLgrJZ7Lm75LPEAHNKlPb0ML
	CgXw3glJ6ijQ5GgbpyqZBvPXqdVBWrv0qsH0mnef2VCHtMdX2T78hhxkPHrgrm/lUF9Z9UVIcd/MZ
	J6BwBvJaeOHAp2nkeQuw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go8E9-0000Kd-AN; Mon, 28 Jan 2019 14:49:33 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go8E5-0000KC-Oe
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 14:49:31 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0545B80D;
 Mon, 28 Jan 2019 06:49:29 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CEF33F589;
 Mon, 28 Jan 2019 06:49:26 -0800 (PST)
Subject: Re: [PATCH v9 22/26] irqchip/gic-v3: Allow interrupts to be set as
 pseudo-NMI
To: "liwei (GF)" <liwei391@huawei.com>, linux-arm-kernel@lists.infradead.org, 
 marc.zyngier@arm.com
References: <1548084825-8803-1-git-send-email-julien.thierry@arm.com>
 <1548084825-8803-23-git-send-email-julien.thierry@arm.com>
 <8c0efe3f-1fc7-cbc7-0086-bd9c379cf0fc@huawei.com>
 <315b0845-441d-4e02-d0a8-03769b63caee@arm.com>
 <b6fa5a94-fce9-dafa-f470-5ffb196ed666@huawei.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <81871e75-69a5-c750-0325-a1bc539c2222@arm.com>
Date: Mon, 28 Jan 2019 14:49:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <b6fa5a94-fce9-dafa-f470-5ffb196ed666@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_064929_827855_A3822440 
X-CRM114-Status: GOOD (  22.66  )
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
Cc: mark.rutland@arm.com, daniel.thompson@linaro.org,
 Jason Cooper <jason@lakedaemon.net>, catalin.marinas@arm.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, christoffer.dall@arm.com,
 james.morse@arm.com, libin 00196512 <huawei.libin@huawei.com>,
 guohanjun 00470146 <guohanjun@huawei.com>, joel@joelfernandes.org,
 Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 28/01/2019 13:59, liwei (GF) wrote:
> Hello Julien & Marc,
> Thanks for your reply, I misunderstood the usage of ready_percpu_nmi() and
> teardown_percpu_nmi() indeed.
> I think that adding a note about this in the comment of request_percpu_nmi() will be nice.

Yes, that's a good suggestion, I'll add that.

Also, if this helps, I have been working on some patches that are not
fully ready for submission to make the Arm PMU interrupt into an NMI (I
was holding onto them until this series would be merged).

I pushed them on this branch:
http://linux-arm.org/linux-jt.git -b nmi_for_pmu

Thanks,

Julien

> On 2019/1/28 16:57, Julien Thierry wrote:
>> Hi,
>>
>> On 26/01/2019 10:19, liwei (GF) wrote:
>>>
>>>
>>> On 2019/1/21 23:33, Julien Thierry wrote:
>>>> Implement NMI callbacks for GICv3 irqchip. Install NMI safe handlers
>>>> when setting up interrupt line as NMI.
>>>>
>>>> Only SPIs and PPIs are allowed to be set up as NMI.
>>>>
>>>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>> Cc: Jason Cooper <jason@lakedaemon.net>
>>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>>> ---
>>>>  drivers/irqchip/irq-gic-v3.c | 84 ++++++++++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 84 insertions(+)
>>>>
>>>> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>>>> index 4df1e94..447d8ab 100644
>>>> --- a/drivers/irqchip/irq-gic-v3.c
>>>> +++ b/drivers/irqchip/irq-gic-v3.c
>>> (snip)
>>>>  
>>>> +static int gic_irq_nmi_setup(struct irq_data *d)
>>>> +{
>>>> +	struct irq_desc *desc = irq_to_desc(d->irq);
>>>> +
>>>> +	if (!gic_supports_nmi())
>>>> +		return -EINVAL;
>>>> +
>>>> +	if (gic_peek_irq(d, GICD_ISENABLER)) {
>>>> +		pr_err("Cannot set NMI property of enabled IRQ %u\n", d->irq);
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	/*
>>>> +	 * A secondary irq_chip should be in charge of LPI request,
>>>> +	 * it should not be possible to get there
>>>> +	 */
>>>> +	if (WARN_ON(gic_irq(d) >= 8192))
>>>> +		return -EINVAL;
>>>> +
>>>> +	/* desc lock should already be held */
>>>> +	if (gic_irq(d) < 32) {
>>>> +		/* Setting up PPI as NMI, only switch handler for first NMI */
>>>> +		if (!refcount_inc_not_zero(&ppi_nmi_refs[gic_irq(d) - 16])) {
>>>> +			refcount_set(&ppi_nmi_refs[gic_irq(d) - 16], 1);
>>>> +			desc->handle_irq = handle_percpu_devid_fasteoi_nmi;
>>>> +		}
>>>> +	} else {
>>>> +		desc->handle_irq = handle_fasteoi_nmi;
>>>> +	}
>>>> +
>>>> +	gic_set_irq_prio(gic_irq(d), gic_dist_base(d), GICD_INT_NMI_PRI);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static void gic_irq_nmi_teardown(struct irq_data *d)
>>>> +{
>>>> +	struct irq_desc *desc = irq_to_desc(d->irq);
>>>> +
>>>> +	if (WARN_ON(!gic_supports_nmi()))
>>>> +		return;
>>>> +
>>>> +	if (gic_peek_irq(d, GICD_ISENABLER)) {
>>>> +		pr_err("Cannot set NMI property of enabled IRQ %u\n", d->irq);
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	/*
>>>> +	 * A secondary irq_chip should be in charge of LPI request,
>>>> +	 * it should not be possible to get there
>>>> +	 */
>>>> +	if (WARN_ON(gic_irq(d) >= 8192))
>>>> +		return;
>>>> +
>>>> +	/* desc lock should already be held */
>>>> +	if (gic_irq(d) < 32) {
>>>> +		/* Tearing down NMI, only switch handler for last NMI */
>>>> +		if (refcount_dec_and_test(&ppi_nmi_refs[gic_irq(d) - 16]))
>>>> +			desc->handle_irq = handle_percpu_devid_irq;
>>>> +	} else {
>>>> +		desc->handle_irq = handle_fasteoi_irq;
>>>> +	}
>>>> +
>>>> +	gic_set_irq_prio(gic_irq(d), gic_dist_base(d), GICD_INT_DEF_PRI);
>>>> +}
>>>> +
>>>
>>> Hello Julien,
>>> I am afraid the setting of priority is not correct here. If the irq is in redistributor(gic_irq(d) < 32),
>>> we should set the priority on each cpu, while we just set the priority on the current cpu here.
>>
>> As Marc stated, to work with PPIs, the core IRQ API provides a set of
>> *_percpu_irq functions (request, enable, disable...).
>>
>> The current idea is that the driver is in charge of calling
>> ready_percpu_nmi() before enabling on the correct CPU, in a similar
>> manner that the driver is in charge of calling enable_percpu_irq() and
>> disable_percpu_irq() on the correct CPU.
>>
>>
>>> static inline void __iomem *gic_dist_base(struct irq_data *d)
>>> {
>>> 	if (gic_irq_in_rdist(d))	/* SGI+PPI -> SGI_base for this CPU */
>>> 		return gic_data_rdist_sgi_base();
>>>
>>> 	if (d->hwirq <= 1023)		/* SPI -> dist_base */
>>> 		return gic_data.dist_base;
>>>
>>> 	return NULL;
>>> }
>>>
>>> I tried to add a smp_call_function here, but the kernel reported a warning as we have disabled irq
>>> when calling raw_spin_lock_irqsave in request_nmi or ready_percpu_nmi.
>>> [    2.137262] Call trace:
>>> [    2.137265]  smp_call_function_many+0xf8/0x3a0
>>> [    2.137267]  smp_call_function+0x40/0x58
>>> [    2.137271]  gic_irq_nmi_setup+0xe8/0x118
>>> [    2.137275]  ready_percpu_nmi+0x6c/0xf0> [    2.137279]  armpmu_request_irq+0x228/0x250
>>
>> Your issue lies here, if your PMU IRQ is a PPI, you shouldn't be calling
>> ready_percpu_nmi() at the time you request but probably somewhere like
>> arm_perf_starting_cpu().
>>
>> And you wouldn't need the smp_call to set the priority.
>>
>> Hope this helps.
>>
>>> [    2.137281]  arm_pmu_acpi_init+0x150/0x2f0
>>> [    2.137284]  do_one_initcall+0x54/0x218
>>> [    2.137289]  kernel_init_freeable+0x230/0x354
>>> [    2.137293]  kernel_init+0x18/0x118
>>> [    2.137295]  ret_from_fork+0x10/0x18
>>>
>>
>> Thanks,
>>
> 

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
