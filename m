Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1693FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:15:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D95E621736
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z43jWusY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V3i4d8qI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D95E621736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pG+6laphwxSm54NMrIKKeobjG4BrEnUCPzVZjT91F98=; b=Z43jWusYMHpFHH
	ZHu5sfAUmMXwXkbf6zKRpXU8+V7NtGZe43RN+UfOP22z6PXRwsN0Tn5vFfXyl8wQXdJc20kRzEyFb
	TScY6MywoUghccHlx7vuHaunlzICFIzK60mtwbmCNv6riHxKBdVb3AKaZT5cyz8StI/s8ZLCDyUna
	yTxpJ74F6CudPQEVuHLneVAW+9TDRyPGZOf9DLB+gQJ2RXnU20VQ8FhFtZXFRKuxxgEVH1h+Q3N4A
	wkc29IZHC7oSw9JXip4yci58dwqBP6SoOMRsVcLVKmI5hBThXgpauYMOUAY7tbyKI0rum6LlKabov
	2CmNpH/NmJvFrXO1slQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw5FO-0002o0-7u; Tue, 19 Feb 2019 13:15:42 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw5FK-0002nf-U9
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 13:15:40 +0000
Received: by mail-it1-x141.google.com with SMTP id i2so5963440ite.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 05:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5ZAiBJfMr1e3jv2AqbnrLwo9rY/3z0+Vb7cGGgBQokU=;
 b=V3i4d8qIZJLFqX87EyeN+XtXX5y4IMg3fKocp/BhYlDEnwPlhLu4+zWYjhTNbKj22P
 MTzoBkFlSUeQ4YHCD0Y5+adEQJ97D1a2/9L1q+/ZOT4CJ/I6DtopLuVnCrpjZio0/+yK
 y3EKC4Z0vtgIh/uePRBioI3TE3zH001JbjeIHQAhlqIjZcWvGuOAZehqiLL6NJLD5Ym7
 oJAnh8iFpFQfoMyr93grzNkGihtqFnIj06tUulJ29gYpwnpYF5bSv1CIxev+FBr5YkOk
 qzynQ79UO6UcrgtL6Ari2eTT9zlF23hWDZdKPS3nQ1PrpxJsUe7ICUGQvqfPzOI/949h
 t8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5ZAiBJfMr1e3jv2AqbnrLwo9rY/3z0+Vb7cGGgBQokU=;
 b=IBMxg3YKkcntZcg+QQCloWTrvU5Al12tVraTQZp6+T+3vgxBtAfkKHcd0Llvpjx4SY
 V8FOtJ4RfVA4Yz9fLUBCVm3yQUrznuKJk7S7O0Le98qtU6jjKyXOtxw3F3r/uF7N5bq5
 3zYioDG7mh+862uTouNG+3RLMq+H9I0WLwu7eq15CIa9oGq2VHLDTvaRyVWdnZeu+q18
 41C872aEWTtgzqX7H2QLwwddwdKA3UdoqgodY+XDjOViD3ti+9DUAQNudAAXMna1EOhy
 blERzUVAiZ9ZbSBdNeCjkJlsQ+lxgUPW+jC7iV7094TzYvUiw1LOBrqtRkRKXVAo17Um
 FUhg==
X-Gm-Message-State: AHQUAuZSsdFPsjjSsFUUTSBuPtwOwzy5T3gv4PO/0RrfqEyuxIrMnycp
 09eZlpHy3zAoYm//DCuf4g/UGJm9R/WPzLyfQCcwEA==
X-Google-Smtp-Source: AHgI3Iad9gAGS1j8FksLaQFkKwhxUTDyoEi8I45rGdjROB+c8nyqJVxhfvGFKF7ZlUcS8Q0R1pbOuvna3w5AZjyR+yo=
X-Received: by 2002:a5e:d609:: with SMTP id w9mr15920226iom.170.1550582137794; 
 Tue, 19 Feb 2019 05:15:37 -0800 (PST)
MIME-Version: 1.0
References: <20190218170245.14915-1-steve.capper@arm.com>
 <CAKv+Gu_xOFXLwKsrFo-rBXdgk4O6zm6xPHB+tv1XjDjzyrjhEA@mail.gmail.com>
 <20190219124825.GH8501@fuggles.cambridge.arm.com>
 <CAKv+Gu-xp06XTvQfwNpCMNej4MLmPZ-borA6oq60+A9XXV6k_g@mail.gmail.com>
 <20190219130138.GI8501@fuggles.cambridge.arm.com>
In-Reply-To: <20190219130138.GI8501@fuggles.cambridge.arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 19 Feb 2019 14:15:26 +0100
Message-ID: <CAKv+Gu9qLiGDfT+yC2-pLhzepYNOfvJ4Squjgmy6u-t3HCJrAw@mail.gmail.com>
Subject: Re: [PATCH 0/9] 52-bit kernel + user VAs
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_051538_979498_ED6527BD 
X-CRM114-Status: GOOD (  32.29  )
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

