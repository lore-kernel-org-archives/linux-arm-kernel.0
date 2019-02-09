Return-Path: <SRS0=BTYN=QQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66D9C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 16:28:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4386217D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 16:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mifpow8G";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gN2e6eE9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4386217D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vjKLRhL4ou04Rm6bhbwhirGIY3dKkLgHdrFV47W97iI=; b=Mifpow8GujoVK2
	Djb89kXjvJiesY8LqXWIYuCfRhpxsa+mS1qgAmn4g/cmXGTHvHrmc8OimOx61KaBGjOttW4F2tKV+
	D/wT5vl2m9uvXJIeByPH3d0eycEEtcMI0VZleOHqm2oGfnnYBsn+Bblq3vG8NYhZNvy3HwELyTHb3
	Io9r4aY9RYLTgXZEcnqSDIooi9raS9qf7xXW/uX3FaYK7O73YULWLgZlAV9r3qIWSyHp1GV0wVRAr
	VK8bjcwzGlK1KxL/774ACzQe5epMZTIBhsX0gPYQys8vAbXkx6Mr84z4TX1nB0whr96/nL5viPiBK
	SxGm9+OHQK/13c2m7siQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsVUZ-0001PJ-7l; Sat, 09 Feb 2019 16:28:35 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsVUW-0001Ox-Al
 for linux-arm-kernel@lists.infradead.org; Sat, 09 Feb 2019 16:28:34 +0000
Received: by mail-wm1-x341.google.com with SMTP id a62so9036654wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 09 Feb 2019 08:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wzAULqxTUgG4qL90xHFg+19/6BAj8+tW1ulyeHM8CbQ=;
 b=gN2e6eE9EuwmeHix6zBrY9qO3dYkrUF5R4UZhaoOclIfo1P4tZDxgvY2toGrikFOD2
 kdg7g41Aum27Dm+Uu/+wts4op0/3hTrCJCLZHbQIHUo+UAV6Fjadb7OQAvDUeY6AB6ZS
 XEKT3Zl1i1daJoCpRtW90nbR7O7Dryw6jkEFR0u2eS2Eq8xi7VWrkWvg7ZYoy/f1qV8D
 1L8WHHJkpjhOkJ6fW6HVugLU+8zvzlVZajyE65D2VtemFiBXV1b1uKcDB96wjVqhzqYr
 lhRBK650iCvq3+ng0+UHJ8atVl+VCTLfW1NvkE8juuUevdgbazzoB2n1C9dnWA4cgR4F
 kfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wzAULqxTUgG4qL90xHFg+19/6BAj8+tW1ulyeHM8CbQ=;
 b=Ah5DnqSoifhE0oiKxq/3/+mLq7VlttEswNXZjfsrBPwCfOI+FoFpMpgiyWXHUF2mVS
 ID1Ut/Okb/HRCyoci64gfOd7dWTX7ObFYoZ1BuX4LaoYG8sSyHoNYIrapUd+W/j2Qz2y
 U/iv2iWaOI3qkN/wsGw0J1KL5T0OgTjBmezxzkaHN6tedWe9bs9gjjiJ2wxflAU4/lPY
 S1FsiepPWG1OiUDb+Skhufc+x41aN6w6ESN3WoRLLIE7rFEofZUCi70j1mXErs/u6zV8
 XLyu+DGJja3IHvUlNaHgvl5QiCIxOcvwGwjdx4iRXDAUa/EBq3OM0VyJ3J6U8Dt9pMUX
 yjGw==
X-Gm-Message-State: AHQUAuZN77mY8fw2teNp53FGlh0Ffwkv9Ig/vPHO3tbKSns7O3c2j4M4
 WwlsCUkJTzhNeHgANWV8Ims=
X-Google-Smtp-Source: AHgI3IbQZ8v1SXkwp2jDOztYVESy3DotGn90D23DS1i3iJfTwroUpLd55pP3NXC4pD73iYDllNSpSA==
X-Received: by 2002:a1c:384:: with SMTP id 126mr3341649wmd.26.1549729709742;
 Sat, 09 Feb 2019 08:28:29 -0800 (PST)
Received: from ?IPv6:2003:ea:8bf1:e200:aca4:3d:8205:4c97?
 (p200300EA8BF1E200ACA4003D82054C97.dip0.t-ipconnect.de.
 [2003:ea:8bf1:e200:aca4:3d:8205:4c97])
 by smtp.googlemail.com with ESMTPSA id c1sm2884656wrf.20.2019.02.09.08.28.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 09 Feb 2019 08:28:29 -0800 (PST)
Subject: Re: [PATCH net-next v2 00/10] net: phy: Add support for 2.5GBASET PHYs
To: Andrew Lunn <andrew@lunn.ch>
References: <20190207094939.27369-1-maxime.chevallier@bootlin.com>
 <81c340ea-54b0-1abf-94af-b8dc4ee83e3a@gmail.com>
 <20190209162545.GA30856@lunn.ch>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <6081929b-4d32-d0e9-9357-563df4b58290@gmail.com>
Date: Sat, 9 Feb 2019 17:28:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190209162545.GA30856@lunn.ch>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190209_082832_418716_43388051 
X-CRM114-Status: GOOD (  13.62  )
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
Cc: Florian Fainelli <f.fainelli@gmail.com>, mw@semihalf.com,
 Antoine Tenart <antoine.tenart@bootlin.com>, netdev@vger.kernel.org,
 gregory.clement@bootlin.com, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org, nadavh@marvell.com, thomas.petazzoni@bootlin.com,
 miquel.raynal@bootlin.com, stefanc@marvell.com,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 09.02.2019 17:25, Andrew Lunn wrote:
>> I'd propose that you extract generic patches being submission-ready
>> and split the patch series into two. I think the following patches
>> would be candidates for the first series: 2, 3, 5, 6
>> (provided they have no dependency on the other patches)
>> Based on that both of us can go on with our work.
>>
>> Andrew, what do you think?
> 
> Yes, that would help.
> 
> Heiner, can you also submit the .get_features patches soon. That is
> another important piece of the puzzle for both drivers.
> 
Just submitted it few hours ago.
https://patchwork.ozlabs.org/patch/1039237/

> 	Thanks
> 		Andrew
> 
Heiner

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
