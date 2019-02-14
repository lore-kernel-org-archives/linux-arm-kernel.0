Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FC3C10F04
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:40:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2395F222A4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bAClj9Km";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DjkuF2Ud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2395F222A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nhkIII6IM4iggaj9GqPAq7tj2ALfHl1kvreYLitQX8c=; b=bAClj9KmoFFt7V
	Ya9pq5/jDsjB57XipWY1ERhKjkdvsbvhPmQnKjFUJ1NfEvz22M05L4vMAAV1102fjV5o796c6//ql
	R1QQWMUdiJD9JfsCprivYM2w5nMJ8Vm/4A/DMMoBXi5v7tY1U9eqroU2Cp8XRNYewFbB8MjNHaT4/
	MxzFP0M+ionFHJn0Q4gVFO8aCsx4+n6fp7JKcxlQ7eMXO8g517Hqa9YGf/kGyOg1hL1etaDoDV9vA
	F4/710/NUyplFKLLnf6Y0iNLpec8H1R+yLhoMy3ZDzmeLrmeZAVHfL+RT30zIoskTpONfEAyXFZHT
	0fC6Hoo/kVB1SPM1NvZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guCZX-00077m-9K; Thu, 14 Feb 2019 08:40:43 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guCZT-00077Q-Un
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 08:40:41 +0000
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1E8ePRS094247;
 Thu, 14 Feb 2019 02:40:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1550133625;
 bh=NW4c19zx3PI1ivdE5Py3m92KABYodHBo/I/ghYD5QYs=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=DjkuF2UdBF2kskcihjZrr9tFQd9KzJ89qIDjaHifSX8QfwUFNnRmBoI4Jx9SN1zbq
 GOUgysLOREM83yH3SIqUmGTxod/vutO+VHHc+KJ/ZwCG21kGuFoOp1FzzjOUIWOW5/
 2W9+9xUVzG32fqk2iGZCPEPmMPUZEcYprMvyrs9A=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1E8ePgl068034
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 14 Feb 2019 02:40:25 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 14
 Feb 2019 02:40:24 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 14 Feb 2019 02:40:24 -0600
Received: from [172.24.190.117] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1E8eKr3026130;
 Thu, 14 Feb 2019 02:40:21 -0600
Subject: Re: [PATCH v5 05/10] dt-bindings: irqchip: Introduce TISCI Interrupt
 router bindings
To: Tony Lindgren <tony@atomide.com>
References: <20190212074237.2875-1-lokeshvutla@ti.com>
 <20190212074237.2875-6-lokeshvutla@ti.com>
 <20190212163018.GL5720@atomide.com>
 <5b5d86b9-2aa7-718c-c1da-70bbf9bf589e@ti.com>
 <20190213153215.GT5720@atomide.com>
From: Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <821ab540-469a-2166-9346-9cc0dec8ffbe@ti.com>
Date: Thu, 14 Feb 2019 14:10:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190213153215.GT5720@atomide.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_004040_076619_11FCA305 
X-CRM114-Status: GOOD (  17.65  )
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
Cc: Nishanth Menon <nm@ti.com>,
 Device Tree Mailing List <devicetree@vger.kernel.org>, jason@lakedaemon.net,
 Peter Ujfalusi <peter.ujfalusi@ti.com>, marc.zyngier@arm.com,
 Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
 Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, tglx@linutronix.de,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 13/02/19 9:02 PM, Tony Lindgren wrote:
> * Lokesh Vutla <lokeshvutla@ti.com> [190213 04:23]:
>> Hi Tony,
>>
>> On 12/02/19 10:00 PM, Tony Lindgren wrote:
>>> Hi,
>>>
>>> * Lokesh Vutla <lokeshvutla@ti.com> [190212 07:43]:
>>>> +The Interrupt Router (INTR) module provides a mechanism to route M
>>>> +interrupt inputs to N interrupt outputs, where all M inputs are selectable
>>>> +to be driven per N output. There is one register per output (MUXCNTL_N) that
>>>> +controls the selection.
>>>> +
>>>> +
>>>> +                                 Interrupt Router
>>>> +                             +----------------------+
>>>> +                             |  Inputs     Outputs  |
>>>> +        +-------+            | +------+             |
>>>> +        | GPIO  |----------->| | irq0 |             |       Host IRQ
>>>> +        +-------+            | +------+             |      controller
>>>> +                             |    .        +-----+  |      +-------+
>>>> +        +-------+            |    .        |  0  |  |----->|  IRQ  |
>>>> +        | INTA  |----------->|    .        +-----+  |      +-------+
>>>> +        +-------+            |    .          .      |
>>>> +                             | +------+      .      |
>>>> +                             | | irqM |    +-----+  |
>>>> +                             | +------+    |  N  |  |
>>>> +                             |             +-----+  |
>>>> +                             +----------------------+
>>>
>>> Is this always one-to-one mapping or can the same interrupt be routed to
>>> multiple targets like to the SoC and some coprocessor?
>>
>> Yes, it is always one-to-one. Output of INTR can only be attached to one of the
>> processor.
> 
> OK
> 
>>>> +Configuration of these MUXCNTL_N registers is done by a system controller
>>>> +(like the Device Memory and Security Controller on K3 AM654 SoC). System
>>>> +controller will keep track of the used and unused registers within the Router.
>>>> +Driver should request the system controller to get the range of GIC IRQs
>>>> +assigned to the requesting hosts. It is the drivers responsibility to keep
>>>> +track of Host IRQs.
>>>> +
>>>> +Communication between the host processor running an OS and the system
>>>> +controller happens through a protocol called TI System Control Interface
>>>> +(TISCI protocol). For more details refer:
>>>> +Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
>>>
>>> Care to describe a bit why the interrupts need to be routed by a system
>>> controller?
>>
>> K3 architecture defines a heterogeneous system where multiple heterogeneous
>> cores are serving its own usecases. Given that there are multiple ways in which
>> a device IRQ can be routed using INTR, like either it can be routed to HLOS
>> core(A53 int this case) or it can be routed to any other coprocessor available
>> in the system(like R5). If every sw running in each co-processor is allowed to
>> program this INTR then there is a high probability that one sw executing on one
>> core can damage other heterogeneous core.  Mainly to avoid this damage the
>> configuration of all the INTRs and INTAs are done in a centralized place(sysfw).
>> Any user for programming its IRQ route should send a message to sysfw with the
>> parameters. These parameters are policed by sysfw and does the configuration.
> 
> OK so maybe update the description along those lines saying it's
> a shared piece of hardware between various independent SoC
> clusters which may or may not be running Linux.

IMHO, SoC integration is out of scope of this document. If you insist I can add
the details.

Thanks and regards,
Lokesh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
