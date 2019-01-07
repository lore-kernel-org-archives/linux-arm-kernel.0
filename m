Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C58DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:18:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BFA82147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sJhX8MGD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EY9oKWv+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fh8F1DsO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BFA82147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cN6fXm/6/t7RdXKghj+17UqcJaGKmk0vbJHm8I8lr9M=; b=sJhX8MGDV1WDAb88Te+ydtEzw
	fyi501drK3P+cY8k1icHmptX0fWDLlMzZ4VQab9TpDU6tRu0iNv6xorz9QIbADWmhprPMW8rn/EQU
	7hA0ZtUIS/4ojz9PErDKsrQWkszAin2ki4dNTgPK1r+N7jUq/UEgqSBFx3Y8vbU4xjWWsq5wPaFyY
	XVUiBdhTVvwggWBwsy/htPxK10Gyy3aAx1PQIXAC7gN2WgKyh3VEr2M9IUWKiouAbUBroDOajLWAC
	ddD0zs1TrgTkiXoVVRrlVrm429VbRyc5eNU4RsfDNix21/3KXePHf2QO8b/2oSg34qXK7gBNQ+TLB
	RTpqeZCoQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggXbu-0006yd-8s; Mon, 07 Jan 2019 16:18:42 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggXbq-0006yF-QE
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 16:18:40 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 8E6F060300; Mon,  7 Jan 2019 16:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1546877917;
 bh=Vd0GSTwVHmxHGxTVofQUT5Ru48N2IHVxwsVZ+p2QY10=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=EY9oKWv+9DguXMYQ3KZ23qrG7VphplWN5cFsDlIodbsOQSVLLM0u5Rz/sOHM/bdyb
 LV37i846QtZupQ0L4sAqx6v6Jvti8cR8Mg3j0RHLHzo1ak63nOIUxhj3Du+sVGRzA+
 glpfDOJ7GEmlN1bcbjzeSjTKKd5mUNeBRUnZ/jxE=
Received: from [192.168.1.6] (unknown [183.83.79.153])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: rplsssn@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id BCF8360300;
 Mon,  7 Jan 2019 16:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1546877916;
 bh=Vd0GSTwVHmxHGxTVofQUT5Ru48N2IHVxwsVZ+p2QY10=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=fh8F1DsOM+0pi3xZq8gWbEUAHa22+GW6UBVhEB2ZGRtq/xsk1J0ZDxueIT6ZjRqHT
 vH7JOHm3rNBqkUvaD5r8TGbYgvOrCseEJxHoxs2417a4m9mEI+E3goSIxh9Gy5e5OL
 XlPefw6XV+ds3D1M1NMxEq7G0FO0jeJ/SW8OOvM4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BCF8360300
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=rplsssn@codeaurora.org
Subject: Re: [PATCH RFC 3/5] dt-bindings: Add PDC timer bindings for Qualcomm
 SoCs
To: Stephen Boyd <swboyd@chromium.org>, andy.gross@linaro.org,
 david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
 linux-soc@vger.kernel.org
References: <20181221115946.10095-1-rplsssn@codeaurora.org>
 <20181221115946.10095-4-rplsssn@codeaurora.org>
 <154546438942.179992.14851496143150245966@swboyd.mtv.corp.google.com>
 <504cae51-0f35-beb8-496b-a335863a9071@codeaurora.org>
 <154603310752.179992.9262815873457262616@swboyd.mtv.corp.google.com>
 <b97937a0-68ff-ded7-d63b-680981818114@codeaurora.org>
 <154655037205.15366.7302521016277534390@swboyd.mtv.corp.google.com>
From: Raju P L S S S N <rplsssn@codeaurora.org>
Message-ID: <6384bcac-634c-5e7e-b357-93982de6eafb@codeaurora.org>
Date: Mon, 7 Jan 2019 21:47:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <154655037205.15366.7302521016277534390@swboyd.mtv.corp.google.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_081838_884811_E3CA4FAF 
X-CRM114-Status: GOOD (  27.32  )
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
Cc: devicetree@vger.kernel.org, rnayak@codeaurora.org, linux-pm@vger.kernel.org,
 dianders@chromium.org, evgreen@chromium.org, linux-kernel@vger.kernel.org,
 mka@chromium.org, ilina@codeaurora.org, bjorn.andersson@linaro.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 1/4/2019 2:49 AM, Stephen Boyd wrote:
