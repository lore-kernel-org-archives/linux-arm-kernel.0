Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19DBC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:54:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C26562147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jjOsJn0O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C26562147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KsY7cExmt5EYCzLqooBCujMpPbyS6cpA8slxXpnknDQ=; b=jjOsJn0Ox+GSv5
	4gp4yasfzzwqNjWINT96DV28X31toCjCKAQZPLxRwFwxMVFPrESL8lDn6OahEXCfL8Kpr0Se9ucEZ
	eUa/nC+tLQixRlsnNrP98EmG7T57YFK93gFv7VfHCf68c/iL1tmrTu9Jh34QS4fTzGCVsP0miZkkC
	GVrok6MIBCTFCKKPYEp1orYzYpTIyOV6ZuDS3T0hCjGpQ/UU9Q38e9BYw+qOz0MFpiO52vFwGINS6
	Agyjhs+Nz2U5MQ59aTlye8bLJyo2XKJaC1FoaQ2x+Tf2ONCLJDeuE3jR5l/tS48D44fIk6vJJ3iBe
	Q/CXdB0PIyrUzGb4wJoA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwPWT-0004P8-TU; Wed, 20 Feb 2019 10:54:41 +0000
Received: from relay2-d.mail.gandi.net ([217.70.183.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwPWP-0004OP-MA
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 10:54:39 +0000
X-Originating-IP: 90.88.23.190
Received: from bootlin.com (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr
 [90.88.23.190]) (Authenticated sender: maxime.chevallier@bootlin.com)
 by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 2F59B4001E;
 Wed, 20 Feb 2019 10:54:22 +0000 (UTC)
Date: Wed, 20 Feb 2019 11:54:21 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v2 07/10] net: phy: marvell10g: Add support for
 2.5GBASET
Message-ID: <20190220115421.588aa5d9@bootlin.com>
In-Reply-To: <20190207234824.dhynfaglfxllxhei@shell.armlinux.org.uk>
References: <20190207094939.27369-1-maxime.chevallier@bootlin.com>
 <20190207094939.27369-8-maxime.chevallier@bootlin.com>
 <20190207234824.dhynfaglfxllxhei@shell.armlinux.org.uk>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_025437_873640_48573087 
X-CRM114-Status: GOOD (  11.96  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Antoine Tenart <antoine.tenart@bootlin.com>, netdev@vger.kernel.org,
 gregory.clement@bootlin.com, linux-kernel@vger.kernel.org, nadavh@marvell.com,
 thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com, stefanc@marvell.com,
 mw@semihalf.com, davem@davemloft.net, linux-arm-kernel@lists.infradead.org,
 Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Russell,

On Thu, 7 Feb 2019 23:48:24 +0000
Russell King - ARM Linux admin <linux@armlinux.org.uk> wrote:

>On Thu, Feb 07, 2019 at 10:49:36AM +0100, Maxime Chevallier wrote:
>> The Marvell Alaska family of PHYs supports 2.5GBaseT and 5GBaseT modes,
>> as defined in the 802.3bz specification.
>> 
>> When the link partner requests a 2.5GBASET link, the PHY will
>> reconfigure it's MII interface to 2500BASEX.
>> 
>> At 5G, the PHY will reconfigure it's interface to 5GBASE-R, but this
>> mode isn't supported by any MAC for now.
>> 
>> This was tested with :
>>  - The 88X3310, which is on the MacchiatoBin  
>
>Hi Maxime,
>
>Looking deeper at this, I think we actually need an additional patch at
>the beginning of your series.
>
>The default AN advertisement in 7.32 is 0x1181 - which includes the
>2.5G and 5G modes.  We need to clear these bits, so that when the 10G
>mode disabled via ethtool, we do not switch to 2.5G or 5G speed (both
>of which are not currently reported as supported.)  Such a patch needs
>backporting to stable kernels.

Good catch. The issue seems fixed by Andrew's patch :
3de97f3c6308 ("net: phy: marvell10g: use genphy_c45_an_config_aneg")

However, the fix should indeed be backported to the -stable trees, I've
been able to repdocude this on 4.20. I'll take care of sending a patch
to -net for that.

Thanks for reporting this,

Maxime


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
