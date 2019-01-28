Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22CAC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:20:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 969D320857
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FkZhruzH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 969D320857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:Subject:From:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VhdOL25peCLYkRcm5STiLKJKJqeMyUVSffsTkPrp9z8=; b=FkZhruzHEEk5kn
	KdgqHqK/10yR5153oJeSoaw7reS0+oguz5JSUTSWUOFgepXHK6hRm9JcZ53EprsIAhBYjJcP9rdMv
	KQLEV4QB5uI8NvQtqcB44jP3u8ITXNi05S8wEzrZm3Is0Wwk21uAixkRmmuFlq3m2+wKKPL+T9e8D
	Xn9hZVBW0kQ98LMNxy+hwtksbv2T8MCAoLfTIGanwLqePj/A2qmrP/0c/ahwjiPjO9zwrDDemTUzy
	Fb4ZhJTUSqZ7aUiISrXk27bWx3t5XavIhOyLocJ8syaTCuRGcIY64bZJOWc/LB0fvFSMrMvjuRby0
	2eq1IMSQCBAD6lDFedbA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go6qI-0006Ii-It; Mon, 28 Jan 2019 13:20:50 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go6qE-0006IG-B6
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 13:20:48 +0000
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0SDGDEL026737; Mon, 28 Jan 2019 14:20:36 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2q8djan9qb-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Mon, 28 Jan 2019 14:20:36 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6180F38;
 Mon, 28 Jan 2019 13:20:34 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 25F452BA3;
 Mon, 28 Jan 2019 13:20:34 +0000 (GMT)
Received: from [10.48.0.167] (10.75.127.46) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 28 Jan
 2019 14:20:33 +0100
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [PATCH v2 2/3] mfd: syscon: Add optional clock support
To: Arnd Bergmann <arnd@arndb.de>
References: <1544604495-4082-1-git-send-email-fabrice.gasnier@st.com>
 <1544604495-4082-3-git-send-email-fabrice.gasnier@st.com>
 <CAK8P3a1MucNG86=bXwVVsasGBOLJ67kuRSpoeneF6M5aB6GmQA@mail.gmail.com>
 <9e0ee154-a399-9bff-3beb-adfd9d6c6fee@st.com>
 <CAK8P3a0kV4-OF7JPwM9cEqxaPvNM9dFZdyZetc47t+D5izkFwQ@mail.gmail.com>
Message-ID: <47a3fe9f-8adb-8f47-e7c1-342f8fc318aa@st.com>
Date: Mon, 28 Jan 2019 14:20:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0kV4-OF7JPwM9cEqxaPvNM9dFZdyZetc47t+D5izkFwQ@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-28_08:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_052046_737060_804AC388 
X-CRM114-Status: GOOD (  21.32  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>,
 Alexandre Torgue <alexandre.torgue@st.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-stm32@st-md-mailman.stormreply.com, Rob Herring <robh+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Lee Jones <lee.jones@linaro.org>,
 Gabriel Fernandez <gabriel.fernandez@st.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/16/19 4:11 PM, Arnd Bergmann wrote:
> On Wed, Jan 16, 2019 at 3:10 PM Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
>>
>> On 1/16/19 1:14 PM, Arnd Bergmann wrote:
>>> (sorry for the late reply, I just realized that I had never sent out the
>>> mail after Lee asked me for a review last year and I had drafted
>>> my reply).
>>
>> Hi Arnd,
>>
>> Many thanks for reviewing, no worries :-)
>>
>>>
>>> On Wed, Dec 12, 2018 at 9:48 AM Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
>>>>
>>>> Some system control registers need to be clocked, so the registers can
>>>> be accessed. Add an optional clock and attach it to regmap.
>>>>
>>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>>>
>>> This looks ok to me in principle, but I have one question: When we
>>> do a clk_get() and clk_prepare() as part of regmap_mmio_attach_clk(),
>>> does that change the behavior of syscon nodes that are otherwise
>>> unused?
>>
>> I'm not sure I correctly understand this question. I don't think it will
>> change the behavior for "unused" nodes. These should remain unused with
>> this patch.
> 
> What I mean is that nodes that listed as 'compatible="syscon"' get
> probed by the syscon driver even when no other driver references
> them, and that in turn would acquire the clock, right?

Hi Arnd,

Sorry for the late reply.

When no other driver references them, nothing happens at probe time on
the clock: no calls to get/prepare... the clock.

=> The clock will remain unrequested & unused until another driver calls
one of "of_syscon_register()" variants:
- syscon_node_to_regmap
- syscon_regmap_lookup_by_compatible
- syscon_regmap_lookup_by_phandle

When another driver references them (e.g. one of the above calls), then
it will acquire the optional clock and use it, e.g.:
- clk_prepare() upon of_syscon_register() variants
- clk_enable & clk_disable when accessing the registers

I hope this clarifies.

Please advise,
Best Regards,
Fabrice

> 
>>> I think we have a bunch of devices that started out as a syscon but
>>> then we added a proper driver for them, which would handle the
>>> clocks explicitly. Is it guaranteed that this will keep working (including
>>> shutting down the clocks when they are unused) if we have two drivers
>>> that call clk_get() on the same device node?
>>
>> I'd expect nothing wrong happens when two drivers call clk_get() for the
>> same clock.
>> Are there some case where two drivers are bind (e.g. syscon driver +
>> another driver) for the same piece of hardware ?
> 
> You won't actually have two drivers binding to the same device, but you
> could have a driver and a syscon user that does relies on the
> syscon_regmap_lookup_by_*() functions.
> 
> I think we've had a couple of cases where we started out representing
> a device as syscon, and then later decided that a high-level abstraction
> would be needed because syscon didn't quite support all the needed
> features.
> 
> Since each syscon node should also have a more specific
> compatible value, you can then have another driver that binds
> to that compatible string.
> 
>       Arnd
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
