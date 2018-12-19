Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F123C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:01:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10D0220874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Vq5djHm3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D0220874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BFV1eRw3Yl4WavdkjHl7d/6nPdzOgqDylY9dzPWtYnk=; b=Vq5djHm3evq/4sHpWTDkB4fXR
	JKIN6gueKDK5DDFM2qnnJ2p3EwZnChvMA+dvNrlOAsW8/E9Qv6DJrTEj1NMxJXZpkhTUbtMQp1N4M
	LBBs+5HSv4lfhigEy88uMhtODSYK11QOKcojyiA2tD4F2U8odmSZmZ9/fJOe8+Q/PSYL+r0FFKOJl
	+AMVupXxt6/ULga/OIOcGoATpq1TtqhEjOrMZ+Mu8zhDAAsWIOYhhDFRi+/Tz6QQXJZHqwZEQcMsS
	ti/e/K3gsiO5fqJJiS406/34lSW/+Y9dMSkolNtJrdrrCvVxFz+wpUo7SocvUVeWkNAxL9gutJVY8
	NGMxoLCVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZdLL-0004UM-TU; Wed, 19 Dec 2018 15:01:03 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZdLC-0004S4-QB
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 15:01:02 +0000
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 wBJEuFhq026070; Wed, 19 Dec 2018 16:00:26 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2pcr8xxg5n-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Wed, 19 Dec 2018 16:00:26 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EFF0D3A;
 Wed, 19 Dec 2018 15:00:24 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BA4552A59;
 Wed, 19 Dec 2018 15:00:24 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.50) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 19 Dec
 2018 16:00:23 +0100
Subject: Re: [PATCH v3 0/3] Make STM32 interrupt controller use hwspinlock
To: Marc Zyngier <marc.zyngier@arm.com>, Benjamin Gaignard
 <benjamin.gaignard@st.com>, <tglx@linutronix.de>,
 <jason@lakedaemon.net>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
References: <20181217142215.17493-1-benjamin.gaignard@st.com>
 <297d3207-7302-674e-5acd-30dc7b2df408@arm.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <fc6eb663-8694-662d-c4c2-705c7bc57700@st.com>
Date: Wed, 19 Dec 2018 16:00:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <297d3207-7302-674e-5acd-30dc7b2df408@arm.com>
Content-Language: en-US
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-19_07:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_070055_134976_F34ADAFF 
X-CRM114-Status: GOOD (  14.45  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Marc,

On 12/18/18 4:39 PM, Marc Zyngier wrote:
> On 17/12/2018 14:22, Benjamin Gaignard wrote:
>> This series allow to protect STM32 interrupt controller configuration registers
>> with a hwspinlock to avoid conflicting accesses between processors.
>>
>> version 3:
>> - with bindings patch
>>
>> version 2:
>> - rework hwspinlock locking sequence in stm32 irqchip to take care of the
>>    cases where hwspinlock node is disabled or not yet probed
>>
>> Benjamin Gaignard (3):
>>    dt-bindings: interrupt-controller: stm32: Document hwlock properties
>>    irqchip: stm32: protect configuration registers with hwspinlock
>>    ARM: dts: stm32: Add hwlock for irqchip on stm32mp157
>>
>>   .../interrupt-controller/st,stm32-exti.txt         |   4 +
>>   arch/arm/boot/dts/stm32mp157c.dtsi                 |   1 +
>>   drivers/irqchip/irq-stm32-exti.c                   | 116 ++++++++++++++++++---
>>   3 files changed, 105 insertions(+), 16 deletions(-)
>>
> 
> I've taken the first two patches. Please route the DTS patch to the
> appropriate tree.
> 

I'll take DTS patch in stm32-next branch.

Regards
Alex

> Thanks,
> 
> 	M.
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
