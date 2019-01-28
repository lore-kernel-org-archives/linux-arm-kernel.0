Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFE7C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:27:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 161892173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YcYyiLRG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 161892173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=exReOxJ2q0DKaMfAprbVvho3gPntdKdM/7wp2fbO4Sg=; b=YcYyiLRGlUVak2
	7od8a7uWAYKpwLWtHKM2InQrAWjyfZmxjlq5nH+BafWVp88ych3in5tJyOBXgfSo1WK/pvl7DCJoq
	VPRrDFWn1e0KnLy9aM2ftljyZRRNlI49UskMkZvWsbAkmcH/cXwS+Sx5TZgyXFoI+zrWayS3Xfe6T
	zRLM47kNV205kqh7WnzS8ZIfor3tMKnuSL3AdBBIuqkC5sAdpMO/5n+wWtObUh3s149ys2WdqXhhs
	sTJ6aH86PAuHk8RtogP2exnGByVOKIVAlMFLgKxXyJ2UqAMiL8PaCmiJicwxvwM+jXGhpA+YeOW1D
	wgSSlGuYpGAO6XrIvHQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go7sb-0000jy-OJ; Mon, 28 Jan 2019 14:27:17 +0000
Received: from relay5-d.mail.gandi.net ([217.70.183.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go7s1-0000Ch-0y
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 14:26:46 +0000
X-Originating-IP: 77.201.116.149
Received: from bootlin.com (149.116.201.77.rev.sfr.net [77.201.116.149])
 (Authenticated sender: maxime.chevallier@bootlin.com)
 by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id DFD811C0023;
 Mon, 28 Jan 2019 14:26:23 +0000 (UTC)
Date: Mon, 28 Jan 2019 15:26:21 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next 5/7] net: phy: marvell10g: Force reading of
 2.5/5G PMA extended abilities
Message-ID: <20190128152621.2aec96c1@bootlin.com>
In-Reply-To: <20190121130030.i5kkjb55gwttobvq@e5254000004ec.dyn.armlinux.org.uk>
References: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
 <20190118152352.26417-6-maxime.chevallier@bootlin.com>
 <20190120190809.GB19714@lunn.ch>
 <20190121113531.7a8b5b51@bootlin.com>
 <20190121105206.mxxxosytk5qiysc2@e5254000004ec.dyn.armlinux.org.uk>
 <20190121132945.6e6dee23@bootlin.com>
 <20190121130030.i5kkjb55gwttobvq@e5254000004ec.dyn.armlinux.org.uk>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_062641_484927_0EAC6882 
X-CRM114-Status: GOOD (  13.65  )
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

On Mon, 21 Jan 2019 13:00:30 +0000
Russell King - ARM Linux admin <linux@armlinux.org.uk> wrote:

>On Mon, Jan 21, 2019 at 01:29:45PM +0100, Maxime Chevallier wrote:
>> Hello Russell,
>> 
>> On Mon, 21 Jan 2019 10:52:06 +0000
>> Russell King - ARM Linux admin <linux@armlinux.org.uk> wrote:  
>> >It's entirely possible that the 3310 switches to different hardware
>> >blocks for 2.5G and 5G speeds, and reading _just_ the 1.4 register
>> >is not sufficient.  
>> 
>> I agree with you but in that particular case, I think we are reading
>> from the correct device. The datasheet itself says that we should be
>> reading 1.4 and 1.11 as we expect, with 2.5G/5G support being set (these
>> registers are read-only, and the datasheet's values aren't what we
>> actually read).  
>
>No, you missed what I was saying.
>
>The 88x3310 is a hybrid device.  It contains multiple instances of
>each individual device at different offsets in each MMD address space.

Ah I see, I indeed thought you refered to the MMDs. 

[...]

>The exception seems to be the PMA/PMD MMD which I've only discovered
>a single instance.

Yes there only seems to be one. There are some other registers in the
1.0xCxxx range, but those who are documented don't help a lot with
determing wether or not these modes are supported.

I wonder if these values are correctly reported in newer PHY firmware
revisions.

I've checked other PCS instances, but it seems the one at 3.0x0xxx is
the one used in 2.5/5GBASET.

I've tested with other PHYs from this family, it looks like they are
derivatives of the 33x0 design, with the addition/removal of internal
IPs. Since the 2110 returns the correct values and has a similar
design, with the PMA returning the correct abilities, I think we are
reading from the correct instance.

Thanks,

Maxime

-- 
Maxime Chevallier, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
