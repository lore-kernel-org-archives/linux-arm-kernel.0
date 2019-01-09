Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE6DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:55:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB48C206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Reh8lBXo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Icz2BBu4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB48C206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=88DZZfR6pjGZM+DjyphI0XhMKOisXUXYfE5vDEUuvm4=; b=Reh8lBXoew90Ee
	rBSsCnzVkFl6nu4tSbqassEUX6lO0MclN74N01mCTgrsP3ndU/FTogt8Ax9hp23dm/aX9Yu9KUHEc
	rqEWfWe7Rkzk3B2X8GJwy+QMSvtE1jM9Z+pRNd+D4MWfhL89/WmU5/wRydiZHfr8X7x6CbaVCar2C
	zrsyCDQAztQ2+xleWQlVbBj5Ylhe4KC39JMnvq0CYcMhSCXX2lVCwP6tIdm/oNu1IB+0RvMHHVoTe
	AMFdWmOYoaOXiMC5YAmet1SJlFCmtgdwkHbwI547jHRBaKdpdpaZSkeoWi8vcn7Nud7MqUohWN1Jj
	NzOK8LMJ7QmC0pVNWQxQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghLod-0005F5-Kp; Wed, 09 Jan 2019 21:55:11 +0000
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghLoZ-0004Ze-Mu
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 21:55:09 +0000
Received: by mail-wr1-x42b.google.com with SMTP id z5so9179598wrt.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 13:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ahukTzBEbhXwCucJcDL2Qob/kcdvGrSZ4Z71NTWHxn0=;
 b=Icz2BBu4sIFrJRAq3SWh8ylZyEo7IIvE8KXFBZdV51nqpZdSXgaBF3FIqAZhJOy/UN
 qKdzb8EeywElLx4dYsfcyUYQbdnF35mhS9cQXcdx3+XE5CQHOeqRp1M79X9uMeM8Kz6Z
 LS2tHKIYDkkbIRIWS7e3ZT3OS2EwNFQykKJ9YU2lyK20CQbHXpYOBL0Vp+RbA9ucjFrJ
 du5BhWE0aEB7XOiXjMVjcWw9n4pl69dJ1tR3nUXDTKuZdpsZJWZ/Um1CaZIDBfMZH8wY
 FiNE8e2EyjtsFvAvDv6E8V5O5Ljyi9JGPGZlZoBJ5JG8105hi7vAgXKcdfJ4OePhtsQg
 DYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ahukTzBEbhXwCucJcDL2Qob/kcdvGrSZ4Z71NTWHxn0=;
 b=j7JXzhFvuiefqI1suM+0zVsEbbR6CXtF2g5WB0Y+FCtK+QQQ6DF5+hdOf4qn0rCKQa
 Vg7FZWsDWr3AhVnmRw6eRt4tfM9UaWUZKpHHSNw9A2ttQeF8+tNFRNWlk8QkC1RoTZVM
 crS7k1cJpcPrD+EMXfQZgzaNwohb2zzgp+JtNmYf+KJq1KGMm4tV8JI8y3NmkZXfS9rb
 pGO26Ie/d7D7/Rvqt43MrFKISuGp6vL7cPWnJ3JZ7CdgWiCngSjOVqBp6Q6h3etA5bAY
 d7gW/7TTviKvPobag2XZhylZofoMWNGUkbTa+PVT2j6fTV3pNXoQR33MEKnq+m6YV2xb
 Wv5A==
X-Gm-Message-State: AJcUukejik2xks8OOeg17fRoeAiiHa5xrlVqwq4ERK7kO4jUJ7lGsei2
 8/8lC90Z2moI2ErpFHzf/3o=
X-Google-Smtp-Source: ALg8bN46/Ob4KlkZl7u2Lrfs3NeO9iAAOYWSJ72TD6cwB564PP+Q/kLZzbd8uxmWqotYcbQ1hHzVxA==
X-Received: by 2002:adf:8506:: with SMTP id 6mr6895416wrh.128.1547070905623;
 Wed, 09 Jan 2019 13:55:05 -0800 (PST)
Received: from ?IPv6:2003:ea:8be2:e400:30af:bb11:dc41:cedc?
 (p200300EA8BE2E40030AFBB11DC41CEDC.dip0.t-ipconnect.de.
 [2003:ea:8be2:e400:30af:bb11:dc41:cedc])
 by smtp.googlemail.com with ESMTPSA id o15sm50679728wrp.12.2019.01.09.13.55.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Jan 2019 13:55:05 -0800 (PST)
Subject: Re: Regression in v4.20 with net phy soft reset changes
To: Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>
References: <20190109190650.GT5544@atomide.com>
 <a63ca542-db96-40ed-201d-59c609f565ce@gmail.com>
 <20190109213611.GU5544@atomide.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <dcbf0bcb-7014-f7ee-3f24-c801babff086@gmail.com>
Date: Wed, 9 Jan 2019 22:54:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190109213611.GU5544@atomide.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_135507_807988_7D626EBF 
X-CRM114-Status: GOOD (  18.96  )
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
Cc: linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>,
 Clemens Gruber <clemens.gruber@pqgruber.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, WingMan Kwok <w-kwok2@ti.com>,
 Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org,
 Tero Kristo <t-kristo@ti.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Murali Karicheri <m-karicheri2@ti.com>, Rex Chang <rchang@ti.com>,
 netdev@vger.kernel.org, linux-omap@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Chris Healy <cphealy@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 09.01.2019 22:36, Tony Lindgren wrote:
> Hi,
> 
> * Heiner Kallweit <hkallweit1@gmail.com> [190109 19:28]:
>> On 09.01.2019 20:06, Tony Lindgren wrote:
>>> Commit 6e2d85ec0559 ("net: phy: Stop with excessive soft reset") caused
>>> a regression where suspend resume cycle fails to bring up Ethernet on at
>>> least cpsw on am437x-sk-evm.
>>>
>> What kind of PHY and which PHY driver is used with this board?
>> I found one schematics of am437x where a KSZ9031RN PHY is used.
>> Is it the same on your board?
> 
> Yes that's the phy.
> 
>> As described in the commit message of this commit you would have
>> the option to implement the soft_reset callback in the PHY driver.
>> Can you try to add .soft_reset = genphy_soft_reset to the
>> KSZ9031 driver config in drivers/net/phy/micrel.c and check whether
>> it fixes the issue?
> 
> Yes that seems to work based on a quick test of five suspend
> resume cycles.
> 
> I wonder what all hardware this issue affects though?
> 
As one of few vendors Microchip publishes errata documentation
like this one for KSZ9031RNX:
http://ww1.microchip.com/downloads/en/DeviceDoc/80000692D.pdf
I wonder whether this is applicable for the PHY in our case and
whether the need for an extra soft reset is caused by one of
the mentioned issues.

> It's probably best that the network folks check what all
> hardare needs patching.
> 
> For TI hardware, Sekhar and TI network folks, can you guys
> please check the various TI SoCs for multiple suspend resume
> cycles with v5.0-rc1 and patch accordingly? See also below
> for something else to check, 10 seconds to resume a phy
> seems very long to me :)
> 
>>> Keerthy noticed this may not happen on the first resume, but usually
>>> happens after few suspend resume cycles. The most working suspend resume
>>> cycles I've seen with the commit above is three.
> ...
>>> Note that unrelated to the commit above, there may be other issues too
>>> as the cpsw phy LED seems to come on only after about five seconds with
>>> about total of 10 seconds before the Ethernet is up again.
> 
> Regards,
> 
> Tony
> 
Heiner

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
