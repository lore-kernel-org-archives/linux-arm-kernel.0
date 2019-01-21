Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91104C2F441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:30:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E2CE21019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OHnu6WMw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IgcA+zu/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E2CE21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Qdf7T8DyyZ0QeD7XmI66VI5bKadskuLt7DGeq54WdZ4=; b=OHnu6WMwuvozJ/
	EQZhZiTY/SH7MVFQJvTVLwX9Kn04hBIn+xNhC41Ui1A32DWyvvOK/3AjsZJBSUEYo2ELfpCi7/F58
	ZvpR3F4gA6YOxz5Urhq0ACcGdsSfgoF/Ob34/JALrt4U4bQqya7ROf+zzUBmWoZxiAAX7dxKbCPRN
	E+QnPw+y9/kyoZfJrScOaOUNjr4+PfzuYs/ZyYKWJQbVi+nB0786O7NG64IVoDJJnv1MCzhBRtrk0
	VlB46ZWfECJjYej5emMq2BYuiRc6Xixu0A9GRJ724mTVRY706n13epvvEM5maWohVHYvkp4R9XYIV
	aXB67DfKd7i2Pb/FCheg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glcSl-0004QE-Ts; Mon, 21 Jan 2019 16:30:15 +0000
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glcSi-0004Pb-QZ
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 16:30:14 +0000
Received: by mail-io1-xd44.google.com with SMTP id t24so16875534ioi.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 08:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eADEIz0iwznb0TSre1LvJOXMgvWd8rOdZ80eJVALlOs=;
 b=IgcA+zu/3zhC1gBAyy/mGl+AwjUvef+boE7Zb66yOFc2qibmGG0Jh5Z74HkztTdSgB
 jZasnWUu68LFhIBBQvxmkQgpvppzuKDU+u7crf4NfP1kjSK+PUB1MInPaxsqCRBF7MYP
 SCLHk/2buYs5nhGNikNiUQcrczAJtZqnnKZCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eADEIz0iwznb0TSre1LvJOXMgvWd8rOdZ80eJVALlOs=;
 b=cyvUCrwjYQHR8S4yyGM5SmlZC2UaQHHGxcwjuZuTrC/aEe/vM+GIm8Kq7kChACWl1Y
 eKHe33xRLJ8gd1biXCnYOiT0ncV2n1UHGLeIytq14Y/q1OkdbzE3iUvEdp5tQL8rA95A
 n3r2hJNK+V6qiEMohDkvKmRD5HiCzpJQxLQvIyxtkDL4i6AV5iANK11sadtMGlMWK7oo
 VIsXE2OSlM4cIzD46z/dzLgONTf8mM7wVfnfrfA1WolYaMETyxQqWy2XZBztcSr9d05Z
 jy3YN6PYCCMcckTaP6DiEtKMfNq+7mpIL37HkOPVimhWwGS68n5xBlBE9J3tKCyESSwg
 Nfhw==
X-Gm-Message-State: AJcUukeKzYipWwrvBKWiEMF4Cp0mdeg1MAEy/DzJvNii+8Qpsh8Jk+2q
 r8Sb0/BgTanzhRCZJzFYIXEcBjx57D9ZKRys9eDEzA==
X-Google-Smtp-Source: ALg8bN6Rwa3oE2P3hjVFSiGUF+4UztXQttKfRRYjOU/YoQyoCIqQxA/Gv1+ltfJOi0INVe0/3LG6Rsu6cJl+GSieOmc=
X-Received: by 2002:a6b:5d01:: with SMTP id r1mr16148051iob.170.1548088211443; 
 Mon, 21 Jan 2019 08:30:11 -0800 (PST)
MIME-Version: 1.0
References: <20190121100617.2311-1-ard.biesheuvel@linaro.org>
 <20190121150734.GA30582@infradead.org>
 <CAKv+Gu-hR=uieOeg7QheA5yfAycUoi2vjZsDUvROKVjW4eUNqw@mail.gmail.com>
 <20190121155908.GA8084@infradead.org>
 <CAKv+Gu8LzS9OgvVnzUT8BZWVgDmx4OfqNiPSf+8=riY_LByN-g@mail.gmail.com>
 <20190121162238.GA17651@infradead.org>
In-Reply-To: <20190121162238.GA17651@infradead.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 21 Jan 2019 17:30:00 +0100
Message-ID: <CAKv+Gu-5V-UjP_YzZBCEsa+o_G6BRSVw2ZimYGNEfRGf-aRPNg@mail.gmail.com>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
To: Christoph Hellwig <hch@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_083012_865716_AA643570 
X-CRM114-Status: GOOD (  21.01  )
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

On Mon, 21 Jan 2019 at 17:22, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Jan 21, 2019 at 05:14:37PM +0100, Ard Biesheuvel wrote:
> > > I'll add big fat comments.  But the fact that nothing is exported
> > > there should be a fairly big hint.
> > >
> >
> > I don't follow. How do other header files 'export' things in a way
> > that this header doesn't?
>
> Well, I'll add comments to make it more obvious..
>
> > As far as I can tell, these drivers allocate DMA'able memory [in
> > ttm_tt_populate()] and subsequently create their own CPU mappings for
> > it, assuming that
> > a) the default is cache coherent, so vmap()ing those pages with
> > cacheable attributes works, and
>
> Yikes.  vmaping with different attributes is generally prone to
> create problems on a lot of architectures.
>

Indeed. But if your starting point is the assumption that DMA is
always cache coherent, those vmap() attributes are never different.

> > b) telling the GPU to use NoSnoop attributes makes the accesses it
> > performs coherent with non-cacheable CPU mappings of those physical
> > pages
> >
> > Since the latter is not true for many arm64 systems, I need this patch
> > to get a working system.
>
> Do we know that this actually works anywhere but x86?
>

In theory, it could work on arm64 systems with stage2-only SMMUs and
correctly configured PCIe RCs that set the right AMBA attributes for
inbound transactions with the NoSnoop attributes set.

Unfortunately, it seems that the current SMMU ARM code will clobber
those AMBA attributes when it uses stage1 mappings, since it forces
the memory attributes to WBWA for cache coherent devices.

So, as I pointed out in the commit log, the main difference between
x86 and other arches it that it can easily tolerate when NoSnoop is
non-functional.

> In general I would call these above sequence rather bogus and would
> prefer we could get rid of such antipatterns in the kernel and just use
> dma_alloc_attrs with DMA_ATTR_WRITECOMBINE if we want writecombine
> semantics.
>

Agreed.

> Until that happens we should just change the driver ifdefs to default
> the hacks to off and only enable them on setups where we 100%
> positively know that they actually work.  And document that fact
> in big fat comments.

Well, as I mentioned in my commit log as well, if we default to off
unless CONFIG_X86, we may break working setups on MIPS and Power where
the device is in fact non-cache coherent, and relies on this
'optimization' to get things working. The same could be true for
non-coherent ARM systems, hence my approach to disable this hack for
cache coherent devices on non-X86 only.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
