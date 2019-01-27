Return-Path: <SRS0=mu0f=QD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAF5C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 15:29:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7A3B214D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 15:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dKvuVgH+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="K86ahw5U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7A3B214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=58S7F6nb5qOsg9IzhVbyE7xVT5Z/r43T24cN9/E5llk=; b=dKvuVgH+5L3kJj
	kaN2q6v7vaBof6wb8twdcjeN6QzKCgHj3iyPMhWKzLZbz0v2seKBqGApEYSrDGCWHENtY9jBeW6JO
	mGLTSqaPqPuN6tDO8UunqUju9ppyzXQ55RiZSS9DM1kunu5XFt446b5hko+KjQqge8SDM/NoTOaOn
	/8ne7jLAG9brnVBVVdU0+4CAh+Qk8bKs74S4TiKoO6tCoZNJmjzMg02szFxxlZ7KaDVSwKfhVMthA
	Ncmospqr4jx71KGd2bZZJEkGx4LWd9Ig4UQRkj+2uVjYWVe/3HE3b5MV7HalxQ9YebrLnQNzLy91E
	xceCPcP56HFs/AK6Usrg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnmN0-0004cM-Nc; Sun, 27 Jan 2019 15:29:14 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnmMs-0004bs-Ej
 for linux-arm-kernel@lists.infradead.org; Sun, 27 Jan 2019 15:29:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VP5q1FOo5Vio/PT9Yl3Zj9qlWGGWPA0gAHPND+54J0Y=; b=K86ahw5U11/8LZyiVE85zDB+N
 PC1X2hq+e2gxT0jvHfcY8shBleMInzH/GKeRdN1BHZjkMk5yXOB/vOqhh/LbDD5wKr0vTEg6tqKiF
 ygJkMkIGP2h5/hLoHOgkuwGEt4+AKmWRhp1SUnhyum5eJ++2O4ev5MTta8AFqlzV0mGlA=;
Received: from e5254000004ec.dyn.armlinux.org.uk
 ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:48000 helo=shell.armlinux.org.uk)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gnmMc-000176-Ua; Sun, 27 Jan 2019 15:28:51 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1gnmMc-0003Ta-8J; Sun, 27 Jan 2019 15:28:50 +0000
Date: Sun, 27 Jan 2019 15:28:50 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2] ARM: avoid Cortex-A9 livelock on tight dmb loops
Message-ID: <20190127152850.gs45h6rppdsuueye@e5254000004ec.dyn.armlinux.org.uk>
References: <E1gn8dp-0004Ai-AW@rmk-PC.armlinux.org.uk>
 <20190125232020.GX5720@atomide.com>
 <alpine.DEB.2.21.999.1901262053130.20293@utopia.booyaka.com>
 <20190126235123.lo6nbuttvdh27qyv@e5254000004ec.dyn.armlinux.org.uk>
 <alpine.DEB.2.21.999.1901270110050.17971@utopia.booyaka.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.999.1901270110050.17971@utopia.booyaka.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190127_072906_655567_912629B1 
X-CRM114-Status: GOOD (  23.51  )
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
Cc: Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@codeaurora.org>,
 linux-omap@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Jan 27, 2019 at 01:15:31AM +0000, Paul Walmsley wrote:
> On Sat, 26 Jan 2019, Russell King - ARM Linux admin wrote:
> 
> > On Sat, Jan 26, 2019 at 09:00:03PM +0000, Paul Walmsley wrote:
> > > On Fri, 25 Jan 2019, Tony Lindgren wrote:
> > > 
> > > > * Russell King <rmk+kernel@armlinux.org.uk> [190125 21:04]:
> > > > > Executing loops such as:
> > > > > 
> > > > > 	while (1)
> > > > > 		cpu_relax();
> > > > > 
> > > > > with interrupts disabled results in a livelock of the entire system,
> > > > > as other CPUs are prevented making progress.  This is most noticable
> > > > > as a failure of crashdump kexec, which stops just after issuing:
> > > > > 
> > > > > 	Loading crashdump kernel...
> > > > > 
> > > > > to the system console.  A workaround for this is to use 10 nops in
> > > > > cpu_relax().
> > > > > 
> > > > > We also use wfe() in while (1) loops to avoid burning cycles in a
> > > > > tight loop, giving the CPU a hint that we're not doing anything
> > > > > useful.
> > > > > 
> > > > > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > > > > ---
> > > > > It's been a while since this was posted, Will's suggestion was to use
> > > > > 10 nops in cpu_relax() last time around.  I still prefer wfe() in
> > > > > these infinite-not-doing-anything-ever loops.
> > > > 
> > > > Works for me:
> > > > 
> > > > Tested-by: Tony Lindgren <tony@atomide.com>
> > > 
> > > There was some concern in the past that WFE, like WFI, might cause the 
> > > core to assert an external signal that might cause the SoC integration to 
> > > place the core into a low-power mode from which it might not be able to 
> > > wake up.  This could happen on OMAP, for example, with WFI.
> > > 
> > > I don't recall the outcome of those discussions.  Was a conclusion ever 
> > > reached?
> > 
> > First, we use WFE in spinlocks.  If WFE were to place the CPU in a
> > low power state that it may not be able to wake up from, all our
> > spinlocks would be unsafe.
> 
> Good point.  WFE must not assert the external signal that indicates 
> that the core is inactive.
> 
> > Next, in all of the situations in this patch, we're executing an
> > infinite loop.  If it were to cause the core to go into a low power
> > mode, surely that's a good thing, rather than the core endlessly
> > executing NOPs?  The only way out of that is for the core to receive
> > a reset _anyway_.
> 
> Makes sense.  
> 
> Do you recall what Will's reasoning was for preferring 10 NOPs to a WFE?

I think there may be an erratum for this which specifies 10 NOPs as
its workaround, but I don't have its number.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
