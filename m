Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE92C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:18:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D8D52083D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ORGKJBVO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CLuQwR3E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D8D52083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1lRLrNercspQgyHsftQ/gHFKgeFtFeGXEtlY2pZfKnM=; b=ORGKJBVO0KCdsf
	pXk1jyg1uRvHnp9IkvdhBCDOfAXqtFTIPyPOYdQgTCEm7RFCxkMo2DnyBJHqjhWuKJAgeco4raQAz
	Ws4Z8lja7rfXVRNlvce6lzhDMi86UycapcTW7abNDR2H44WVJ8hyUbeBPTJjl8TeaDfA1WAt9Bhbm
	qoi3gADsZHUTt3/QAs6+INdmJI8MOxn6ghh3/aw9tiw5Fq7DikhUmQ4Od6VySQD8j1+rqgv5jxW4h
	Vz2XOdPI3QkqWR2q88ThjO/7N1Ubi/H9AKiTvEr3JSBiMQ1yZoTGSuW9qQeNLHppehZKbtnrIUTMm
	8tgP4dxEZTA0yxSIPhRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyjB3-0004x2-Ul; Tue, 26 Feb 2019 20:18:09 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyjAw-0004wc-Ul
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 20:18:09 +0000
Received: by mail-it1-x143.google.com with SMTP id 188so6273423itb.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 12:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KUJqFm7bapOsmvOqekZpLzhms9FmXcPzUHTm5FyDJTc=;
 b=CLuQwR3Ed633mmVZMUiFRvnSdAcVEMKnzumi6xjsFxeT5mFtn6Qb77mOiqZt+U80S9
 Hc0sXwqt1BuwJUNXe3guOxReaffLeIzvaPVwtpfh8DEv7C627sjuyS9qoeCWL2GqSvPf
 ECmd0DlCAb65q5+VD0rMVSCdSsaQBgmSxJ/KoW1/o/Wi7iqkTAXOqyKlfgLxEpJr6Cs9
 1NWh2ayJovBf+z5LGb4OiLYoLtz1ryVaTYdCeIX+LeVOTMp2iCOMvDbF3gD4kdGEUAlf
 Y4BeKU/ioAAWtIPthm2TMNHkUPsRayrjV39pNORfVWVtMInaVtCbM/HJGVbRsfN2s+QI
 QNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KUJqFm7bapOsmvOqekZpLzhms9FmXcPzUHTm5FyDJTc=;
 b=B5TbUoBGQjp0SxNZQhzWdAJ5X4+H9892pN1UwhfzLmMyj3UYaAM2vbC37mtKKHYumu
 A/ORnBgS4oBY9jynfx8lbzw6MCz1fW6tXGo3J8A3+vA9yCSn+YxIRH3GBoXrH8ydydYE
 k1wXfeHoB56anoPsisZtnpqB4Y08i6qzstGLUMw9633I1feHt3txyk71ctSgAMXhfs5X
 WEDkyODM8XjTTMrDYFtU+NU6sLEO8aYFQfwiyMW/51y72btAsbyGE1WZhTGIcjXjYot2
 vm3+9MbuHE1Jc+jhRKl3VGhJljte9c266IXmpFwg9gth6WGPtEy+rO5icPbWdD1FDAAm
 Qe1w==
X-Gm-Message-State: AHQUAuZZh5ezG29KTwQmPjXwKWypP/50N62Q/A+/6xSkaeOKfrNnTkJl
 1PMrKVAsrWKUSRKk2Yw9FmewRvQSBcBRtcxKEHdtHQ==
X-Google-Smtp-Source: AHgI3Ibrmx3uACYdFSzYcmJhR8g3jyq8ln7Aqfanorn14YBwN0wruMgTKbVrRd1atNtr/1/eabg9kaJHrzXqkYFac9Y=
X-Received: by 2002:a24:1947:: with SMTP id b68mr3168484itb.121.1551212281484; 
 Tue, 26 Feb 2019 12:18:01 -0800 (PST)
