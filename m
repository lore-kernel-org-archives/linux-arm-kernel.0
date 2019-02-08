Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6E8C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 05:22:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D832220863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 05:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Wmm725Tr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ug4sduE1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D832220863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GlbM0P8tlrSuRS4zOkcVvXRdYCyIKgciJ5Bn2ECNhB0=; b=Wmm725TrkXwYlJ
	owyUFIpYWoc7XLea2Rea1rhKYn6VOXM/JDoizC76gfhtxq0Ot/hsjZ3zx3TfQxhugJbiuzgC5FuFu
	lZWP2NDsELrLlGZF9/qvbek5FBPi9K5w4oxC2v4/1s0tAiqOZp0YJ8UO7OJ9rFCuP4NinooAzt7m+
	UdBLgK4GRPe+2BDwm6MLJ5+TJIhwObGjv72zPl4DziiEFdjJwqJG15K8qDWPHPo4yTHKH25MsFeQU
	sOuROwzpK9rPARNlZgbsQwsPO4KPnKxPo4uyvpP4ohG+Ow1OWsyg8YAMBU3cT46vwyE7Rivl89Gwq
	hC+rr08pvWlpoFwljYVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grycV-0003ro-I9; Fri, 08 Feb 2019 05:22:35 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grycR-0003rM-UL; Fri, 08 Feb 2019 05:22:33 +0000
Received: by mail-lf1-x142.google.com with SMTP id l10so1619922lfh.9;
 Thu, 07 Feb 2019 21:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oQ4Ilbn2E5O3fse3aFqgWsQmQAFvePOUeZWey4DXpkM=;
 b=ug4sduE1Nnl6Ucdd6kGSolkdKH1uWHus2x+U5KYf2iN2rOsM9HLP3WTOmtwRbzp/vU
 WmI7jBaiRmhbQxbwHIe1HKiSj7rT5Pv4oHUINwtri7G7ilhTP4D78Yq6vvJJUSwIrTRk
 2ZUDMC1PaOffK1wF+qWJhW3jgyxtid/rRRhQV+FwutdaTY+tC2WlM9hOb7ujI5dOg5DP
 EU9fmyUvSJJZv2KkRSduA90NhevjuS8YMcH4NWCpzE+PGCGGZkX1L5MalVS4z+wPl2v1
 T8K0xfLoY4zbiJwnBzc2QcYZ5ejUJufl/jXJiF3yK/Xx/zcNB2iHuxOECHTIDbBUCpMu
 3Lug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oQ4Ilbn2E5O3fse3aFqgWsQmQAFvePOUeZWey4DXpkM=;
 b=Cv2Jo/uACKD7qmIbgu0hRQxw7mU+Wk/Sf60UiervINlZDoVTERVC+vgYeN2pvi6veD
 xMHNVONmDJpHEjD7M9892Ogug+mOL+1jsTolkLFaIh0PtCcmsgTqGGam0VuHmmQ3pU1E
 v+NKrzicMOeAUYkQy7JnReq32Vu5G/1XBaxa2bJP/GIbzuYauXvvBygmYLF2z8XWFMTz
 wfdZ+pgVJJn/2DdZxTPSnqlmRINPNhcHoIq/AblsVb59/QwXr5jZcMChpC+proD0JOvq
 wObt5CN87wxyjzOUvcaP+ta0tOsYlA5W0ooLRVFImdDWzfbPYXDwKUX/flP5/VXTyVRb
 QwLA==
X-Gm-Message-State: AHQUAuZqC9kY2jRNr3ZN+hLndjRQk8qBjKx3Jzy+Yq7UDLeSpw2/qo76
 /5XVIg0weeZzSR4lai6C4VpBzFvb6w2MC45DgH0=
X-Google-Smtp-Source: AHgI3IYz0SkMlWyxEeQhmXaahAF/5quTQnuzAn7bE9wiMnoPq679b6hVT3lDwP3on5fiZwP5X0S2WjPjR8kO/5pnmkU=
X-Received: by 2002:ac2:5496:: with SMTP id t22mr1036162lfk.31.1549603349625; 
 Thu, 07 Feb 2019 21:22:29 -0800 (PST)
MIME-Version: 1.0
References: <20190131030812.GA2174@jordon-HP-15-Notebook-PC>
 <20190131083842.GE28876@rapoport-lnx>
 <CAFqt6za9xA_8OKiaaHXcO9go+RtPdjLY5Bz_fgQL+DZbermNhA@mail.gmail.com>
 <20190207164739.GX21860@bombadil.infradead.org>
In-Reply-To: <20190207164739.GX21860@bombadil.infradead.org>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Fri, 8 Feb 2019 10:52:16 +0530
Message-ID: <CAFqt6zawBP5Yyy7nfoKz_6ugw8e4MVopvBaeKvaKoXcS-_oSNg@mail.gmail.com>
Subject: Re: [PATCHv2 1/9] mm: Introduce new vm_insert_range and
 vm_insert_range_buggy API
