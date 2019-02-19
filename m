Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A94DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:44:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16BB721848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kxtgKciM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16BB721848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=olimex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Zq3vi8O3WKBXbBVUiHCc9EFHJh82DJ7HMaldjlj+luE=; b=kxtgKciMXElgyva9T+W7/UceC
	nNlYia5Mr7qxz0Mr6bFhQcrmfSGNPvxT5qKCOuk1W38Fse+kZxc9LOuvNJ2X12Usm3dnHMOsS+W80
	E4bEzYgnXe9Np7rsx1cUz6niQtZ9BnlmSZZxGBMHgy35p1ZwMIJotPIX/PHPv8KMcBrwRY372LdHa
	UAM694mbzxtLOsAdr6oGcqPYF0O9IVpctU1V735uAh6zalg2pfgfYxfqd6Er8GsF4Eu8KcVeeA7e2
	Z2TghdbDHRRh8eJQb6osUe/caEMuCJqAXgNL1jI+CMEDk99L+L3XZlr1sWfDeF9ngDeXtyJMh2T+1
	lVADayx2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw04l-0004bS-58; Tue, 19 Feb 2019 07:44:23 +0000
Received: from olimex.com ([2001:470:0:1f2::b869:4820])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw04i-0004b8-Gr
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 07:44:21 +0000
Received: from 195.238.85.143 ([195.238.85.143]) by olimex.com with ESMTPSA
 (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD)
 (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
 for <linux-arm-kernel@lists.infradead.org>; Mon, 18 Feb 2019 23:44:15 -0800
Subject: Re: [PATCH v2 5/8] arm64: dts: allwinner: Enable AXP803 CHGLED for
 Olimex boards
To: Pavel Machek <pavel@ucw.cz>, Stefan Mavrodiev <stefan@olimex.com>
References: <20190215115013.11098-1-stefan@olimex.com>
 <20190215115013.11098-6-stefan@olimex.com> <20190215184916.GA17897@amd>
From: Stefan Mavrodiev <stefan@olimex.com>
Message-ID: <d01f4cd2-67ef-66dc-4cb9-cad117bae90b@olimex.com>
Date: Tue, 19 Feb 2019 09:43:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190215184916.GA17897@amd>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_234420_561051_1A3EEBD9 
X-CRM114-Status: GOOD (  13.17  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Maxime Ripard <maxime.ripard@bootlin.com>,
 "open list:X-POWERS MULTIFUNCTION PMIC DEVICE DRIVERS"
 <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>,
 Jacek Anaszewski <jacek.anaszewski@gmail.com>,
 Lee Jones <lee.jones@linaro.org>,
 "open list:LED SUBSYSTEM" <linux-leds@vger.kernel.org>,
 "moderated list:ARM/Allwinner sunXi SoC support"
 <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On 2/15/19 8:49 PM, Pavel Machek wrote:
> On Fri 2019-02-15 13:50:10, Stefan Mavrodiev wrote:
>> Teres-I and A64-OLinuXino commes with populated LED connected
>> to AXP803. So to be used as battery indication, pass the LED control
>> to the charger itself in mode 0 ( FULL while charging, OFF no battery
>> or completed).
>>
>> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
>> ---
>>   arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts | 6 ++++++
>>   arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts   | 6 ++++++
>>   2 files changed, 12 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
>> index f7a4bccaa5d4..7d6930319fba 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
>> @@ -177,6 +177,12 @@
>>   
>>   #include "axp803.dtsi"
>>   
>> +&axp_led {
>> +	label = "a64-olinuxino:yellow:chgled";
> There's little chance userspace will recognize this led.
>
> Can you make it "platform:yellow:charging" and fix it for other
> boards, too?

Sure.

Best regards,
Stefan Mavrodiev

>
> 									Pavel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
