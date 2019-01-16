Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89E8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:51:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CB782082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lwBpyvnc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="d9bAJymd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB782082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mat4kH7nDwp2zcyXwDAw8Iz2v5BGjur5IWK066Tio8s=; b=lwBpyvncmMaeop
	0moUgbMOKXXGc4cAtI8RrmRS28TOWK56p12JZhMjg+B5c/yFeU0l9GrGJZ6Pi3cJ3GIWXEdkbcWcP
	926pBeOM1trwk5Ke09itpGOJaqs9c4MjW+2BpaiY8SC8fdVh5J72BSzsD8oM09Mj6BApxil9JyEft
	qBET+HlpHZIu8YZw0Ddal82sqivnRsCjHcWlA4gCqtCAFTcPDEAfGTJNwwNmTicFidAq+kv/kmQHX
	jB1LQbcrnPEeRjPQ4q1F93CKZI5C/wWnG8GJudu76qQ2zuc8gDvtCWrgFeDYpEUfRAdeLlUZ6UFDt
	oZHTfTVHbrLm2XOpWI8A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjlbW-0007qX-Gs; Wed, 16 Jan 2019 13:51:38 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjlbP-0007mw-89
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 13:51:36 +0000
Received: by mail-lf1-x141.google.com with SMTP id e26so4951742lfc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 05:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/QAlEPOTpbjNMnenHIMdR9E8UMK5/zSWeglYGtHhaUc=;
 b=d9bAJymd/T9HU4uCTwuYz5vsazR9vJ/oN3bUaagTOzYk/QKhokk3tTKmllUGImXUb/
 1davUna9zTX7ceySQ7by7EHvBo+jeWeU6VyDH/lzOPboagV5WM+XNf6y6IbIzl508MRj
 hI1TmRxOm5uV6uVKKkkcBdtihIMOWLzXoEFME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/QAlEPOTpbjNMnenHIMdR9E8UMK5/zSWeglYGtHhaUc=;
 b=WrYzuVUdiCtSPLbLdRsa4ElgFj0griH9aHLjOJ7sjj7m3Lj+Odt933BccideZ/Fs4R
 em4yqBUBm73larh2Glmj353r8oRErr6jAbTXGcyVOAe938bI8BIR42IHZHLzNEl6lDPj
 PpAMu7TPQFi5LrE6EcNYPtcHai6kbmnqQ7cUzShAtdGuLm7jwnQIu5RwI0mt3ZHxxQFi
 YmcJgrfpKFZSaJJXHtu/Qddc0KXcip76LAHIJ4z/FAnTHupYcOTfRp7oLJHBcDinVvnG
 YncdBPG7AABh+gHR3qG3vAP+lnIIKEplpGlKthCdy2HZMGPH799/IFARp7hPQ1rN5PvS
 Rtug==
X-Gm-Message-State: AJcUukcJuy08lecQ3v8ySiIvpGev9YgDsXgwUV8/pJUZkifhz3TByn/j
 oqJAB4DOHA5KhRL/lhlw37PbSDUGv3RD+327aMlsAA==
X-Google-Smtp-Source: ALg8bN6rmOifW5Z+BVBm11ZzhoRM65WVwbSH+n4lOJ5EGq9j1EXWpMOKYEFSXfrjsX/EW8pxMJa1n2IGs8pQ2C+6vkc=
X-Received: by 2002:a19:5154:: with SMTP id f81mr7212599lfb.96.1547646688932; 
 Wed, 16 Jan 2019 05:51:28 -0800 (PST)
MIME-Version: 1.0
References: <20190114095804.27978-1-hch@lst.de>
 <CAPDyKFqCOWmd3kE=f3bgOgYX-aQKCmbuRH98sTr05sHN71vXZA@mail.gmail.com>
 <CAK8P3a16ZoBt=HpZByb_1iH+-0e9O0F0sPX+ROfO9hWnJR94qg@mail.gmail.com>
In-Reply-To: <CAK8P3a16ZoBt=HpZByb_1iH+-0e9O0F0sPX+ROfO9hWnJR94qg@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 16 Jan 2019 14:51:16 +0100
Message-ID: <CACRpkdY4SRxJiH8PEwTNAyPum_=e3VhG30y8wJhfcdML--9BdQ@mail.gmail.com>
Subject: Re: remove block layer bounce buffering for MMC
To: Arnd Bergmann <arnd@arndb.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_055131_417422_0ED3F4CB 
X-CRM114-Status: GOOD (  16.73  )
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

On Wed, Jan 16, 2019 at 11:25 AM Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Jan 14, 2019 at 11:27 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > +Linus Walleij (recently made a cleanup of the mmc bounce buffering code).

Nah it's not THAT bounce buffer.

> Linus probably knows more here, but I have a vague recollection of
> the MMC bounce buffer code being needed mostly for performance
> reasons: when the scatterlist is discontiguous, that can result in
> a request being split up into separate MMC commands, which due
> to the lack of queued commands combined with the need for
> garbage collection on sub-page writes results in a huge slowdown
> compared to having larger bounce buffers all the time.
>
> We had discussed finding a different way to do this (separate
> from the bounce buffering), but I don't know if that ever happened,
> or if this is even the code that you are changing here.

Nope not the same code.

The term "bounce buffer" is sadly used as ambigously as
__underscores in front of function names.

That other "bounce buffer" was first deleted and then
reimplemented as a local hack in the SDHCI driver core
after it caused performance regressions on the i.MX and
some laptops, see commit:

commit bd9b902798ab14d19ca116b10bde581ddff8f905
mmc: sdhci: Implement an SDHCI-specific bounce buffer

That should be orthogonal to Christoph's changes in this
patch series.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
