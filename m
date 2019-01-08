Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FD0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:57:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 248D220827
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ok/LbTzB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 248D220827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=A/3Cc2AJ1XthAS9jLXtojB/KmBxKWTzO2/Asr5uxnZ0=; b=Ok/LbTzBEtFVIk
	FmSDJf1gX7/rPfwkXCXDeclIQJUfZkk8+v5VsoJxAkOyVL8jtoSz9UiEdOOWjmDzmfgyOBB9REkR9
	jBvAcLzp053hr6GjU+Uz5wWhkTtUokqZtXGpZJbAqJ4VIzwHVTmGg+x/Uh5r9NFWwwX4I7d7oHmXC
	9TuxIhr74DVO3mLbHLvwf4rUGTvHmvCj/6KJQiZu8ROL2oTWg03zgoailA+tYDleTnNmnqGIQ6gzv
	3J/JHAd5UY0I157gTdU4Y0495CIsX1IS8iMnVfa73cPjgTEfP0l8liXUEBlvyMvtne4s4oRVDktJo
	ageDvSgYHGdS/LQV+UMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggvd6-0006YP-VQ; Tue, 08 Jan 2019 17:57:32 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggvd3-0006Xr-7l
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 17:57:31 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 801B2A78;
 Tue,  8 Jan 2019 09:57:28 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF6903F5AF;
 Tue,  8 Jan 2019 09:57:25 -0800 (PST)
Subject: Re: [PATCH 2/2] EDAC: add ARM Cortex A15 L2 internal asynchronous
 error detection driver
To: Borislav Petkov <bp@alien8.de>,
 "Wiebe, Wladislav (Nokia - DE/Ulm)" <wladislav.wiebe@nokia.com>
References: <AM6PR0702MB379953E130CC1E1DEE18B79BFA8A0@AM6PR0702MB3799.eurprd07.prod.outlook.com>
 <20190108104204.GA14243@zn.tnic>
From: James Morse <james.morse@arm.com>
Message-ID: <e1458b95-6d17-21be-5dd8-ee7ff8d8b3fb@arm.com>
Date: Tue, 8 Jan 2019 17:57:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190108104204.GA14243@zn.tnic>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_095729_341946_7700F601 
X-CRM114-Status: GOOD (  25.87  )
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
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, "Sverdlin,
 Alexander \(Nokia - DE/Ulm\)" <alexander.sverdlin@nokia.com>,
 "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "mchehab@kernel.org" <mchehab@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Boris, Wladislav,

On 08/01/2019 10:42, Borislav Petkov wrote:
> + James and leaving in the rest for reference.

(thanks!)

> So the first thing to figure out here is how generic is this and if
> so, to make it a cortex_a15_edac.c driver which contains all the RAS
> functionality for A15. Definitely not an EDAC driver per functional unit
> but rather per vendor or even ARM core.

This is implementation-defined/specific-to-A15 and is documented in the TRM [0].
(On the 'all the RAS functionality for A15' front: there are two more registers:
L2MERRSR and CPUMERRSR. These are both accessible from the normal-world, and
don't appear to need enabling.)


But we have the usual pre-v8.2 problems, and in addition cluster-interrupts, as
this signal might be per-cluster, or it might be combined.

Wladislav, I'm afraid we've had a few attempts at pre-8.2 EDAC drivers, the
below list of problems is what we've learnt along the way. The upshot is that
before the architected RAS extensions, the expectation is firmware will handle
all this, as its difficult for the OS to deal with.


My first question is how useful is a 'something bad happened' edac event? Before
the v8.2 extensions with its classification of errors, we don't know anything more.

The usual suspects are, (partly taken from the thread at [1]):
* A15 exists in big/little configurations. We need to know which CPUs are A15.
* We need to know we aren't running under a hypervisor, (a hypervisor can trap
  accesses to these imp-def register, KVM does).
* Nothing else should be clearing these bits, e.g. secure-world software, or
  another CPU.
* Secure-world needs to enable write-access to L2ECTLR, and we need to
  know its done it. This needs doing on every CPU, and needs to not 'go missing'
  over cpu-hotplug or cpu-idle.

These are things that don't naturally live in the DT.


The new-one is these cluster-interrupts: How do we know which set of CPUs each
interrupt goes with? What happens if user-space tries to rebalance them?

Another SoC with A15 may combine all the cluster-interrupts into a single
'something bad happened' interrupt. Done like this, we would need to cross-call
to the other CPUs when we take an interrupt - which is not something we can do.

Is this a level or edge interrupt? Is it necessary to clear that bit in the
register to lower the interrupt line?
The TRM talks about 'pending L2 internal asynchronous error', pending makes me
suspect this is at least possible. If it is, a level-interrupt to one CPU, that
can only be cleared by another leads to deadlock.


Thanks,

James

> On Tue, Jan 08, 2019 at 08:10:45AM +0000, Wiebe, Wladislav (Nokia - DE/Ulm) wrote:
>> This driver adds support for L2 internal asynchronous error detection
>> caused by L2 RAM double-bit ECC error or illegal writes to the
>> Interrupt Controller memory-map region on the Cortex A15.

