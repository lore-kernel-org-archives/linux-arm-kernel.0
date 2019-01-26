Return-Path: <SRS0=wPy5=QC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A557CC282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 23:54:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67D4920882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 23:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Zo1HYIMX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="XuNdkhsM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67D4920882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2mVygZ0uGiVWHPPba9Qwyvr3/cLribysIJg4iLOn0hI=; b=Zo1HYIMXUBI28r
	+4HMzDTybbaBYFp8rX22dPMOAONMBuFxShJTEGinz2neI3W4vYk3+Xba6YBPWjG4d/EruhXjphbaE
	A8MpBAoFdMlvVy5xk7fnDs6CNfuEEROU6ABIfUzdh8wfCsNf5W6w8dS2u/7rgZKvZzo+j58nwRU+8
	nPgln1oqEEJy3iOJlF9mLgk6Y8NGJ7WlIJPM+V1QcYygb1hWkGahfAJy+Z2SW9BHKo7mj/9KtYS0W
	dQMxBKweSsLX52v07XbUjAYbDOVbgqV0AJCHkgyUQo/SBVIdwiVPARyEIW5t7uLmRRWQOovX0uRKP
	GKjn7bFomJrM9XK32DRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnXlg-0006R5-S0; Sat, 26 Jan 2019 23:53:44 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnXlc-0006Pp-Ab
 for linux-arm-kernel@lists.infradead.org; Sat, 26 Jan 2019 23:53:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=l4UYT+2i8w/RGyKLulYjrPEuTk1VQRqp4A2ONH8Bypc=; b=XuNdkhsMZTvitIjFT1EIu5EeV
 0aggK710iZoauV8oZpiMiRTgDg4dsHrBR6LH69WlYvfYjhRcdUmW5O0wHPY07wJCQXrJcgLtZ9W+U
 vP6ez8jcjiwrzpGiDCTWPLMjSWpn0oaQW2RTxEAiKEv3WUlXDpVGdbP6JcvK3/MSOUwC4=;
Received: from e5254000004ec.dyn.armlinux.org.uk
 ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55444 helo=shell.armlinux.org.uk)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gnXjQ-0004zw-FU; Sat, 26 Jan 2019 23:51:24 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1gnXjP-0002vn-S3; Sat, 26 Jan 2019 23:51:23 +0000
Date: Sat, 26 Jan 2019 23:51:23 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2] ARM: avoid Cortex-A9 livelock on tight dmb loops
Message-ID: <20190126235123.lo6nbuttvdh27qyv@e5254000004ec.dyn.armlinux.org.uk>
References: <E1gn8dp-0004Ai-AW@rmk-PC.armlinux.org.uk>
 <20190125232020.GX5720@atomide.com>
 <alpine.DEB.2.21.999.1901262053130.20293@utopia.booyaka.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.999.1901262053130.20293@utopia.booyaka.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190126_155340_511603_1C041C12 
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
Cc: Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@codeaurora.org>,
 linux-omap@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Jan 26, 2019 at 09:00:03PM +0000, Paul Walmsley wrote:
> On Fri, 25 Jan 2019, Tony Lindgren wrote:
> 
> > * Russell King <rmk+kernel@armlinux.org.uk> [190125 21:04]:
> > > Executing loops such as:
> > > 
> > > 	while (1)
> > > 		cpu_relax();
> > > 
> > > with interrupts disabled results in a livelock of the entire system,
> > > as other CPUs are prevented making progress.  This is most noticable
> > > as a failure of crashdump kexec, which stops just after issuing:
> > > 
> > > 	Loading crashdump kernel...
> > > 
> > > to the system console.  A workaround for this is to use 10 nops in
> > > cpu_relax().
> > > 
> > > We also use wfe() in while (1) loops to avoid burning cycles in a
> > > tight loop, giving the CPU a hint that we're not doing anything
> > > useful.
> > > 
> > > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > > ---
> > > It's been a while since this was posted, Will's suggestion was to use
> > > 10 nops in cpu_relax() last time around.  I still prefer wfe() in
> > > these infinite-not-doing-anything-ever loops.
> > 
> > Works for me:
> > 
> > Tested-by: Tony Lindgren <tony@atomide.com>
> 
> There was some concern in the past that WFE, like WFI, might cause the 
> core to assert an external signal that might cause the SoC integration to 
> place the core into a low-power mode from which it might not be able to 
> wake up.  This could happen on OMAP, for example, with WFI.
> 
> I don't recall the outcome of those discussions.  Was a conclusion ever 
> reached?

First, we use WFE in spinlocks.  If WFE were to place the CPU in a
low power state that it may not be able to wake up from, all our
spinlocks would be unsafe.

Next, in all of the situations in this patch, we're executing an
infinite loop.  If it were to cause the core to go into a low power
mode, surely that's a good thing, rather than the core endlessly
executing NOPs?  The only way out of that is for the core to receive
a reset _anyway_.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
