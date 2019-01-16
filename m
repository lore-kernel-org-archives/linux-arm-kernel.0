Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821E0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:54:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A7B02082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CL3MdCKr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7B02082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8VqLCuKyfil6Cp7uIUwaT6rFltRh6DiyEMeF/1dVjMc=; b=CL3MdCKrwnCpd8
	cOVxyoJe9OLp21HPMRIVQPnw46GH17LPx9qqN8oufgz+3aFno/ZsZylXg1jGraBnLiQbXGEIuMDmd
	1fVoCGtMzYA7AyXQUhqwDwUHwf0gRO3iPVKwQ27WlJQE+xWAWx8Vwyh9CcX/MSxBtEdqb2vfcVCmC
	26WLujpANpC4S04y4qorlzgGKbwEHFljiG7zyce2Wq2hUIAakphrYFpgUE2bIIHJ0xU97Z71cYsdq
	yVtQJZHIuKrG4+KRWRRAowTRwt0LHKEiZcb5x+AJtfSOauh+87u0LCNq61pjiT9S2xHmPBttOjQNO
	UG1reCqwB7nQFoEzqLOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjleR-0008JT-Lk; Wed, 16 Jan 2019 13:54:39 +0000
Received: from mail-qk1-f194.google.com ([209.85.222.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjleN-0008J1-Vv
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 13:54:37 +0000
Received: by mail-qk1-f194.google.com with SMTP id c21so3757587qkl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 05:54:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OeXSLo9ui7FrcGRJ2DuvONgNX8g8U/wRgwtLSPYMQgY=;
 b=tMmlhGWhjvt7FZ4qiTFVcbt/AMIVcqAAWAkOT8T+WyCLjJ789eRHYjlNq7OvIkyYTD
 lbmm0UnIR2p4CNxWCex8oO0uCpJO+UQJfKePMzbolBeYsnhLUXapcB9Odly3iF0EaUEH
 fER4+pFrWX5pTe5hFCxFuIUh/bx/MILFN5QNuMUyDIjX9Ti6u0O4MphcUKv4e55I3RQm
 CHyUuKHubHIb0fx8qsoPpsbXYDhX6QAybVT1ya1ytZa9wQmhuSzUgBF4ei9Dca44OLFi
 0d0a/fnLauqmlBWc7xDh/pE2dxu45bxRizLu3MDl8sXy9Tb7kXDhn/r7LiJiKUZWBDRp
 lbaw==
X-Gm-Message-State: AJcUukeYZq05mT0tUQIx/3PO7S59WpANVvfVsGyHR85r+2CepoeYOr2p
 o4nWeT+kB8IYDxIws15e1u+WRYCKjm5m+KkPxQQ=
X-Google-Smtp-Source: ALg8bN5JYDUHSiThrD7YByCGVuB9x+rHtEvt0GVKiITnGChkIsi8HJ2qupKGY4X8+vQdX0WFItALMDfWT/318cXa5qM=
X-Received: by 2002:ae9:d8c2:: with SMTP id u185mr6371320qkf.107.1547646874745; 
 Wed, 16 Jan 2019 05:54:34 -0800 (PST)
MIME-Version: 1.0
References: <20190114095804.27978-1-hch@lst.de>
 <CAPDyKFqCOWmd3kE=f3bgOgYX-aQKCmbuRH98sTr05sHN71vXZA@mail.gmail.com>
 <CAK8P3a16ZoBt=HpZByb_1iH+-0e9O0F0sPX+ROfO9hWnJR94qg@mail.gmail.com>
 <CACRpkdY4SRxJiH8PEwTNAyPum_=e3VhG30y8wJhfcdML--9BdQ@mail.gmail.com>
In-Reply-To: <CACRpkdY4SRxJiH8PEwTNAyPum_=e3VhG30y8wJhfcdML--9BdQ@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 16 Jan 2019 14:54:18 +0100
Message-ID: <CAK8P3a15eGQ+gxxZxGVxsJXpkYSQPOZ5UmRNr7biS--Ye+Unsg@mail.gmail.com>
Subject: Re: remove block layer bounce buffering for MMC
To: Linus Walleij <linus.walleij@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_055436_026858_67056074 
X-CRM114-Status: GOOD (  19.85  )
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Aaro Koskinen <aaro.koskinen@iki.fi>,
 Nicolas Pitre <nico@fluxnic.net>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Ben Dooks <ben-linux@fluff.org>, linux-omap <linux-omap@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 16, 2019 at 2:51 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Wed, Jan 16, 2019 at 11:25 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Mon, Jan 14, 2019 at 11:27 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > +Linus Walleij (recently made a cleanup of the mmc bounce buffering code).
>
> Nah it's not THAT bounce buffer.
>
> > Linus probably knows more here, but I have a vague recollection of
> > the MMC bounce buffer code being needed mostly for performance
> > reasons: when the scatterlist is discontiguous, that can result in
> > a request being split up into separate MMC commands, which due
> > to the lack of queued commands combined with the need for
> > garbage collection on sub-page writes results in a huge slowdown
> > compared to having larger bounce buffers all the time.
> >
> > We had discussed finding a different way to do this (separate
> > from the bounce buffering), but I don't know if that ever happened,
> > or if this is even the code that you are changing here.
>
> Nope not the same code.
>
> The term "bounce buffer" is sadly used as ambigously as
> __underscores in front of function names.
>
> That other "bounce buffer" was first deleted and then
> reimplemented as a local hack in the SDHCI driver core
> after it caused performance regressions on the i.MX and
> some laptops, see commit:
>
> commit bd9b902798ab14d19ca116b10bde581ddff8f905
> mmc: sdhci: Implement an SDHCI-specific bounce buffer
>
> That should be orthogonal to Christoph's changes in this
> patch series.

Ok, thanks for the clarification. Please ignore my comments then.

    Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
