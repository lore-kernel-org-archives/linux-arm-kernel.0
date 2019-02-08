Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F812C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:22:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBD4F20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Aqr0wIxN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBD4F20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dTOuM2cfZoRcDzITKwQGPMBcR0ebmaANmo7JOumUsdE=; b=Aqr0wIxN/TclkY
	6JNKFsdpPp38KACw5vjaiwzEKStWt/xtCTKo9wlLwLzrOL+TlX5QgaMmrJI6bzZKZaVNWcm+8f8Rc
	k722GTH2VE1C42/y0HUT/1CYVhdtQufUoFefaho+Tr0hUTVB+mLxbWI9Yfmov9nW7RT7k4lWQmLwc
	/jnFG6TZkuT6KDlY6oDfvTA/u5UeKsQGikI6W+FrFothgv4aJepedzi+u5MNAtoUlgTwFdJCrW1l/
	yTPxPXPoycwEpHINYax2DrqK74m2kL8Y76X8mvFxr/IQexGxx1aXHnInIpVCPMWwIdaNlY+jKA7qv
	+mo/M4/mdsqo6uuQBcfA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs7zE-0000Ha-Qe; Fri, 08 Feb 2019 15:22:40 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs7z2-00006S-Ss
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 15:22:30 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 6C3E980CC;
 Fri,  8 Feb 2019 15:22:36 +0000 (UTC)
Date: Fri, 8 Feb 2019 07:22:24 -0800
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Droid 4 modem support in kernel & ofono
Message-ID: <20190208152224.GG5720@atomide.com>
References: <20190201203616.GA2087@amd> <20190201205032.GF5720@atomide.com>
 <20190207221745.GA12219@amd>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190207221745.GA12219@amd>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_072229_024763_5DA6EE3D 
X-CRM114-Status: GOOD (  20.31  )
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
Cc: mpartap@gmx.net, merlijn@wizzup.org, sre@kernel.org,
 kernel list <linux-kernel@vger.kernel.org>, nekit1000@gmail.com,
 ofono@ofono.org, linux-omap@vger.kernel.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Pavel Machek <pavel@ucw.cz> [190207 22:18]:
> Hi!
> 
> > > Ok, so I got calls and smses somehow working in kernel&ofono ... which
> > > is really all I need.
> > 
> > Nice :)
> > 
> > I think the SIM card reading and writing should be doable
> > using dlci10 /dev/motmdm10 for AT+CRSM calls..
> 
> Might be. Sorry, this is outside of my area of interest, because LTE
> would not be on usable frequencies, anyway.

Oh I did not mean LTE, I meant for general SIM access for
ofono for pin codes etc. Anyways, if anybody needs the sim,
it should be available at /dev/motmdm10.

> > > I pushed the tree to git@github.com:pavelmachek/ofono.git , branch
> > > d4... But I had to do some "rather interesting" hacks. D4 modem
> > > expects packets and current kernel drivers rely on write() boundaries
> > > and flush(). .. which is a bit of problem for in ofonod, as it expects
> > > to work with bytestream with no explicit packet boundaries.
> > > 
> > > However D4 still uses normal AT commands, so... it would be good to be
> > > able to use AT parsing framework in ofono.
> > > 
> > > I believe easiest solution would be to automatically do the packet
> > > splitting in kernel, it should be as easy as splitting on \r and
> > > ^Z. (Currently packets are only generated when \r or ^Z is seen on
> > > write boundary, but that does not work well for ofono).
> > 
> > OK yeah it's worth trying. I hit that issue too with the
> > flush needed for droid4-sms-tools scripts. And the traffic
> > we're seeing is minimal and AFAIK there's no network port
> > for ts27010. And SMS messages are PDU encoded anyways.
> > 
> > Hmm should we do it for \r\n and \r? Otherwise the \n
> > will be left out of the packet :)
> 
> I guess splitting on \n makes sense, yes. 
> 
> Ofono normally uses just \r. Translating it to \r\n in kernel (ttys
> already do that) would be super nice, but I think this is easy enough
> to handle in ofono.

Do you have some simple test case with printf?

This test case works just fine already:

$ printf "AT+CFUN=1\rAT+SCRN=0\r" > /dev/motmdm1

But maybe the modem behaves in a different way for different
dlci.. So a minimal test case would be good to have :)

Regards,

Tony


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
