Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAF8C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:43:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3219218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s4k+vAWb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3219218A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/TQo1YaL4xjyLN7HGoKM6h7PmllfC52TO0c5O4q/m84=; b=s4k+vAWbdNITuvVJcy0orCFdX
	6gZu0JG2h2PIeMIAwhC7aYbaYn/M6lI6Rc71rUMaIKa2EXBxiPg3UW4kJUKFt4J08A781PcXncY+S
	N4Md6DNdeH0rv7y3b+ySnQTQQBTy44AW7hDT/nwWdN9QO1O64wKJ+kVxNbU6h0OJoGN8gZvrNn3jw
	5qV8eUk1n9n10uwN5Y8EVO39fMgvpS0Hm1HmimVtJeDLTuST6HvmzH4owH4j/KI6jgL8VbWME5gAz
	Lb6tjJMQa2YCG+j+Ds6PVxK+WyFnSrajOFdJg44lPSQzSyItfwNeC5c0sGRktbFL3EpOSuyaSEZ0u
	kiD1clWyw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmyxZ-00008X-1u; Fri, 25 Jan 2019 10:43:41 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmywP-0007zR-6V
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 10:43:11 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80CEBEBD;
 Fri, 25 Jan 2019 02:42:28 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 692A83F5AF;
 Fri, 25 Jan 2019 02:42:26 -0800 (PST)
Subject: Re: [RESEND PATCH v3 1/2] drivers: amba: Updates to component
 identification for driver matching.
To: mike.leach@linaro.org, saiprakash.ranjan@codeaurora.org
References: <20181218215944.2444-1-mike.leach@linaro.org>
 <20181218215944.2444-2-mike.leach@linaro.org>
 <353c8f4b-f48f-863c-7149-342b764a02c0@codeaurora.org>
 <CAJ9a7Vh6McpjtyRuBDPSYMWec0TuWkXeOLBOpKvv8tWUU0sV2A@mail.gmail.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <f4d78f6f-1b85-22ca-bfa6-abaf0d67a898@arm.com>
Date: Fri, 25 Jan 2019 10:42:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAJ9a7Vh6McpjtyRuBDPSYMWec0TuWkXeOLBOpKvv8tWUU0sV2A@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_024229_863503_20F6CEE5 
X-CRM114-Status: GOOD (  21.27  )
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
Cc: rnayak@codeaurora.org, mathieu.poirier@linaro.org,
 coresight@lists.linaro.org, linux@armlinux.org.uk,
 linux-kernel@vger.kernel.org, sibis@codeaurora.org,
 vivek.gautam@codeaurora.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Mike,

On 25/01/2019 10:37, Mike Leach wrote:
> Hello Sai
> On Fri, 25 Jan 2019 at 07:20, Sai Prakash Ranjan
> <saiprakash.ranjan@codeaurora.org> wrote:
>>
>> Hi Mike,
>>
>> Thanks for the patch.
>>
>> BTW somehow I can't find the latest series in my inbox, so commenting
>> on this here.
>>
>> Mathieu pointed me to this patch series.This solves CPU debug module
>> sharing same PID as ETM on MSM8996. I will be posting patch for CPU
>> debug UCI table soon.
>>
>> But please find my one comment inline.
>>
>> On 12/19/2018 3:29 AM, Mike Leach wrote:
>>> The CoreSight specification (ARM IHI 0029E), updates the ID register
>>> requirements for components on an AMBA bus, to cover both traditional
>>> ARM Primecell type devices, and newer CoreSight and other components.
>>>
>>> The Peripheral ID (PID) / Component ID (CID) pair is extended in certain
>>> cases to uniquely identify components. CoreSight components related to
>>> a single function can share Peripheral ID values, and must be further
>>> identified using a Unique Component Identifier (UCI). e.g. the ETM, CTI,
>>> PMU and Debug hardware of the A35 all share the same PID.
>>>
>>
>> [..]
>>
>>> +static const struct amba_id *
>>> +amba_lookup(const struct amba_id *table, struct amba_device *dev)
>>> +{
>>>        while (table->mask) {
>>> -             ret = (dev->periphid & table->mask) == table->id;
>>> -             if (ret)
>>> -                     break;
>>> +             if (((dev->periphid & table->mask) == table->id) &&
>>> +                     ((dev->cid != CORESIGHT_CID) ||
>>> +                      (amba_cs_uci_id_match(table, dev))))
>>
>> Shouldn't the check be (dev->cid == CORESIGHT_CID) ?
>> Without this STM fails to probe on both SDM845 and MSM8996.
>>
> I believe the test is correct
> 
> To expand the logic here:
> 
> if  (dev->periphid & table->mask) == table->id) {
>        //** match on peripheral ID at this point
>       if (CID != CORESIGHT_ID)
>                 return table; //** not coresight - match on peripheral ID only
>       //** or
>       if (amba_cs_uci_id_match() )
>                  return table;  //** is coresight - match on UCI if
> available - otherwise peripheral ID only;
> 
> However - looking at the coresight STM driver - this is using the
> private .data field in the amba_id for a name - which I had not
> spotted before.

Good point. We also use this field for Coresight SOC-600 ETR for
advertising the caps not detected from hardware.

> I will have to revisit this patchset to fix either the amba id struct
> or the method for getting the uci data into the amba_id.data which
> allows for multiple uses.

Thanks Mike !

Cheers
Suzuki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
