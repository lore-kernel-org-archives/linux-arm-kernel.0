Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD24C282DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:54:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D4272085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Zhy4QGyk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="np8gI06k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D4272085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xCBlPa2HQuYqqwxILvq+7wPTowJCLakSUiqLZBsEegA=; b=Zhy4QGykdIxZSs
	0pEct4OXAUl5hFkdU953lGSQHzs+LC59On/Hg4N0sbjyqpDdOMW4FQ1BHhx3UKapQx+P2tjhgXt6I
	VS9IPOTo9ffeB7uQCJACEicWr8r6l0v7CmWK1y6whTkqQupBlalDPkGIjaMhpOpvlbMGA/KReYOkY
	Wb/StVF1e/qYNI4FyLXfcqxfwxdMtCO+unuiMy17ZurdjdtHIBKChA7TLU/8KhoiEjLzveP20lr30
	u5cFaxbpqaned8oBw4+LFJY1gyB+2D7PrcnJivXJjSzfPlImPZc4KGLfTRnm3DL/JL7GDDf8XLwXT
	JowF8SARi3PZL8pRf/Ew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glXDu-0004Uj-3w; Mon, 21 Jan 2019 10:54:34 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glXDp-0004RZ-B9
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 10:54:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bHl6u5CSoO8WLLMUhKDWOpKdoQzA9HnxTdbysIoV06w=; b=np8gI06kfhZ5DUVAtPKhd4E23
 yO+WCGg+TBIw1Nq6GweH8VBun8qehtcT/RwpooyhqcW6r7x/bwehbrugS3ufkj419u2N+a7dzC9Qd
 0toGnyKlSdZXzzXoQoZT7DokWtd87KVl47RZ8t6lTLPtMWKYafAl6pPz/GrnvlwDjyO7A=;
Received: from e5254000004ec.dyn.armlinux.org.uk
 ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49384 helo=shell.armlinux.org.uk)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1glXBX-0002zt-6C; Mon, 21 Jan 2019 10:52:07 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1glXBW-0000oX-GB; Mon, 21 Jan 2019 10:52:06 +0000
Date: Mon, 21 Jan 2019 10:52:06 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 5/7] net: phy: marvell10g: Force reading of
 2.5/5G PMA extended abilities
Message-ID: <20190121105206.mxxxosytk5qiysc2@e5254000004ec.dyn.armlinux.org.uk>
References: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
 <20190118152352.26417-6-maxime.chevallier@bootlin.com>
 <20190120190809.GB19714@lunn.ch>
 <20190121113531.7a8b5b51@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190121113531.7a8b5b51@bootlin.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_025430_442356_C8D99FDB 
X-CRM114-Status: GOOD (  15.52  )
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

On Mon, Jan 21, 2019 at 11:35:31AM +0100, Maxime Chevallier wrote:
> Hello Andrew,
> 
> On Sun, 20 Jan 2019 20:08:09 +0100
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
> >On Fri, Jan 18, 2019 at 04:23:50PM +0100, Maxime Chevallier wrote:
> >> As per 802.3bz, if bit 14 of (1.11) "PMA Extended Abilities" indicates
> >> whether or not we should read register (1.21) "2.52/5G PMA Extended
> >> Abilities", which contains information on the support of 2.5GBASET and
> >> 5GBASET.
> >> 
> >> After testing on several variants of PHYS of this family, it appears
> >> that bit 14 in (1.11) isn't always set when it should be.
> >> 
> >> PHYs 88X3310 (on MacchiatoBin) and 88E2010 do support 2.5G and 5GBASET,
> >> but don't have 1.11.14 set. Their register 1.21 is filled with the
> >> correct values, indicating 2.5G and 5G support.
> >> 
> >> PHYs 88X2110 do have their 1.11.14 bit set, as it should.  
> >
> >Hi Maxime
> >
> >Is there anything about this in any Errata?
> 
> I haven't seen any Errata on that unfortunately.
> 
> I also thought about reading (1.4) "PMA/PMD Speed Ability", but the
> 2.5G and 5G speeds are also reported as not being supported on the
> 88X3310.

It's entirely possible that the 3310 switches to different hardware
blocks for 2.5G and 5G speeds, and reading _just_ the 1.4 register
is not sufficient.

The 88x3310 is multiple PHY devices in one package, with a CPU that
manages the routing between each individual device.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
