Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD7CC282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:02:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EA6E2075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jtsphPyR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dycem5Iy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EA6E2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QA2N6fHuRRJ/N8vkqteRgx3yJVXBkUY9VwbxsQsW7rs=; b=jtsphPyRiDUvtX
	i8/xmXB5zAE51X2X278hGIO6iuTJu3PESK9qn3cBzqejVvi4BXNQ0UF+jBBAYlS5dsYsHL81KOpB2
	sjh3KbTypHfYuIhSoWu3O5BwdZgP3l7s5aGS6HAWawiowpCc1GQ+e2v0hPWeyPczz5PjgfAGyhpyE
	ZRmMLL7kZafb8fYyfpUTnoONwBpXPe830dCGb0XztKcxJwss/edUCrMyS9UwgZGpr1vlWvECceq1f
	ViUSyF1kx+XiYCVAWo0mWd9UK1rGbORnE51KO0B7DqbB/u0LBbd8TT2kkqhD4Dm+FRzfJC+k2+FMG
	btvqbYhtiBAdy92+ICjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtEyC-0003YT-Um; Mon, 11 Feb 2019 17:02:12 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtEy9-0003Xt-KN; Mon, 11 Feb 2019 17:02:11 +0000
Received: by mail-lf1-x141.google.com with SMTP id q11so8346602lfd.3;
 Mon, 11 Feb 2019 09:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UhMN5gACQr1+W4A8Ag5wPDh62RaNjK/ZgHm434PrC78=;
 b=Dycem5Iy15XhBFQsCdrlyR70cVYi8iEHdjbiM68ElBqd2AuRvAsNQVBPszRVGhzOes
 4ghWIEDaZJqjwIvPAoy9X2DP7JqHWi80tnUpOlPWlpZ1uM1s61kbY33b7oQI39GLLDGn
 E61Ey9sXAEhgkUTxWs3YjJn/cr2UtlFvIsMQptsivCA4qcu2lBVw1mBwHXi14ZhLqfZT
 llfzt7bn5yuGTsb/KDKH+rY6A+TOjuCAl9E0Djzyw3HMlvO3y65at592q5FsX1KdRYDL
 KORq40gRwIB8Akjia616vJ//3AM1qSrbGnqfQtj9Zf7Jn60umhLieOoHQwDpAo7mMfoP
 LsLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UhMN5gACQr1+W4A8Ag5wPDh62RaNjK/ZgHm434PrC78=;
 b=nJXSda7h/zDi22XYYcEVh3cytk16O7n/jDoFFV/On3ojP3qOMWVyUXKzheXWpj43SQ
 akyg3ZMIl2dIiqAsi2JqWA7jkzhRLXIMTXKCKQsgN8RLaQdSyXcoTTh7T25I0rfahjvA
 AuBD30sRJ+lRqFWQuwWoYO0RPpJ5s6NmcN79ZJ2qBa5fW6/ThKqWhBh4d6UtZA/peXJ+
 2oKqpB4zwPcGQKNY3hRjWThu/jcebN9BR/2XevB+XX7ihgCpP8l3uDor8Ypr5qGHB0uR
 /LAYqdN5Ftyn4mJ/8SBKEGNVs9NeZCjbaTx0Rl4i+Jrjjj2sZwVa98lnvWZMT3nnJm2g
 7aOg==
X-Gm-Message-State: AHQUAuZ7bZslBxVYJ4yCYg9zAPPEXcRGqirbO80udgL3VBOHVbQMbaEn
 rFxeDnFhrzv+eFe+z5NAneWA/K5Lx66lBhBRG44=
X-Google-Smtp-Source: AHgI3IalfbXEC0ubkiPvBEKZp244GmIb+2indUy8ujEZOIJyFGOHcxcPXDTtIiBWV4qDRv6rjSWWM0OTaxXYOKcGqoU=
X-Received: by 2002:ac2:4318:: with SMTP id l24mr631387lfh.75.1549904525499;
 Mon, 11 Feb 2019 09:02:05 -0800 (PST)
MIME-Version: 1.0
References: <20190131030812.GA2174@jordon-HP-15-Notebook-PC>
 <20190131083842.GE28876@rapoport-lnx>
 <CAFqt6za9xA_8OKiaaHXcO9go+RtPdjLY5Bz_fgQL+DZbermNhA@mail.gmail.com>
 <20190207164739.GX21860@bombadil.infradead.org>
 <CAFqt6zawBP5Yyy7nfoKz_6ugw8e4MVopvBaeKvaKoXcS-_oSNg@mail.gmail.com>
