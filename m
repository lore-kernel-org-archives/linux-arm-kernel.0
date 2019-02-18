Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50677C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:16:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B5872147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p21UV9hc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=davidjohnsummers.uk header.i=@davidjohnsummers.uk header.b="u+2nP47b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B5872147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davidjohnsummers.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oneBURIEKWvyIkBzPHo32C5Mv+zjqIkEtdqDW/9S2jo=; b=p21UV9hcdp7qSLa445wBEKSco
	/7UxhRY9j2s6WWuRaAIMd/DikckraBp90E9lVv76dfj+oU7RFfObQKv8AxIsN10kW2EO+nLCoxK7T
	A8FvrkoI/YT6dm07CDMkkziYAYbhpBzhowFd944QayOX/ylVJg7h2CI42faUxNAw3iy4PxiKYM9xO
	xaT8P0dcHZinimYewhCgTBrctNqmUAT01jEFT5TvQ1dFE8W8ydBOEmxy7cH8A5CTefkrrlLsCgYav
	dTonAamU5tE7yOp7cEqjGL9zqjnUyDrOkXhAthiwmJIJIkVAAUfFIb4sRCMbvVn2T0Gws/O1TJ3YX
	CLBfmfv8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvqH7-0003m2-NV; Mon, 18 Feb 2019 21:16:29 +0000
Received: from mail-gw.thundercloud.uk ([149.255.60.84])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvqH1-0003k7-Kf
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 21:16:27 +0000
Received: from mailbsf01.thundercloud.uk (mail-gw.thundercloud.uk
 [149.255.60.72])
 by mail-gw.thundercloud.uk (Postfix) with ESMTPS id 9CE4F6008404
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 21:16:21 +0000 (GMT)
X-ASG-Debug-ID: 1550524580-0554131266240760001-tbGyMd
Received: from cloud706.unlimitedwebhosting.co.uk (no-dns-yet.unlimited.uk.net
 [149.255.62.7]) by mailbsf01.thundercloud.uk with ESMTP id UFrFEnhviPRtHaZw
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 18 Feb 2019 21:16:20 +0000 (GMT)
X-Barracuda-Envelope-From: beagleboard@davidjohnsummers.uk
X-Barracuda-Effective-Source-IP: no-dns-yet.unlimited.uk.net[149.255.62.7]
X-Barracuda-Apparent-Source-IP: 149.255.62.7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=davidjohnsummers.uk; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SXXC20TlzUXv134pO6X5XUpkiEqHlJJOsP5OE1JM0S0=; b=u+2nP47bVB7xuEOQY7TFEG7cHJ
 H5YuCdjK1kRTH5oERCh9Zo65SWlN+/N82M58Zm9XyngCOcWCg6YQ06DK4DPFdMICdmd3xaFANd61b
 VaD9X6SuFwVfGqOu2U7HDN+wR3GGT/H4c1S9qKSQUPrIAPhnQUQeMP7Rh/SaAQr9+ET05qUj2ECK2
 +tm0xezLK9LhNs88mcvBPAmrlqn8smo2HIqugtaG1l+IQDZbR57DKnHHuvQBI9CQIZS3J5pWncdm0
 k0Mxjz+f0BhcI0xsamRBmctjpKPXyONJgMB8D0Z3N7sNAwzlAB0PuA+iJdBKReYpr1+IEAXHy5cM9
 3M800CVg==;
Received: from [87.114.170.31] (port=58406 helo=[192.168.2.187])
 by cloud706.unlimitedwebhosting.co.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.91)
 (envelope-from <beagleboard@davidjohnsummers.uk>)
 id 1gvpUJ-000RzE-Kp; Mon, 18 Feb 2019 20:26:03 +0000
Subject: Re: [PATCH 2/3] ARM: dts: rk3288 Tinker Board (S) add wi-fi
To: Stefan Wahren <stefan.wahren@i2se.com>, heiko@sntech.de,
 robh+dt@kernel.org, mark.rutland@arm.com
X-ASG-Orig-Subj: Re: [PATCH 2/3] ARM: dts: rk3288 Tinker Board (S) add wi-fi
References: <20190217121513.22965-1-beagleboard@davidjohnsummers.uk>
 <20190217121513.22965-3-beagleboard@davidjohnsummers.uk>
 <1528638260.343699.1550436208775@email.ionos.de>
