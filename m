Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDACC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 00:42:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9220E20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 00:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eQUmQxpx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="eX/5rDHB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9220E20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=H9UWK6duY9FrixjcW9kOvUGeWJL9ebUZNzXfTCbpYrM=; b=eQUmQxpxcXPW/v
	Fuyk8I3yteJHUJEM/J7oKO4TRfCmrvHOGduSoGT2Y92N1Ah1jTGDhJ0T4xXXlc+EFzmOUSZ+19CGa
	BxuHVSYNh1ZH53c2VYH93Vsk4C5a33d7bC74p42mvQiL+ZLFtXpEEPedjf7G+QDS0YtvvJZ7q+X92
	7uyYQEHDxhm5s3Z2qxD3SAOqbmDMelBUR3hoLvgJhqr/6whPi/a5ZrJnnCO+uedNr3slBST3fXQNe
	7aUlm28AGzeoJ6Wa1hng/edGbQysuJHSDBVvWrZbIfe/E6pn7KeVXj3L2al+0H2Oscp0OgN5bjotj
	NXurHIPYb2mIHOQHTukg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVnAt-0007Xi-S9; Sun, 09 Dec 2018 00:42:23 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVnAq-0007MF-AF
 for linux-arm-kernel@lists.infradead.org; Sun, 09 Dec 2018 00:42:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XXnHNq90NEPRHZ0DMdUL8uj5oGKQkGauK2SDuU0hszo=; b=eX/5rDHB8n6dC7p3/4KVblYCk
 b/yiQlkAD0vlj4r1LXkHNR3qfSRVSUODgn+Ez6OAOqm1Av/YSwqrGCiZI1QqHphfMJYRNy6prpzKo
 +kdqsUbvffLCoFYioZ3rM4sR52KvttGqyM/0K/oI9Xc8VdxYxRZZg3Yg5gvJXoWFCqpRw=;
Received: from n2100.armlinux.org.uk
 ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:57307)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gVnAG-0008Ut-UW; Sun, 09 Dec 2018 00:41:45 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gVnAD-0004az-B1; Sun, 09 Dec 2018 00:41:41 +0000
Date: Sun, 9 Dec 2018 00:41:39 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/3] arm: Convert arm boot_lock to raw
Message-ID: <20181209004138.GC9507@n2100.armlinux.org.uk>
References: <20181207102749.15205-1-bigeasy@linutronix.de>
 <20181207102749.15205-2-bigeasy@linutronix.de>
 <20181207130012.GX6920@n2100.armlinux.org.uk>
 <CACRpkdbvyimBfCCBOEr84P+_y6+sBkqz0+nmFyYeOJ4cXjsA6A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACRpkdbvyimBfCCBOEr84P+_y6+sBkqz0+nmFyYeOJ4cXjsA6A@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_164220_513609_87954A75 
X-CRM114-Status: GOOD (  21.16  )
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
Cc: ext Tony Lindgren <tony@atomide.com>,
 viresh kumar <viresh.kumar@linaro.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 David Brown <david.brown@linaro.org>, Xu Wei <xuwei5@hisilicon.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
 Viresh Kumar <vireshk@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Kukjin Kim <kgene@kernel.org>, Andy Gross <andy.gross@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Linux-OMAP <linux-omap@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Barry Song <baohua@kernel.org>, Frank Rowand <frank.rowand@am.sony.com>,
 Patrice CHOTARD <patrice.chotard@st.com>,
 shiraz hashim <shiraz.linux.kernel@gmail.com>,
 Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Dec 09, 2018 at 12:15:35AM +0100, Linus Walleij wrote:
> On Fri, Dec 7, 2018 at 2:00 PM Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> 
> > I think the bigger question is why are all these platforms using this.
> > For the ARM development platforms, it's fair as they have no way to
> > power down the CPUs or reset the other CPUs, and the "boot lock" was
> > there originally to prevent the delay calibration going awry.  (I've
> > been saying this for years but obviously people like to stuff their
> > fingers in their ears.)
> >
> > It annoys me when people cargo-cult copy code and don't bother trying
> > to understand it, which is shown clearly in your diffstat.
> 
> It's a very good point.
> 
> I did away with "my" culprit at one point in
> commit c00def71efd9
> "ARM: ux500: simplify secondary CPU boot"
> so people could look at that for an example to see how pointless
> this "pen holding" (what does it even mean, I never figured it
> out?) and boot_lock is.

It's a "holding pen" - in normal parlence, it's a place where livestock
are temporarily confined.

In this case, our livestock are CPUs, and they are temporarily confined
in a tight loop.  Early ARM development boards did not have a way to
wake individual secondary CPUs from the boot loader, so the only way to
boot them as Linux wanted was to direct the boot loader to release all
CPUs into a "holding pen" and then release them from the holding pen
one at a time when Linux wanted a secondary CPU to come online.

The early systems also did not have very good bandwidth between the
CPUs and memory, which meant that the CPU requesting another core to
be plugged in would perturb the secondary core's delay calibration to
a noticable amount, and trapping the requesting core in a spinlock
would prevent the delay calibration going awry.

So, really _both_ these things are really really specific to ARM
development platforms, and have nothing to do with modern production
hardware.

No one should _ever_ copy the ARM reference platform SMP hotplug
code.  Needing that code is quite simply a sign that the platform is
quite simply not production hardware.

I really don't get how we've ended up with so many copies of this.
Maybe the code isn't being properly reviewed?  Maybe the process for
merging new platforms is way too lenient?  Whatever, the fact that
we're ending up with new copies of the pen release and boot lock
stuff demonstrably illustrates that the review process for new
platforms is very broken.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
