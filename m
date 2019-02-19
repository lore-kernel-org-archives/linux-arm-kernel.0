Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B43C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:18:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECA242147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p4Yc+mOb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ktsv9md1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECA242147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Esujtq8azRHLHCDIej51GA/YgMZY1Vijfo+Mw7K5Zf0=; b=p4Yc+mObzxG4Ov
	TMcIDLALzfPW7VXLVA4800mxYCsfElzoBaOyHWKThsV8Fu0i7EzIVgHaTyYXIhhLBgz/wLMeCDs3w
	z6YQZYlMQJ9wwpsLjtzbqk6LwRYpajb6ewLTTcvFa9OYSCH0MtLOgya2s9da2pbXb5lTqa6ujwGta
	RzQ4nQtkXXIOCvSKe1VW2qinzhy0AE1mmemy8ozxyIahLryheVyz0Hdh2O0vy+citdnlsqkVdgiq8
	+cj1SlJl5+7ujvccTlCbuzUmqx6jEQDRKryFFA4jbGf+venwSUHraaO+RD1Gnxyo3b28/m7y034el
	iIN0q/FXkIDf/1oiRtPQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw86O-0008GS-3V; Tue, 19 Feb 2019 16:18:36 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw86K-0008G7-FH
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 16:18:34 +0000
Received: by mail-it1-x143.google.com with SMTP id l15so7518558iti.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 08:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bnTJd4mCCK+0Y3QbJw8kqJZAFpFDr+KR944bBUp80kg=;
 b=ktsv9md12WMWolVhfmDSy1Se+JsUOWlhFc4Uo/mZ4ARdBlCZ03Aq+ogE6Z4GOSmJDT
 6IhOG1Xo6FdbJgLjH7bGNmOLuMZ4wo3OyQ29uLlpaCz6vZ1zSjUY3aBReNvYDSsYImgp
 ZZxQPheBadnaSrxLwSrULW6pKHpn8vnttFtvbs8zthJguyQXO+/X8cN04lRiil+DhnsU
 rq22BnMDTw2rfqYCQlpmb8RvhfG0wWSN6aEbZPlNx/cFdgPemLFKFNe4oR0U1SN/Xg9u
 S5hMJjFc0YnWmc0ky9TZ5YEa5yXtyH+iLpy0/aHVsGQVcbO9FGxeyILXg67bh8bahAtJ
 HpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bnTJd4mCCK+0Y3QbJw8kqJZAFpFDr+KR944bBUp80kg=;
 b=XK17qVU/r8Vg883pSrM2GbZVKGt5NNgqGHv3ZjMVVxAYs1nOgYzqykOSbZUWFw+jB4
 ErI74+8V4ZCHJxiQFJjrUqWpE6rF03ujnx6//xRy66DR31D9tjKwdRjgjWD7jCDyEnS+
 X89kvDz5Y09jrypVgK6WMDM+xd6NcKbpiFHhLYCRjMSorC1WjMp31NUoG3FFTPBbcptY
 G4vu/0lu7kcNfLInnqXla6O4ZiNq89use2W6JCx9bZFgXER7NeCdCu4bCf3fKclq0B0v
 CEu1PeXxSZd4vlmAkczqKIHTzVsAV9YaGbbTrz6jlqBZY0dqjctyyZdwljOgkunwVymS
 W/IQ==
X-Gm-Message-State: AHQUAubpxygpowRcFFexBHJOMwvUprE2TpNdOLNYZbF3hCTwETsv2yXQ
 57SKuclv5sgACMOGNApK0S23EwVgSSAPrJgrXiTmXw==
X-Google-Smtp-Source: AHgI3IZ/lr43D41EVbJi6PNzMsD1EpmoimswMGWMmQIcdv7noE6Xc+rXTQWCxtRdA9D+lTlHW07XYk70S1619YXZiYY=
X-Received: by 2002:a24:56d0:: with SMTP id o199mr3025325itb.158.1550593111421; 
 Tue, 19 Feb 2019 08:18:31 -0800 (PST)
MIME-Version: 1.0
References: <20190218170245.14915-1-steve.capper@arm.com>
 <CAKv+Gu_xOFXLwKsrFo-rBXdgk4O6zm6xPHB+tv1XjDjzyrjhEA@mail.gmail.com>
 <20190219124825.GH8501@fuggles.cambridge.arm.com>
 <CAKv+Gu-xp06XTvQfwNpCMNej4MLmPZ-borA6oq60+A9XXV6k_g@mail.gmail.com>
 <20190219130138.GI8501@fuggles.cambridge.arm.com>
 <CAKv+Gu9qLiGDfT+yC2-pLhzepYNOfvJ4Squjgmy6u-t3HCJrAw@mail.gmail.com>
 <20190219135640.GA15458@capper-debian.cambridge.arm.com>
