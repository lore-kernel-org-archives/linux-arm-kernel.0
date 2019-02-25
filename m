Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F13C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 10:06:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E350A20842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 10:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZV/2uU0S";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="jzYiUY27"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E350A20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+n/HSjArrkjsoOpOHJJrFJrPZ6+INvHzPYToXvesMLk=; b=ZV/2uU0S8fhm1A
	z5ohhxZuUk4HOV+DjBt32GySl1uhbkrPlmOx0/xeoGsJcR/qUks1atN16vsEJMggnyLz7lcEcgjXl
	ykYjpImdfbIsL1KB8jpteMZC1vMxwUZBiMbWSGQ+1RwT2tFv4hoNuBf5yhTjmCpWGoQXohAp+Ggim
	TOdRybRyJnqkWAZB73UOEvxYG/YDcAQ3ZMA4ULbXMUEsMu+nIvS3XMwxa+MItuha2Dv/4VUYLRAa/
	wgxLMOJO1/UBc1cMtBMJQpWKKg3L/j/uGGBKCD33ai5ExKC2Zs4DGwNYV9r/cJgpnH224QUI1cFOd
	RR13uXkmHcFQvF0P947A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyD9B-0006Qp-2G; Mon, 25 Feb 2019 10:06:05 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyD97-0006QN-76
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 10:06:02 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 600B725B784;
 Mon, 25 Feb 2019 21:05:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1551089158; bh=dIlLXuVkPuy3+3Pwz5AcdmHZ7XLJ9paJQzKCp+di1MU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jzYiUY27MWrpFJ4cJMMPxi52Xf9wx0Sxs9M5iGhe940WwnqovNyfgI0Uebfk5gsma
 Ozzkchs/PzpGWIbpyH/jUGCzq3EQVkmDWGVb+mPSrZYBqwC1watzKITrXR4HlIQ8Ld
 Ww+jWvMya0Z8kmutaThYQ6Rq+T2bGAFAkC2YTMcI=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 8530B94056F; Mon, 25 Feb 2019 11:05:56 +0100 (CET)
Date: Mon, 25 Feb 2019 11:05:56 +0100
From: Simon Horman <horms@verge.net.au>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] Renesas ARM Based SoC Updates for v5.1
Message-ID: <20190225100556.zlnn3rzgoq5n5a27@verge.net.au>
References: <cover.1549622472.git.horms+renesas@verge.net.au>
 <CAK8P3a0prd-4eyVOVUpp2Bhn1mGOVZwA_we79TNjSa4FF5DP6A@mail.gmail.com>
 <20190218112715.zufzr3knrhs37t6h@verge.net.au>
 <CAK8P3a1BrahyfrRD=1dSLNzc1mujh+rxdLoU8CtGruRSbo3JVg@mail.gmail.com>
 <20190218141417.7n6q5petp5oepd55@verge.net.au>
 <CAK8P3a3ULz5BG=hUmhX0a+AX4yYs9gB9G8QEjYjV9pDO=5BBuw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a3ULz5BG=hUmhX0a+AX4yYs9gB9G8QEjYjV9pDO=5BBuw@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_020601_405338_3F6D7F90 
X-CRM114-Status: GOOD (  19.03  )
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
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Kevin Hilman <khilman@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 stable <stable@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>, arm-soc <arm@kernel.org>,
 Olof Johansson <olof@lixom.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Marek Vasut <marek.vasut+renesas@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 18, 2019 at 03:21:14PM +0100, Arnd Bergmann wrote:
> On Mon, Feb 18, 2019 at 3:15 PM Simon Horman <horms@verge.net.au> wrote:
> >
> > On Mon, Feb 18, 2019 at 02:12:07PM +0100, Arnd Bergmann wrote:
> > > On Mon, Feb 18, 2019 at 12:27 PM Simon Horman <horms@verge.net.au> wrote:
> > > > On Fri, Feb 15, 2019 at 05:49:32PM +0100, Arnd Bergmann wrote:
> > > > > On Fri, Feb 8, 2019 at 12:14 PM Simon Horman <horms+renesas@verge.net.au> wrote:
> > > > > > Renesas ARM Based SoC Updates for v5.1
> > > > > >
> > > > > > * Correct shared IRQ handling of R-Car Gen2 Regulator quirk
> > > > > > * Add missing dts files to MAINTAINERS
> > > > >
> > > > > Should the bugfix be marked Cc:stable and and Fixes:... ?
> > > > >
> > > > Sorry for missing that, I think that the bugfix should have had the following.
> > > > Let me know if/how you want to handle updating the patch's changelog.
> > > >
> > > > Fixes: 6d14d4d313d09dab ("ARM: shmobile: Rework the PMIC IRQ line quirk")
> > >
> > > I think the easiest way is to send an email to stable@kernel.org asking for
> > > a backport of commit 5347a0203709 ("ARM: shmobile: Fix R-Car Gen2 regulator
> > > quirk") after that has hit the mainline kernel and asking for a backport.
> > >
> > > I've added it to Cc here, but I don't know if that's sufficient.
> > >
> > > If you'd rather have me pick up the patch for 5.0 as well, I can also do
> > > that and add the Cc/Fixes lines there. We will then have a duplicate
> > > commit in 5.1, but it should not cause any merge issues.
> >
> > Thanks Arnd,
> >
> > I'm happy to handle this via stable and avoid the duplicate.
> > If I don't hear back from them in a few days I'll make a formal
> > submission there.
> 
> Ok, sounds good.
> 
> To clarify: I think you should only write them /after/ the commit
> is in mainline then, i.e. near the end of the 5.1 merge window.

Thanks Arnd, got it.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
