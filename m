Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38044C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:59:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0191820685
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K9Tvc7iL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fQF/fTQ0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="W1clugGN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0191820685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:Subject:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Q+jYISCQR4ETFmUD5hYHR4E8Zv6ztbY0clABOGOW6+E=; b=K9Tvc7iLsWNJYaGwlfQzIl9DM
	8SIXqdrNWBuiH6p7EQIugHcAncvQsPlp2q0PkBYtT2YggQ5+A2BmYQ1umFX9nQIVhLP8y9NQjsFiC
	LN9w/B6/QDqTBnSpMfKKFPsEpywm6Di//oSQ4MNSf3dt6+hc7B7WmndZB38WYziYDkywhh/mB5sKr
	JlOATOEcCFA2C2gLyZt3Yy6nRK4ssl0Z1fJx0eLgWUZpW2TqVgJ+T8txA4YeXnPi8MZp/783Z0ybO
	QVZA3AwHo6/vkQndqRPkClVH9r+hN7SCsiPOn9XNIgZFg9FOoudyotulIiRoHr0zEDMeS/zyiwYqJ
	7f9QMLLCQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghdfW-0004ot-Qh; Thu, 10 Jan 2019 16:58:58 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghdfT-0004oY-HY
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 16:58:57 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 615996020A; Thu, 10 Jan 2019 16:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547139533;
 bh=HM15Tt9/ii2ZvUK7n9I0DdCWj4ukHrWRvzYXhSoccHI=;
 h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
 b=fQF/fTQ0LmrJ2+BcF2k/iswA4Tu5Wuw48xSaEYYcBjfUswFezxWcCAAsW8HM0vY7s
 pwZTelQInWEs0e9M7sn3gmkmQVSLC3GLmRbeYWP0Wa2eA8aBOLgmVT8fgCpYAil4JF
 BFRRdpDN/A3gmcuEgAaxq5cHq09V7BZQsP2dJaf8=
Received: from [192.168.1.3] (unknown [183.83.79.153])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: rplsssn@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 3B939601B4;
 Thu, 10 Jan 2019 16:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547139532;
 bh=HM15Tt9/ii2ZvUK7n9I0DdCWj4ukHrWRvzYXhSoccHI=;
 h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
 b=W1clugGNdztvz1O0ofuQsLuVuCdyV6u124PPy6m0C1EoXGeIQzwVLINQXyug16c0i
 EZMajKZIoBRk/G+LaWbVPvgzQ/Ikexg5zIqXIMejOuDS5BxHj8VsKHp03IUWGRByWP
 ojwKTT0tV1jexHQPHqQ8NYG7c+MdGBdvNx+6P24g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3B939601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=rplsssn@codeaurora.org
From: Raju P L S S S N <rplsssn@codeaurora.org>
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
 <6384bcac-634c-5e7e-b357-93982de6eafb@codeaurora.org>
 <93a4b632-5740-42a9-9552-b46dd599ad68@codeaurora.org>
 <154705600478.15366.3563482093409250809@swboyd.mtv.corp.google.com>
Message-ID: <3ae4bf87-88be-466d-0f1e-ff7bf5c4e816@codeaurora.org>
Date: Thu, 10 Jan 2019 22:28:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <154705600478.15366.3563482093409250809@swboyd.mtv.corp.google.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_085855_626033_31AC0629 
X-CRM114-Status: GOOD (  26.18  )
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



