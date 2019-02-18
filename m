Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82855C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:55:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 529BF2184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iwQEydu/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 529BF2184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=x73CNr96E8KWBrtyc5MwUvnYaY4S0Smb1bonDBHMJNg=; b=iwQEydu/WRt0K1Fxlz46MwMQ2
	EDo9F2vGvfagLUxqSRkvkGjBYUiWKw8WaGOA0qC+aGmBJiYSde5+K8niueq2oKUUutjkh1nNsVmRg
	lJbIZtx1LCupsItBvUBw/MIq3t5aQNazM/dHGCrM0hd6zw2vb3Gx2Tv1734OONfsfAg2yR+QpjSfO
	3gQzLuBXkZpoaoBn0sxkv5JcuA/CiAQknC4A4HzD2tuhwF/8TaD6iXL9pbsSJU1Jwo137l2PFOz+g
	GPMdZggGmfsVHdu1sBg6Zmc1tBEPHRedh2HzHy/yiu/ULdlNZD9NCXKTqcpNPr3kYDlundRBO3xQ8
	hH5TgtipQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvhWA-0002T9-L8; Mon, 18 Feb 2019 11:55:26 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvhVF-0001Av-B2; Mon, 18 Feb 2019 11:55:24 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B701C80D;
 Mon, 18 Feb 2019 03:54:22 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C9933F720;
 Mon, 18 Feb 2019 03:54:11 -0800 (PST)
Subject: Re: [PATCH 1/3] ARM: dts: rk3288 Tinker Board (S) sdcard changes
To: David Summers <beagleboard@davidjohnsummers.uk>, heiko@sntech.de,
 robh+dt@kernel.org, mark.rutland@arm.com
References: <20190217121513.22965-1-beagleboard@davidjohnsummers.uk>
 <20190217121513.22965-2-beagleboard@davidjohnsummers.uk>
 <e83b0404-bd32-a5d5-2e32-e0f49b122b95@arm.com>
 <2d8ac4e6-b825-dca7-d3cb-57cb32b3230b@davidjohnsummers.uk>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <6a15343b-554b-6059-09af-f6511e740866@arm.com>
Date: Mon, 18 Feb 2019 11:54:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <2d8ac4e6-b825-dca7-d3cb-57cb32b3230b@davidjohnsummers.uk>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_035523_091568_8EFCDCA4 
X-CRM114-Status: GOOD (  29.42  )
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
Cc: linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 17/02/2019 15:19, David Summers wrote:
> On 17/02/2019 14:00, Robin Murphy wrote:
>> Hi David,
>>
>> On 2019-02-17 12:15 pm, David Summers wrote:
>>> This patch makes some minor changes to how the sd card is
>>> described in the device tree for the ASUS Tinker Board (S). In
>>> particular on the Tinker Board S, when booted from the eMMC, and with
>>> no card in the sd slot, and the log has endless messages about not
>>> being able to detect the card.
>>>
>>> Several methods to remove this error have been tried, the only one
>>> that works is the broken-cd and so that is what is applied here.
>>
>> I don't have a Tinker Board, but the symptom sounds instantly familiar 
>> from hacking on another RK3288 box; have you tried adding 
>> "regulator-always-on" to the vccio_sd regulator?
>>
>> With the reference design (which I would assume the Tinker Board has 
>> no reason to deviate from in this area), the CD pin is either wired 
>> directly to the SoC with no external pull-up, or explicitly pulled up 
>> to VCCIO_SD. Either way, when the dwmmc driver probes and discovers 
>> there is no card present, it sets the currently-unnecessary 
>> vqmmc-supply as inactive, and thus the regulator core turns off 
>> VCCIO_SD entirely. Unfortunately, this removes the voltage from the 
>> entire I/O domain including the internal pull-up, which ends up 
>> leaving the CD pin floating and generating spurious events.
>>
>> Robin.
> 
> Hi Robin,
> 
> An interesting suggestion - no it hasn't been tried to always set the 
> vccio_sd regulator on. Will give it a go on ArchLinux Arm.
> 
> I guess this would explain why the Tinker Board booting from sd doesn't 
> see the error, as its enabled probably in uboot and then keeps working.
> 
> IIRC though, if booting the TBS from eMMC, then inserting an sd card and 
> the errors stop. I guess this wouldn't happen if the power wasn't applied?

That's the fun part of this scenario - the presence of a card is 
unambiguous, it's only the absence of one which depends on the pull-up 
state, so whenever as a card is inserted everything does work correctly. 
  Assuming they are the same errors I was seeing, they're from the 
driver *thinking* a card is inserted due to CD floating low, then 
failing to communicate with it, after which it powers down the I/O 
interface again and the whole cycle begins anew.

> I guess also that "regulator-always-on" is a quick test - but that for 
> submission to kernel it would be better done via "mmc-pwrseq-simple"?

No, it's a valid description of the hardware to say "disabling this 
regulator makes something fail to work as expected" if that is truly the 
case. Besides, pwrseq is about how to initialise a detected present 
card, not how to correctly detect that presence in the first place.

> Anyway I set up a test - so we can confirm this.

Great - there is of course still the possibility that the pin really 
isn't wired up at all, in which case ignoring CD and taking the CPU 
overhead of polling would be the only option, but the vendor DT doesn't 
have any signs to suggest that's the case, and makes me lean more 
towards the pull-up issue.

Robin.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
