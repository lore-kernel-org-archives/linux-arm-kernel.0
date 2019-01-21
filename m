Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1919C2F421
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:15:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6890920844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p5/Xdv8w";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kj4FebBW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6890920844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LHzd9j317hLl+hEAQsMKDTxUunAkAOFPMuklBUHg898=; b=p5/Xdv8wsN/ZLm
	Ft0ZdJustTPbqoXO8X88kWpuuTDDLn7ZhLwMl194dsLEpmVJFob/BpCEErCYG9sva7fyC26qqN9pK
	H9FGAI5D0yQ/KIAYhOXRerrxhyjP86TwanyD+ae+S6hdJpJJ19zoAU8GXAIxPLZuzwHx4jbBb2qag
	qhvIBeiO1cPOZwRF+X2OGYEeQvn56AAwiR/mwpKhvYJez/oxMw2rO/wEJ3sP2QlL/FSp50dznU7hE
	xaBND4xbLNrNUat6JjsU3QmMwGBnT7mh0fx4b0DV84CDNhDEP73MsBD0mazNpo3ac6KX+IwJpJHbV
	cTJE81lhapRrky+9G7kg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glcDy-0002JQ-5M; Mon, 21 Jan 2019 16:14:58 +0000
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glcDu-0002I4-5p
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 16:14:55 +0000
Received: by mail-io1-xd41.google.com with SMTP id g8so16809658iok.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 08:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JJK1BCKSyDL+6Bnumrmgz0aFAHbUsIf0r+wdJw+CqMA=;
 b=Kj4FebBWF3IgYE59zzK25BcvMYseHgw2U55GKDu80LoJc/1no88VfZWlimZA92sHU/
 6z4nya+rz29tQfRHc4u4Wt+pAECUdo5iUyr2hhxn2hAkDZBP6J2HKgJfnHLekJzK1vIJ
 tlERyFoqq1KbB5gtnwr8uQra/yhMCIJnZ+jZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JJK1BCKSyDL+6Bnumrmgz0aFAHbUsIf0r+wdJw+CqMA=;
 b=Knuy4RpagjL/t0aXgEcjrxqjypDRf2NQUcn+Lkk2b2RIucZ45Xe/Q2f6tw/aMsUEfc
 l7kmt7egwEppO+J2hQBB2z5h39JVQfWKQcFbhk+KxKkLQxWIYWHY+JL1RGYNYsOseHyd
 SicYAfoj3KhbUujSTpavjGWQoObZlIUs5nTyN29PHglHpkLriATY3x2rfvH9WEwZCbQS
 wz4Ewyo2HPZ4yvPWZB0w+AVZCGNmFvyAMpFCA9WEbUdbubMWDw35ei5Q47axn5AuxgpO
 DTSIGDlYyCCHjvosGWl+pNTBKdTrGD6aqjv/Yowe7HSq1wAKEuYn1sT5dKkofgFfGq2A
 Ahdg==
X-Gm-Message-State: AJcUukcmwVPUFDkk96/JDwA0L/BDsHksgG9DGT/F380y9DMD7Qg79IPn
 24NxS6dypnxNc46k9tAz8jt28mYLd95jVdcHv7YkzA==
X-Google-Smtp-Source: ALg8bN4kiLIcOotuv3Eol9fGHrSR9csRaV14VqHmTkDO6pNF4iUibro4vd5Dh/nvdiiHg+VbxvGt1HqX22lk+oQCMOk=
X-Received: by 2002:a5e:c206:: with SMTP id v6mr17797491iop.60.1548087289131; 
 Mon, 21 Jan 2019 08:14:49 -0800 (PST)
MIME-Version: 1.0
References: <20190121100617.2311-1-ard.biesheuvel@linaro.org>
 <20190121150734.GA30582@infradead.org>
 <CAKv+Gu-hR=uieOeg7QheA5yfAycUoi2vjZsDUvROKVjW4eUNqw@mail.gmail.com>
 <20190121155908.GA8084@infradead.org>
In-Reply-To: <20190121155908.GA8084@infradead.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 21 Jan 2019 17:14:37 +0100
Message-ID: <CAKv+Gu8LzS9OgvVnzUT8BZWVgDmx4OfqNiPSf+8=riY_LByN-g@mail.gmail.com>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
To: Christoph Hellwig <hch@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_081454_223974_B237BDEA 
X-CRM114-Status: GOOD (  21.43  )
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
Cc: Will Deacon <will.deacon@arm.com>, David Zhou <David1.Zhou@amd.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Airlie <airlied@linux.ie>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Michel Daenzer <michel.daenzer@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx@lists.freedesktop.org, Junwei Zhang <Jerry.Zhang@amd.com>,
 Huang Rui <ray.huang@amd.com>, dri-devel <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Michael Ellerman <mpe@ellerman.id.au>,
 Alex Deucher <alexander.deucher@amd.com>, Sean Paul <sean@poorly.run>,
 Christian Koenig <christian.koenig@amd.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 21 Jan 2019 at 16:59, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Jan 21, 2019 at 04:33:27PM +0100, Ard Biesheuvel wrote:
> > On Mon, 21 Jan 2019 at 16:07, Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > > +#include <linux/dma-noncoherent.h>
> > >
> > > This header is not for usage in device drivers, but purely for
> > > dma-mapping implementations!
> > >
> >
> > Is that documented anywhere?
>
> I'll add big fat comments.  But the fact that nothing is exported
> there should be a fairly big hint.
>

I don't follow. How do other header files 'export' things in a way
that this header doesn't?

> > > And even if something like this was valid to do, it would have to be
> > > a core function with an arch hook, and not hidden in a random driver.
> >
> > Why would it not be valid to do? Is it wrong for a driver to be aware
> > of whether a device is cache coherent or not?
> >
> > And in case it isn't, do you have an alternative suggestion on how to
> > fix this mess?
>
> For the write combine mappings we need a proper core API how instances
> can advertise the support.  One thing I want to do fairly soon is
> error checking of the attrs argument to dma_alloc_attrs - so if you
> pass in something unsupported it will give you back an error.
>

That sounds useful.

> It seems that isn't quite enough for the drm use case, so we might
> also need a way to query these features, but that really has to go
> through the usual dma layer abstraction as well and not hacked together
> in a driver based on an eduacted guestimate.

As far as I can tell, these drivers allocate DMA'able memory [in
ttm_tt_populate()] and subsequently create their own CPU mappings for
it, assuming that
a) the default is cache coherent, so vmap()ing those pages with
cacheable attributes works, and
b) telling the GPU to use NoSnoop attributes makes the accesses it
performs coherent with non-cacheable CPU mappings of those physical
pages

Since the latter is not true for many arm64 systems, I need this patch
to get a working system.

So how do you propose we proceed to get this fixed? Does it have to
wait for this proper core API plus followup changes for DRM?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