To: Matthew Wilcox <willy@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_212231_999473_5CDDD697 
X-CRM114-Status: GOOD (  20.07  )
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
Cc: Michal Hocko <mhocko@suse.com>, Heiko Stuebner <heiko@sntech.de>,
 Peter Zijlstra <peterz@infradead.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
 linux1394-devel@lists.sourceforge.net,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, oleksandr_andrushchenko@epam.com,
 joro@8bytes.org, Russell King - ARM Linux <linux@armlinux.org.uk>,
 iommu@lists.linux-foundation.org, Mike Rapoport <rppt@linux.ibm.com>,
 airlied@linux.ie, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, treding@nvidia.com,
 linux-media@vger.kernel.org, Kees Cook <keescook@chromium.org>,
 pawel@osciak.com, Rik van Riel <riel@surriel.com>, rppt@linux.vnet.ibm.com,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, mchehab@kernel.org,
 iamjoonsoo.kim@lge.com, vbabka@suse.cz, Juergen Gross <jgross@suse.com>,
 hjc@rock-chips.com, xen-devel@lists.xen.org,
 Kyungmin Park <kyungmin.park@samsung.com>, stefanr@s5r6.in-berlin.de,
 Andrew Morton <akpm@linux-foundation.org>, robin.murphy@arm.com,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 7, 2019 at 10:17 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Feb 07, 2019 at 09:19:47PM +0530, Souptick Joarder wrote:
> > Just thought to take opinion for documentation before placing it in v3.
> > Does it looks fine ?
> >
> > +/**
> > + * __vm_insert_range - insert range of kernel pages into user vma
> > + * @vma: user vma to map to
> > + * @pages: pointer to array of source kernel pages
> > + * @num: number of pages in page array
> > + * @offset: user's requested vm_pgoff
> > + *
> > + * This allow drivers to insert range of kernel pages into a user vma.
> > + *
> > + * Return: 0 on success and error code otherwise.
> > + */
> > +static int __vm_insert_range(struct vm_area_struct *vma, struct page **pages,
> > +                               unsigned long num, unsigned long offset)
>
> For static functions, I prefer to leave off the second '*', ie make it
> formatted like a docbook comment, but not be processed like a docbook
> comment.  That avoids cluttering the html with descriptions of internal
> functions that people can't actually call.
>
> > +/**
> > + * vm_insert_range - insert range of kernel pages starts with non zero offset
> > + * @vma: user vma to map to
> > + * @pages: pointer to array of source kernel pages
> > + * @num: number of pages in page array
> > + *
> > + * Maps an object consisting of `num' `pages', catering for the user's
>
> Rather than using `num', you should use @num.
>
> > + * requested vm_pgoff
> > + *
> > + * If we fail to insert any page into the vma, the function will return
> > + * immediately leaving any previously inserted pages present.  Callers
> > + * from the mmap handler may immediately return the error as their caller
> > + * will destroy the vma, removing any successfully inserted pages. Other
> > + * callers should make their own arrangements for calling unmap_region().
> > + *
> > + * Context: Process context. Called by mmap handlers.
> > + * Return: 0 on success and error code otherwise.
> > + */
> > +int vm_insert_range(struct vm_area_struct *vma, struct page **pages,
> > +                               unsigned long num)
> >
> >
> > +/**
> > + * vm_insert_range_buggy - insert range of kernel pages starts with zero offset
> > + * @vma: user vma to map to
> > + * @pages: pointer to array of source kernel pages
> > + * @num: number of pages in page array
> > + *
> > + * Similar to vm_insert_range(), except that it explicitly sets @vm_pgoff to
>
> But vm_pgoff isn't a parameter, so it's misleading to format it as such.
>
> > + * 0. This function is intended for the drivers that did not consider
> > + * @vm_pgoff.
> > + *
> > + * Context: Process context. Called by mmap handlers.
> > + * Return: 0 on success and error code otherwise.
> > + */
> > +int vm_insert_range_buggy(struct vm_area_struct *vma, struct page **pages,
> > +                               unsigned long num)
>
> I don't think we should call it 'buggy'.  'zero' would make more sense
> as a suffix.

suffix can be *zero or zero_offset* whichever suits better.

>
> Given how this interface has evolved, I'm no longer sure than
> 'vm_insert_range' makes sense as the name for it.  Is it perhaps
> 'vm_map_object' or 'vm_map_pages'?
>

I prefer vm_map_pages. Considering it, both the interface name can be changed
to *vm_insert_range -> vm_map_pages* and *vm_insert_range_buggy ->
vm_map_pages_{zero/zero_offset}.

As this is only change in interface name and rest of code remain same
shall I post it in v3 ( with additional change log mentioned about interface
name changed) ?

or,

It will be a new patch series ( with carry forward all the Reviewed-by
/ Tested-by on
vm_insert_range/ vm_insert_range_buggy ) ?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
