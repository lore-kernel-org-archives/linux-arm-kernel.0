Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146A8C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:52:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3B3F204EC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LRVTF3lQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FmA6MWAX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3B3F204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4J0VEZ2r83ts/Mqd5AwyA9Uetr09IzF2uICTGCV9Ceo=; b=LRVTF3lQLtmmsN
	a2R7abyJROKvK4o17Nlxc7h49xWKrQrqkMc2FHegtM1R7NRKD5VOlQkbie4isx9mc6T62cwHuZ5J0
	qGDZxuXQDloSppV/LfxqfyTllASD6LQoxPsi5Clpka6eFl5TCXrnQzoewdlqTRkl/fvEkI+x91FuI
	9/n7y2Xz/ezp2BAUb9o90K6eWuuzLfJWGzZWBFHkKVkX/b2VZB8Z5h/cbCnQuB8TELOiZ3K0IcO2u
	0QR/2493FdCCV7TWGqa0ICl8IMkONJpVx4TsUt0xTne+O18S+8oFEkkud8tRcN9P9zts9ru2fIN91
	u/7luhfCLYuCOt9+G+/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw4sa-0000Wo-17; Tue, 19 Feb 2019 12:52:08 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw4sW-0000WA-2D
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 12:52:05 +0000
Received: by mail-it1-x142.google.com with SMTP id h6so5862985itl.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 04:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wCdMOOx1XOm3gHZ9Uh3MAuXi1gpKlWcNxdUY0sx0MGA=;
 b=FmA6MWAX2LLst07XVunE+QusIFBtapZ6XIE/2DmMv0eRLcwi4ear29BsDXRkxfHxKs
 Qtg2sIqPH+3mX8MPsdXSDcTAz1IiktMTonPhJlLuTvVPPqKOjf7OyDGNFma2ex+6Jn3b
 /sFZUq8qxxy+5rjmUx8pGF1yVZHDyugiOE+6tWlMObvYvi5PBlhRs/QoTqNNWCohaqeO
 XhN4eO0NgoDH2RTgCswIa9w/TQT40+RlSpLE3+UiwGtoXhPSIG61s1bon1r5sAbQ48pQ
 OAnWnjpSSornmPU6CBuy8Rg28fXQFn/OSdRuNTBZrO4i4bFTMTJcLtJMDgkmvtIVYvjS
 YMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wCdMOOx1XOm3gHZ9Uh3MAuXi1gpKlWcNxdUY0sx0MGA=;
 b=tKIq6+YhwRJZBYokceXd/GtZnxXm+PSPfbOSNf0uxkOAPxy+RbfieYofN4DygcAIq+
 2SRbOYLjpMoOXu9uPWu22+ssw6aSQ4LbsWEllum9h4KyoNp4eF/MYh3tV5NAQGjVkkQF
 ZlugyDYUYCN0j20kqBELrPO4XJtDKC9AG7X1EN/95kMTsfbdHWLB993WLkNqFDilGFbS
 b7uz6vVjuLs4fCGn9gWaaEAVV7rzbsgGFV5ftTRNhbHs9BEH/s+HdjmEGWu/AA7Uda5l
 /NceFUYzLWqId59YwOW3ib0B7Cbgv57bOS0e+ZUIg+hd5/GiMgiaAn8c8Wmu0glwRJn+
 nAuw==
X-Gm-Message-State: AHQUAuYTE2nwdfs3Jj6XzamfWeYbxCHJkZL3hfRjkOW2Qj/BAXR+HhzT
 vwr8zvJRIoQeSceY0gHr3awH3Rt5LLMjffLwAuWu8g==
X-Google-Smtp-Source: AHgI3IbPbgW2Yj+7N9OcTLCZZD02SeCt2jKfZaGUVImcwHsIn8H+bfoUvzR1moq9BS46bBNQatyvkUk15EJgqKYfbBg=
X-Received: by 2002:a24:45dd:: with SMTP id c90mr2205808itd.71.1550580722986; 
 Tue, 19 Feb 2019 04:52:02 -0800 (PST)
MIME-Version: 1.0
References: <20190218170245.14915-1-steve.capper@arm.com>
 <CAKv+Gu_xOFXLwKsrFo-rBXdgk4O6zm6xPHB+tv1XjDjzyrjhEA@mail.gmail.com>
 <20190219124825.GH8501@fuggles.cambridge.arm.com>
