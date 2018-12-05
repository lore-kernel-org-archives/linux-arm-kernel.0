Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E082C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:31:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 321B52064D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WDsYuR8E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 321B52064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IZNek+Mzb44iwv4Rpbg/WwJrNnuV7+7XxusxwpGXTAo=; b=WDsYuR8ESrmNQzp9edlEzc6p8
	n44eJFXTguszJfgtN7FBpRzEf2tPIHtIG4ykVn1nMg9N3+4I15a4vfkZ9wm7JsK68pFmydvsk8v4e
	nhMhRisW9QPVWVJ736PZqSaNDzeeC42HWbNQMm66QArWqek3LMIeUbwsVm3LKUZ8PKZ8ozzBNrSEK
	8ZvkwodlVsv4c3SxMK+TJkf8T53YxHICf830f9hNoKj4NDX4jydejQ8637JevPIbGL1iMD2pqOwtb
	EIWUyqi7MFAKOIbZx8ocuaEcuxC96vmL6ZQQ/ndsv/Z5WcKtdgziSha+adVWsowD92k0zPDnsJsiJ
	fzhIzXqnA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUUSI-0001Db-H6; Wed, 05 Dec 2018 10:30:58 +0000
Received: from mx.socionext.com ([202.248.49.38])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUUSE-0001CO-Tg
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 10:30:57 +0000
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
 by mx.socionext.com with ESMTP; 05 Dec 2018 19:30:41 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
 by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 36E5960062;
 Wed,  5 Dec 2018 19:30:41 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP;
 Wed, 5 Dec 2018 19:30:41 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
 by iyokan.css.socionext.com (Postfix) with ESMTP id 8DD9440377;
 Wed,  5 Dec 2018 19:30:40 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
 by yuzu.css.socionext.com (Postfix) with ESMTP id 670C4120304;
 Wed,  5 Dec 2018 19:30:40 +0900 (JST)
Subject: Re: [PATCH 02/14] dt-bindings: soc: milbeaut: Add Milbeaut trampoline
 description
To: Rob Herring <robh+dt@kernel.org>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-3-git-send-email-sugaya.taichi@socionext.com>
 <154337047410.88331.9696178601340675631@swboyd.mtv.corp.google.com>
 <c746a3de-a9e3-9f25-ecb9-703ceb7e62d0@socionext.com>
 <154356579701.88331.5043467509900444879@swboyd.mtv.corp.google.com>
 <f5917f71-f15b-a92d-649c-e3f5f5f10698@socionext.com>
 <CAL_Jsq+dnKht3TwCh1qB1H4pYFhQJmSN0nAayU+=PJLAvq0bbQ@mail.gmail.com>
 <90b00858-6e9e-8f7c-f6d4-b35e5daa6eee@socionext.com>
 <CAL_JsqJ=FRfzVFiOJ0wvoV5iZV+Gx3ft9pGyhb-GoKnOAQgPtQ@mail.gmail.com>
From: "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <60f13d51-51e6-33f9-5393-e9425883c528@socionext.com>
Date: Wed, 5 Dec 2018 19:30:39 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJ=FRfzVFiOJ0wvoV5iZV+Gx3ft9pGyhb-GoKnOAQgPtQ@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_023055_321870_4D109F36 
X-CRM114-Status: GOOD (  26.36  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Stephen Boyd <sboyd@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>, Jassi Brar <jaswinder.singh@linaro.org>,
 "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
 Jiri Slaby <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-clk <linux-clk@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 2018/12/04 22:32, Rob Herring wrote:
> On Tue, Dec 4, 2018 at 5:30 AM Sugaya, Taichi
> <sugaya.taichi@socionext.com> wrote:
>>
>> Hi
>>
>> On 2018/12/04 0:49, Rob Herring wrote:
>>> On Mon, Dec 3, 2018 at 1:42 AM Sugaya, Taichi
>>> <sugaya.taichi@socionext.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On 2018/11/30 17:16, Stephen Boyd wrote:
>>>>> Quoting Sugaya, Taichi (2018-11-29 04:24:51)
>>>>>> On 2018/11/28 11:01, Stephen Boyd wrote:
>>>>>>> Quoting Sugaya Taichi (2018-11-18 17:01:07)
>>>>>>>>      create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt
>>>>>>>>
>>>>>>>> diff --git a/Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt b/Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt
>>>>>>>> new file mode 100644
>>>>>>>> index 0000000..f5d906c
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt
>>>>>>>> @@ -0,0 +1,12 @@
>>>>>>>> +Socionext M10V SMP trampoline driver binding
>>>>>>>> +
>>>>>>>> +This is a driver to wait for sub-cores while boot process.
>>>>>>>> +
>>>>>>>> +- compatible: should be "socionext,smp-trampoline"
>>>>>>>> +- reg: should be <0x4C000100 0x100>
>>>>>>>> +
>>>>>>>> +EXAMPLE
>>>>>>>> +       trampoline: trampoline@0x4C000100 {
>>>>>>> Drop the 0x part of unit addresses.
>>>>>>
>>>>>> Okay.
>>>>>>
>>>>>>
>>>>>>>> +               compatible = "socionext,smp-trampoline";
>>>>>>>> +               reg = <0x4C000100 0x100>;
>>>>>>> Looks like a software construct, which we wouldn't want to put into DT
>>>>>>> this way. DT doesn't describe drivers.
>>>>>> We would like to use this node only getting the address of the
>>>>>> trampoline area
>>>>>> in which sub-cores wait.  (They have finished to go to this area in previous
>>>>>> bootloader process.)
>>>>>
>>>>> Is this area part of memory, or a special SRAM? If it's part of memory,
>>>>> I would expect this node to be under the reserved-memory node and
>>>>> pointed to by some other node that uses this region. Could even be the
>>>>> CPU nodes.
>>>>
>>>> Yes, 0x4C000100 is a part of memory under the reserved-memory node. So
>>>> we would like to use the SRAM ( allocated 0x00000000 ) area instead.
>>>> BTW, sorry, the trampoline address of this example is simply wrong.  We
>>>> were going to use a part of the SRAM from the beginning.
>>>>
>>>>>
>>>>>>
>>>>>> So should we embed the constant value in source codes instead of getting
>>>>>> from
>>>>>> DT because the address is constant at the moment? Or is there other
>>>>>> approach?
>>>>>>
>>>>>
>>>>> If it's constant then that also works. Why does it need to come from DT
>>>>> at all then?
>>>>
>>>> We think it is not good to embed constant value in driver codes and do
>>>> not have another way...
>>>> Are there better ways?
>>>
>>> If this is just memory, can you use the standard spin-table binding in
>>> the DT spec? There are some requirements like 64-bit values even on
>>> 32-bit machines (though this gets violated).
>>
>> The spin-table seems to be used on only 64-bit arch. Have it ever worked
>> on 32-bit machine?
> 
> Yes.
> 
>> And I would like not to use it because avoid violation.
> 
> The issue now that I remember is cpu-release-addr is defined to always
> be a 64-bit value while some platforms made it a 32-bit value.
> 'cpu-release-addr' is also used for some other enable-methods.

Thanks.
OK, try to use the spin-table.

Best Regards,
Sugaya Taichi

> 
> Rob
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