On 1/9/2019 11:16 PM, Stephen Boyd wrote:
> Quoting Raju P L S S S N (2019-01-08 21:34:32)
>>
>>
>> On 1/7/2019 9:47 PM, Raju P L S S S N wrote:
>>>
>>>
>>> On 1/4/2019 2:49 AM, Stephen Boyd wrote:
>>>>
>>>> I'd hope that each RSC's PDC timer wakes up the owner of the RSC so that
>>>> we can use the sysreg based timers and ignore the MMIO based timers
>>>> here. This isn't a very important distinction to make though, so if you
>>>> have to use the MMIO timers then it just means some extra DT things need
>>>> to be done to relate the MMIO timers with the RSC that has the timer
>>>> that needs to be programmed too.
>>>
>>>>
>>>> Either way we would need a way to either hook the ARM architected timer
>>>> driver in the kernel, or reimplement the bit of code needed to implement
>>>> the clockevent based on the ARM architected timer that programs the ARM
>>>> timer and the PDC timer together.
>>>>
>>>
>>> Could you please provide some more details on the implementation?
>>
>> Hi Stephen,
>>
>> Regardless of implementation options about application processor
>> subsytem PDC timer, I think there is a need to differentiate the fact
>> that for application processor subsystem PDC timer programming is done
>> by SW but not for display processor subsystem as HW sleep solver takes
>> care of PDC timer during sleep entry/exit. How about having a dt
>> property like qcom,pdc-timer-mode = "solver"/"sw" ? The current patch
>> introduced client based model using regmap to achieve this
>> differentiation between these two subsystems. By using the dt property,
>> once rpmh-src driver instance for application subsystem can have PDC
>> timer programing implemented. Let me know if there is another way.
>>
>> For implementation of PDC timer, I see the following based on above
>> discussion -
>> 1. Take the existing cpu_pm_notify approach and move the current series
>> approach of programing PDC timer registers to RSC driver. This wouldn't
>> involve any changes in clock_event_framework/broadcast framework.
>>
>> 2. Add api hooks (like reading the next wake up programmed) to ARM
>> architecture timer driver so that the value is copied to PDC timer using
>> the api with in RSC driver based on cpu_pm_notifications.
>>
>> 3. Changes in clockevent to program both ARM mem timer & PDC timer
>> together. Could you please share some more details on this?
>>
>>
>> Please let me know if the first approach is ok.
>>
> 
> The first approach requires that we expose internals of the clockevent
> and broadcast timer information to drivers. From my perspective it looks
> like a weird kludge to workaround the fact that the broadcast timer
> doesn't actually work on this platform. That's why I'm suggesting that
> you fix the broadcast timer on your platform to actually work, and do
> that within the clockevent/broadcast layers instead of indirecting that
> through cpu_pm notifiers.
> 
> That could be done by making a PDC clockevent that has some DT binding
> of a property pointing to an MMIO timer frame and then reimplementing
> the MMIO timer code in the PDC driver on top of the frame/register
> region it pulls out of there. Or it could be written in reverse by
> having the generic MMIO timer driver point to the PDC somehow and
> implement some platform specific API to pass that information to the
> real wakeup programming part in PDC.
> 
> I'm leaning toward the first approach where PDC is the clockevent and
> that uses the MMIO timer on the backend to do what it needs to program a
> wakeup. That way you can mandate the usage of the physical timer and
> keep this quirk away from the ARM timer driver. It also makes the idea
> of a qcom,pdc-timer-mode sort of useless because the PDC will have a
> property that points to the timer frame and that will mean "use this for
> broadcast wakeup". I'm not sure how the ARM folks feel about this
> though. It would probably require some sort of ARM timer API that lets
> us program the MMIO timer frame from the PDC driver. So exporting
> arch_timer_reg_write() and making that always inlined to optimize hot
> paths would be required.
> 

Regarding the first approach -
If PDC clk_evt_dev is created and registered to broadcast framework, it 
means it will replace MMIO timer event device in broadcast framework (as 
only one broadcast event timer can exist). So in registration phase, the 
tick broadcast framework would configure broadcat event handler for 
PDC(clk_evt_dev).

Even if we have some way of exporting arch_timer_reg_write() to program 
the wakeup for MMIO timer, the irq handler for MMIO timer is responsible 
to invoke event_handler. However, since MMIO timer is replaced by PDC 
timer event device, event handler will not be able to inform broadcast 
framework. What can be done about this?



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