In-Reply-To: <20190219124825.GH8501@fuggles.cambridge.arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 19 Feb 2019 13:51:51 +0100
Message-ID: <CAKv+Gu-xp06XTvQfwNpCMNej4MLmPZ-borA6oq60+A9XXV6k_g@mail.gmail.com>
Subject: Re: [PATCH 0/9] 52-bit kernel + user VAs
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_045204_230312_C479B4C8 
X-CRM114-Status: GOOD (  27.10  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, crecklin@redhat.com,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Steve Capper <steve.capper@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 19 Feb 2019 at 13:48, Will Deacon <will.deacon@arm.com> wrote:
>
> On Tue, Feb 19, 2019 at 01:13:32PM +0100, Ard Biesheuvel wrote:
> > On Mon, 18 Feb 2019 at 18:05, Steve Capper <steve.capper@arm.com> wrote:
> > >
> > > This patch series adds support for 52-bit kernel VAs using some of the
> > > machinery already introduced by the 52-bit userspace VA code in 5.0.
> > >
> > > As 52-bit virtual address support is an optional hardware feature,
> > > software support for 52-bit kernel VAs needs to be deduced at early boot
> > > time. If HW support is not available, the kernel falls back to 48-bit.
> > >
> > > A significant proportion of this series focuses on "de-constifying"
> > > VA_BITS related constants.
> > >
> > > In order to allow for a KASAN shadow that changes size at boot time, one
> > > must fix the KASAN_SHADOW_END for both 48 & 52-bit VAs and "grow" the
> > > start address. Also, it is highly desirable to maintain the same
> > > function addresses in the kernel .text between VA sizes. Both of these
> > > requirements necessitate us to flip the kernel address space halves s.t.
> > > the direct linear map occupies the lower addresses.
> > >
> > > One obvious omission is 52-bit kernel VA + 48-bit userspace VA which I
> > > can add with some more #ifdef'ery if needed.
> > >
> >
> > Hi Steve,
> >
> > Apologies if I am bringing up things that have been addressed
> > internally already. We discussed the 52-bit kernel VA work at
> > plumber's at some point, and IIUC, KASAN is the complicating factor
> > when it comes to having compile time constants for VA_BITS_MIN,
> > VA_BITS_MAX and PAGE_OFFSET, right?
> >
> > To clarify what I mean, please refer to the diagram below, which
> > describes a hybrid 48/52 kernel VA arrangement that does not rely on
> > runtime variable quantities. (VA_BITS_MIN == 48, VA_BITS_MAX == 52)
> >
> > +------------------- (~0) -------------------------+
> > |                                                |
> > |            PCI IO / fixmap spaces              |
> > |                                                |
> > +------------------------------------------------+
> > |                                                |
> > |             kernel/vmalloc space               |
> > |                                                |
> > +------------------------------------------------+
> > |                                                |
> > |                module space                    |
> > |                                                |
> > +------------------------------------------------+
> > |                                                |
> > |                BPF space                       |
> > |                                                |
> > +------------------------------------------------+
> > |                                                |
> > |                                                |
> > |   vmemmap space (size based on VA_BITS_MAX)    |
> > |                                                |
> > |                                                |
> > +-- linear/vmalloc split based on VA_BITS_MIN -- +
> > |                                                |
> > |    linear mapping (48 bit addressable region)  |
> > |                                                |
> > +------------------------------------------------+
> > |                                                |
> > |    linear mapping (52 bit addressable region)  |
> > |                                                |
> > +------ PAGE_OFFSET based on VA_BITS_MAX --------+
> >
> > Since KASAN is what is preventing this, would it be acceptable for
> > KASAN to only be supported when you use a true 48 bit or a true 52 bit
> > configuration, and disable it for the 48/52 hybrid configuration?
> >
> > Just thinking out loud (and in ASCII art :-))
>
> TBH, if we end up having support for 52-bit kernel VA, I'd be inclined to
> drop the 48/52 configuration altogether. But Catalin's on holiday at the
> moment, and may have a different opinion ;)
>

But that implies that you cannot have an image that supports 52-bit
kernel VAs but can still boot on hardware that does not implement
support for it. If that is acceptable, then none of this hoop jumping
that Steve is doing in these patches is necessary to begin with,
right?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