MIME-Version: 1.0
References: <20190218170245.14915-1-steve.capper@arm.com>
 <CAKv+Gu_xOFXLwKsrFo-rBXdgk4O6zm6xPHB+tv1XjDjzyrjhEA@mail.gmail.com>
 <20190219124825.GH8501@fuggles.cambridge.arm.com>
 <CAKv+Gu-xp06XTvQfwNpCMNej4MLmPZ-borA6oq60+A9XXV6k_g@mail.gmail.com>
 <20190219130138.GI8501@fuggles.cambridge.arm.com>
 <CAKv+Gu9qLiGDfT+yC2-pLhzepYNOfvJ4Squjgmy6u-t3HCJrAw@mail.gmail.com>
 <20190219135640.GA15458@capper-debian.cambridge.arm.com>
 <CAKv+Gu82_vmeztgCe_y5+pXR27CRUzWBszk+ZEmxXZw9zpRNtA@mail.gmail.com>
 <20190226173007.GA1553@capper-debian.cambridge.arm.com>
In-Reply-To: <20190226173007.GA1553@capper-debian.cambridge.arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 26 Feb 2019 21:17:49 +0100
Message-ID: <CAKv+Gu9J6+4rNBJKF8kVpP96bgANR3ZiMuOcvYLYCPEy-PkUDg@mail.gmail.com>
Subject: Re: [PATCH 0/9] 52-bit kernel + user VAs
To: Steve Capper <Steve.Capper@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_121803_115430_5AC82C3B 
X-CRM114-Status: GOOD (  47.29  )
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

