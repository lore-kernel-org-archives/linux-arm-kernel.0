Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA3AC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:00:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AA75218B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tMEfcmro";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="E2SZTPx/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AA75218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=G7HvlWnWXgCLgqwSUYLkA3wubh7tEvo+FyVcEbvp8sU=; b=tMEfcmrozxjJNtzKeIPNIO6H/
	wFT9FbGZCd0lgDytp1P7dosjVJ//BPGdQyV4UIekoP3B5Kfmgg2EK7+0nazy57Maie1v30XlcxYKB
	JNcccsQGH76A2zrxiaRSFvClpKThn4agIy1u5a+HUFX1oQlxdFsRjwcwJA5x+zcN6VUmEuSUAl2WC
	liV3gOvrBWrXi8js3pv1gPeQRRJnaYgVPkCuX24Y3jrN+mm9RERbM8GMF9GEMnalfrnfxyaRzkb/9
	fbKK4CNqRAa0RmdufmochWy9VMOWy9T+UCJAVIWT2hxaqbd2LJV3OICiTqn6mvAYcckkAo5WDBc41
	9AWRPtoIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grfXi-0006pz-Ai; Thu, 07 Feb 2019 09:00:22 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grfXa-0006de-AV
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 09:00:19 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x17909N7064509;
 Thu, 7 Feb 2019 03:00:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1549530009;
 bh=kbe4CEQgtDkF7N6OJLnSI5lU9ue/nEXutdaEd7XiHWk=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=E2SZTPx/o+cU5q0LVcj9Bc4IBDI3VNDUYTxD75JLRR3AHsvTjNt/KestehB3Ye3Q2
 tAq2tj9sAsfpPXDYhEBj7qjzN1Kk/kTs2TArVFjfBo2JFA5nUV05AEYy7UZETXg1mZ
 LreKiwPMwHEAKgfMPpV+hm8yHYBysTSM4kEVxTtM=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x17909el106679
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 7 Feb 2019 03:00:09 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 7
 Feb 2019 03:00:07 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 7 Feb 2019 03:00:07 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x17902FY003375;
 Thu, 7 Feb 2019 03:00:03 -0600
Subject: Re: [PATCH 1/3] dt-bindings: clock: ti,sci-clk: Add support for
 parsing clock info from DT
To: Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>
References: <1546954223-9738-1-git-send-email-t-kristo@ti.com>
 <1546954223-9738-2-git-send-email-t-kristo@ti.com>
 <20190121210449.GB7851@bogus> <7ce7bd25-b5c4-f99d-fda6-0f21376f2204@ti.com>
 <ab8707fb-e632-5be9-9fdb-4b1fb3cb26ba@ti.com>
 <154947523891.74891.8214442349263473281@swboyd.mtv.corp.google.com>
From: Tero Kristo <t-kristo@ti.com>
Message-ID: <2a22b7f4-8ac4-184e-6c69-f324488614ee@ti.com>
Date: Thu, 7 Feb 2019 10:59:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <154947523891.74891.8214442349263473281@swboyd.mtv.corp.google.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_010014_464580_A66C5B3B 
X-CRM114-Status: GOOD (  23.73  )
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
Cc: devicetree@vger.kernel.org, mturquette@baylibre.com,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 ssantosh@kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 06/02/2019 19:47, Stephen Boyd wrote:
> Quoting Tero Kristo (2019-02-05 00:25:40)
>> On 22/01/2019 09:33, Tero Kristo wrote:
>>> On 21/01/2019 23:04, Rob Herring wrote:
>>>> At first, I thought this was an either/or thing. Use firmware or use DT,
>>>> but it is really only get the clocks used in the DT from firmware.
>>>>
>>>> Why wouldn't you just always do that? I can think of 3 cases:
>>>> reparenting, debug and overlays. This breaks reparenting and overlays,
>>>> right? Debug could be handled with some userspace trigger to get all the
>>>> clocks.
>>>
>>> Re-parenting this does not break, as the scan still checks every
>>> possible parent of a clock scanned. Overlays are broken for sure, as we
>>> don't know which overlays we would be applying, and what clocks would be
>>> in them. Debug is kind of broken as we only scan a small portion of the
>>> clocks.
>>>
>>>>
>>>> Why scan any of the clocks up front? Why not just create the clocks on
>>>> demand? If an unknown clock id is requested, then create the clock and
>>>> query the firmware at that point. That would avoid the DT scan too.
>>>> Maybe there's some issues in the clk framework preventing that, but
>>>> that's not really a DT problem.
>>>
>>> The very initial version I did a couple of years back, did scan the
>>> clocks based on need, and registered them dynamically. Stephen shot down
>>> this based on the assessment that there might be locking issues with the
>>> common clock framework with this approach leading into potential
>>> deadlock situations.
> 
> It's an interesting idea to limit the scope of clks that are registered
> to only the leaf and whatever up to the root of the tree is involved in
> the working set of the kernel.
> 
>>
>> So Rob, what is the final call on this binding? Ack/NAK? If NAK, shall I
>> implement a kernel cmdline param to select the parsing method or what is
>> preferred? Doing it build time with a simple Kconfig seems too limiting.
>>
> 
> Is the problem a performance problem where probing the firmware for all
> the clks is costly and time intensive?

Yes this is pretty expensive, as there can be quite a large amount of 
clocks on a SoC, and each clock must be probed separately.

> So instead of doing that we're
> describing some of the details in DT? Why can't we describe the clk tree
> in C code with some data structure that indicates parent child linkages?
> This is how every other SoC is doing this so far.

We can obviously do that also, however it is "neat" that we can probe 
the available clocks from the device, and don't need to hardcode 
anything kernel side... and neither maintain the clock data. If we want 
to go the hardcoded way, I can create tools to autogenerate the kernel 
side clock data from the clock dump of a running system though, and use 
the built-in clock data if it is available, retaining the existing probe 
method basically for new devices.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
