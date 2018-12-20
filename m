Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883E2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 23:42:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4807221904
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 23:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S3pZD3yV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="o4FtxOn6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4807221904
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WgFL2j5oSrxg57sZZkMr3AbF7Km/z+EBnuJ/64ImS7M=; b=S3pZD3yVZRSkAx
	hHX6x3t7XbZ9tMbf5LfSy/8Qw17HwgcgK6OzTrsmOGtGvKRBHq+VM42/rV0HMmGncPW7FUdcgAEmh
	t7CaVTh3X1JtnhC3UhcCwCUsFypZtjxLC0z9vXilGK9a9+TyIliVhqQj7iIQrzxTtT8mENI7A6Ngs
	1siRMOdXTn5ZSApTTWscI8imqHqTLyi9SeLNqq+sP+5K8xpP3WmjoqQp9hpY+W10C88Lu0Q1jzJzC
	1KXSiv770BuLOutipB0hqxj34xomVV8lSSVep6T0dundbwUNXQ0Rw0ehrvR9KnuY69gnMqovgXHJi
	OUyAm6glNkAPJTSg/B/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga7xp-0003ar-1G; Thu, 20 Dec 2018 23:42:49 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga7xl-0003SH-8U
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 23:42:46 +0000
Received: from penelope.horms.nl (g1-27-253-251-228.bmobile.ne.jp
 [27.253.251.228])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 86B3425BDFF;
 Fri, 21 Dec 2018 10:42:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1545349351; bh=gPwBba0El8wczk78M1r1X612fsNe3RY+zKcDDQtWHEA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=o4FtxOn6UYzIII2HBYs2cV9xSf/nCM8UEH27Guu5HQQh63L4YsJ/9QCWy77HYZFnQ
 NEMHA8FualF1lDd8Lhk+aCPgebQzFT4rboYyVqrQPOsFUQLze3cJh4exI2zGqiUBqq
 pU9VqZqwYWpz3SjYz7XlRlbBr0duYONSE2mG/yN0=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id 7B8CAE21792; Thu, 20 Dec 2018 15:42:29 -0800 (PST)
Date: Fri, 21 Dec 2018 08:42:29 +0900
From: Simon Horman <horms@verge.net.au>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL v2 0/3] Renesas ARM64 Based SoC Defconfig Updates for
 v4.21
Message-ID: <20181220234225.iaodzrfok4d2ifl4@verge.net.au>
References: <20181214115647.12391-1-horms+renesas@verge.net.au>
 <20181218094407.hfe7aei2hmnsih5u@verge.net.au>
 <CAK8P3a36OO+qM6r0BnrjWEWU6SV4SXu63Y=3Pq0FNt=56mzJXg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a36OO+qM6r0BnrjWEWU6SV4SXu63Y=3Pq0FNt=56mzJXg@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_154245_483347_14ECFB08 
X-CRM114-Status: GOOD (  14.54  )
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
Cc: Kevin Hilman <khilman@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>, arm-soc <arm@kernel.org>,
 Olof Johansson <olof@lixom.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 20, 2018 at 05:38:45PM +0100, Arnd Bergmann wrote:
> > > ----------------------------------------------------------------
> > > Renesas ARM64 Based SoC Defconfig Updates for v4.21 (v2)
> > >
> > > * Enable in arm64 defconfig:
> > >   - Renesas R-Car Gen3 PCIe PHY driver
> > >   - Renesas R-Car thermal driver
> > >   - ASoC simple SCU sound card support
> >
> > It seems that Morimoto-san has determined that the sound card patch is not
> > necessary. Rather than move to v3 for these not entirely critical changes I
> > would prefer to withdraw this pull request and revisit these changes for
> > v4.22 although if you do happen to pull this then I don't think any harm
> > would be done.
> >
> > I apologise for any inconvenience this may cause.
> 
> No worries, I just dropped the pull request from my todo list for 4.21 now.

Great, thanks Arnd.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
