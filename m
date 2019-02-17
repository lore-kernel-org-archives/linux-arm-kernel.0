Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2068C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 19:25:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0323218A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 19:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D2/G1rTZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=davidjohnsummers.uk header.i=@davidjohnsummers.uk header.b="0JpGg0NH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0323218A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davidjohnsummers.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nNdR0F8C0LbL6Qgk/ugX7r717AEFgdfq/MT2t0mPj4U=; b=D2/G1rTZCI4hqqHpBjvuC6Cqk
	z65Fb4C4AoxdFu5mqlADPwI6ZszE3F6O92+lodZ4VpiRJer0P6w5eX9tWVJEtelqgQTuB3CUtTIda
	ihOMLmJjDGSwb8dvzi8sggpnowXoGkm9NGXBsCIAYDQtRRPeZ9vpRb0MyrCDOnavEoI0B6KedEdNE
	kvpzZe+i8tkCeSwPmlY051GNa6QQ4/9yMsYle4qlC+nLjb/fqdODIx0oCShg0192HsifA1a9cqE6C
	fzXuSc1Xc1GIkE8sO/oaMqK3619nqsmH9AT7mFMjYASSMPg/zW+PDMKHRJ9I1UoeE/V/9JUxC3NFA
	ZL8jDjtBw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvS4S-000443-II; Sun, 17 Feb 2019 19:25:48 +0000
Received: from mail-gw.thundercloud.uk ([149.255.60.84])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvS4O-00043K-Kr
 for linux-arm-kernel@lists.infradead.org; Sun, 17 Feb 2019 19:25:46 +0000
Received: from mailbsf01.thundercloud.uk (mail-gw.thundercloud.uk
 [149.255.60.72])
 by mail-gw.thundercloud.uk (Postfix) with ESMTPS id AF14962C3743
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 17 Feb 2019 19:16:29 +0000 (GMT)
X-ASG-Debug-ID: 1550430987-05541312681676b0001-tbGyMd
Received: from cloud706.unlimitedwebhosting.co.uk (no-dns-yet.unlimited.uk.net
 [149.255.62.7]) by mailbsf01.thundercloud.uk with ESMTP id 5CGxpK6aqPdWpl9f
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 17 Feb 2019 19:16:27 +0000 (GMT)
X-Barracuda-Envelope-From: beagleboard@davidjohnsummers.uk
X-Barracuda-Effective-Source-IP: no-dns-yet.unlimited.uk.net[149.255.62.7]
X-Barracuda-Apparent-Source-IP: 149.255.62.7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=davidjohnsummers.uk; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5F0K2F9nHMrOH+caLRxHnOSEkO4hzNWHrtp/m5a5ew0=; b=0JpGg0NHySkvRIBK5oErPkeqqz
 gm2rLHLdtWqI53DfgX0u8voXbGYKfPXbU2kMpNNWZhGIXK2FhqHlK9SJ651Dpzhie1+RmM/WEng89
 jmEqTfajZrb7J23tQeMC2n10+2JJijkPbZTRqk40aUdluKnxCivCYpT3iR7lefWzwwY+QkJ8r+m8b
 oDoZKMvbwsJksjAdHTRcpQbGfQC2b4OqumfBszSOhWgbHVT6D83lolV4uRUryVaB+7JjR+KebaxB9
 xs9mnQXnX/vA00dD7imHGkD/Jo1e6fooBuKPLn+ZnB72tTtx3LsFxFaEWBleF9xNvrveyBnTYjiJ2
 BMGLv56g==;
Received: from [87.114.170.31] (port=57740 helo=[192.168.2.187])
 by cloud706.unlimitedwebhosting.co.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.91)
 (envelope-from <beagleboard@davidjohnsummers.uk>)
 id 1gvRiW-000RkM-5J; Sun, 17 Feb 2019 19:03:08 +0000
Subject: Re: [PATCH 2/3] ARM: dts: rk3288 Tinker Board (S) add wi-fi
To: Tony McKahan <tonymckahan@gmail.com>
X-ASG-Orig-Subj: Re: [PATCH 2/3] ARM: dts: rk3288 Tinker Board (S) add wi-fi
References: <20190217121513.22965-1-beagleboard@davidjohnsummers.uk>
 <20190217121513.22965-3-beagleboard@davidjohnsummers.uk>
 <CAERgokmpHQb2czJdx++qFoogFRmkvXZm=4BNOsVuCz-ZvgTEaw@mail.gmail.com>
