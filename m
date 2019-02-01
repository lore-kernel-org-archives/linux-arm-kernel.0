Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE14C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:50:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C7BF2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TcQoeG4y";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="JNyp1wxJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C7BF2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0KSnrUzdYjIWUnNAPT+ujtRbhPTmbdVNE1I/EMno7Kc=; b=TcQoeG4yzdXwpFUaCSaYDU6Q9
	BCy6wwiAU34w9YJqr08c5ifSB3Dha0AtH2hhkTSI49yoahQkwDLRxLhIs/Z00mpp6z4MqtSziKLDX
	nMh9QDLZMLg2Dt4u1iP8tiD+K6EBLb3ld8BYTTaHD62H+AjGiY9CoV7jNNRrktmeZqwj/wIjn/HXU
	tQgwaIyBWHBH8SgtCSgNUz/s5jplEG57+xPuXPbBCwaqu/cYqPvI19FrJBcMQM5AxScSidXbg9IwR
	KoKXDHAu9dnhqqsHsEu06jps+OBjLUJpN08BFtziH6d4Mx4JWcZwSIVPag4tHmKRoAgzj+CfgvN3S
	hgbLFMVkg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpb5e-0003fS-3r; Fri, 01 Feb 2019 15:50:50 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpb4F-00018W-6H
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 15:49:56 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c546a570000>; Fri, 01 Feb 2019 07:48:40 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Fri, 01 Feb 2019 07:49:22 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Fri, 01 Feb 2019 07:49:22 -0800
Received: from [10.19.108.132] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 1 Feb
 2019 15:49:19 +0000
Subject: Re: [PATCH V5 2/7] clocksource: tegra: add Tegra210 timer support
To: Jon Hunter <jonathanh@nvidia.com>, Thierry Reding
 <thierry.reding@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20190201033621.16814-1-josephl@nvidia.com>
 <20190201033621.16814-3-josephl@nvidia.com>
 <5490ad66-7d20-7093-7025-1d0ec8da6dec@nvidia.com>
 <3c9b86ba-32dd-76b2-9a51-6cd86782cadf@nvidia.com>
 <ab418999-a45c-bd9c-b9bd-5c382e86d26c@nvidia.com>
From: Joseph Lo <josephl@nvidia.com>
Message-ID: <c33697d8-43a9-654b-503f-e60adbaf289f@nvidia.com>
Date: Fri, 1 Feb 2019 23:49:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <ab418999-a45c-bd9c-b9bd-5c382e86d26c@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1549036120; bh=SjYRayLmjrLPYjKGkL341MDkDszyHBUg+VtNsNQYVVo=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=JNyp1wxJjHcmyWe3emHSjH45gGMqadlrbAcut4/I+bls7QHSL8QCCHHKIuX+EcvIY
 EaFlofhk5zpiK0ycQFWDLErUqOCJkzBPPritwCyBjLcEmiri/weLMViHo68hWSoiaQ
 ZmIjcFkPkLgxbnKyygOcqDbiEHj3qwQM7gpESCNl5kcPKHeIjLkYXEc5+A7126B4P/
 +Xwg5k0K2vvZcPpFvnhC00z7ZhZ6KW1ZRzhJDyUXuddw0c6kaKKGa9nlVCCSxGKGmy
 YaBsWSyMX7OsXsxY+l+vEISR7G5c3eV8slVLsyV4P4jxNdDBPry8elYpGR2cJZOPO2
 KKOFJ3AivOKsg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_074923_806736_58939B33 
X-CRM114-Status: GOOD (  12.90  )
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
Cc: linux-tegra@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2/1/19 11:43 PM, Jon Hunter wrote:
> 
> 
> On 01/02/2019 14:39, Joseph Lo wrote:
>> On 2/1/19 8:44 PM, Jon Hunter wrote:
>>>
>>> On 01/02/2019 03:36, Joseph Lo wrote:
>>>> Add support for the Tegra210 timer that runs at oscillator clock
>>>> (TMR10-TMR13). We need these timers to work as clock event device and to
>>>> replace the ARMv8 architected timer due to it can't survive across the
>>>> power cycle of the CPU core or CPUPORESET signal. So it can't be a
>>>> wake-up
>>>> source when CPU suspends in power down state.
>>>>
>>>> Also convert the original driver to use timer-of API.
>>>
>>> It may have been nice to split this into 2 patches to make it easier to
>>> see what is going on but not a big deal.
>>>
>>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>>>> Acked-by: Thierry Reding <treding@nvidia.com>
>>>> ---
snip.
>>>
>> This can't get the timer base address. I think you mean ...
>>
>> +#ifdef CONFIG_ARM
>> +#define TIMER_CPU0 0x50 /* TIMER3 */
>> +#else
>> +#define TIMER_CPU0 0x90 /* TIMER10 */
>> +#endif
>> +#define TIMER_BASE_FOR_CPU(cpu) (TIMER_CPU0 + (cpu) * 8)
> 
> Ah I see.
> 
>> This doesn't need.
>> +#define TIMER_FOR_CPU(cpu) (TIMER_CPU0 + cpu)
> How come? Don't you still need to know the timer index for a given CPU?
> 

Doesn't need. TIMER_BASE_FOR_CPU is enough. Other use cases are well 
handled by timer-of API. :)

Thanks,
Joseph

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
