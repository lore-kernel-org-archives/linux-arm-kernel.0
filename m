Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C45BC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:59:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CD372084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mbKKrL6b";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eCCiazMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CD372084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nX7q4qeUt9MxAlVQr5dsSLUQykn1evSywHPNpYBAAPY=; b=mbKKrL6bt8jymV
	6hK845QMC1gRCfX60RPexIWik+6U9nvcJJMhdgOp72Qc3DjkJuVniak7p2nSxnYzEP4Q2BAdFeRAy
	ueYjAmL+M2tU38wWFuDRmJ36b9OHxLwKx7IoRh5yixGdk3ZELUVlZWCqi4ZA87zZxXNK0bffeZMVb
	CrqNlDxYisYwPX9KCz/8mnvKwkpHbIHJTrd0Cgr+omplqA0CYwhfnWmTePmzITsv4+fLsKzgIUNOs
	25pTtRHk92REgUIKQsy5VkHF3QH3e7vTSeBYZR2EDZg/RDRlyu1nhXboXXNpDfQwiy1m4FHpQExaA
	aapr5veGaJrtLLCCs5RA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmbnF-0004sW-Ti; Thu, 24 Jan 2019 09:59:29 +0000
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmbnB-0004rY-Oa
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 09:59:27 +0000
Received: by mail-io1-xd44.google.com with SMTP id x6so4190272ioa.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 01:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fgHKcL4xdEEMdad/2NT2cQ+H43LUktLRBTulol45+Sk=;
 b=eCCiazMjq7/07kICz8IwPTyJTMqXPwJMtqE8vpKF7LI/lwkPiv9cjb1J21vQBX+IpU
 CRF9j1wgxveHdq8CxxvhByrD3ugUOA5Wu5KosryVUd6ZVU6NrwadNXgAQmLlLbVHhtwu
 oRiHjxN66xO8L58vlNB3+RyEWC4gSus9qnde8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fgHKcL4xdEEMdad/2NT2cQ+H43LUktLRBTulol45+Sk=;
 b=qZ7SLSoXyxcFeKL/0CbNTsB5P+D4UuyyTNRylXiqeOdPr5yaAdefuSP3nK4Zrn9xKs
 +mh1szSUYKyoatYnoCiec9OXpXrlnqxpn/KK7kJYw1tZnpuCBQB5NjebZcGMw0EcaE+l
 Y/MY9yS6x3vtRBw4x3GSfuVBhOMY6y8R3XSg9SnzTRVTDC6eyAa84LcDcemJWmxxJcxP
 zdQc56kJhsiNAxo74O/ijVG2uwgLZeXGPtLXxbjI1KVKg3f+6o4uy8XkCSu9r8JlyThV
 kY1G0+Eqy58yK3xffZGrOJqRhRAihsT+KufONWRQESrNSCi3WGKvTbMrAaigVRDTiUHM
 ZC1w==
X-Gm-Message-State: AHQUAub23fbu5Tr+QxuhJd+P6H0UvCJqlhuGlDX+AciwKVG20g4xUXQ4
 iTwcJwgtsV03sNoWRZtWlBvGDG1PFomZnV1kdpXx0Q==
X-Google-Smtp-Source: AHgI3IboMLH50JXLBxqx/0QHm2NseMFH4XozkT2ZHKt7OTu6e99I1fTYb95pyT9TrmPvPhv8CEGlbnPwMuHD/6cCLDc=
X-Received: by 2002:a5e:c206:: with SMTP id v6mr3565776iop.60.1548323964752;
 Thu, 24 Jan 2019 01:59:24 -0800 (PST)
MIME-Version: 1.0
References: <850b6aee-0040-c333-b125-45211c18ada5@daenzer.net>
 <CAKv+Gu99zHqcQtj6TiOXAr3Qa6WWhKem+DHVA_mAQ0-Bc0Vbqw@mail.gmail.com>
 <047667fd-17be-1c37-5d2a-26768cfd6ab8@daenzer.net>
 <CAKv+Gu_VBd8agHASc5RS0eCgyXP64Lt_i4yPuBjKwGQ+5Lpd5Q@mail.gmail.com>
 <CADnq5_O1uxCrSksfF127AZTfbmdukxmqGdh2Ee0zM6CqgG_Mhg@mail.gmail.com>
 <CAKv+Gu-4uYh_HD_5Ry_L80Nf5zpRhT4oJYhhG5_8g3gSzBs2tg@mail.gmail.com>
 <20190123071521.GB20526@infradead.org>
 <CAKv+Gu8+77uZHJ6ZYjGNcKQL8C3cT5Ree+TcTVmkQXAHV-ADyg@mail.gmail.com>
 <20190123164428.GA9367@infradead.org>
 <CAKv+Gu-9vEKu8mG-o+-4M1ZcgZmTTJVfEdNS9R27AFX8P5sqyQ@mail.gmail.com>
 <20190124091316.GA22796@infradead.org>
 <bb559f74-4b1e-d5ee-74fb-b5dcd4a128cb@amd.com>
 <CAKv+Gu_3LurSN-6w1WijPfpJpc+Pgu0YTnwTfMrXMF3-AKAnJA@mail.gmail.com>
 <953e5e5f-5d47-d6df-40df-c8c94db5447f@amd.com>