In-Reply-To: <20190219135640.GA15458@capper-debian.cambridge.arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 19 Feb 2019 17:18:18 +0100
Message-ID: <CAKv+Gu82_vmeztgCe_y5+pXR27CRUzWBszk+ZEmxXZw9zpRNtA@mail.gmail.com>
Subject: Re: [PATCH 0/9] 52-bit kernel + user VAs
To: Steve Capper <Steve.Capper@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_081832_525960_30CF3E35 
X-CRM114-Status: GOOD (  41.63  )
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
Cc: "crecklin@redhat.com" <crecklin@redhat.com>,
 Marc Zyngier <Marc.Zyngier@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>,
 Will Deacon <Will.Deacon@arm.com>, nd <nd@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 19 Feb 2019 at 14:56, Steve Capper <Steve.Capper@arm.com> wrote:
>
> On Tue, Feb 19, 2019 at 02:15:26PM +0100, Ard Biesheuvel wrote:
> > On Tue, 19 Feb 2019 at 14:01, Will Deacon <will.deacon@arm.com> wrote:
> > >
> > > On Tue, Feb 19, 2019 at 01:51:51PM +0100, Ard Biesheuvel wrote:
> > > > On Tue, 19 Feb 2019 at 13:48, Will Deacon <will.deacon@arm.com> wrote:
> > > > >
> > > > > On Tue, Feb 19, 2019 at 01:13:32PM +0100, Ard Biesheuvel wrote:
> > > > > > On Mon, 18 Feb 2019 at 18:05, Steve Capper <steve.capper@arm.com> wrote:
> > > > > > >
> > > > > > > This patch series adds support for 52-bit kernel VAs using some of the
> > > > > > > machinery already introduced by the 52-bit userspace VA code in 5.0.
> > > > > > >
> > > > > > > As 52-bit virtual address support is an optional hardware feature,
> > > > > > > software support for 52-bit kernel VAs needs to be deduced at early boot
> > > > > > > time. If HW support is not available, the kernel falls back to 48-bit.
> > > > > > >
> > > > > > > A significant proportion of this series focuses on "de-constifying"
> > > > > > > VA_BITS related constants.
> > > > > > >
> > > > > > > In order to allow for a KASAN shadow that changes size at boot time, one
> > > > > > > must fix the KASAN_SHADOW_END for both 48 & 52-bit VAs and "grow" the
> > > > > > > start address. Also, it is highly desirable to maintain the same
> > > > > > > function addresses in the kernel .text between VA sizes. Both of these
> > > > > > > requirements necessitate us to flip the kernel address space halves s.t.
> > > > > > > the direct linear map occupies the lower addresses.
> > > > > > >
> > > > > > > One obvious omission is 52-bit kernel VA + 48-bit userspace VA which I
> > > > > > > can add with some more #ifdef'ery if needed.
> > > > > > >
> > > > > >
> > > > > > Hi Steve,
> > > > > >
> > > > > > Apologies if I am bringing up things that have been addressed
> > > > > > internally already. We discussed the 52-bit kernel VA work at
> > > > > > plumber's at some point, and IIUC, KASAN is the complicating factor
> > > > > > when it comes to having compile time constants for VA_BITS_MIN,
> > > > > > VA_BITS_MAX and PAGE_OFFSET, right?
> > > > > >
> > > > > > To clarify what I mean, please refer to the diagram below, which
> > > > > > describes a hybrid 48/52 kernel VA arrangement that does not rely on
> > > > > > runtime variable quantities. (VA_BITS_MIN == 48, VA_BITS_MAX == 52)
> > > > > >
> > > > > > +------------------- (~0) -------------------------+
> > > > > > |                                                |
> > > > > > |            PCI IO / fixmap spaces              |
> > > > > > |                                                |
> > > > > > +------------------------------------------------+
> > > > > > |                                                |
> > > > > > |             kernel/vmalloc space               |
> > > > > > |                                                |
> > > > > > +------------------------------------------------+
> > > > > > |                                                |
> > > > > > |                module space                    |
> > > > > > |                                                |
> > > > > > +------------------------------------------------+
> > > > > > |                                                |
> > > > > > |                BPF space                       |
> > > > > > |                                                |
> > > > > > +------------------------------------------------+
> > > > > > |                                                |
> > > > > > |                                                |
> > > > > > |   vmemmap space (size based on VA_BITS_MAX)    |
> > > > > > |                                                |
> > > > > > |                                                |
> > > > > > +-- linear/vmalloc split based on VA_BITS_MIN -- +
> > > > > > |                                                |
> > > > > > |    linear mapping (48 bit addressable region)  |
> > > > > > |                                                |
> > > > > > +------------------------------------------------+
> > > > > > |                                                |
> > > > > > |    linear mapping (52 bit addressable region)  |
> > > > > > |                                                |
> > > > > > +------ PAGE_OFFSET based on VA_BITS_MAX --------+
> > > > > >
> > > > > > Since KASAN is what is preventing this, would it be acceptable for
> > > > > > KASAN to only be supported when you use a true 48 bit or a true 52 bit
> > > > > > configuration, and disable it for the 48/52 hybrid configuration?
> > > > > >
> > > > > > Just thinking out loud (and in ASCII art :-))
> > > > >
> > > > > TBH, if we end up having support for 52-bit kernel VA, I'd be inclined to
> > > > > drop the 48/52 configuration altogether. But Catalin's on holiday at the
> > > > > moment, and may have a different opinion ;)
> > > > >
> > > >
> > > > But that implies that you cannot have an image that supports 52-bit
> > > > kernel VAs but can still boot on hardware that does not implement
> > > > support for it. If that is acceptable, then none of this hoop jumping
> > > > that Steve is doing in these patches is necessary to begin with,
> > > > right?
> > >
> > > Sorry, I misunderstood what you meant by a "48/52 hybrid configuration". I
> > > thought you were referring to the configuration where userspace is 52-bit
> > > and the kernel is 48-bit, which is something I think we can drop if we gain
> > > support for 52-bit kernel.
> > >
> > > Now that I understand what you mean, I think disabling KASAN would be fine
> > > as long as it's a runtime thing and the kernel continues to work in every
> > > other respect.
> > >
> >
> > No, it would be a limitation of the 52-bit config which also supports
> > 48-bit-VA-only-h/w that the address space is laid out in such a way
> > that there is simply no room for the KASAN shadow region, since it
> > would have to live in the 48-bit addressable area, but be big enough
> > to cover 52 bits of VA, which is impossible.
> >
> > For the vmemmap space, we could live with sizing it statically to
> > cover a 52-bit VA linear region, but the KASAN shadow region is simply
> > too big.
> >
> > So if KASAN support in that configuration is a requirement, then I
> > agree with Steve's approach, but it does imply that quite a number of
> > formerly compile-time constants now get turned into runtime variables.
> >
> > Steve, do you have any idea what the impact of that is?
>
> Hi Guys,
>
> The KASAN region only really necessitates two things: 1) that we think
> about the end address of the region (which is invariant) rather than the
> start address; and that 2) we flip the kernel VA space. IIUC both these
> changes have a neglible perf impact.
>
> As for VA_BITS_ACTUAL, we need this in a few places: KVM mapping
> support, and the big one phys_to/from_virt. For phys_to/from_virt the
> logic is changed s.t. we use a variable lookup for translation but this
> is folded into a new variable physvirt_offset (before the patch we used
> a single variable read too).
>
> Again IIUC there should be a minimal perf impact (unless one tries to do
> cat /sys/kernel/debug/kernel_page_tables with KASAN enabled - but that
> can be optimised later).
>
> I didn't have the patience for ASCII art ;-), but I have a picture of
> what I think it looks like here:
> https://s3.amazonaws.com/connect.linaro.org/yvr18/presentations/yvr18-119.pdf
> What I've tried to do is have most parts of the kernel VA space
> invariant between 48/52 bits. If it's helpful I can type this up into a
> document/commit log message?
>
> For this series I have tried to introduce VA_BITS_MIN in its own patch
> and also VA_BITS_ACTUAL into its own patch to make it easier to follow.
>

OK, perhaps I am just rephrasing what you essentially implemented
already, but let me try to explain a bit better what I mean:

- we flip the VA space in the way you suggest
- we limit the size of the top half of the address space to 47 bits
- KASAN region growns downwards from (~0) << 47
- we define PAGE_OFFSET as (~0) << 52, regardless of whether the h/w
supports LVA or not
- however, we tweak the phys/virt translation so that memory appears
in the 48-bit addressable part of the linear region on non-LVA
hardware

The latter basically means that the KASAN shadow region will intersect
the linear region, but whether we map memory or shadow pages there
depends on the h/w config at runtime.

The heart of the matter is probably the different placement of the
memory inside the linear region, depending on whether the h/w is LVA
capable or not, which is also reflected in your physvirt_offset. I am
just trying to figure out why we need VA_BITS_ACTUAL to be a runtime
variable.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
