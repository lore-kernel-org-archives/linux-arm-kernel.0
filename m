Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92BDC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:26:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C446217D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cmrhjX29";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SI2DmSzA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C446217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KMnhguD1EAxOqhqLbD+Gn463eKxZmwQGY+gIT/C0uNY=; b=cmrhjX29gdC/XBwSCLCGa+ZDG
	v3k3wUWvqsmQ41qkSVnNeZj2YtUP8OrDVzkotsPW2jrljRuYlsKR4rp2Y9PnJtWS2RqjAlZx3VZOa
	1TxPTeQREehMJwwX85qIstE184PyygYN4x52bbXFqoKdoFf/Z6ifMijkT31aVTZZmszb8GyomOvLX
	zpIxF2UGzyDOGm3Lm1uILlEWd3VoAZEAdeJGapTAhDWy1XFLzKrUjdHcw9SLxCCYPD5+WvZeyXWtv
	BqT1Pr8auKndsLneaLwLzfbOJahkFZPEMbVT+pzO009eUZiUtkLK1SaFEv37P0/i+7TMnCxYhWbV6
	AVvpw9N4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmMIF-000634-Gp; Wed, 23 Jan 2019 17:26:27 +0000
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmMIC-000623-3F
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 17:26:25 +0000
Received: by mail-yb1-xb41.google.com with SMTP id i6so1185006ybo.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 09:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=actR6wxtkGTljUML/n8Vta7kknOhszHmdvU8nQiBaks=;
 b=SI2DmSzACC1Xqywqto2pn1GdxVYGgESqDZiC4uGDHfPnGpI6pZOyBjokDlhde/oktc
 tyutOLVqgQiw8gBuiHQ81XeCDNR8F960LnBk3uVr+BdJA7u7dakjfLnH8EziB/uXg/jC
 m13ZorCwEAs5TXIb23LIcYzFuaUnvb0EufqRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=actR6wxtkGTljUML/n8Vta7kknOhszHmdvU8nQiBaks=;
 b=K4DMS9u159rh2LKZcaV9H3UDIlChbXehAsGMmpFy9+N9dsNYJdFaNImGlVzju75QFx
 Xl2DNP5OqANnNFxTlJtmkUcTWp8P/5RTh7BSddxESxjwUIMtDtlI2Gd3r84UZPHI1lwK
 axyk6QNKlow5HYPqEkxszOphEH6VmW1FNoweTq9vSwzncmJFf7URSXwHlb5wK9l37P0v
 0CLu10o/LyPziEYTFHEJXn+FlwMyWkrpoMJ0oSXQNDJ3aSAdi47cAlb+PbIMIz/smUfl
 1HBn1xqJJPt3QoIdX/q4vA7NVo9WQ9MeUdwdgh1TLwrxg1OIFMq+Xd5GJyuBeZMzCotn
 BkqA==
X-Gm-Message-State: AJcUukf1svSBL7YDGlEJimdTGiOcobDStPGq8ThfyOjQGOMrtAl7Ww01
 5xBFNvsRFtrvnM5BqgrkOlHt6pQ9gVxCmlaGPxmkjGJl3XUpkgNTdgYhGw0S1hpvChzrg3/pkyk
 qtb4EH5BDA4J8vpzMcGW0AIpZLtW9P02GKoyEYGXN3+8YZl5uciUZndTRJpEwuC5AgkIXosigX/
 /8IezgI0LI6ZExhy22Y9GtJg==
X-Google-Smtp-Source: ALg8bN6pS6Haxp8MocMO9zHvC3DX7jNSlloU5Gfk0LtdPi5F8Mo9OXmNPFZZiLATInY2l+Coz7P9kQ==
X-Received: by 2002:a25:5c5:: with SMTP id 188mr2906458ybf.290.1548264382704; 
 Wed, 23 Jan 2019 09:26:22 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id l16sm7599320ywa.25.2019.01.23.09.26.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 23 Jan 2019 09:26:21 -0800 (PST)
Subject: Re: [PATCH 1/2] ARM: defconfig: Enable BCM2835_POWER for bcm2835 and
 multi_v7
To: Stefan Wahren <stefan.wahren@i2se.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>
References: <1548252470-17920-1-git-send-email-stefan.wahren@i2se.com>
 <616d33b6-a8c8-3ead-c0f5-f87ca71b84b6@broadcom.com>
 <1037403886.766203.1548264146309@email.ionos.de>
From: Scott Branden <scott.branden@broadcom.com>
Message-ID: <e5688106-cdb2-6a5d-ffb0-4a70137e75b5@broadcom.com>
Date: Wed, 23 Jan 2019 09:26:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1037403886.766203.1548264146309@email.ionos.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_092624_142351_2D63A9EE 
X-CRM114-Status: GOOD (  17.62  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, bcm-kernel-feedback-list@broadcom.com,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Stefan,

On 2019-01-23 9:22 a.m., Stefan Wahren wrote:
> Hi Scott,
>
>> Scott Branden <scott.branden@broadcom.com> hat am 23. Januar 2019 um 17:41 geschrieben:
>>
>>
>> Hi Stefan,
>>
>> On 2019-01-23 6:07 a.m., Stefan Wahren wrote:
>>> Since commit 52a4adbaebcc ("ARM: bcm283x: Switch V3D over to using the
>>> PM driver instead of firmware.") VC4 on BCM2835 requires the power driver.
>>>
>>> Otherwise the driver won't probe and HDMI output stays black:
>>> vc4_v3d 20c00000.v3d: ignoring dependency for device, assuming no driver
>>>
>>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>>> ---
>>>    arch/arm/configs/bcm2835_defconfig  | 1 +
>>>    arch/arm/configs/multi_v7_defconfig | 1 +
>>>    2 files changed, 2 insertions(+)
>> Seems more fool proof to add a default ARCH_BCM3825 in the Kconfig
>>
>> instead of modifying multiple defconfig files.
>>
>> And that way users with custom defconfig files for 2835 will get the
>> config change automatically.
> i already thought about this, but it didn't worked for arm64. Maybe i missed something.

ARCH_BCM2835 exists in arch/arm64/Kconfig.platforms and is set in 
arch/arm64/configs/defconfig.

So I don't see why it wouldn't work?


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
