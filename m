Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EC7C7112F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:30:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 626C92084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RrAu2Fh3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 626C92084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DMUs++VUbOPmDiAWH+I1HdGksuN5OFBHNmsJcSymN0I=; b=RrAu2Fh3dwSTqW
	GHZHQphadpxu5VJLkPexLyhSmDSna9638j44ONp4liB2P7RBh7iaXiZvo/TnLNSFoSTmjM+K6Sjgp
	pi8w29gKPMtNqKsoS2j8a7OPLbdtLVGoqPafpy9rmCTcWOnu675Ge/aRvFs7hxkZOHUsvGFPbiuO7
	x7m2Ba/lyuzdN44Qd3FR6x60GggyYBnwFi7RZ3mX/UhVhyAljPQwk6YNaJuh/+a4Na4EXFjpUXb8q
	xAPOVOT/PpXs/yY+dUaZHtkzzGnvJlnkb7+2H/lts/160FJ5IRVqj6d2rgnuLbZ/hPxovi/k3n6W/
	reQIITMG50Yx2LuPGtMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glYiH-0007fw-Hq; Mon, 21 Jan 2019 12:30:01 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glYiD-0007fY-Hy
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 12:29:59 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 485FF20898; Mon, 21 Jan 2019 13:29:55 +0100 (CET)
Received: from bootlin.com (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr
 [90.88.156.87])
 by mail.bootlin.com (Postfix) with ESMTPSA id D2F2B2077B;
 Mon, 21 Jan 2019 13:29:44 +0100 (CET)
Date: Mon, 21 Jan 2019 13:29:45 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next 5/7] net: phy: marvell10g: Force reading of
 2.5/5G PMA extended abilities
Message-ID: <20190121132945.6e6dee23@bootlin.com>
In-Reply-To: <20190121105206.mxxxosytk5qiysc2@e5254000004ec.dyn.armlinux.org.uk>
References: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
 <20190118152352.26417-6-maxime.chevallier@bootlin.com>
 <20190120190809.GB19714@lunn.ch>
 <20190121113531.7a8b5b51@bootlin.com>
 <20190121105206.mxxxosytk5qiysc2@e5254000004ec.dyn.armlinux.org.uk>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_042957_723669_CFDC53F8 
X-CRM114-Status: GOOD (  14.62  )
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

On Mon, 21 Jan 2019 10:52:06 +0000
Russell King - ARM Linux admin <linux@armlinux.org.uk> wrote:

>On Mon, Jan 21, 2019 at 11:35:31AM +0100, Maxime Chevallier wrote:
>> Hello Andrew,
>> 
>> On Sun, 20 Jan 2019 20:08:09 +0100
>> Andrew Lunn <andrew@lunn.ch> wrote:
>>   
>> >On Fri, Jan 18, 2019 at 04:23:50PM +0100, Maxime Chevallier wrote:  
>> >> As per 802.3bz, if bit 14 of (1.11) "PMA Extended Abilities" indicates
>> >> whether or not we should read register (1.21) "2.52/5G PMA Extended
>> >> Abilities", which contains information on the support of 2.5GBASET and
>> >> 5GBASET.
>> >> 
>> >> After testing on several variants of PHYS of this family, it appears
>> >> that bit 14 in (1.11) isn't always set when it should be.
>> >> 
>> >> PHYs 88X3310 (on MacchiatoBin) and 88E2010 do support 2.5G and 5GBASET,
>> >> but don't have 1.11.14 set. Their register 1.21 is filled with the
>> >> correct values, indicating 2.5G and 5G support.
>> >> 
>> >> PHYs 88X2110 do have their 1.11.14 bit set, as it should.    
>> >
>> >Hi Maxime
>> >
>> >Is there anything about this in any Errata?  
>> 
>> I haven't seen any Errata on that unfortunately.
>> 
>> I also thought about reading (1.4) "PMA/PMD Speed Ability", but the
>> 2.5G and 5G speeds are also reported as not being supported on the
>> 88X3310.  
>
>It's entirely possible that the 3310 switches to different hardware
>blocks for 2.5G and 5G speeds, and reading _just_ the 1.4 register
>is not sufficient.

I agree with you but in that particular case, I think we are reading
from the correct device. The datasheet itself says that we should be
reading 1.4 and 1.11 as we expect, with 2.5G/5G support being set (these
registers are read-only, and the datasheet's values aren't what we
actually read).

>The 88x3310 is multiple PHY devices in one package, with a CPU that
>manages the routing between each individual device.

I also just checked register 3.4 "PCS Speed Ability", and 3.8 "PCS
Status 2" which also contains informations on 2.5G/5G abilities, but
there's the same issue here.

Maxime

-- 
Maxime Chevallier, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
