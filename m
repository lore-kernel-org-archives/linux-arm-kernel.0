Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C19C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:18:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 143722084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B3/EWypv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="SNRhQZ1c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143722084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MIiygCR1gj1f9zuqumewoIftdWQYlbnWEYtaHwZqEwQ=; b=B3/EWypvxLoA6e
	5za7Fw+39IeXKMGrGymwn2bebQO4bHazRd/7SpUE6PRZ6wmGYUhE9I7KJL8D8BJyBGQAfz8Ghq2HB
	oLjzvXviHBgxpD71nFaaQqJX9Vll/NlKBNBmrFCitUsQE+iwOeXGv5Yglchs75cdjJL95foyVyhrf
	nNsMQYRkgJPW4HaFot2zFUMCTfzcS3ZIw5yxNOJ0BBCxjmDKOFgwJf/r0fpeEpLyoJWEVtR/YrQP4
	MLgTHi5frr8Q3YYnXQv7HDObjPRi35S06YYkzC2c9cr4gia2yDEx/GEA0Pa454+w8iFoqMQwBvHVb
	YrWa993OoA/6kICs77Fw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX2Wv-0004Qd-Bm; Wed, 12 Dec 2018 11:18:17 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX2Ws-0004KL-2i
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 11:18:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2C8G0IAo4Oc82zl8EazggK3EYhgh6Uk7Nj8uveOU2YY=; b=SNRhQZ1cW+QSMJibT4EfZOwK0
 t2D1wlPkxY2hiGx0DMQwEX7tgMlZSL7s+XvRtE5AH/6YfcQqKmphBDtgi/yNEVyWGkqjr64O8ndq1
 +J6WDSjLsjNFduDN4Ky7YY8PYdxCHJICGvjjsofOAcGC5v08nS55qPJeUG4EckBN3EDo8=;
Received: from n2100.armlinux.org.uk
 ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:54022)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gX2U4-0004JQ-8V; Wed, 12 Dec 2018 11:15:20 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gX2U0-0005Ht-Iy; Wed, 12 Dec 2018 11:15:17 +0000
Date: Wed, 12 Dec 2018 11:15:12 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/3] arm: Convert arm boot_lock to raw
Message-ID: <20181212111512.GG9507@n2100.armlinux.org.uk>
References: <20181207102749.15205-1-bigeasy@linutronix.de>
 <20181207102749.15205-2-bigeasy@linutronix.de>
 <20181207130012.GX6920@n2100.armlinux.org.uk>
 <CACRpkdbvyimBfCCBOEr84P+_y6+sBkqz0+nmFyYeOJ4cXjsA6A@mail.gmail.com>
 <20181209004138.GC9507@n2100.armlinux.org.uk>
 <20181210143718.plwd36vdxxd7q2el@linutronix.de>
 <CACRpkdby=Xreh0VPpHBPLhvupgQyEqDiae+e0u=-n3o2SWVMTw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACRpkdby=Xreh0VPpHBPLhvupgQyEqDiae+e0u=-n3o2SWVMTw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_031814_283411_160676D7 
X-CRM114-Status: GOOD (  13.76  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
 viresh kumar <viresh.kumar@linaro.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 David Brown <david.brown@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
 Viresh Kumar <vireshk@kernel.org>, Xu Wei <xuwei5@hisilicon.com>,
 ext Tony Lindgren <tony@atomide.com>, Chen-Yu Tsai <wens@csie.org>,
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

On Tue, Dec 11, 2018 at 07:19:32PM +0100, Linus Walleij wrote:
> On Mon, Dec 10, 2018 at 3:37 PM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> 
> > Okay. So the whole patch won't get applied, right? If so, may I please
> > get the
> >         arch/arm/plat-versatile/platsmp.c
> >
> > hunk applied?
> 
> Can you please send one patch per mach-* plat-*?

I think just patch arch/arm/plat-versatile/platsmp.c and ignore the
rest - as I say, the right solution is to eliminate the lock.

I have a patch to simply remove the lock from omap2+.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