In-Reply-To: <953e5e5f-5d47-d6df-40df-c8c94db5447f@amd.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 24 Jan 2019 10:59:13 +0100
Message-ID: <CAKv+Gu9umPEmB+wh54NOTYcQ14oxf7rwVAXgCqo7V2A+VwkqPA@mail.gmail.com>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
To: "Koenig, Christian" <Christian.Koenig@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_015925_797554_18F7069F 
X-CRM114-Status: GOOD (  23.79  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Zhang,
 Jerry" <Jerry.Zhang@amd.com>, Christoph Hellwig <hch@infradead.org>,
 David Airlie <airlied@linux.ie>, "Huang, Ray" <Ray.Huang@amd.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Alex Deucher <alexdeucher@gmail.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, Sean Paul <sean@poorly.run>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 24 Jan 2019 at 10:45, Koenig, Christian
<Christian.Koenig@amd.com> wrote:
>
> Am 24.01.19 um 10:28 schrieb Ard Biesheuvel:
> > On Thu, 24 Jan 2019 at 10:25, Koenig, Christian
> > <Christian.Koenig@amd.com> wrote:
> >> Am 24.01.19 um 10:13 schrieb Christoph Hellwig:
> >>> On Wed, Jan 23, 2019 at 05:52:50PM +0100, Ard Biesheuvel wrote:
> >>>> But my concern is that it seems likely that non-cache coherent
> >>>> implementations are relying on this hack as well. There must be a
> >>>> reason that this hack is only disabled for PowerPC platforms if they
> >>>> are cache coherent, for instance, and I suspect that that reason is
> >>>> that the hack is the only thing ensuring that the CPU mapping
> >>>> attributes match the device ones used for these buffers (the vmap()ed
> >>>> ones), whereas the rings and other consistent data structures are
> >>>> using the DMA API as intended, and thus getting uncached attributes in
> >>>> the correct way.
> >>> Dave, who added that commit is on Cc together with just about everyone
> >>> involved in the review chain.  Based on the previous explanation
> >>> that idea what we might want an uncached mapping for some non-coherent
> >>> architectures for this to work at all makes sense, but then again
> >>> the way to create those mappings is entirely architecture specific,
> >>> and also need a cache flushing before creating the mapping to work
> >>> properly.  So my working theory is that this code never properly
> >>> worked on architectures without DMA coherent for PCIe at all, but
> >>> I'd love to be corrected by concrete examples including an explanation
> >>> of how it actually ends up working.
> >> Cache coherency is mandatory for modern GPU operation.
> >>
> >> Otherwise you can't implement a bunch of the requirements of the
> >> userspace APIs.
> >>
> >> In other words the applications doesn't inform the driver that the GPU
> >> or the CPU is accessing data, it just does it and assumes that it works.
> >>
> > Wonderful!
> >
> > In that case, do you have any objections to the patch proposed by
> > Christoph above?
>
> Yeah, the patch of Christoph actually goes way to far cause we have
> reports that this works on a bunch of other architectures.
>
> E.g. X86 64bit, PowerPC (under some conditions) and some MIPS.
>

This is *exactly* my point the whole time.

The current code has

static inline bool drm_arch_can_wc_memory(void)
{
#if defined(CONFIG_PPC) && !defined(CONFIG_NOT_COHERENT_CACHE)
   return false;

which means the optimization is disabled *unless the system is
non-cache coherent*

So if you have reports that the optimization works on some PowerPC, it
must be non-cache coherent PowerPC, because that is the only place
where it is enabled in the first place.

> The only problematic here actually seems to be ARM, so you should
> probably just add an "#ifdef .._ARM return false;".
>

ARM/arm64 does not have a Kconfig symbol like
CONFIG_NOT_COHERENT_CACHE, so we can only disable it everywhere. If
there are non-coherent ARM systems that are currently working in the
same way as those non-coherent PowerPC systems, we will break them by
doing this.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
