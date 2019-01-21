Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A178C2F3A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:00:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5081A20861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RuI8v7ej";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HMRWHWCm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5081A20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0N2pTBX1XSJab4CTUQOt/N0OXx30W5f+PzjrZyPTDmo=; b=RuI8v7ejAfUySA
	xfR7G5GEms4rca1xs3EmSbSfNV3P3v43SZSRBZLDvR7Gi1LqyuvPrz7bujdD6ZxMgu/raa+YsiHZk
	PMtOFtPgFLHMKx/oQe/eMXde8RRTB1JaLegnEDD82G6wl0KXj6ymgq3ijTUNhvUMQqgZEZ2Q7dGYF
	3FgR+hV13s6RQsMIGOSu6bd8LbcJiLHIqoqztuRNOMvKHCwmUuL/DGnWxt+oGsTTZtL9fnLIrJyV3
	T+Icm5bsXM5JA5kUDF1/Gyx7BLpIP6MhO9/5bZvLMnLk5WwOajpBj4obUz23lNnRFdiDyTRkH9thl
	HApV10OSWT+flaEQ/Mcw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glZC9-0005MB-Fs; Mon, 21 Jan 2019 13:00:53 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glZC5-0005LP-D6
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 13:00:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ipwiN3PRKrQcMWvCKKqu5ZB7SpMzYl2BERw9AiTLkNM=; b=HMRWHWCmcr3pAZazg0etePB01
 845wQkHMyCaJaDVOMDRVauwapIOfvOxXuimLmy+T5kFQh3IcKLgVKR2SoOjVGflf7uroioUzRHziM
 duVIxxnuEWlcl+cKwjZt49V5Qnq1hhleHoH5Lan1Az+nGZV0NCAewgn3PUmOsbzwwxcDg=;
Received: from e5254000004ec.dyn.armlinux.org.uk
 ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:59636 helo=shell.armlinux.org.uk)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1glZBn-0003qZ-Ly; Mon, 21 Jan 2019 13:00:31 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1glZBm-0000sX-Vn; Mon, 21 Jan 2019 13:00:31 +0000
Date: Mon, 21 Jan 2019 13:00:30 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 5/7] net: phy: marvell10g: Force reading of
 2.5/5G PMA extended abilities
Message-ID: <20190121130030.i5kkjb55gwttobvq@e5254000004ec.dyn.armlinux.org.uk>
References: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
 <20190118152352.26417-6-maxime.chevallier@bootlin.com>
 <20190120190809.GB19714@lunn.ch>
 <20190121113531.7a8b5b51@bootlin.com>
 <20190121105206.mxxxosytk5qiysc2@e5254000004ec.dyn.armlinux.org.uk>
 <20190121132945.6e6dee23@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190121132945.6e6dee23@bootlin.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_050050_172886_A1943620 
X-CRM114-Status: GOOD (  19.49  )
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

On Mon, Jan 21, 2019 at 01:29:45PM +0100, Maxime Chevallier wrote:
> Hello Russell,
> 
> On Mon, 21 Jan 2019 10:52:06 +0000
> Russell King - ARM Linux admin <linux@armlinux.org.uk> wrote:
> >It's entirely possible that the 3310 switches to different hardware
> >blocks for 2.5G and 5G speeds, and reading _just_ the 1.4 register
> >is not sufficient.
> 
> I agree with you but in that particular case, I think we are reading
> from the correct device. The datasheet itself says that we should be
> reading 1.4 and 1.11 as we expect, with 2.5G/5G support being set (these
> registers are read-only, and the datasheet's values aren't what we
> actually read).

No, you missed what I was saying.

The 88x3310 is a hybrid device.  It contains multiple instances of
each individual device at different offsets in each MMD address space.

For example, there isn't just one PCS in MMD 3, there are three:

offset 0x0000: 10GBASE-T PCS
offset 0x1000: 10GBASE-R, 10GBASE-X, 40GBASE-R PCS
offset 0x2000: 1000baseX-FD PCS

Which get used depends on what is active.  For example, on the
Macchiatobin, the PCS at 0x1000 gets used for the SFP port, and
the PCS at 0x0000 gets used for the copper port.  The PCS at
0x2000 doesn't ever seem to become active.

MMD 4 (PHYXS) is very similar, and MMD 7 (AN) has four instances.
Different AN instances get used for 10GBASE-T, 10GBASE-KR, SGMII etc.

Each of these blocks either comes from Marvell or another manufacturer.
The 3310 is a mismash of IPs bolted together, with a bunch of routing
between them.  It is not simply a Clause 45 compliant PHY (it isn't
compliant, because C45 requires certain registers to be reserved,
but the 3310 has incomplete address decoding - visible as repeats in
the address space of each MMD.)

The exception seems to be the PMA/PMD MMD which I've only discovered
a single instance.

> >The 88x3310 is multiple PHY devices in one package, with a CPU that
> >manages the routing between each individual device.
> 
> I also just checked register 3.4 "PCS Speed Ability", and 3.8 "PCS
> Status 2" which also contains informations on 2.5G/5G abilities, but
> there's the same issue here.

What I'm saying is, there is much more to this PHY than just the 802.3
register layout because of there being multiple instances.  It _may_
be that a different set of instances gets used to the ones at offset 0
for any particular set of speeds.

I can't look at this at the moment because I am unable to get access to
the 802.3bz specifications - I try to get them through the IEEE get
program website, and I can get to the 802.3 Ethernet specs, click on
either of the 802.3bz amendment 7 links, and I just get a couple of
spinning blobs in Firefox - the page never finishes loading.  So, I
can't get the register information for NBASE-T and compare it to the
various MMD instances in the 88x3310.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