>> diff --git a/drivers/edac/cortex_a15_l2_async_edac.c b/drivers/edac/cortex_a15_l2_async_edac.c
>> new file mode 100644
>> index 000000000000..26252568e961
>> --- /dev/null
>> +++ b/drivers/edac/cortex_a15_l2_async_edac.c
>> @@ -0,0 +1,134 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2018 Nokia Corporation

(boiler plate not needed with the SPDX header)

>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/of.h>
>> +
>> +#include "edac_module.h"
>> +
>> +#define DRIVER_NAME "cortex_a15_l2_async_edac"
>> +
>> +#define L2ECTLR_L2_ASYNC_ERR BIT(30)
>> +
>> +static irqreturn_t cortex_a15_l2_async_edac_err_handler(int irq, void *dev_id)
>> +{
>> +	struct edac_device_ctl_info *dci = dev_id;
>> +	u32 status = 0;
>> +
>> +	/*
>> +	 * Read and clear L2ECTLR L2 ASYNC error bit caused by INTERRIRQ.
>> +	 * Reason could be a L2 RAM double-bit ECC error or illegal writes
>> +	 * to the Interrupt Controller memory-map region.
>> +	 */
>> +	asm("mrc p15, 1, %0, c9, c0, 3" : "=r" (status));

"L2 internal asynchronous error caused by L2 RAM double-bit ECC error" doesn't
tell us if a CPU consumed the error, or if the error has caused a write to go
missing. Without the classification, this means 'something bad happened'.

I'd prefer to panic() when we see one of these. I'd like it even more if
firmware rebooted for us.


>> +	if (status & L2ECTLR_L2_ASYNC_ERR) {
>> +		status &= ~L2ECTLR_L2_ASYNC_ERR;
>> +		asm("mcr p15, 1, %0, c9, c0, 3" : : "r" (status));

4.3.49 "L2 Extended Control Register" of the A15 TRM says this field can be
read-only/write-ignored for the normal world if NSACR.NS_L2ERR is 0.

How do we know if firmware has set this bit on all CPUs? We can't clear the
error otherwise.


>> +		edac_printk(KERN_EMERG, DRIVER_NAME,
>> +			    "L2 internal asynchronous error occurred!\n");
>> +		edac_device_handle_ue(dci, 0, 0, dci->ctl_name);

>> +
>> +		return IRQ_HANDLED;
>> +	}
>> +
>> +	return IRQ_NONE;
>> +}
>> +
>> +static int cortex_a15_l2_async_edac_probe(struct platform_device *pdev)
>> +{
>> +	struct edac_device_ctl_info *dci;
>> +	struct device_node *np = pdev->dev.of_node;
>> +	char *ctl_name = (char *)np->name;
>> +	int i = 0, ret = 0, err_irq = 0, irq_count = 0;
>> +
>> +	/* We can have multiple CPU clusters with one INTERRIRQ per cluster */

Surely this an integration choice?

You're accessing the cluster through a cpu register in the handler, what happens
if the interrupt is delivered to the wrong cluster?
How do we know which interrupt maps to which cluster?
How do we stop user-space 'balancing' the interrupts?


>> +	irq_count = platform_irq_count(pdev);
>> +	if (irq_count < 0) {
>> +		edac_printk(KERN_ERR, DRIVER_NAME,
>> +			    "No L2 ASYNC error IRQ found!\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	dci = edac_device_alloc_ctl_info(0, ctl_name, 1, ctl_name,
>> +					 irq_count, 0, NULL, 0,
>> +					 edac_device_alloc_index());
>> +	if (!dci)
>> +		return -ENOMEM;
>> +
>> +	dci->dev = &pdev->dev;
>> +	dci->mod_name = DRIVER_NAME;
>> +	dci->ctl_name = ctl_name;
>> +	dci->dev_name = dev_name(&pdev->dev);
>> +	platform_set_drvdata(pdev, dci);
>> +
>> +	if (edac_device_add_device(dci))
>> +		goto err;
>> +
>> +	for (i = 0; i < irq_count; i++) {
>> +		err_irq = platform_get_irq(pdev, i);
>> +		ret = devm_request_irq(&pdev->dev, err_irq,
>> +				       cortex_a15_l2_async_edac_err_handler, 0,
>> +				       dev_name(&pdev->dev), dci);
>> +
>> +		if (ret < 0) {
>> +			edac_printk(KERN_ERR, DRIVER_NAME,
>> +				    "Failed to register L2 ASYNC error IRQ %d\n",
>> +				     err_irq);
>> +			goto err2;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +err2:
>> +	edac_device_del_device(&pdev->dev);
>> +err:
>> +	edac_device_free_ctl_info(dci);
>> +
>> +	return ret;
>> +}


[0]
http://infocenter.arm.com/help/topic/com.arm.doc.ddi0438c/DDI0438C_cortex_a15_r2p0_trm.pdf
[1] https://lore.kernel.org/lkml/1521073067-24348-1-git-send-email-york.sun@nxp.com/

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
