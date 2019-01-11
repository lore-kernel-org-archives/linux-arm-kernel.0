Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B54C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:11:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE17120878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RQEVj0+L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE17120878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yhLqfCpjuERmBeCgp/0bNc8nM107jWT9q1volPki4sg=; b=RQEVj0+Ldrp43/
	3ZE/aBA0v/5J48RoD4PO7+PwOlqa1Wl6uNHqPEtnChooq9ASc90B6W3SvL5acC8WkfxY195ayMhOb
	MRQ7c9bZpIkDa9enNHKJa460DaqUubZBWpWmjEEZT7eshken2r1PkNoiKPt8Na/UX/+MnWqCcJA3R
	B7TqknlNG4JGCpLvF0hu61lEoelAIl72pwdqzUJix4j0e+nu1uEAAnkrDw0ls3CcvwPF2hmJSNsiZ
	aXtujv5gyx+ZxJHmEVnOQda1ygVunmI1Z+JaaFU+v0s+HTQ9/+d+20JkRsM0wnSM/qBSUV+1iHqG7
	H5hajw9kmba9lDfmK1uA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi1Gy-0007Z9-QE; Fri, 11 Jan 2019 18:11:12 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi1Gv-0007Yj-Md
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 18:11:11 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B44E80D;
 Fri, 11 Jan 2019 10:11:09 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A0A693F6CF;
 Fri, 11 Jan 2019 10:11:06 -0800 (PST)
Subject: Re: [PATCH 2/2] EDAC: add ARM Cortex A15 L2 internal asynchronous
 error detection driver
To: "Wiebe, Wladislav (Nokia - DE/Ulm)" <wladislav.wiebe@nokia.com>
References: <AM6PR0702MB379953E130CC1E1DEE18B79BFA8A0@AM6PR0702MB3799.eurprd07.prod.outlook.com>
 <20190108104204.GA14243@zn.tnic>
 <e1458b95-6d17-21be-5dd8-ee7ff8d8b3fb@arm.com>
 <AM6PR0702MB37997C0FA1670DD1AF4C25C7FA8B0@AM6PR0702MB3799.eurprd07.prod.outlook.com>
From: James Morse <james.morse@arm.com>
Message-ID: <bba99e8c-5e3e-98a4-d0c9-9734216e66d2@arm.com>
Date: Fri, 11 Jan 2019 18:11:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <AM6PR0702MB37997C0FA1670DD1AF4C25C7FA8B0@AM6PR0702MB3799.eurprd07.prod.outlook.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_101109_778172_9A61436F 
X-CRM114-Status: GOOD (  25.13  )
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
 "robh+dt@kernel.org" <robh+dt@kernel.org>, Borislav Petkov <bp@alien8.de>,
 "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>, "Sverdlin,
 Alexander \(Nokia - DE/Ulm\)" <alexander.sverdlin@nokia.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "mchehab@kernel.org" <mchehab@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Wladislav,

On 09/01/2019 14:44, Wiebe, Wladislav (Nokia - DE/Ulm) wrote:
>> From: James Morse <james.morse@arm.com>
>> Sent: Tuesday, January 08, 2019 6:57 PM

>> On 08/01/2019 10:42, Borislav Petkov wrote:
>>> So the first thing to figure out here is how generic is this and if
>>> so, to make it a cortex_a15_edac.c driver which contains all the RAS
>>> functionality for A15. Definitely not an EDAC driver per functional
>>> unit but rather per vendor or even ARM core.
>>
>> This is implementation-defined/specific-to-A15 and is documented in the
>> TRM [0].
>> (On the 'all the RAS functionality for A15' front: there are two more registers:
>> L2MERRSR and CPUMERRSR. These are both accessible from the normal-
>> world, and don't appear to need enabling.)

After I sent this it occurred to me the core can't know about errors in the L3
cache (if there is one) or the memory-controller. These may have edac/ras
abilities, but they are selected by the soc integrator, so could be per soc.
This goes against Boris's no-per-functional-unit edac drivers. If we had to pick
one out of that set, I think the memory-controller is most useful as DRAM is the
most likely to be affected by errors.


>> But we have the usual pre-v8.2 problems, and in addition cluster-interrupts,
>> as this signal might be per-cluster, or it might be combined.
>>
>> Wladislav, I'm afraid we've had a few attempts at pre-8.2 EDAC drivers, the
>> below list of problems is what we've learnt along the way. The upshot is that
>> before the architected RAS extensions, the expectation is firmware will
>> handle all this, as its difficult for the OS to deal with.
>>
>>
>> My first question is how useful is a 'something bad happened' edac event?
> 
> We experienced sometimes random user-space crashes where we didn't 
> expect a bug in the application code. If there would be a notification 
> by such edac event,

Sure, but we always have to assume its the worst case: an uncontained error (to
use the v8.2 terms). A write has gone somewhere it shouldn't, we can't trust
memory anymore.

> we would at least know that something bad happened before.

>>> On Tue, Jan 08, 2019 at 08:10:45AM +0000, Wiebe, Wladislav (Nokia -
>> DE/Ulm) wrote:
>>>> This driver adds support for L2 internal asynchronous error detection
>>>> caused by L2 RAM double-bit ECC error or illegal writes to the
>>>> Interrupt Controller memory-map region on the Cortex A15.
>>
>>>> diff --git a/drivers/edac/cortex_a15_l2_async_edac.c
>>>> b/drivers/edac/cortex_a15_l2_async_edac.c
>>>> new file mode 100644
>>>> index 000000000000..26252568e961
>>>> --- /dev/null
>>>> +++ b/drivers/edac/cortex_a15_l2_async_edac.c
>>>> @@ -0,0 +1,134 @@

>>>> +static int cortex_a15_l2_async_edac_probe(struct platform_device
>>>> +*pdev) {
>>>> +	struct edac_device_ctl_info *dci;
>>>> +	struct device_node *np = pdev->dev.of_node;
>>>> +	char *ctl_name = (char *)np->name;
>>>> +	int i = 0, ret = 0, err_irq = 0, irq_count = 0;
>>>> +
>>>> +	/* We can have multiple CPU clusters with one INTERRIRQ per cluster
>>>> +*/
>>
>> Surely this an integration choice?
>>
>> You're accessing the cluster through a cpu register in the handler, what
>> happens if the interrupt is delivered to the wrong cluster?
>> How do we know which interrupt maps to which cluster?
>> How do we stop user-space 'balancing' the interrupts?
> 
> You are right, based on all your inputs I think we can stop using this driver
> as generic A15 solution

Handling this interrupt in firmware is probably the best for your soc. For a
generic a15 driver in the kernel, we would have to consider 'no interrupt',
(e.g. the interrupt is wired to some other SCP/BMC thing). Once we've got
polling code for these registers, we may as well always use it.


Thanks,

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
