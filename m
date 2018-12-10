Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BC4C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:31:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43E062084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t9IQJdQs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LoB9VraD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E062084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=q14gYtwNlyRxyZqya6HgEQ1vrihS3iq3VUiq2WIPVdE=; b=t9IQJdQsBk80LS
	IQ3r3g5OTHKEPenvZUp8cdlP3KIkkRFLTejqsLLBSKZ7yKA3iudZ387Zk9hBdeB4gbMZP3hVkQgDa
	R4BHFrhpxCdk5yYwp1Huw16qArgxJ3IdkXVLrflu95JkrqFaAK3FOqTlL/mRxRLpGGCJu52g7N8T3
	FeyHA/dmNjvYu32m3IHVETRjCBdcDahRGfkOSrO75cJDk2CP2JgNQIQLWF0HCN2JgA3uAPqhFRMJL
	Q8HktK2AcUiBoFJApa4mnCTYfhat9X040t/6g5M0njw29Mbdi6gc+s6fUTRrQdXYT8Ei7+31xHvOR
	0J12ORs1etZD7t0LdZhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWLf4-0001AO-5e; Mon, 10 Dec 2018 13:31:50 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWLf0-00019q-6k
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 13:31:47 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBADVGpp114475;
 Mon, 10 Dec 2018 07:31:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1544448676;
 bh=ENeKuHivQJ95bWleVk2747Bk8AeS95413Q0GLP55crw=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=LoB9VraDxq3RWg+ngjDru2EMwAtuoWLZ9ULkwYIRdqLTWpCSh4KFlYuzk0MF37Cfy
 4v1SxrlqOz3CbjOcNiHSZuy8pSI9Q0TBH6YTCZrWybFFBrZrHjr1/hIlZ5yZM8EwMU
 HEfJ55CQ+ax1KLr9h0Z20p1TfkOYX7GBR4x/DNF8=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBADVGvZ035402
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 10 Dec 2018 07:31:16 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 10
 Dec 2018 07:31:16 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 10 Dec 2018 07:31:16 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBADVCdg002809;
 Mon, 10 Dec 2018 07:31:12 -0600
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-am654-base-board: Add MMC/SD
 support
To: Sekhar Nori <nsekhar@ti.com>, Nishanth Menon <nm@ti.com>
References: <20181207084233.13700-1-faiz_abbas@ti.com>
 <20181207084233.13700-3-faiz_abbas@ti.com>
 <20181208155427.jmidz4vsw4k4qj36@akan>
 <c1dd9783-84dc-9dad-ea94-9a14a4ad814d@ti.com>
 <20181210120647.i3ply3p7umvedb3u@akan>
 <66f9d53b-abec-0a28-8eae-ecb99b075db4@ti.com>
From: Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <a73337c2-977c-c9a8-141e-cf91a4591cbc@ti.com>
Date: Mon, 10 Dec 2018 19:03:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <66f9d53b-abec-0a28-8eae-ecb99b075db4@ti.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_053146_341814_48FD772F 
X-CRM114-Status: GOOD (  23.98  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, ulf.hansson@linaro.org,
 Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>,
 linux-kernel@vger.kernel.org, kishon@ti.com, t-kristo@ti.com,
 robh+dt@kernel.org, adrian.hunter@intel.com, michal.simek@xilinx.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 10/12/18 6:10 PM, Sekhar Nori wrote:
> Hi Nishanth,
> 
> On 10/12/18 5:36 PM, Nishanth Menon wrote:
>> On 13:33-20181210, Sekhar Nori wrote:
>>> On 08/12/18 9:24 PM, Nishanth Menon wrote:
>>>> On 14:12-20181207, Faiz Abbas wrote:
>>>>
>>>>> +
>>>>> +&sdhci0 {
>>>>> +	status = "okay";
>>>>> +	pinctrl-names = "default";
>>>>> +	pinctrl-0 = <&main_mmc0_pins_default>;
>>>>> +	bus-width = <8>;
>>>>> +	non-removable;
>>>>> +	ti,driver-strength-ohm = <50>;
>>>>
>>>> ^^
>>>>
>>>>> +};
>>>>> +
>>>>> +&sdhci1 {
>>>>> +	status = "okay";
>>>>> +	pinctrl-names = "default";
>>>>> +	pinctrl-0 = <&main_mmc1_pins_default>;
>>>>> +	ti,driver-strength-ohm = <50>;
>>>>
>>>> NAK.
>>>>
>>>> $ git checkout next-20181207
>>>> $ git grep ti,driver-strength-ohm Documentation
>>>> $
>>>>
>>>> Nada.. And.. I think "new phy binding" probably introduces this.
>>>> [1] https://patchwork.kernel.org/project/linux-mmc/list/?series=53185
>>>>
>>>> If your patches are'nt really ready, please send them as RFC, I am not
>>>> really in a mood to track the status of every single driver subsystem.
>>>>
>>>> If your binding is not in linux next at the baremin, as far as I am
>>>> concerned, this is not ready, and should be RFC.
>>>
>>> No, RFC does not say "do not merge" or "this has dependencies". RFC is
>>> used to invite a stronger review when introducing a new concept. Its
>>> fair game to apply patches marked RFC if maintainer is okay with the
>>> content.
>>
>> True, fair enough.. RFC is request for comments. Anyways, that is
>> besides the point.
>>>
>>> Dependencies are either noted in cover-letter or below the patch
>>> tear-line. With what you are asking, looks like patches need to be
>>> resubmitted once dependencies are cleared, even if there is no change in
>>> the content itself. This will be additional work.
>>
>> Yes please. There would be other dts changes that are probably ready and
>> I really wont be tracking everything happening on other drivers. If the
>> binding is present at least in next, it is a good indication of things
>> clean and ready to go.
> 
> Agree that bindings should be in linux-next before device-tree files are
> merged.
> 
>>
>>>
>>> That said, if it makes life convenient for you, you can impose such a
>>> rule for patches you need to handle. But I think it will take some
>>> getting used for developers who send patches to you as I don't think
>>> this is a norm elsewhere.
>>>
>>> Adding Tony and Arnd as well, in case I have missed some recently
>>> accepted convention.
>>
>>
>> I have'nt looked at any conventions, The style I prefer to follow when I do
>> submissions: It is my job to get the bindings in, until then my actual
>> dts is just "request for comments". Only after the bindings are merged
>> do I formally submit dts - simply because I dont expect dts maintainer
>> to track what happened to my driver's binding and discussions there of.
> 
> Ok.
> 
>>
>> Seriously, is'nt it really reasonable for dts maintainer to check every
>> single driver's development status in 15 different mailing lists?
>> Because, it sounds like what you are asking. At least I wont have time
>> for it..
>>
>>
>> I really am curious how Arnd / Tony actually pull this one off.. If they
>> have continous cron job for checking if your patch is ready... I doubt
>> it..
> 
> I think you can rely on the author to tell you when something is> actually ready to be merged (and you can tell him/her to remind you).

Yes. I will ping Nishanth once the bindings are in next.

Thanks,
Faiz

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
