Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390B9C2F441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:50:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B20420663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DvTvBjDg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="knWbAVnH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B20420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2SFyFtP+PvwNavhZRCNeM6WSewMVBMHEhEiqI6sDbW8=; b=DvTvBjDg0awXKh
	jdNXWx/LrPfgnRnMW0A6KAnjEh9EaChk5Vzl1utsvH7NVbgSsuWy8CJBW5gmEMiifg00ra+nFsd1n
	LnfMQbOnZuzxGiBx9s+AP+Krx+hBZNaj5jG/itVcnKDPAwTmp5T+ZULRbjbCktDTloAD087LsNIAE
	1u+ZfRe9YTBFgXDYpq38GdwhJk6OknOF9mxxRfoNNxYrUnSOl3ERASWG7yMkwS2AEzQBal31Q/07V
	IhVy/9DusZ/QWT1eVdPUqDHMA0W2ijcvLk7/zAW24T5e5WWGv6RJPKBu8LWOrueXRiUvLdrfAuvTY
	OWDvl7qbZrJL/7UE8gUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glcmF-0005Ys-ER; Mon, 21 Jan 2019 16:50:23 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glcmC-0005YA-Pq
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 16:50:22 +0000
Received: by mail-it1-x142.google.com with SMTP id z7so17263558iti.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 08:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jZkIHXbK2+RKhg/FHopxKpLPTPpYQ83cmICCVP5I1bs=;
 b=knWbAVnHA7+Agjb5/CO/MtnhNDzHxs1w+IC3Nz1jpwcsb8snEobirr9OPT7vnVAyjM
 G6NAWfTMsLKfJPaK/+xd1CR0jyRbpul4k6GUchiOBw9O6hv9K5TJcivnab0xl8rTcuH/
 6w2XqvWbUPGinJlmAPo+bB1hFD6OeQcxuzw8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jZkIHXbK2+RKhg/FHopxKpLPTPpYQ83cmICCVP5I1bs=;
 b=nRxAktjaxFrurO0yaHB9NtVd/qvvvSvqf3rMDNix1QT/+IhOUsLgWsB/Vq5YaWQbZ7
 3AQkCgwqpo8S+ct0Vp60wvKmgdcqKxcuijXdrVrdfThKY2O0sgU0jM666ZEglYHWK6E0
 db7L1s/ueyvXCDaenjcDWydL+LdqV/PwTvqMRzCwBzukCXVBZq63oPHylwN7bAiaYzRW
 5qnEX2S7N938YDv5XhFprnytTtMAoNZDyG/NpL/8xLM3pDxaFGoUkgMLTKyHmrUl7fE/
 VwbzimNsFtvsBvDpBNJrUn//CQA24wKg+LKny+24cYMjo4lxS3atQCYVCHOxEn78c1Xr
 zfZw==
X-Gm-Message-State: AJcUukdtawjQVcvt3lpUTNd4oRV5D3kRjiXSaefxpEk29PQT65VMD3LC
 zSP8Pk/gvFubUF7RTYyen9bXVlAMIsYy7Le/eJFV0w==
X-Google-Smtp-Source: AHgI3IZ8jqfnbXkm8z0a6VM6wu0ORa/r/ofG2Bo4LFcs9kk1YW++hnvh4+IvRBmFKzE2afhxd1IwQGXtRgBhCS6uCg0=
X-Received: by 2002:a24:edc4:: with SMTP id r187mr132454ith.158.1548089419522; 
 Mon, 21 Jan 2019 08:50:19 -0800 (PST)
MIME-Version: 1.0
References: <20190121100617.2311-1-ard.biesheuvel@linaro.org>
 <20190121150734.GA30582@infradead.org>
 <CAKv+Gu-hR=uieOeg7QheA5yfAycUoi2vjZsDUvROKVjW4eUNqw@mail.gmail.com>
 <20190121155908.GA8084@infradead.org>
 <CAKv+Gu8LzS9OgvVnzUT8BZWVgDmx4OfqNiPSf+8=riY_LByN-g@mail.gmail.com>
 <20190121162238.GA17651@infradead.org>
 <CAKv+Gu-5V-UjP_YzZBCEsa+o_G6BRSVw2ZimYGNEfRGf-aRPNg@mail.gmail.com>
 <20190121163539.GA18070@infradead.org>
In-Reply-To: <20190121163539.GA18070@infradead.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 21 Jan 2019 17:50:07 +0100
Message-ID: <CAKv+Gu-NxJkT7ViO8HogVMnPyiYDfOEQsEJ8AFNshexopbby8A@mail.gmail.com>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
To: Christoph Hellwig <hch@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_085020_839686_44D9B084 
X-CRM114-Status: GOOD (  17.79  )
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

On Mon, 21 Jan 2019 at 17:35, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Jan 21, 2019 at 05:30:00PM +0100, Ard Biesheuvel wrote:
> > > Until that happens we should just change the driver ifdefs to default
> > > the hacks to off and only enable them on setups where we 100%
> > > positively know that they actually work.  And document that fact
> > > in big fat comments.
> >
> > Well, as I mentioned in my commit log as well, if we default to off
> > unless CONFIG_X86, we may break working setups on MIPS and Power where
> > the device is in fact non-cache coherent, and relies on this
> > 'optimization' to get things working. The same could be true for
> > non-coherent ARM systems, hence my approach to disable this hack for
> > cache coherent devices on non-X86 only.
>
> Do we break existing setups or just reduce performance due to the lack
> of WC mappings?  I thought it was the latter.

Combining this check

#if defined(CONFIG_PPC) && !defined(CONFIG_NOT_COHERENT_CACHE)
    return false;
...
#else
    return true;
#endif

with the fact that the driver assumes that DMA is cache coherent, I'd
be surprised if this hardware works without the hack.

The optimization targets cache coherent systems where pushing data
through the cache into the GPU is wasteful, given that it evicts other
data and relies on snooping by the device. In this case, disabling the
optimization reduces performance.

My point is that it is highly likely that non-cache coherent systems
may accidentally be in a working state only due to this optimization,
and not because the driver deals with non-cache coherent DMA
correctly.

> The point is that
> even your check won't do what you actually said.

Well, it enables the optimization only for non-cache coherent devices.
How is that different from what I said?

>  At lot of non-loongson
> mips platforms are not cache coherent.

You are assuming that whoever added that check cared about other MIPS platforms

> As are a lot of arm setups
> and all sparc64 ones for example.  And chances that someone will
> hacks this file out in a random subsystem when adding news ports also
> is rather slim, so we'll remaing broken by default.
>
> That is why I want at very least:  a whitelist instead of a blacklist
> and some very big comments explaining what is going on here.

ideally, we'd turn off this optimization entirely unless running on
x86. That would be my preference.

However, given the above re non-cache coherent systems, i am cautious.

>  And in
> the mid to long term even drm really needs to learn to use the
> proper APIs :(

+1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
