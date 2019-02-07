Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D66EC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:03:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05BF2218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sLnnAayu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjiAT/gI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05BF2218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Or05rQLgVGnPmaZRltJAdY9F3Ze0K7fBNu+GDU9v/pE=; b=sLnnAayu7Nwvwj
	nWadKW9FN+amRdMpW1Ka3rkwr4a0s/Onm5CmSN1EXijK9SWFWvr0/Huq+96BkwBp5ukpjePYGaggW
	fFGojx959nFwZRM5oxVD7FJOarZZsQLRETp1zIhietVUz0/qLpMmA0tVA869jQB2fxoTFilVNh2xz
	6YiL/yxNHJp0VQ8YFskn6PWV95C1Z2RimRNG7f6KkVzTfP11iRnvjIB3Cubo/p5hC3l9SBwSQVj6u
	jXOMfbLhTqHOyXxS6+xjavzvZiVKp/EEl0gI143+x3Q1l0LPM6eelXr8rlTL2A66csRYQpd80HBT9
	feB/eyza5WqKR3kemdRg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grm8o-0002M5-5W; Thu, 07 Feb 2019 16:03:06 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grm8k-0002LZ-OP; Thu, 07 Feb 2019 16:03:04 +0000
Received: by mail-lj1-x243.google.com with SMTP id f24-v6so355069ljk.0;
 Thu, 07 Feb 2019 08:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XbhO6aTIpP/xPNM6je9v7tcpC/w9vjx4259+gRxRQwc=;
 b=GjiAT/gIsh5Mq6FaeJOcXRPVS+aPNNLKdv+19jCUnMwmRGIdhLqn3qDw/4sBtvN8Hh
 ju5PXYuad3zjRdl4YnH6xybt7cBkrbmeOnKARIuUOVU23QxAGpMC+Hdo6To4YYz20SdN
 KcTwZZWk54YH7U7nqUwLwSjiM9GATvQyhZUXP3zIoYmhVtPcGhqivpfFt5hrHNrlLnxo
 tIyWz8GH0zeVk4l5jxYZ+30lNxdS11GYkmxBwZke/ifmkSt1cGDnrqxpSjof3u8Ym6Qe
 fsNkAS4OqyhqNSBKMi847x/GuItYvXS/zeCBaX1OV5BcJ5lVqZztpXRUYwokbPHyzTQT
 Yr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XbhO6aTIpP/xPNM6je9v7tcpC/w9vjx4259+gRxRQwc=;
 b=pW5+VpNB602fAsfuHi7DKSb/3ZsIypXXNo4ZQigrMeA6410efSAq1TsDtunOp9r3XQ
 GCMrVnLltzIN4d7qTMAEudELOPIi+XH7ZzSvPXShBl3E43khzmr5sHtkkEIlgLlS3S8T
 HpfajWoIQhnkWcxfyXt8l+9kWPcgYWYaTiF8sm8wOmo7Cw4HOY5YnCImFHoIqhc9acVD
 JDDJqoS7TcPQrhuWDl86sOcvDjQyXvBHrKXTVehYycRO3QFXTInCuhoENWtb3BQsdoXE
 wQJsM0EfpsFvDEiLfh85cOGvCl26JiNZhSWnN7d5cbFFBEhRCs6rp9SP25Ce1azXTDhn
 DtgQ==
X-Gm-Message-State: AHQUAuZb9S8ts98Fp6CV3Tw8R7CIXaNPbtTxJupMUWmG5wf2TTHGvkw2
 MhVqViH+/lpPUC1dUICvHHUlGTX0zMf980r69Vs=
X-Google-Smtp-Source: AHgI3IaLErP6UQHRoJXwjaGn0+byhpg0FJEkJj8lu4LnRPheskg9h3w2v7B+w3vp6ap3L+ni8MOMEGmZGFdfVJFI55k=
X-Received: by 2002:a2e:858e:: with SMTP id
 b14-v6mr2729099lji.43.1549555380735; 
 Thu, 07 Feb 2019 08:03:00 -0800 (PST)
MIME-Version: 1.0
References: <20190131030812.GA2174@jordon-HP-15-Notebook-PC>
 <20190131083842.GE28876@rapoport-lnx>
 <CAFqt6za9xA_8OKiaaHXcO9go+RtPdjLY5Bz_fgQL+DZbermNhA@mail.gmail.com>
 <20190207155700.GA8040@rapoport-lnx>
In-Reply-To: <20190207155700.GA8040@rapoport-lnx>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Thu, 7 Feb 2019 21:37:08 +0530
Message-ID: <CAFqt6zbE0JD09ibp3jZ0rr5xp52SEK+Pi6pGMQwSp_=d0edy7g@mail.gmail.com>
Subject: Re: [PATCHv2 1/9] mm: Introduce new vm_insert_range and
 vm_insert_range_buggy API
To: Mike Rapoport <rppt@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_080302_791356_E00AB6C5 
X-CRM114-Status: GOOD (  16.19  )
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
 Matthew Wilcox <willy@infradead.org>, airlied@linux.ie,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 treding@nvidia.com, linux-media@vger.kernel.org,
 Kees Cook <keescook@chromium.org>, pawel@osciak.com,
 Rik van Riel <riel@surriel.com>, iommu@lists.linux-foundation.org,
 rppt@linux.vnet.ibm.com, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 mchehab@kernel.org, iamjoonsoo.kim@lge.com, vbabka@suse.cz,
 Juergen Gross <jgross@suse.com>, hjc@rock-chips.com, xen-devel@lists.xen.org,
 Kyungmin Park <kyungmin.park@samsung.com>, stefanr@s5r6.in-berlin.de,
 Andrew Morton <akpm@linux-foundation.org>, robin.murphy@arm.com,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 7, 2019 at 9:27 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> Hi Souptick,
>
> On Thu, Feb 07, 2019 at 09:19:47PM +0530, Souptick Joarder wrote:
> > Hi Mike,
> >
> > Just thought to take opinion for documentation before placing it in v3.
> > Does it looks fine ?
>
> Overall looks good to me. Several minor points below.

Thanks Mike. Noted.
Shall I consider it as *Reviewed-by:* with below changes ?

>
> > +/**
> > + * __vm_insert_range - insert range of kernel pages into user vma
> > + * @vma: user vma to map to
> > + * @pages: pointer to array of source kernel pages
> > + * @num: number of pages in page array
> > + * @offset: user's requested vm_pgoff
> > + *
> > + * This allow drivers to insert range of kernel pages into a user vma.
>
>           allows
> > + *
> > + * Return: 0 on success and error code otherwise.
> > + */
> > +static int __vm_insert_range(struct vm_area_struct *vma, struct page **pages,
> > +                               unsigned long num, unsigned long offset)
> >
> >
> > +/**
> > + * vm_insert_range - insert range of kernel pages starts with non zero offset
> > + * @vma: user vma to map to
> > + * @pages: pointer to array of source kernel pages
> > + * @num: number of pages in page array
> > + *
> > + * Maps an object consisting of `num' `pages', catering for the user's
>                                    @num pages
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
>                                                                   the offset
>
> > + * 0. This function is intended for the drivers that did not consider
> > + * @vm_pgoff.
> > + *
> > + * Context: Process context. Called by mmap handlers.
> > + * Return: 0 on success and error code otherwise.
> > + */
> > +int vm_insert_range_buggy(struct vm_area_struct *vma, struct page **pages,
> > +                               unsigned long num)
> >
>
> --
> Sincerely yours,
> Mike.
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
