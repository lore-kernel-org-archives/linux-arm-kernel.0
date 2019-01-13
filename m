Return-Path: <SRS0=Fp1N=PV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECA6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 15:51:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98B5B20657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 15:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qJPPN6tg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98B5B20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PO8btnomWm814Dd5G1C4OoICtMCofnk571gwpUu2oJc=; b=qJPPN6tgHPfgiN
	+t63XUpQdbxQCvskSB5zE0IOVYEvut31tZmao2QQ4wF1OkR4RXJR+1gX+get4+m2RDtHvAPKoxx/+
	LStE+v7GTMenAZ2O78+sR22sLYkzbGeI4yweyrijEtUpNYkVicI2ZlO1N5jl3jzcHDl9kZbaegSrR
	IKy74zDdDqoBZPqSEuQc5kKtlO8PseyektXEbs85dgstUiM+QtpwxMdE9YPE4/yF75eVFDazYWYzt
	0lMpBleQJT8F8IQ8z/5NcAuYKoOMRx0RNZGUIsT7fmKtTq5ma/n1RdNd5Az56F1nh0SBFOD7A9FKr
	xjP0fkczYpSm/wyPPrew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gii2L-0002Ly-Bt; Sun, 13 Jan 2019 15:50:57 +0000
Received: from eddie.linux-mips.org ([148.251.95.138] helo=cvs.linux-mips.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gii2I-0002LS-3D
 for linux-arm-kernel@lists.infradead.org; Sun, 13 Jan 2019 15:50:56 +0000
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23991062AbfAMPus3zMs0 (ORCPT
 <rfc822;linux-arm-kernel@lists.infradead.org>);
 Sun, 13 Jan 2019 16:50:48 +0100
Date: Sun, 13 Jan 2019 16:50:47 +0100
From: Ladislav Michl <ladis@linux-mips.org>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: Hilscher NetX mach-netx refactorings
Message-ID: <20190113155047.GA12829@lenoch>
References: <CACRpkdb-zphMyZbGh5XYy2A6B1224BGFmTwr0Bm98G3oM0MeoQ@mail.gmail.com>
 <CAK8P3a08TV+sQhsCPjkXh6wOKEpLfGLqVo9+FHoXzDVXs_bY7A@mail.gmail.com>
 <CACRpkdZ7KSmgTYP8a_RUJAWKzuc652OZ420Lq4ZnzkCuESLZ2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACRpkdZ7KSmgTYP8a_RUJAWKzuc652OZ420Lq4ZnzkCuESLZ2Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190113_075054_133748_5D5E9DAC 
X-CRM114-Status: GOOD (  22.12  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Robert Schwebel <r.schwebel@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Olof Johansson <olof@lixom.net>, github@hilscher.com,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Linus,

On Sun, Jan 13, 2019 at 01:14:36PM +0100, Linus Walleij wrote:
> On Sat, Jan 12, 2019 at 1:03 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Sat, Jan 12, 2019 at 9:35 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> > >
> > > Hi Sascha, Robert,
> > >
> > > I am looking at refactoring mach-netx to use the new PL11x
> > > DRM driver for the graphics.
> > >
> > > I need to make sure that patches get tested on the hardware
> > > and just want to ascertain that there is an active maintainer that
> > > will be able to test patches I make for this and work on getting
> > > it migrated to DRM before I start spending time on it.
> > >
> > > Are you/pengutronix still actively maintaining this machine and
> > > testing new kernels on netx?
> > >
> > > I guess the second question is whether you have plans to migrate
> > > it to device tree and multiplatform, but I'm mainly thinking about
> > > my own little patches now.
> >
> >
> > On a related note, there does appear to be active work on
> > newer netx machines that were never upstreamed, see
> > https://github.com/Hilscher/netx4000-linux/commits/v4.9-netx4000-stable
> 
> That RS485 addition to PL011 using GPIOs is a bit hacky but
> looks like very useful for industrial applications.
> Ladislav, have you been in contact with Hilscher?

I guess I appeared on Cc list because of commit 797537a45450 ("amba-pl011:
Add RS485 support (ioctl and devicetree)") from above github repo which
is based on my hack originaly done for rPi3 as I got tired of all those
experts implementing 'drive enable' in userspace. That's broken by design
and works only by accident. But as I'm also considering every single
device running from SD card broken by design - it was perfect match ;-)

But seriously, it is indeed needed for industrial applications and
should be done a bit better - I mean regarding those delays in interrupt
context.

> > I wonder if anyone has contacts into the company so we can
> > work together with them to include them into mainline Linux.

I do not own this machine nor I was in contact with Hilscher, but I can
help with mainlining PL011's RS485 support. It is only matter of time
until someone brings some "product" based on RPi claiming "it almost
works, it just needs a bit of fixing" ;-) So having that in mainline
would save some future effort.

> They have a mail address github@hilscher.com, let's knock
> on the door and see if somebody answers it :D
> 
> I'd personally be able to take a stab at converting this machine
> to device tree and multiplatform if I only had access to the
> hardware, as it seems to be in the same class as EP93xx
> and MOXA ART: deployed in industrial systems as we speak.
> 
> Yours,
> Linus Walleij

Best regards,
	ladis

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
