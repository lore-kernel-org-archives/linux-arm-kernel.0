Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA12DC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:04:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E99420989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P9Dy5cL/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QJB+KKWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E99420989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=065/D0GDbIiP3haF+Km7r2E1yq0iN9cLztgEzrRpbDY=; b=P9Dy5cL/qbeoFy
	lAeShm1ER+Rew3RLbGZcI2RoYZkH+GXfi0aJ2ynJQ1fkuHD951LPrfXvkpFPLTrAcW0sL3fnjMMbS
	rWYE5AB6k4Zeu3lg4U83a8yELRli36FvAZaf+VThyClTNDQdgnYPGVkXZCnqiJ6fNKSu2K4TrQ26e
	yJFIQUATEpNj6ZzpeQPY7dS4qbM2Ssc/GFLPjIjm2ZgrIu9l5j3gVHIcORzkLxPFE5Ap4023EIksK
	uR2OgIMZHHnCHm8oy8AZXiwJoRW/HIOLF1dDyYhpfTNJ4KLuGrVXKiLyrLvM4iZcwoiXYZl2RYNxA
	6G4OoGFGYOTeUQnrYMdg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goCCq-0003fG-J8; Mon, 28 Jan 2019 19:04:28 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goCCm-0003et-MZ
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 19:04:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ru7gGyvVw36QdPrzf6sAwQjdDMjUX4uqyiGJlmuyf1I=; b=QJB+KKWwFHtAI2FAiI+/JyVFl
 rdsM3VlKY+kWUsp4N+E7OVXSG70bs6ud6Vpe9A/D3oyklrUSBNRr5mKxBf5jcChg5gSjPwCiMH44l
 uAX77T1BU2EKAbX/I+5yvupdlyFbGz7+0XShazsEYA4MJaGmHWc1tiQsGvGGyAvksEx9w=;
Received: from shell.armlinux.org.uk
 ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:51070)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1goCCT-0001tA-JY; Mon, 28 Jan 2019 19:04:05 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1goCCP-0004gM-Rn; Mon, 28 Jan 2019 19:04:01 +0000
Date: Mon, 28 Jan 2019 19:04:01 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 0/3] at803x: Add quirk to disable SmartEEE
Message-ID: <20190128190401.zzus6m6fjxpyf36d@e5254000004ec.dyn.armlinux.org.uk>
References: <20190125125513.23656-1-ccaione@baylibre.com>
 <20190125130612.npknjuzjmny4yohg@e5254000004ec.dyn.armlinux.org.uk>
 <20190125184330.dm3kaoewvbwddacy@xps>
 <a8b8e82f-2b68-ed9d-6106-0542dddc1181@gmail.com>
 <20190125191947.um4w4e5jpsv2kcxc@e5254000004ec.dyn.armlinux.org.uk>
 <3e09ef54-f817-2659-4e9e-74a88a80cbcc@gmail.com>
 <20190128104620.3e724lfm5xv5il4x@xps>
 <20190128155739.yyftnu7a5hz6if7d@e5254000004ec.dyn.armlinux.org.uk>
 <9118a1cc-7ad7-cdfc-4925-d609efbc8265@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9118a1cc-7ad7-cdfc-4925-d609efbc8265@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_110424_876191_CF2CADAC 
X-CRM114-Status: GOOD (  29.84  )
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
Cc: mark.rutland@arm.com, andrew@lunn.ch, f.fainelli@gmail.com,
 devicetree@vger.kernel.org, s.hauer@pengutronix.de,
 Carlo Caione <ccaione@baylibre.com>, robh+dt@kernel.org, abailon@baylibre.com,
 kernel@pengutronix.de, fabio.estevam@nxp.com, shawnguo@kernel.org,
 aisheng.dong@nxp.com, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 28, 2019 at 07:23:49PM +0100, Heiner Kallweit wrote:
> On 28.01.2019 16:57, Russell King - ARM Linux admin wrote:
> > On Mon, Jan 28, 2019 at 10:46:20AM +0000, Carlo Caione wrote:
> >> On 25/01/19 20:27, Heiner Kallweit wrote:
> >>> OK, then the description of the referenced patch isn't fully correct
> >>> and SmartEEE and EEE are partially compatible, and the problem is
> >>> just that we don't know exactly to which extent.
> >>
> >> Reading from the datasheet at [0] it seems that SmartEEE is compatible with
> >> EEE but it's something different.
> > 
> > As I understand it, SmartEEE is just like normal EEE as far as the link
> > partner is concerned.  The difference is between the PHY and MAC.  What
> > follows is a simplified understanding of the differences.
> > 
> > In conventional EEE, the MAC takes part in EEE - the local MAC requests
> > that its attached PHY enters LPI mode, which signals to the link partner
> > PHY that the data stream on the link is going to pause.  When the local
> > MAC wants to transmit, it first has to signal to the attached PHY that
> > the link should be woken up, and the MAC has to wait for the link to
> > exit LPI before transmitting.
> > 
> > With SmartEEE, the decision to enter LPI mode is taken not by the local
> > MAC but by the PHY instead, since SmartEEE is designed to produce power
> > savings for MACs that do not support LPI.  Of course, they won't achieve
> > the same power saving as real EEE, but they do help to reduce the power
> > dissipation in the PHY.
> > 
> > PHYs that support this buffer some data from the MAC, and that buffering
> > has to be sufficient for the delay in the link coming out of LPI mode
> > without losing data.
> > 
> > As far as the link partner is concerned, EEE and SmartEEE appear the
> > same.
> > 
> >> With SmartEEE the PHY can actually enter LPI state even if this is not
> >> supported by the link partner since the LPI pattern is generated inside the
> >> PHY itself, so auto-implementing a sort of EEE.
> > 
> > It sounds to me like you have this the wrong way round.  SmartEEE isn't
> > about the link partner not supporting LPI, it's about the local MAC not
> > supporting EEE, but still getting some power savings.
> > 
> > EEE (of either kind) can only be entered on the link when both the
> > local PHY and remote PHY indicate support for EEE, and have negotiated
> > that they support EEE.
> > 
> > Most of the power dissipation is from driving the signals into the
> > network cable (which is a lossy environment) to ensure that the far
> > end has sufficient signal to keep the link established.  SmartEEE is
> > about giving a way to enter 802.3az EEE mode on the _cable_ with a
> > MAC that does not support EEE.
> > 
> > I've monitored the signals on a link with an Atheros AR8035 with
> > SmartEEE mode enabled, and a Marvell 88e1514 PHY in a Marvell switch
> > on the other end, and seen the signals on the cable quiesce as a
> > result of SmartEEE, but only when _both_ partners are set to allow
> > EEE in the negotiated link mode.
> > 
> 
> If SmartEEE is compatible with EEE on a PHY level, then I'd expect that
> advertisement of SmartEEE at different speeds can be controlled via the
> standard EEE MMD regs. Is this the case?

There is no "advertisement of SmartEEE" - it's just EEE.  That is
because as far as the link partner is concerned, SmartEEE is just
EEE.

Carlio posted a link to one of the datasheets for the family.  In
there, it describes the EEE capability register, which describes
what is supported, and the EEE wake error counter register.

It also describes the EEE advertisement and link parter advertisement
registers.

All these registers correspond to the 802.3 section 45 defined MMD
and address offsets found in Clause 45 compliant PHYs, and these
registers control not only EEE but also SmartEEE.

Please stop thinking that SmartEEE is different on the link partner
side from EEE - as far as the link partner is concerned, there is
no difference.  The difference is all to do with the MAC side of
the local PHY.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
