Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58722C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:05:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28A992080A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N8DnX0Gl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gpAjquA4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A992080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ks+WWZOVtDWjiU0grtEx9DygozLKjwQGdWsRc6pLaas=; b=N8DnX0GlauLOSt
	sznOEmz1/DE9e7SsA/oTWHa4yr2Je0hWnileq0TPD9e1O4HlWXo6NPBYDX2HzFvAFSIopKoQHODqA
	scli06Tji0RhsRbyBzQTSsYash12Ls7EEMjB7gbdeGoQ/LqIK6Bfx2sYySWBh3X/docT4aLuLkqi1
	jQok++znlNhVahjuZBZmInJhVRk0smrPVSTI2QDK+ee0BxLVJRIdy/khxnwV6YdoVa4d7WpqKgeBM
	tHUodhPYY06qqV3oml4Ckh6nF6ycuBXCmQQvSNcUZL6OfU/BTXW6NTFXW77JTSjaZE4rGEh1BnYQ4
	+zMIpvqI1qoTLHj1sv3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs31n-0000vE-Iw; Fri, 08 Feb 2019 10:04:59 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs31j-0000uB-CE
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 10:04:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=r2JI6RZbxxMPkjfd2sfEVg3GnmwGJVzZjJju8YRKSZI=; b=gpAjquA4ulO3M8hhssEgXbGwV
 yDUozV+8rBHjfGkGOArbUM6ACeSAZlfWZPeIS3tz4IBUayL7BhBgb4+2AWAIPUiY+KFZ5jTnY5pr3
 NC6fjsBS+5xnmwlkD7h8zvXY6EJgyehzupSr9oZRRFwcH7KBwGBJZUItCv1RAA9zm9uPw=;
Received: from shell.armlinux.org.uk
 ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50978)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gs31V-0007mY-E8; Fri, 08 Feb 2019 10:04:41 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1gs31P-0006yX-Jf; Fri, 08 Feb 2019 10:04:35 +0000
Date: Fri, 8 Feb 2019 10:04:35 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH net-next v2 0/6] Add comphy support for Armada 38x
Message-ID: <20190208100435.bljszwiwc26wwpfj@shell.armlinux.org.uk>
References: <20190207161825.ueinmyf6ygjiqzzy@shell.armlinux.org.uk>
 <20190207.181049.1229639710283404215.davem@davemloft.net>
 <20190208085821.7556a18d@windsurf>
 <295924f0-1007-4b39-189b-1b21e4bf1b86@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <295924f0-1007-4b39-189b-1b21e4bf1b86@ti.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_020455_580649_6693F3B9 
X-CRM114-Status: GOOD (  18.14  )
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
Cc: mark.rutland@arm.com, andrew@lunn.ch, jason@lakedaemon.net,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 gregory.clement@bootlin.com, robh+dt@kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 David Miller <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org,
 sebastian.hesselbarth@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 08, 2019 at 02:52:26PM +0530, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On 08/02/19 1:28 PM, Thomas Petazzoni wrote:
> > Hello David,
> > 
> > On Thu, 07 Feb 2019 18:10:49 -0800 (PST)
> > David Miller <davem@davemloft.net> wrote:
> > 
> >> From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
> >> Date: Thu, 7 Feb 2019 16:18:25 +0000
> >>
> >>> This series adds support for the comphy for Armada 38x, which allows
> >>> these SoCs to use 2500BASE-X mode with appropriate SFP modules.
> >>>
> >>> Tested on SolidRun Clearfog after updating for the 5.0 merge window
> >>> changes.  
> >>
> >> Series applied, thanks Russell.
> > 
> > This series contained:
> > 
> >  - Device Tree bindings that had not been ACKed by the DT bindings
> >    maintainers, one of which should have been merged through the
> >    drivers/phy maintainer tree.
> > 
> >  - A brand new drivers/phy driver that had not been ACKed by the
> >    drivers/phy maintainer.
> 
> The PHY driver looks good to me. But I think it might still be better to take
> it via PHY tree since there are other Marvell drivers that are getting merged
> and will result in conflicts in Kconfig and Makefile.

... which would have the effect that if the DTS and mvneta changes
are merged ahead of the PHY changes into Linus' tree, mvneta breaks.
Breaking stuff in the merge window is something that needs to be
avoided - that's the exact time that bisects need to work.

Splitting a dependent patch series up for different subsystems to
avoid conflicts is not always a good idea.

Linus has said many times that he's okay dealing with simple
conflicts during the merge window (normally wanting the requester to
at least be aware of the conflict.)  Yet, some seem to have fostered
an idea that "conflicts are bad and must be avoided at all costs".
I've sent Linus several pull requests with conflicts during the age
of git, and the conflict resolution diff in the pull request email.
It's *never* been a problem, even if Linus has decided a slightly
different resolution is better.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