On Tue, 26 Feb 2019 at 18:30, Steve Capper <Steve.Capper@arm.com> wrote:
>
> On Tue, Feb 19, 2019 at 05:18:18PM +0100, Ard Biesheuvel wrote:
> > On Tue, 19 Feb 2019 at 14:56, Steve Capper <Steve.Capper@arm.com> wrote:
> > >
> > > On Tue, Feb 19, 2019 at 02:15:26PM +0100, Ard Biesheuvel wrote:
> > > > On Tue, 19 Feb 2019 at 14:01, Will Deacon <will.deacon@arm.com> wrote:
> > > > >
> > > > > On Tue, Feb 19, 2019 at 01:51:51PM +0100, Ard Biesheuvel wrote:
> > > > > > On Tue, 19 Feb 2019 at 13:48, Will Deacon <will.deacon@arm.com> wrote:
> > > > > > >
> > > > > > > On Tue, Feb 19, 2019 at 01:13:32PM +0100, Ard Biesheuvel wrote:
> > > > > > > > On Mon, 18 Feb 2019 at 18:05, Steve Capper <steve.capper@arm.com> wrote:
> > > > > > > > >
> > > > > > > > > This patch series adds support for 52-bit kernel VAs using some of the
> > > > > > > > > machinery already introduced by the 52-bit userspace VA code in 5.0.
> > > > > > > > >
> > > > > > > > > As 52-bit virtual address support is an optional hardware feature,
> > > > > > > > > software support for 52-bit kernel VAs needs to be deduced at early boot
> > > > > > > > > time. If HW support is not available, the kernel falls back to 48-bit.
> > > > > > > > >
> > > > > > > > > A significant proportion of this series focuses on "de-constifying"
> > > > > > > > > VA_BITS related constants.
> > > > > > > > >
> > > > > > > > > In order to allow for a KASAN shadow that changes size at boot time, one
> > > > > > > > > must fix the KASAN_SHADOW_END for both 48 & 52-bit VAs and "grow" the
> > > > > > > > > start address. Also, it is highly desirable to maintain the same
> > > > > > > > > function addresses in the kernel .text between VA sizes. Both of these
> > > > > > > > > requirements necessitate us to flip the kernel address space halves s.t.
> > > > > > > > > the direct linear map occupies the lower addresses.
> > > > > > > > >
> > > > > > > > > One obvious omission is 52-bit kernel VA + 48-bit userspace VA which I
> > > > > > > > > can add with some more #ifdef'ery if needed.
> > > > > > > > >
> > > > > > > >
> > > > > > > > Hi Steve,
> > > > > > > >
> > > > > > > > Apologies if I am bringing up things that have been addressed
> > > > > > > > internally already. We discussed the 52-bit kernel VA work at
> > > > > > > > plumber's at some point, and IIUC, KASAN is the complicating factor
> > > > > > > > when it comes to having compile time constants for VA_BITS_MIN,
> > > > > > > > VA_BITS_MAX and PAGE_OFFSET, right?
> > > > > > > >
> > > > > > > > To clarify what I mean, please refer to the diagram below, which
> > > > > > > > describes a hybrid 48/52 kernel VA arrangement that does not rely on
> > > > > > > > runtime variable quantities. (VA_BITS_MIN == 48, VA_BITS_MAX == 52)
> > > > > > > >
> > > > > > > > +------------------- (~0) -------------------------+
> > > > > > > > |                                                |
> > > > > > > > |            PCI IO / fixmap spaces              |
> > > > > > > > |                                                |
> > > > > > > > +------------------------------------------------+
> > > > > > > > |                                                |
> > > > > > > > |             kernel/vmalloc space               |
> > > > > > > > |                                                |
> > > > > > > > +------------------------------------------------+
> > > > > > > > |                                                |
> > > > > > > > |                module space                    |
> > > > > > > > |                                                |
> > > > > > > > +------------------------------------------------+
> > > > > > > > |                                                |
> > > > > > > > |                BPF space                       |
> > > > > > > > |                                                |
> > > > > > > > +------------------------------------------------+
> > > > > > > > |                                                |
> > > > > > > > |                                                |
> > > > > > > > |   vmemmap space (size based on VA_BITS_MAX)    |
> > > > > > > > |                                                |
> > > > > > > > |                                                |
> > > > > > > > +-- linear/vmalloc split based on VA_BITS_MIN -- +
> > > > > > > > |                                                |
> > > > > > > > |    linear mapping (48 bit addressable region)  |
> > > > > > > > |                                                |
> > > > > > > > +------------------------------------------------+
> > > > > > > > |                                                |
> > > > > > > > |    linear mapping (52 bit addressable region)  |
> > > > > > > > |                                                |
> > > > > > > > +------ PAGE_OFFSET based on VA_BITS_MAX --------+
> > > > > > > >
> > > > > > > > Since KASAN is what is preventing this, would it be acceptable for
> > > > > > > > KASAN to only be supported when you use a true 48 bit or a true 52 bit
> > > > > > > > configuration, and disable it for the 48/52 hybrid configuration?
> > > > > > > >
> > > > > > > > Just thinking out loud (and in ASCII art :-))
> > > > > > >
> > > > > > > TBH, if we end up having support for 52-bit kernel VA, I'd be inclined to
> > > > > > > drop the 48/52 configuration altogether. But Catalin's on holiday at the
> > > > > > > moment, and may have a different opinion ;)
> > > > > > >
> > > > > >
> > > > > > But that implies that you cannot have an image that supports 52-bit
> > > > > > kernel VAs but can still boot on hardware that does not implement
> > > > > > support for it. If that is acceptable, then none of this hoop jumping
> > > > > > that Steve is doing in these patches is necessary to begin with,
> > > > > > right?
> > > > >
> > > > > Sorry, I misunderstood what you meant by a "48/52 hybrid configuration". I
> > > > > thought you were referring to the configuration where userspace is 52-bit
> > > > > and the kernel is 48-bit, which is something I think we can drop if we gain
> > > > > support for 52-bit kernel.
> > > > >
> > > > > Now that I understand what you mean, I think disabling KASAN would be fine
> > > > > as long as it's a runtime thing and the kernel continues to work in every
> > > > > other respect.
> > > > >
> > > >
> > > > No, it would be a limitation of the 52-bit config which also supports
> > > > 48-bit-VA-only-h/w that the address space is laid out in such a way
> > > > that there is simply no room for the KASAN shadow region, since it
> > > > would have to live in the 48-bit addressable area, but be big enough
> > > > to cover 52 bits of VA, which is impossible.
> > > >
> > > > For the vmemmap space, we could live with sizing it statically to
> > > > cover a 52-bit VA linear region, but the KASAN shadow region is simply
> > > > too big.
> > > >
> > > > So if KASAN support in that configuration is a requirement, then I
> > > > agree with Steve's approach, but it does imply that quite a number of
> > > > formerly compile-time constants now get turned into runtime variables.
> > > >
> > > > Steve, do you have any idea what the impact of that is?
> > >
> > > Hi Guys,
> > >
> > > The KASAN region only really necessitates two things: 1) that we think
> > > about the end address of the region (which is invariant) rather than the
> > > start address; and that 2) we flip the kernel VA space. IIUC both these
> > > changes have a neglible perf impact.
> > >
> > > As for VA_BITS_ACTUAL, we need this in a few places: KVM mapping
> > > support, and the big one phys_to/from_virt. For phys_to/from_virt the
> > > logic is changed s.t. we use a variable lookup for translation but this
> > > is folded into a new variable physvirt_offset (before the patch we used
> > > a single variable read too).
> > >
> > > Again IIUC there should be a minimal perf impact (unless one tries to do
> > > cat /sys/kernel/debug/kernel_page_tables with KASAN enabled - but that
> > > can be optimised later).
> > >
> > > I didn't have the patience for ASCII art ;-), but I have a picture of
> > > what I think it looks like here:
> > > https://s3.amazonaws.com/connect.linaro.org/yvr18/presentations/yvr18-119.pdf
> > > What I've tried to do is have most parts of the kernel VA space
> > > invariant between 48/52 bits. If it's helpful I can type this up into a
> > > document/commit log message?
> > >
> > > For this series I have tried to introduce VA_BITS_MIN in its own patch
> > > and also VA_BITS_ACTUAL into its own patch to make it easier to follow.
> > >
>
> Hi Ard,
>
> Apologies for my late reply, I had been staring at this for a while.
>
> >
> > OK, perhaps I am just rephrasing what you essentially implemented
> > already, but let me try to explain a bit better what I mean:
> >
> > - we flip the VA space in the way you suggest
> > - we limit the size of the top half of the address space to 47 bits
> > - KASAN region growns downwards from (~0) << 47
> > - we define PAGE_OFFSET as (~0) << 52, regardless of whether the h/w
> > supports LVA or not
> > - however, we tweak the phys/virt translation so that memory appears
> > in the 48-bit addressable part of the linear region on non-LVA
> > hardware
> >
> > The latter basically means that the KASAN shadow region will intersect
> > the linear region, but whether we map memory or shadow pages there
> > depends on the h/w config at runtime.
> >
> > The heart of the matter is probably the different placement of the
> > memory inside the linear region, depending on whether the h/w is LVA
> > capable or not, which is also reflected in your physvirt_offset. I am
> > just trying to figure out why we need VA_BITS_ACTUAL to be a runtime
> > variable.
>
> Currently the direct linear map between configurations does not overlap,
> we have:
>
> FFF00000_00000000 - Direct linear map start (52-bit)
> FFF80000_00000000 - Direct linear map end (52-bit)
> FFFF0000_00000000 - Direct linear map start (48-bit)
> FFFF8000_00000000 - Direct linear map end (48-bit)
>
> We *can* make PAGE_OFFSET a constant for both 48/52 bit VA_BITS, if we
> offset it. vmemmap can then be adjusted on early boot to ensure that
> everything points to the right place. However we will get overlap for
> 52-bit configurations between KASAN and the direct linear map.
>
> The question is: are we okay with quite a large overlap?
>
> The KASAN region begins on 0xFFFDA000_00000000 for 52-bit. If we wish to
> employ a "full" 47-bit direct linear map on 48-bit systems we need a
> PAGE_OFFSET of 0xFFF78000_00000000 in order to make the direct linear
> map end addresses "match up" between 48/52 bit configurations.
>
> This doesn't leave us with a lot of room for 52-bit configurations
> though, if KASAN is enabled.
>

OK, so with actual numbers, what I had in mind was


FFF00000_00000000  start of 52-bit addressable linear region | PAGE_OFFSET

FFFD8000_00000000  start of KASAN shadow region | KASAN_SHADOW_OFFSET

FFFF0000_00000000  start of 48-bit addressable linear region

FFFF6000_00000000  start of used KASAN shadow region (48-bit VA)
                   (KASAN_SHADOW_OFFSET + F0000_00000000 >> 3)

FFFF8000_00000000  start of vmemmap area - end of KASAN shadow region

FFFF8200_00000000  end of vmemmap area - start of bpf/module/etc area


The trick is that the full (52 - 3) bits KASAN shadow space overlaps
with the 48-bit linear region, but since you don't need KASAN shadow
pages for memory that does not exist, the region FFFF0000_00000000 -
FFFF6000_00000000 can be used for mapping the memory in case the h/w
is 48-bit only.

So in this case, PAGE_OFFSET and KASAN_SHADOW_OFFSET remain compile
time constants, and as long as we don't attempt to map anything
outside of the 48-bit addressable area on h/w that does not support
it, the fact that those quantities are outside the 48-bit range does
not really matter.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
