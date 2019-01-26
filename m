Return-Path: <SRS0=wPy5=QC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B073CC282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:20:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EACB218F0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SLrcb2zA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EACB218F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:Subject:From:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=El/lTb3hUnZe+dcjpyufm4TQEbLaFdnrBjHNhIFZkHg=; b=SLrcb2zAP7X7Xt
	HJYp2MXnXsHgziwmwrJOP7Og0OgiR73PovgC7FBIPNkUlQkLWANfrOqTxN1qBHRz+h18R1zZxaJih
	lQYo8nmTiaRIaEaccXZLmPRVZIokuCi6K4Ag/bFXLvygf2n8rhUIdfe8SXn71n7Le3O30jzgHfLI9
	uIDLK7fbY3SgnFe5kwhZsw/tHr/DWmN3UB1pIZO9c8CJDQr4jnroobO58PT/COar80flnvZ3/eOrg
	Pw6c83LhtmCmp0Q/Dpp5T3sQiRMgbs16M8bmf9xHhSrf4pwI0UmO94GnZkXZwG2ii5mESm8Lz4SUv
	Jok1efVTdsN2kNNbwsng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnL4l-0002ml-7q; Sat, 26 Jan 2019 10:20:35 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnL4h-0002lo-Di
 for linux-arm-kernel@lists.infradead.org; Sat, 26 Jan 2019 10:20:33 +0000
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 55EE481A7C89EC101583;
 Sat, 26 Jan 2019 18:20:22 +0800 (CST)
Received: from [127.0.0.1] (10.184.212.80) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Sat, 26 Jan 2019
 18:20:17 +0800
From: "liwei (GF)" <liwei391@huawei.com>
Subject: Re: [PATCH v9 22/26] irqchip/gic-v3: Allow interrupts to be set as
 pseudo-NMI
To: Julien Thierry <julien.thierry@arm.com>,
 <linux-arm-kernel@lists.infradead.org>
References: <1548084825-8803-1-git-send-email-julien.thierry@arm.com>
 <1548084825-8803-23-git-send-email-julien.thierry@arm.com>
Message-ID: <8c0efe3f-1fc7-cbc7-0086-bd9c379cf0fc@huawei.com>
Date: Sat, 26 Jan 2019 18:19:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548084825-8803-23-git-send-email-julien.thierry@arm.com>
X-Originating-IP: [10.184.212.80]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190126_022031_635816_E0FB7838 
X-CRM114-Status: GOOD (  18.02  )
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
 Jason Cooper <jason@lakedaemon.net>, marc.zyngier@arm.com,
 catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 christoffer.dall@arm.com, james.morse@arm.com, joel@joelfernandes.org,
 Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 2019/1/21 23:33, Julien Thierry wrote:
> Implement NMI callbacks for GICv3 irqchip. Install NMI safe handlers
> when setting up interrupt line as NMI.
> 
> Only SPIs and PPIs are allowed to be set up as NMI.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/irqchip/irq-gic-v3.c | 84 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 4df1e94..447d8ab 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
(snip)
>  
> +static int gic_irq_nmi_setup(struct irq_data *d)
> +{
> +	struct irq_desc *desc = irq_to_desc(d->irq);
> +
> +	if (!gic_supports_nmi())
> +		return -EINVAL;
> +
> +	if (gic_peek_irq(d, GICD_ISENABLER)) {
> +		pr_err("Cannot set NMI property of enabled IRQ %u\n", d->irq);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * A secondary irq_chip should be in charge of LPI request,
> +	 * it should not be possible to get there
> +	 */
> +	if (WARN_ON(gic_irq(d) >= 8192))
> +		return -EINVAL;
> +
> +	/* desc lock should already be held */
> +	if (gic_irq(d) < 32) {
> +		/* Setting up PPI as NMI, only switch handler for first NMI */
> +		if (!refcount_inc_not_zero(&ppi_nmi_refs[gic_irq(d) - 16])) {
> +			refcount_set(&ppi_nmi_refs[gic_irq(d) - 16], 1);
> +			desc->handle_irq = handle_percpu_devid_fasteoi_nmi;
> +		}
> +	} else {
> +		desc->handle_irq = handle_fasteoi_nmi;
> +	}
> +
> +	gic_set_irq_prio(gic_irq(d), gic_dist_base(d), GICD_INT_NMI_PRI);
> +
> +	return 0;
> +}
> +
> +static void gic_irq_nmi_teardown(struct irq_data *d)
> +{
> +	struct irq_desc *desc = irq_to_desc(d->irq);
> +
> +	if (WARN_ON(!gic_supports_nmi()))
> +		return;
> +
> +	if (gic_peek_irq(d, GICD_ISENABLER)) {
> +		pr_err("Cannot set NMI property of enabled IRQ %u\n", d->irq);
> +		return;
> +	}
> +
> +	/*
> +	 * A secondary irq_chip should be in charge of LPI request,
> +	 * it should not be possible to get there
> +	 */
> +	if (WARN_ON(gic_irq(d) >= 8192))
> +		return;
> +
> +	/* desc lock should already be held */
> +	if (gic_irq(d) < 32) {
> +		/* Tearing down NMI, only switch handler for last NMI */
> +		if (refcount_dec_and_test(&ppi_nmi_refs[gic_irq(d) - 16]))
> +			desc->handle_irq = handle_percpu_devid_irq;
> +	} else {
> +		desc->handle_irq = handle_fasteoi_irq;
> +	}
> +
> +	gic_set_irq_prio(gic_irq(d), gic_dist_base(d), GICD_INT_DEF_PRI);
> +}
> +

Hello Julien,
I am afraid the setting of priority is not correct here. If the irq is in redistributor(gic_irq(d) < 32),
we should set the priority on each cpu, while we just set the priority on the current cpu here.
static inline void __iomem *gic_dist_base(struct irq_data *d)
{
	if (gic_irq_in_rdist(d))	/* SGI+PPI -> SGI_base for this CPU */
		return gic_data_rdist_sgi_base();

	if (d->hwirq <= 1023)		/* SPI -> dist_base */
		return gic_data.dist_base;

	return NULL;
}

I tried to add a smp_call_function here, but the kernel reported a warning as we have disabled irq
when calling raw_spin_lock_irqsave in request_nmi or ready_percpu_nmi.
[    2.137262] Call trace:
[    2.137265]  smp_call_function_many+0xf8/0x3a0
[    2.137267]  smp_call_function+0x40/0x58
[    2.137271]  gic_irq_nmi_setup+0xe8/0x118
[    2.137275]  ready_percpu_nmi+0x6c/0xf0
[    2.137279]  armpmu_request_irq+0x228/0x250
[    2.137281]  arm_pmu_acpi_init+0x150/0x2f0
[    2.137284]  do_one_initcall+0x54/0x218
[    2.137289]  kernel_init_freeable+0x230/0x354
[    2.137293]  kernel_init+0x18/0x118
[    2.137295]  ret_from_fork+0x10/0x18

I am exploring a better way to solve this issue.

Thanks,
Wei Li


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