From: David Summers <beagleboard@davidjohnsummers.uk>
Message-ID: <3e9a387c-2ebc-c762-6222-90efc851e4ed@davidjohnsummers.uk>
Date: Mon, 18 Feb 2019 20:26:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <1528638260.343699.1550436208775@email.ionos.de>
Content-Language: en-PH
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cloud706.unlimitedwebhosting.co.uk
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - davidjohnsummers.uk
X-Get-Message-Sender-Via: cloud706.unlimitedwebhosting.co.uk: authenticated_id:
 davidjoh/from_h
X-Authenticated-Sender: cloud706.unlimitedwebhosting.co.uk: beagleboard@davidjohnsummers.uk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Barracuda-Connect: no-dns-yet.unlimited.uk.net[149.255.62.7]
X-Barracuda-Start-Time: 1550524580
X-Barracuda-Encrypted: ECDHE-RSA-AES256-GCM-SHA384
X-Barracuda-URL: https://149.255.60.72:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at thundercloud.uk
X-Barracuda-Scan-Msg-Size: 2793
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=2.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.67544
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_131623_819262_5D2982B8 
X-CRM114-Status: GOOD (  16.81  )
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

On 17/02/2019 20:43, Stefan Wahren wrote:
> Hi David,
>
>> David Summers <beagleboard@davidjohnsummers.uk> hat am 17. Februar 2019 um 13:15 geschrieben:
>>
>>
>> +
>> +	sdio_pwrseq: sdio-pwrseq {
>> +		compatible = "mmc-pwrseq-simple";
>> +		clocks = <&rk808 RK808_CLKOUT1>;
>> +		clock-names = "ext_clock";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&wifi_enable>;
> As i wrote at the Arch board it would be nice to keep the Asus comment here:
>
> /*
>   * On the module itself this is one of these (depending
>   * on the actual card populated):
>   * - SDIO_RESET_L_WL_REG_ON
>   * - PDN (power down when low)
>   */
>
Sorry Stefan,

I'm with Robin on this one. Three reasons:

1) When you look at where ASUS added these comments:

https://github.com/TinkerBoard/debian_kernel/commit/6a3128ade33f758887048578ada61a4b7ab8e678

They has only added RK_PD4 = 28

So at best to only applies to that change.

2) If you look at datasheet:

http://files.pine64.org/doc/datasheet/pine64/RTL8723BS.pdf
http://cit.odessa.ua/media/pdf/Intel-Compute-Stick/FN-Link_F23BDSM25-W1.pdf

Then neither of the two pins are mentioned, and the comment is not helpful

3) Should dts have comments in? Over time I'm got to like git, and that 
you click on blame. That is what showed in post one that the comment 
only applied to one pin. To me blame point to the patch - and that 
usually gives more details. Its why I explain that we don't know what 
these two pins are attached to - this doesn't sound good, but actually 
its all we know. So it explains things. So I now think that dts should 
have very few comments in, and only where they *really* add something. 
In this case we don't know what the comment means ..


>> +		reset-gpios = <&gpio4 RK_PD3 GPIO_ACTIVE_LOW>, <&gpio4 RK_PD4 GPIO_ACTIVE_LOW>;
>> +	};
>>   };
>>   
>>   &cpu0 {
>> @@ -337,8 +345,8 @@
>>   
>>   &io_domains {
>>   	status = "okay";
>> -
> Please drop this whitespace change
Most {} in dts don't have white space line in - only between {} {}. So a 
white space line in the middle of a single {} is unusual. I can't see 
what its needed for, or what it makes clearer. So to me removing makes 
it more in line with everything else. If people are unhappy though I'll 
add the white line back in again.
>>   	sdcard-supply = <&vccio_sd>;
>> +	wifi-supply = <&vcc_18>;
>>   };
>>   
>>   &pinctrl {
>> @@ -417,6 +425,12 @@
>>   			rockchip,pins = <7 8 RK_FUNC_GPIO &pcfg_pull_none>;
>>   		};
>>   	};
>> +
>> +	sdio {
>> +		wifi_enable: wifi-enable {
>> +			rockchip,pins = <4 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>, <4 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
> Please make a line break after the first pin definition
Yes that makes sense

David


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
