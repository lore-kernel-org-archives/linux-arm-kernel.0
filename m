Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5DAC10F01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:15:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E64A217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P+KXNYlL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=davidjohnsummers.uk header.i=@davidjohnsummers.uk header.b="ZpWHnoMc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E64A217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davidjohnsummers.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WFsJnlafuLicnJm8dkyZVRvYJ0Abp670fc5XIBJvbM8=; b=P+KXNYlLc2T7Sr9U8GcEx/tAq
	RFkpQg6mYenqjXpe+bpToBDK6tb90VFIMCYulXOB0Jk2uG+VHU7hWZ5g72VMGBKHSnD6YKJHlcKCQ
	l+LKb5kl0iEEalFmJir8A4L/XlxHtHxAq0z2iBd7y1SBeKEfnlU1SV9vhGh0HhxmyKK0gQFBEfS6E
	0a17h8orH1gXyeygNRvQLH33TmjpcvIPL6TBxcmmcvQteeD2wavtw67ogStJizzytbce38VKbCu1L
	RAdkFE71E0APJwKwyYm8I8WXJ+SARgkPjdwqMeaz/e75wXi0686PGXLL879oHK146hx+iPHUIkyAS
	I4H73hDSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvpKQ-00045Q-E3; Mon, 18 Feb 2019 20:15:50 +0000
Received: from mail-gw.thundercloud.uk ([149.255.60.87])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvpKM-00043f-3e
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 20:15:48 +0000
Received: from mailbsf01.thundercloud.uk (mail-gw.thundercloud.uk
 [149.255.60.72])
 by mail-gw.thundercloud.uk (Postfix) with ESMTPS id 67335608EDE7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 20:08:30 +0000 (GMT)
X-ASG-Debug-ID: 1550520506-0554131266235a40001-tbGyMd
Received: from cloud706.unlimitedwebhosting.co.uk (no-dns-yet.unlimited.uk.net
 [149.255.62.7]) by mailbsf01.thundercloud.uk with ESMTP id zz3mVHUvZSgnHL6H
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 18 Feb 2019 20:08:26 +0000 (GMT)
X-Barracuda-Envelope-From: beagleboard@davidjohnsummers.uk
X-Barracuda-Effective-Source-IP: no-dns-yet.unlimited.uk.net[149.255.62.7]
X-Barracuda-Apparent-Source-IP: 149.255.62.7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=davidjohnsummers.uk; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q8XSc6m/CUk1pUs6zlctThQxdtW12nIZVIaZkm4NT48=; b=ZpWHnoMcqe5BkO5Z0wsT7RBK+B
 A6jHMRlv2QnRBIu485/rgrRr3MVYkJWnHRm2J+WlwirWhKHgXm0lBI58GmJHRumwLWrogcya7NPYF
 TbyJmK1HyTxs2J5Hod0SCKsOqPK9unEcswv6ev2qUoHNg7PUH6btM5SUxyGOAOrJl7lqoPKedZl2U
 /sNLuf9tP9BTtq0wiWtweY0+5uusKXbhD3tdS27Mg5VsuliF59Yc/eHEApn/ze3QGJBdpKCs85niD
 FMMjCsoiAolKY6qktTdFVFC5NiyM3GkC4LnTfuUQqeVLjDxOfsVqzvaSLxku17+yBaHOKpvYjthSU
 eGJR115w==;
Received: from [87.114.170.31] (port=58324 helo=[192.168.2.187])
 by cloud706.unlimitedwebhosting.co.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.91)
 (envelope-from <beagleboard@davidjohnsummers.uk>)
 id 1gvpDF-000Nse-SA; Mon, 18 Feb 2019 20:08:25 +0000
Subject: Re: [PATCH 1/3] ARM: dts: rk3288 Tinker Board (S) sdcard changes
To: Stefan Wahren <stefan.wahren@i2se.com>, heiko@sntech.de,
 robh+dt@kernel.org, mark.rutland@arm.com
X-ASG-Orig-Subj: Re: [PATCH 1/3] ARM: dts: rk3288 Tinker Board (S) sdcard
 changes
References: <20190217121513.22965-1-beagleboard@davidjohnsummers.uk>
 <20190217121513.22965-2-beagleboard@davidjohnsummers.uk>
 <1660942499.343639.1550435365757@email.ionos.de>
From: David Summers <beagleboard@davidjohnsummers.uk>
Message-ID: <9ec51eb3-72d5-4bfe-0e66-31dda51bd6a0@davidjohnsummers.uk>
Date: Mon, 18 Feb 2019 20:08:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <1660942499.343639.1550435365757@email.ionos.de>
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
X-Barracuda-Start-Time: 1550520506
X-Barracuda-Encrypted: ECDHE-RSA-AES256-GCM-SHA384
X-Barracuda-URL: https://149.255.60.72:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at thundercloud.uk
X-Barracuda-Scan-Msg-Size: 2672
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=2.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.67542
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_121546_287604_3A02B1A3 
X-CRM114-Status: GOOD (  20.99  )
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

Thanks Stefan,

If the change to make sure that power is set to vccio_sd work, and so I 
have to do another patch, I'll make sure I update.

David.

On 17/02/2019 20:29, Stefan Wahren wrote:
> Hi David,
>
> we need a better patch subject here e.g.
>
> ARM: dts: rk3288-tinker: Fix SD card detection
>
> plus a Fixes tag for the commit we want to fix.
>
>> David Summers <beagleboard@davidjohnsummers.uk> hat am 17. Februar 2019 um 13:15 geschrieben:
>>
>>
>> This patch makes some minor changes to how the sd card is
>> described in the device tree for the ASUS Tinker Board (S). In
>> particular on the Tinker Board S, when booted from the eMMC, and with
>> no card in the sd slot, and the log has endless messages about not
>> being able to detect the card.
>>
>> Several methods to remove this error have been tried, the only one
>> that works is the broken-cd and so that is what is applied here.
>>
>> Alas the ASUS schematic is not clear enough to indicate if the card
>> detect is wired up to the cpu, the schematic does not show internal
>> wiring on the Tinker Board!
>>
>> Now this error didn't show up on the Tinker Board, as that machine
>> only boots where there is a sd card installed. However as the TB and
>> TBS are so similar it is expected that the Tinker Board also doesn't
>> have a functioning card detect. Hence the change here is made to the
>> dtsi file, so it applies to both TB and TBS.
>>
>> The disable-wp is also removed, it doesnt seem needed on the micro
>> sdcard slots, and without thisn the card can still be written
>> to. Hence this flag is also removed.
>>
>> Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
>> ---
>>   arch/arm/boot/dts/rk3288-tinker.dtsi | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/rk3288-tinker.dtsi b/arch/arm/boot/dts/rk3288-tinker.dtsi
>> index 2b38075a2917..fceaeed44e34 100644
>> --- a/arch/arm/boot/dts/rk3288-tinker.dtsi
>> +++ b/arch/arm/boot/dts/rk3288-tinker.dtsi
>> @@ -432,9 +432,7 @@
>>   	bus-width = <4>;
>>   	cap-mmc-highspeed;
>>   	cap-sd-highspeed;
>> -	card-detect-delay = <200>;
>> -	disable-wp;			/* wp not hooked up */
> I think we should keep as long as it doesn't hurt.
>
>> +	broken-cd;
>>   	pinctrl-names = "default";
>>   	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
>>   	status = "okay";
>> -- 
>> beagleboard@davidjohnsummers.uk
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