From: David Summers <beagleboard@davidjohnsummers.uk>
Message-ID: <af8bdf55-c815-247e-9fdd-0e610bac0d62@davidjohnsummers.uk>
Date: Sun, 17 Feb 2019 19:03:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAERgokmpHQb2czJdx++qFoogFRmkvXZm=4BNOsVuCz-ZvgTEaw@mail.gmail.com>
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
X-Barracuda-Start-Time: 1550430987
X-Barracuda-Encrypted: ECDHE-RSA-AES256-GCM-SHA384
X-Barracuda-URL: https://149.255.60.72:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at thundercloud.uk
X-Barracuda-Scan-Msg-Size: 3393
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=2.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.67492
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_112544_825780_BFDF8428 
X-CRM114-Status: GOOD (  15.99  )
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
Cc: mark.rutland@arm.com, Stefan Wahren <stefan.wahren@i2se.com>,
 =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Oh yes - didn't reply to the "chip_h", in asus patch called "chip_enable_h".

This is the <&gpio4 RK_PD3 GPIO_ACTIVE_LOW> IIRC. We could see that two 
pins were pulled. RK_PD3 and RK_PD4; but not knowing exactly why the 
pins were pulled, question is should they be separate?

We went the direction of putting both pins under wifi_enable.

Its not clear to me which is the least confusing, should wifi_enable 
need pulling two pins, or should there be an extra service 
"chip_enable_h" for the extra pin? Think our problem is we didn't see 
what "chip_enable_h" meant - the description doesn't help. Hence why we 
removed, and merged with wifi_enable ...

On 17/02/2019 14:32, Tony McKahan wrote:
> A similar configuration has been in use on Armbian images since kernel
> 4.14, but not in a clean enough format for submission. I will test
> this, but the only differences I see compared to ours are combination
> of the mystery "chip_h" power domain/reset with the Wifi one and the
> inclusion of sd_uhs_ddr50.
>
> -Tony
>
> On Sun, Feb 17, 2019 at 7:16 AM David Summers
> <beagleboard@davidjohnsummers.uk> wrote:
>> This patch adds the wifi to the ASUS Tinker Board (S) machines.
>>
>> Unfortunatly neither the Tinker Board nor the Tinker Board S schematic
>> indicate how the WiFi is wired up on these devices. The WiFi is
>> provided by the RTL8723BS device, that has sdio WiFi and UART
>> Bluetooth. This patch just adds the WiFi interface.
>>
>> With no schematic, most of the wiring has been derived from the ASUS
>> patch to Debian:
>>
>> https://github.com/TinkerBoard/debian_kernel/commit/6a3128ade33f758887048578ada61a4b7ab8e678
>>
>> In conjunction with the pin out of the RTL8723BS device:
>>
>> http://files.pine64.org/doc/datasheet/pine64/RTL8723BS.pdf
>> http://cit.odessa.ua/media/pdf/Intel-Compute-Stick/FN-Link_F23BDSM25-W1.pdf
>>
>> The only unusual part is that to bring the card up, both the pins
>> RK_PD3 and RK_PD4 need to be pulled. Why this needs to be done is not
>> clear, best explaination is that they are connected to the RTL8723BS
>> pins WL_DIS# and BT_DIS#, which the data sheet vaguely says:
>>
>> Shared with GPIO9 This Pin Can Externally Shutdown the RTL8723BS WLAN
>> function when BT_DISn is Pulled Low. When this pin deasserted, SDIO
>> interface will be disabled. This pin can also support the WLAN Ra
>> dio-off function with host interface remaining connected.
>>
>> Anyway extensive testing the TheSaint on ArchLinux Arm Forum
>>
>> https://archlinuxarm.org/forum/viewtopic.php?f=44&t=13064&start=120#p60548
>>
>> Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>>
>> +
>> +       sdio_pwrseq: sdio-pwrseq {
>> +               compatible = "mmc-pwrseq-simple";
>> +               clocks = <&rk808 RK808_CLKOUT1>;
>> +               clock-names = "ext_clock";
>> +               pinctrl-names = "default";
>> +               pinctrl-0 = <&wifi_enable>;
>> +               reset-gpios = <&gpio4 RK_PD3 GPIO_ACTIVE_LOW>, <&gpio4 RK_PD4 GPIO_ACTIVE_LOW>;
>> +       };
>>
>> +
>> +       sdio {
>> +               wifi_enable: wifi-enable {
>> +                       rockchip,pins = <4 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>, <4 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
>> +               };
>> +       };



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