On Tue, 19 Feb 2019 at 14:01, Will Deacon <will.deacon@arm.com> wrote:
>
> On Tue, Feb 19, 2019 at 01:51:51PM +0100, Ard Biesheuvel wrote:
> > On Tue, 19 Feb 2019 at 13:48, Will Deacon <will.deacon@arm.com> wrote:
> > >
> > > On Tue, Feb 19, 2019 at 01:13:32PM +0100, Ard Biesheuvel wrote:
> > > > On Mon, 18 Feb 2019 at 18:05, Steve Capper <steve.capper@arm.com> wrote:
> > > > >
> > > > > This patch series adds support for 52-bit kernel VAs using some of the
> > > > > machinery already introduced by the 52-bit userspace VA code in 5.0.
> > > > >
> > > > > As 52-bit virtual address support is an optional hardware feature,
> > > > > software support for 52-bit kernel VAs needs to be deduced at early boot
> > > > > time. If HW support is not available, the kernel falls back to 48-bit.
> > > > >
> > > > > A significant proportion of this series focuses on "de-constifying"
> > > > > VA_BITS related constants.
> > > > >
> > > > > In order to allow for a KASAN shadow that changes size at boot time, one
> > > > > must fix the KASAN_SHADOW_END for both 48 & 52-bit VAs and "grow" the
> > > > > start address. Also, it is highly desirable to maintain the same
> > > > > function addresses in the kernel .text between VA sizes. Both of these
> > > > > requirements necessitate us to flip the kernel address space halves s.t.
> > > > > the direct linear map occupies the lower addresses.
> > > > >
> > > > > One obvious omission is 52-bit kernel VA + 48-bit userspace VA which I
> > > > > can add with some more #ifdef'ery if needed.
> > > > >
> > > >
> > > > Hi Steve,
> > > >
> > > > Apologies if I am bringing up things that have been addressed
> > > > internally already. We discussed the 52-bit kernel VA work at
> > > > plumber's at some point, and IIUC, KASAN is the complicating factor
> > > > when it comes to having compile time constants for VA_BITS_MIN,
> > > > VA_BITS_MAX and PAGE_OFFSET, right?
> > > >
> > > > To clarify what I mean, please refer to the diagram below, which
> > > > describes a hybrid 48/52 kernel VA arrangement that does not rely on
> > > > runtime variable quantities. (VA_BITS_MIN == 48, VA_BITS_MAX == 52)
> > > >
> > > > +------------------- (~0) -------------------------+
> > > > |                                                |
> > > > |            PCI IO / fixmap spaces              |
> > > > |                                                |
> > > > +------------------------------------------------+
> > > > |                                                |
> > > > |             kernel/vmalloc space               |
> > > > |                                                |
> > > > +------------------------------------------------+
> > > > |                                                |
> > > > |                module space                    |
> > > > |                                                |
> > > > +------------------------------------------------+
> > > > |                                                |
> > > > |                BPF space                       |
> > > > |                                                |
> > > > +------------------------------------------------+
> > > > |                                                |
> > > > |                                                |
> > > > |   vmemmap space (size based on VA_BITS_MAX)    |
> > > > |                                                |
> > > > |                                                |
> > > > +-- linear/vmalloc split based on VA_BITS_MIN -- +
> > > > |                                                |
> > > > |    linear mapping (48 bit addressable region)  |
> > > > |                                                |
> > > > +------------------------------------------------+
> > > > |                                                |
> > > > |    linear mapping (52 bit addressable region)  |
> > > > |                                                |
> > > > +------ PAGE_OFFSET based on VA_BITS_MAX --------+
> > > >
> > > > Since KASAN is what is preventing this, would it be acceptable for
> > > > KASAN to only be supported when you use a true 48 bit or a true 52 bit
> > > > configuration, and disable it for the 48/52 hybrid configuration?
> > > >
> > > > Just thinking out loud (and in ASCII art :-))
> > >
> > > TBH, if we end up having support for 52-bit kernel VA, I'd be inclined to
> > > drop the 48/52 configuration altogether. But Catalin's on holiday at the
> > > moment, and may have a different opinion ;)
> > >
> >
> > But that implies that you cannot have an image that supports 52-bit
> > kernel VAs but can still boot on hardware that does not implement
> > support for it. If that is acceptable, then none of this hoop jumping
> > that Steve is doing in these patches is necessary to begin with,
> > right?
>
> Sorry, I misunderstood what you meant by a "48/52 hybrid configuration". I
> thought you were referring to the configuration where userspace is 52-bit
> and the kernel is 48-bit, which is something I think we can drop if we gain
> support for 52-bit kernel.
>
> Now that I understand what you mean, I think disabling KASAN would be fine
> as long as it's a runtime thing and the kernel continues to work in every
> other respect.
>

No, it would be a limitation of the 52-bit config which also supports
48-bit-VA-only-h/w that the address space is laid out in such a way
that there is simply no room for the KASAN shadow region, since it
would have to live in the 48-bit addressable area, but be big enough
to cover 52 bits of VA, which is impossible.

For the vmemmap space, we could live with sizing it statically to
cover a 52-bit VA linear region, but the KASAN shadow region is simply
too big.

So if KASAN support in that configuration is a requirement, then I
agree with Steve's approach, but it does imply that quite a number of
formerly compile-time constants now get turned into runtime variables.

Steve, do you have any idea what the impact of that is?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
