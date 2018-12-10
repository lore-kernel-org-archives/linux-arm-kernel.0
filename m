Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03951C65BB3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:40:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB82320821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AVz6UtZd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB82320821
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s+ahzgaTHHNZslVP+gjAcas0axYCT4d+i9CIPzrBt4g=; b=AVz6UtZdk0Rw1t
	dz1PZid8yTd4/4GIrp1u1ip4Dx99FCSITqbHF6RK6Bs4FTYDgB+ZOd5TEzIndvrVcG2sHLa/bQjd4
	SY3y7pafDiCwBBTZjCsUIXzILoaoOq6MLUZKU9txYOA/Dzvw1/b6Q9nUggfatEYWRBH1na7Ki/eMv
	d1ZluVCalrXvW5eA7n36HDWz0KI87UM7G7qK9sTR1T95vhwmfyMwW7kh9djsd4PZ0qRJ1c7QKwzdM
	4KIGBZR3lGb/AIRYn+q95+oJxEQa29a3wXwdokQZB6Cpf/uTk6AlOEM2dISn4F07js7gxhVMBh6Q5
	+t6Ypi37yM69bpEEMmPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWKrk-0005oB-Ee; Mon, 10 Dec 2018 12:40:52 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWKrf-0005a4-JW
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 12:40:49 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBACeMBd125533;
 Mon, 10 Dec 2018 06:40:22 -0600
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBACeM4g130964
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 10 Dec 2018 06:40:22 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 10
 Dec 2018 06:40:22 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 10 Dec 2018 06:40:22 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBACeIjD002754;
 Mon, 10 Dec 2018 06:40:18 -0600
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-am654-base-board: Add MMC/SD
 support
To: Nishanth Menon <nm@ti.com>
References: <20181207084233.13700-1-faiz_abbas@ti.com>
 <20181207084233.13700-3-faiz_abbas@ti.com>
 <20181208155427.jmidz4vsw4k4qj36@akan>
 <c1dd9783-84dc-9dad-ea94-9a14a4ad814d@ti.com>
 <20181210120647.i3ply3p7umvedb3u@akan>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <66f9d53b-abec-0a28-8eae-ecb99b075db4@ti.com>
Date: Mon, 10 Dec 2018 18:10:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181210120647.i3ply3p7umvedb3u@akan>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_044047_820236_DE873DA7 
X-CRM114-Status: GOOD (  25.82  )
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
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, kishon@ti.com,
 t-kristo@ti.com, Faiz Abbas <faiz_abbas@ti.com>, adrian.hunter@intel.com,
 michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Nishanth,

On 10/12/18 5:36 PM, Nishanth Menon wrote:
> On 13:33-20181210, Sekhar Nori wrote:
>> On 08/12/18 9:24 PM, Nishanth Menon wrote:
>>> On 14:12-20181207, Faiz Abbas wrote:
>>>
>>>> +
>>>> +&sdhci0 {
>>>> +	status = "okay";
>>>> +	pinctrl-names = "default";
>>>> +	pinctrl-0 = <&main_mmc0_pins_default>;
>>>> +	bus-width = <8>;
>>>> +	non-removable;
>>>> +	ti,driver-strength-ohm = <50>;
>>>
>>> ^^
>>>
>>>> +};
>>>> +
>>>> +&sdhci1 {
>>>> +	status = "okay";
>>>> +	pinctrl-names = "default";
>>>> +	pinctrl-0 = <&main_mmc1_pins_default>;
>>>> +	ti,driver-strength-ohm = <50>;
>>>
>>> NAK.
>>>
>>> $ git checkout next-20181207
>>> $ git grep ti,driver-strength-ohm Documentation
>>> $
>>>
>>> Nada.. And.. I think "new phy binding" probably introduces this.
>>> [1] https://patchwork.kernel.org/project/linux-mmc/list/?series=53185
>>>
>>> If your patches are'nt really ready, please send them as RFC, I am not
>>> really in a mood to track the status of every single driver subsystem.
>>>
>>> If your binding is not in linux next at the baremin, as far as I am
>>> concerned, this is not ready, and should be RFC.
>>
>> No, RFC does not say "do not merge" or "this has dependencies". RFC is
>> used to invite a stronger review when introducing a new concept. Its
>> fair game to apply patches marked RFC if maintainer is okay with the
>> content.
> 
> True, fair enough.. RFC is request for comments. Anyways, that is
> besides the point.
>>
>> Dependencies are either noted in cover-letter or below the patch
>> tear-line. With what you are asking, looks like patches need to be
>> resubmitted once dependencies are cleared, even if there is no change in
>> the content itself. This will be additional work.
> 
> Yes please. There would be other dts changes that are probably ready and
> I really wont be tracking everything happening on other drivers. If the
> binding is present at least in next, it is a good indication of things
> clean and ready to go.

Agree that bindings should be in linux-next before device-tree files are
merged.

> 
>>
>> That said, if it makes life convenient for you, you can impose such a
>> rule for patches you need to handle. But I think it will take some
>> getting used for developers who send patches to you as I don't think
>> this is a norm elsewhere.
>>
>> Adding Tony and Arnd as well, in case I have missed some recently
>> accepted convention.
> 
> 
> I have'nt looked at any conventions, The style I prefer to follow when I do
> submissions: It is my job to get the bindings in, until then my actual
> dts is just "request for comments". Only after the bindings are merged
> do I formally submit dts - simply because I dont expect dts maintainer
> to track what happened to my driver's binding and discussions there of.

Ok.

> 
> Seriously, is'nt it really reasonable for dts maintainer to check every
> single driver's development status in 15 different mailing lists?
> Because, it sounds like what you are asking. At least I wont have time
> for it..
> 
> 
> I really am curious how Arnd / Tony actually pull this one off.. If they
> have continous cron job for checking if your patch is ready... I doubt
> it..

I think you can rely on the author to tell you when something is
actually ready to be merged (and you can tell him/her to remind you).

For the review itself, doing it by having a look at the dependencies
mentioned in the cover letter (like available for this series) should be
good enough (I feel).

I am not sure if there is a need to post an "RFC version", and then
follow it up with an actual "PATCH version" once dependencies are
cleared though.

Thanks,
Sekhar

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
