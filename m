Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9A6C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:10:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C81620882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ojs/fn5t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C81620882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Uregpbc3WGrAwdF6nrUlZXAmNMcULNQSlvrI39bxxPE=; b=ojs/fn5tj7lx+S
	SWUZeJNwupmZYUsz4AYDXwtdIlfrx+G8dBnbCLAkIH0qE9KlRnAEeLjEXPNnGLXLhvRYdsl+mnQFQ
	J0+2rATt317S0/h8CRTxOZGSAa3F0CVQfRNpiw0fR7wtBdasR3iEVqnDbInrB1B5RCq0hHZMA0McL
	WjDKXvfIfFLsJ4wQcrPWZRDlYXw+UpLnnRr8o/kf35xPvn4Wl4qqlM65koH02F1D1OPbCqeCjp+Yf
	5SDyRF4/oPsDAt17YOIPnjRqcpe49PbVJG3CsT+CJ0Vdeb37EiWR891rQawcIyQDOrh6BXb4pzynt
	j9oTLXBf/M9d6LYo7rzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVIiO-0007S3-AO; Fri, 07 Dec 2018 16:10:56 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVIiK-0007RL-6m; Fri, 07 Dec 2018 16:10:53 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id CCA9180C0;
 Fri,  7 Dec 2018 16:10:42 +0000 (UTC)
Date: Fri, 7 Dec 2018 08:10:36 -0800
From: Tony Lindgren <tony@atomide.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: Subject: [PATCH v4 0/4] mtd: rawnand: ams-delta: Use GPIO API
 for data I/O
Message-ID: <20181207161036.GN6707@atomide.com>
References: <20180813223448.21316-1-jmkrzyszt@gmail.com>
 <20181121110806.32076-1-jmkrzyszt@gmail.com>
 <20181121155639.77873f7f@bbrezillon>
 <20181123170333.GH53235@atomide.com>
 <20181207090425.4480d2c0@xps13>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181207090425.4480d2c0@xps13>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_081052_288435_6D26321D 
X-CRM114-Status: GOOD (  16.78  )
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
Cc: linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
 Richard Weinberger <richard@nod.at>, Linus Walleij <linus.walleij@linaro.org>,
 Janusz Krzysztofik <jmkrzyszt@gmail.com>, linux-kernel@vger.kernel.org,
 Boris Brezillon <boris.brezillon@bootlin.com>, linux-mtd@lists.infradead.org,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, Marek Vasut <marek.vasut@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Miquel Raynal <miquel.raynal@bootlin.com> [181207 08:04]:
> Hi Tony,
> 
> Tony Lindgren <tony@atomide.com> wrote on Fri, 23 Nov 2018 09:03:33
> -0800:
> 
> > * Boris Brezillon <boris.brezillon@bootlin.com> [181121 14:56]:
> > > On Wed, 21 Nov 2018 12:08:02 +0100
> > > Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> > >   
> > > > Finalize implementation of the idea suggested by Artem Bityutskiy and
> > > > Tony Lindgren, described in commit b027274d2e3a ("mtd: ams-delta: fix
> > > > request_mem_region() failure"). Use pure GPIO consumer API, as reqested
> > > > by Boris Brezillon.
> > > > 
> > > > Janusz Krzysztofik (4):
> > > >       ARM: OMAP1: ams-delta: Provide GPIO lookup table for NAND data port
> > > >       mtd: rawnand: ams-delta: Request data port GPIO resource
> > > >       mtd: rawnand: ams-delta: Use GPIO API for data I/O
> > > >       ARM: OMAP1: ams-delta: Drop obsolete NAND resources
> > > > 
> > > >  arch/arm/mach-omap1/board-ams-delta.c |   22 ++----
> > > >  drivers/mtd/nand/raw/ams-delta.c      |  120 +++++++++++++++++++---------------
> > > >  2 files changed, 80 insertions(+), 62 deletions(-)
> > > > 
> > > > Performance on Amstrad Delta is now acceptable after recent extensions
> > > > to GPIO API and rawnanad enhancements.
> > > > 
> > > > Series intented to be merged via mtd tree, should not conflict with
> > > > other OMAP1 patches submitted for 4.21.  
> > > 
> > > We'll prepare an immutable tag, just in case.  
> > 
> > Sounds good to me thanks:
> > 
> > Acked-by: Tony Lindgren <tony@atomide.com>
> 
> Actually, I can't setup a topic branch with this series because it
> depends on other changes in nand/next. If a conflict happens in -next,
> I suppose we will have to send you a PR.

Hmm OK I have pretty much all the stuff applied and in next
already so if it's not conflicting now it should not conflict.

Regards,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