> Quoting Raju P L S S S N (2019-01-03 04:22:58)
>>
>> On 12/29/2018 3:08 AM, Stephen Boyd wrote:
>>> Quoting Raju P L S S S N (2018-12-26 01:44:43)
>>>>
>>>> There are two RSC devices in SoC one for application processor subsystem
>>>> & other display subsystem. Both RSC contain registers for PDC timers
>>>> (one for each subsystem).
>>>
>>> When is the timer programmed on the display subsystem's RSC? It's hard
>>> to give advice without all the information.
>>
>> For display subsystem RSC, hardware sleep solver takes care of timer
>> programming for wakeup when the subsystem goes to Power collapse.
> 
> So the display subsystem doesn't need to program their PDC in their RSC
> from software?
Yes.

> 
>>>
>>> I would think that it would make sense for the application processor's
>>> RSC timer to be programmed from the broadcast timer mechanism in the
>>> kernel so that timers during idle work and suspend turns off the timer
>>> appropriately with a shutdown hook. I guess the PDC can't tell you the
>>> time though? It looks like a shadow (and limited) version of the ARM
>>> architected MMIO timer that we already program for the broadcast timer
>>> mechanism. Is that because even the MMIO timer can't wakeup the system
>>> in deep idle?  Assuming that's true, it means the ARM MMIO timer can't
>>> always be used as the system wide broadcast mechanism because we need to
>>> augment it with the PDC timer to get the actual wakeup.
>>>
>>
>> Yes. this is correct.
>>
>>> Maybe we should be adding hooks into the broadcast timer mechanism to
>>> program this wakeup event hardware in addition to the ARM MMIO timer. Or
>>> we should stop using the ARM MMIO timer on these systems and read the
>>> system register based physical time in the RSC timer driver and register
>>> this 64-bit PDC register as the broadcast timer. So the time reading
>>> would be through sysreg and the wakeup programming would be done by
>>> writing the PDC timer. The assumption would be that we have access to
>>> the physical time registers (which sounds like the assumption we have to
>>> make).
>>
>> There are no physical timer registers available in RSC for this purpose.
>>
>>>
>>> Do we get an interrupt somewhere from the RSC hardware when the timer
>>> fires? Or does that just cause a system wakeup event without any pending
>>> irq and then another irq (like the ARM architected timer) just happens
>>> to be pending around the same time? If we get an interrupt somehow then
>>> I would prefer to drop the ARM MMIO timer and do this hybrid broadcast
>>> timer approach.
>>
>> There is no interrupt for PDC timeout. It just causes system wakeup
>> without a pending irq. ARM MMIO is necessary for irq.
> 
> Does that system wakeup cause the CPUs to be enabled? So the sysreg
> based timer in the CPU would start working? Or does it only make the
> system come out of a deep enough idle state to make an always on domain
> work that only contains the MMIO based ARM architected timer?

It only makes the system come out of deep sleep state for MMIO timer to 
function.

> 
> I'd hope that each RSC's PDC timer wakes up the owner of the RSC so that
> we can use the sysreg based timers and ignore the MMIO based timers
> here. This isn't a very important distinction to make though, so if you
> have to use the MMIO timers then it just means some extra DT things need
> to be done to relate the MMIO timers with the RSC that has the timer
> that needs to be programmed too.

> 
> Either way we would need a way to either hook the ARM architected timer
> driver in the kernel, or reimplement the bit of code needed to implement
> the clockevent based on the ARM architected timer that programs the ARM
> timer and the PDC timer together.
> 

Could you please provide some more details on the implementation?


>>
>>>
>>> How the RSC is used in general by other devices, like display, is not
>>> clear to me. We don't have a "wakeup event" framework in the kernel that
>>> device drivers like the display driver can grab a reference to and
>>> program some system wide wakeup for. That sounds like something new that
>>> could be handled entirely in the display driver with direct register
>>> writes, or it could be some qcom specific API/framework that eventually
>>> calls down into the same RSC driver that knows what offsets to write
>>> into in the display RSC's register space, or it could be an entirely
>>> generic framework like clk or regulator frameworks that could be used by
>>> anything. BTW, are we using the display RSC yet?
>>>
>>
>> Only display subsystem RSC is programmed along with CPU RSC in Linux.
>> display RSC instance is not present in upstream but it is present in
>> downstream and used for resource communication purpose only.
> 
>  From the comment above it sounds like the display RSC handles the wakeup
> programming in hardware? So there isn't a need to add a 'wakeup event'
> framework or anything like that. Please correct me if I'm wrong.

Yes. There is no need for any framework. From RSC driver point of view 
there is a need to differentiate apps_rsc vs display_rsc as SW programs 
PDC timer only in apps_rsc case. How about having a dt property to 
capture this?

Thanks,
Raju

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
