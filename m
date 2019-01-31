Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6C8C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:05:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD20C2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i1M0s22j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD20C2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+nygp1GYFGDH68fmo3Qo0iC4JNn++thESu9FD/dZAEs=; b=i1M0s22jMmx5W4weB8nxxDg+Y
	pVcDQj6wDtgFM2q4ua953JUAsfThRnHY+FvXlEEEv0gMPa9i0myW9jQGcMEN5vV+vi268pzw9AoOG
	bL6kEN3V00D3XRd8mXCpsML2AoQ7UlhMBi9Hr/FumSNChCLJ3ZARR3qarZxYdyvhWf24dAm2/ndD+
	SKckT9Mx9hLTcncLAExrDjOy5q9KA1pFKIT2wO+JG9whP/2PO1vBN2ZjMLQAlKtewCa7jmrErj2/R
	LEqx0tGDXP0kcQhZ590hlG/K5xiTMemIWkyZ+QOEV1Xbky22k3Newc9rUPeK8/w54Iw+gsgg03i27
	JhKO0yz3Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp7Ly-0008JI-Mj; Thu, 31 Jan 2019 08:05:42 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp7LK-0006jX-7D
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 08:05:21 +0000
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0V7pESJ007062; Thu, 31 Jan 2019 09:04:54 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2q8dw3e137-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Thu, 31 Jan 2019 09:04:54 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8220F31;
 Thu, 31 Jan 2019 08:04:53 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5B5E2ECC;
 Thu, 31 Jan 2019 08:04:53 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.46) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 31 Jan
 2019 09:04:52 +0100
Subject: Re: [GIT PULL] STM32 DT changes for v4.21 #1
To: Arnd Bergmann <arnd@arndb.de>
References: <3fb58758-a67f-3a0f-72d2-abbfd71b6ae0@st.com>
 <6a490c72-c76a-51ef-7c5d-2178d2adcc83@st.com>
 <17acd15d-6fdb-c797-c37c-37bab49ac3b6@st.com>
 <CAK8P3a2g_oMMT75SbhF1aQ0+BXr+D8WUtMthEYbmF+15WfbSqg@mail.gmail.com>
 <8d74b1fc-2771-befc-adb1-36d344f3cf53@st.com>
 <CAK8P3a05d5dMw_L=iMBT_aJaizjXuKMoiNhjj0yPTdqxMOt2VQ@mail.gmail.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <85828aaa-c2f8-750f-3df0-cbded16d4a26@st.com>
Date: Thu, 31 Jan 2019 09:04:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a05d5dMw_L=iMBT_aJaizjXuKMoiNhjj0yPTdqxMOt2VQ@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-31_03:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_000503_058833_520886A2 
X-CRM114-Status: GOOD (  17.53  )
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



On 1/30/19 10:01 PM, Arnd Bergmann wrote:
> On Wed, Jan 30, 2019 at 5:45 PM Alexandre Torgue
> <alexandre.torgue@st.com> wrote:
>> On 1/30/19 5:29 PM, Arnd Bergmann wrote:
>>> On Tue, Jan 8, 2019 at 9:42 AM Alexandre Torgue <alexandre.torgue@st.com> wrote:
>>>> On 1/8/19 8:29 AM, Alexandre Torgue wrote:
>>>>> On 12/3/18 12:18 PM, Alexandre Torgue wrote:
>>>>>> Hi Arnd, Olof and Kevin,
>>>>>>
>>>>>> Please consider this first round of STM32 DT updates for v4.21.
>>>>>>
>>>>>> Thanks.
>>>>>> Alex
>>>>>>
>>>>>
>>>>> This PR has not been merged in 5.0-rc1. Is there an issue (except than
>>>>> v4.21 doesn't exist :)) ?
>>>>> If not, is it possible to get it in next 5.0 rc ?
>>>>>
>>>>
>>>> Sorry for the last post. I completely missed Olof answer:
>>>>
>>>> "I think you might have missed pushing the tag to the remote?
>>>> -Olof
>>>> "
>>>>
>>>> My tag is now pushed. Is there a chance to get it in next RC ?
>>>
>>> I noticed this we were still missing this one, but it's clearly too
>>> late now for 5.0 now, so I've pulled it into arm/dt for 5.1 now.
>>
>> Sure it's too late :) and no pb. I planned to resend it for 5.1 so
>> thanks to have already taken it. One question, I have a (small) PR to
>> send for 5.1 this week. what is the best for you: base it on top of
>> arm/dt ? or rebase the one for 5.0 on 5.1 and make my PR on top of it ?
> 
> You should never rebase a branch that was already merged somewhere,
> and I also wouldn't base one of your branches on top of mine.
> 
> What I'd recommend instead is to base your new work on top of
> the branch I just pulled. If you also need stuff from 5.0-rc1, then
> start with that and merge stm32-dt-for-v4.21-1 into that, followed
> by your new work on top (note: don't merge 5.0-rc1 into
> stm32-dt-for-v4.21-1 though, that would lead to a confusing
> git history).

Ok. Thanks Arnd.

> 
>        Arnd
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