In-Reply-To: <CAFqt6zawBP5Yyy7nfoKz_6ugw8e4MVopvBaeKvaKoXcS-_oSNg@mail.gmail.com>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Mon, 11 Feb 2019 22:36:15 +0530
Message-ID: <CAFqt6zYGSn1dA8tdiH16Mq0bzkx5DmpUo+2RUZ0nTPm+nvZS7Q@mail.gmail.com>
Subject: Re: [PATCHv2 1/9] mm: Introduce new vm_insert_range and
 vm_insert_range_buggy API
To: Matthew Wilcox <willy@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_090209_704695_A3899EA4 
X-CRM114-Status: GOOD (  22.18  )
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

On Fri, Feb 8, 2019 at 10:52 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> On Thu, Feb 7, 2019 at 10:17 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Thu, Feb 07, 2019 at 09:19:47PM +0530, Souptick Joarder wrote:
> > > Just thought to take opinion for documentation before placing it in v3.
> > > Does it looks fine ?
> > >
> > > +/**
> > > + * __vm_insert_range - insert range of kernel pages into user vma
> > > + * @vma: user vma to map to
> > > + * @pages: pointer to array of source kernel pages
> > > + * @num: number of pages in page array
> > > + * @offset: user's requested vm_pgoff
> > > + *
> > > + * This allow drivers to insert range of kernel pages into a user vma.
> > > + *
> > > + * Return: 0 on success and error code otherwise.
> > > + */
> > > +static int __vm_insert_range(struct vm_area_struct *vma, struct page **pages,
> > > +                               unsigned long num, unsigned long offset)
> >
> > For static functions, I prefer to leave off the second '*', ie make it
> > formatted like a docbook comment, but not be processed like a docbook
> > comment.  That avoids cluttering the html with descriptions of internal
> > functions that people can't actually call.
> >
> > > +/**
> > > + * vm_insert_range - insert range of kernel pages starts with non zero offset
> > > + * @vma: user vma to map to
> > > + * @pages: pointer to array of source kernel pages
> > > + * @num: number of pages in page array
> > > + *
> > > + * Maps an object consisting of `num' `pages', catering for the user's
> >
> > Rather than using `num', you should use @num.
> >
> > > + * requested vm_pgoff
> > > + *
> > > + * If we fail to insert any page into the vma, the function will return
> > > + * immediately leaving any previously inserted pages present.  Callers
> > > + * from the mmap handler may immediately return the error as their caller
> > > + * will destroy the vma, removing any successfully inserted pages. Other
> > > + * callers should make their own arrangements for calling unmap_region().
> > > + *
> > > + * Context: Process context. Called by mmap handlers.
> > > + * Return: 0 on success and error code otherwise.
> > > + */
> > > +int vm_insert_range(struct vm_area_struct *vma, struct page **pages,
> > > +                               unsigned long num)
> > >
> > >
> > > +/**
> > > + * vm_insert_range_buggy - insert range of kernel pages starts with zero offset
> > > + * @vma: user vma to map to
> > > + * @pages: pointer to array of source kernel pages
> > > + * @num: number of pages in page array
> > > + *
> > > + * Similar to vm_insert_range(), except that it explicitly sets @vm_pgoff to
> >
> > But vm_pgoff isn't a parameter, so it's misleading to format it as such.
> >
> > > + * 0. This function is intended for the drivers that did not consider
> > > + * @vm_pgoff.
> > > + *
> > > + * Context: Process context. Called by mmap handlers.
> > > + * Return: 0 on success and error code otherwise.
> > > + */
> > > +int vm_insert_range_buggy(struct vm_area_struct *vma, struct page **pages,
> > > +                               unsigned long num)
> >
> > I don't think we should call it 'buggy'.  'zero' would make more sense
> > as a suffix.
>
> suffix can be *zero or zero_offset* whichever suits better.
>
> >
> > Given how this interface has evolved, I'm no longer sure than
> > 'vm_insert_range' makes sense as the name for it.  Is it perhaps
> > 'vm_map_object' or 'vm_map_pages'?
> >
>
> I prefer vm_map_pages. Considering it, both the interface name can be changed
> to *vm_insert_range -> vm_map_pages* and *vm_insert_range_buggy ->
> vm_map_pages_{zero/zero_offset}.
>
> As this is only change in interface name and rest of code remain same
> shall I post it in v3 ( with additional change log mentioned about interface
> name changed) ?
>
> or,
>
> It will be a new patch series ( with carry forward all the Reviewed-by
> / Tested-by on
> vm_insert_range/ vm_insert_range_buggy ) ?

Any suggestion on this minor query ?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
