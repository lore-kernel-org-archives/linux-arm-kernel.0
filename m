Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDB7C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:45:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49155218AE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MAzXkQu6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49155218AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OUYdycBvLKgHGVWeTNAV5T2/nooYGiPvqWEnF2ghvvk=; b=MAzXkQu63aGxuTNktpl6OUNfq
	V7iLhwmxStS3r0aywEHKFjeKAl3XTVQNqp82NlZaf+nyse+8jOb2WV2UoMh4ha17UE8GdXH6UbEGx
	GqqiXvb5LaP1PyjpBlvM3RmRBBRegszHN2Y/wHus3PuCPo/SigvBlNM8sRrgi7HpGmCQl4snpJBzx
	2kYHnXXsU39SIgLRMHkqynN7R2deoMAz+vMtZi4KVLW4/9e9/H81OyBjIIXZAcrSQ+sj0Dlu6zVeu
	g0msx+jBfSOqDPiyWTfSItmBwQKSO+lMxZogIxkpJWAYoGmhc2zfx/yaTaVQlbXBxTqUB5p/CkmHp
	aCXcRwDiQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goszr-0000xo-8g; Wed, 30 Jan 2019 16:45:55 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goszn-0000x4-FU
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 16:45:53 +0000
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0UGgcZh004041; Wed, 30 Jan 2019 17:45:43 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2q8e72a84u-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Wed, 30 Jan 2019 17:45:43 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8363931;
 Wed, 30 Jan 2019 16:45:42 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5F8A1A770;
 Wed, 30 Jan 2019 16:45:42 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.48) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 30 Jan
 2019 17:45:41 +0100
Subject: Re: [GIT PULL] STM32 DT changes for v4.21 #1
To: Arnd Bergmann <arnd@arndb.de>
References: <3fb58758-a67f-3a0f-72d2-abbfd71b6ae0@st.com>
 <6a490c72-c76a-51ef-7c5d-2178d2adcc83@st.com>
 <17acd15d-6fdb-c797-c37c-37bab49ac3b6@st.com>
 <CAK8P3a2g_oMMT75SbhF1aQ0+BXr+D8WUtMthEYbmF+15WfbSqg@mail.gmail.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <8d74b1fc-2771-befc-adb1-36d344f3cf53@st.com>
Date: Wed, 30 Jan 2019 17:45:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2g_oMMT75SbhF1aQ0+BXr+D8WUtMthEYbmF+15WfbSqg@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG5NODE2.st.com (10.75.127.14) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-30_13:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_084551_813262_22FD4ED4 
X-CRM114-Status: GOOD (  16.01  )
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
Cc: Olof Johansson <olof@lixom.net>, Kevin Hilman <khilman@baylibre.com>,
 arm-soc <arm@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 1/30/19 5:29 PM, Arnd Bergmann wrote:
> On Tue, Jan 8, 2019 at 9:42 AM Alexandre Torgue <alexandre.torgue@st.com> wrote:
>> On 1/8/19 8:29 AM, Alexandre Torgue wrote:
>>> On 12/3/18 12:18 PM, Alexandre Torgue wrote:
>>>> Hi Arnd, Olof and Kevin,
>>>>
>>>> Please consider this first round of STM32 DT updates for v4.21.
>>>>
>>>> Thanks.
>>>> Alex
>>>>
>>>
>>> This PR has not been merged in 5.0-rc1. Is there an issue (except than
>>> v4.21 doesn't exist :)) ?
>>> If not, is it possible to get it in next 5.0 rc ?
>>>
>>
>> Sorry for the last post. I completely missed Olof answer:
>>
>> "I think you might have missed pushing the tag to the remote?
>> -Olof
>> "
>>
>> My tag is now pushed. Is there a chance to get it in next RC ?
> 
> I noticed this we were still missing this one, but it's clearly too
> late now for 5.0 now, so I've pulled it into arm/dt for 5.1 now.

Sure it's too late :) and no pb. I planned to resend it for 5.1 so 
thanks to have already taken it. One question, I have a (small) PR to 
send for 5.1 this week. what is the best for you: base it on top of 
arm/dt ? or rebase the one for 5.0 on 5.1 and make my PR on top of it ?

Regard
Alex

> 
>         Arnd
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
