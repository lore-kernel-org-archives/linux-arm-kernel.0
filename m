Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C3BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:54:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEAEF20879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Nu79eKOa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEAEF20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PyRxzdXZYgEHPK/3ypIr/21cl4jqtgujuyN0FtuFGAQ=; b=Nu79eKOaTLCbX407anltOPk+w
	0tatimbB2Dybq3wu7KlZGNJReyoSebqtWjLYdzKm+RQrFEcY3ZTQQv7W4FM1cl5wLCNMWufvaiFTT
	G2RluhCqpiLyRGdbJMcQjUZhKx/C3LudaK6MJ3B+1OMZWKoF0Y5w+ZqCERtq4muBUajNZOEEA37ha
	vw57p8lt1gtxvO2Ufh8O7D/381H0gLWOJBujoz9PfqyoJE6J0bs9Dk+3PmcKMSCFKQvoMaqiJVP+Z
	a5UTY80ABUy1BAviIKXjUGrY2vFRlq8Weh7aDGXmZrvnDu2z5aXuFIpP/XzBIrEyFT8WkZIK2lo3/
	YhZdAOLSw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghamR-0005Di-Q7; Thu, 10 Jan 2019 13:53:55 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghamA-0004yN-Nx; Thu, 10 Jan 2019 13:53:40 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90BA515BE;
 Thu, 10 Jan 2019 05:53:38 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A404D3F5AF;
 Thu, 10 Jan 2019 05:53:37 -0800 (PST)
Subject: Re: [PATCH 5/5] arm64: dts: rockchip: Fix nanopi4 uSD card detect
To: Heiko Stuebner <heiko@sntech.de>
References: <cover.1546981251.git.robin.murphy@arm.com>
 <6925511.AQqqGbhmY3@phil> <c2c40662-f7aa-75d5-572e-c58b21170b59@arm.com>
 <6110368.KK4K1XCW2x@phil>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <53136c8d-2e17-d404-884f-1fd22fdc192a@arm.com>
Date: Thu, 10 Jan 2019 13:53:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <6110368.KK4K1XCW2x@phil>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_055338_787067_651BAC78 
X-CRM114-Status: GOOD (  24.76  )
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
Cc: linux-rockchip@lists.infradead.org, tomeu.vizoso@collabora.com,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 10/01/2019 13:26, Heiko Stuebner wrote:
> Am Mittwoch, 9. Januar 2019, 00:22:01 CET schrieb Robin Murphy:
>> On 2019-01-08 10:42 pm, Heiko Stuebner wrote:
>>> Am Dienstag, 8. Januar 2019, 22:57:27 CET schrieb Robin Murphy:
>>>> For whatever reason, the sdmmc_dectn function isn't working properly
>>>> as-is, and microSD insertion and removal goes unnoticed. Flipping the
>>>> pin into GPIO mode, however, does do the job, so let's just handle it
>>>> that way for now until someone feels inclined to figure out what GRF
>>>> voodoo or otherwise is needed for correct 'native' operation.
>>>>
>>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>>> ---
>>>>    arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi | 7 ++++++-
>>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
>>>> index 9c723038d8f8..2a183a6af150 100644
>>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
>>>> @@ -505,6 +505,10 @@
>>>>    		sdmmc0_pwr_h: sdmmc0-pwr-h {
>>>>    			rockchip,pins = <0 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none>;
>>>>    		};
>>>> +
>>>> +		sdmmc0_det_l: sdmmc0-det-l {
>>>
>>> alphabetically by node-name please,
>>> aka sdmmc0-det-* should be above sdmmc0-pwr-*
>>
>> Right you are, not sure how that one slipped through.
>>
>>> If you're respinning the whole series this should be fixed,
>>> otherwise I can also do that when applying.
>>
>> I've fixed it up locally, although it might be worth holding off on this
>> particular patch for the moment now that I've taken another look through
>> the TRM and noticed those smoking-gun-looking bits in
>> GRF_SIG_DETECT_CON{0,1} - I'll investigate...
> 
> Personally I'm very much fine with using a cd-gpio instead of trying
> to bring order to the GRF "chaos" ;-) as I'm also not really sure
> if we gain anything with the IP-internal detect mechanism.
> 
> But then do as you like :-D

I'm assuming from the wiring (and from how I recall my 3288/3328 boxes 
behaving) that the dedicated function implements its own debouncing - 
seems the switch in this particular socket is noisy enough that the GPIO 
interrupt is firing well over 100 times per physical event. Not a big 
deal really, I just need to scratch the itch of making things work 
'properly' ;)

>> [ side note - do you reckon there'd be any value in bolting a debugfs
>> interface onto the GRF driver, or is the realistic answer to just use
>> /dev/mem like everyone else and stop having silly ideas? ]
> 
> I don't think it would help much ... especially when it really only outputs
> the register contents in the same way as mem or so does.
> 
> Having to fiddle with GRF bits really should only happen in rare cases,
> so I guess mem should do the trick for that.
> 
> And the GRF driver also was a bit controversial anyway, with the title
> of "dumping ground" looming over it ... so I'd like to keep it small
> and simple ;-) .

Yeah, it would end up being one of those things that's really handy for 
about 5 minutes every couple of years, and a massive pain to maintain 
the rest of the time. Plus I realise that I'd want to compare the 
behaviour of stock kernels anyway, and having to patch and rebuild those 
rather defeats the point.

Thanks,
Robin.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
