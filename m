Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560BEC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:01:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25C8820854
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DZrUMaU9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ju/wbRai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C8820854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LK9RHMw9T7H4rw765QGR1kpwCxz/7NGa9cbhO8CnhKA=; b=DZrUMaU9G2ox96
	b/2LDK1cHBA7D3Dlz3nOJt/vfneUzHfF1vmYba5vGrEbbVXh2gEu646Yn2hWCJbS89/mQoglkYx3J
	F2tDnbdpSMFn82lLdRi6Iu/3DAOwf6lqzhvsc6n0nMQZFiRPCIQQMvTcV57n9fZ4TQQAVM62VP9RC
	7hKzdgfQ2FXKzlwcKU3x3gxp1LfOE4ig3ILvkhvPWSxJKeK92pG7iTWoA113Crq3qS+SJxbP1Z0Se
	nU1ol8/Xpz0oWldRaTfaaf731SU8ddBPJsMXB6g2VuxHIr84BseaVdqnuAM+OwjYk8D92+pS3Nx6S
	mo9sZ1gEt1w11k7SZg/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glq3d-0004W5-6H; Tue, 22 Jan 2019 07:01:13 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glq3U-0004Us-Hj; Tue, 22 Jan 2019 07:01:11 +0000
Received: by mail-lf1-x142.google.com with SMTP id c16so17237473lfj.8;
 Mon, 21 Jan 2019 23:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gELQudhz58q+DJDV372aKur4b52yXBFHqo3p/1/epX0=;
 b=ju/wbRaiQK+PGoIe980i73IkWyZOcGgLds1X6yS8+dyW2hPJ8EeY/cV9ZcT22L8d8B
 +nSeIHrfxHIMTQ0bV2q8Hzpa/44AF5RnMNUpz0UbbE+rS0sQiwaPg2yjDJcmQJ0rzUuA
 /+F47UbAsvMdhm5VySdUBQ7qVjsOHKgTIY/89sokdQvZx35D3lDoU5w4NLGiNPi8VyM6
 ePJ6XrppTBsHJ3Tzh5yibTUv8khy7WXIrAI0Rs2IIzr9uu/LUs3oOSdlA190uU6y1KpI
 Tp0jmkzDO1o4Cm3DFtXcZxiclWU96S0Lbgu4Bk0jlh51yl85gNEbbk5IxMve+rn2btyE
 vmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gELQudhz58q+DJDV372aKur4b52yXBFHqo3p/1/epX0=;
 b=ls+mOWgjlOL0NoqPwNNJY5cJMkV4R2IkPh8QGd5vSYFpQLjfk9jERJfbFXz7aa38a2
 yXvw06AiXdQSJz0P60WVwuE/xHGq3cgrtkbjxcTO468Et2Pp/XgikD97C5x4fKgGFuKX
 Rmn+x1FP6urVTEXYkJYtgmhB3vU+0a4TUx9rF+cI6aoDOFGU4thucdoW0jtiKzoY2Ahy
 dfUF/I9JBnDMCyTUe+x2zEcoLTxDNRNmTynaCA8lC/ebak5zXeXFU3oEvrFEG+hadgQA
 jt9zG0jJDPVH3NtWbj8C29Rx4ItS/CBLjDeeOlMhrO/7aA1xQ8XRPLuYmxmm9WiXhdwx
 3cBg==
X-Gm-Message-State: AJcUukf9b3BQb/g/r8wdlUQcsLt/W7jP4hCkW+67wYr9vny657OGwNve
 a1dKkVfcBLLLMDs/vIrWf68zNjMvbBDpY2deTEA=
X-Google-Smtp-Source: ALg8bN5gT5OYIsNf6kzYRoKkBJpu3w73otKRaRsQX3tTXfLn+Hvz7kpoUCVQ3KKhPY1rbMQ/DQw1jB+C/ru5U9faLaI=
X-Received: by 2002:a19:6514:: with SMTP id z20mr18984719lfb.31.1548140459614; 
 Mon, 21 Jan 2019 23:00:59 -0800 (PST)
MIME-Version: 1.0
References: <20190111150712.GA2696@jordon-HP-15-Notebook-PC>
In-Reply-To: <20190111150712.GA2696@jordon-HP-15-Notebook-PC>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Tue, 22 Jan 2019 12:30:47 +0530
Message-ID: <CAFqt6zYOpbwc8518f27W8_YOkuprdJJLyJg1fFB==wrFZLdEYQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] mm: Introduce new vm_insert_range and
 vm_insert_range_buggy API
To: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, vbabka@suse.cz, 
 Rik van Riel <riel@surriel.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
 rppt@linux.vnet.ibm.com, Peter Zijlstra <peterz@infradead.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>, robin.murphy@arm.com, 
 iamjoonsoo.kim@lge.com, treding@nvidia.com, Kees Cook <keescook@chromium.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, stefanr@s5r6.in-berlin.de,
 hjc@rock-chips.com, Heiko Stuebner <heiko@sntech.de>, airlied@linux.ie,
 oleksandr_andrushchenko@epam.com, 
 joro@8bytes.org, pawel@osciak.com, Kyungmin Park <kyungmin.park@samsung.com>, 
 mchehab@kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
 Juergen Gross <jgross@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_230104_598615_ADAE8B7B 
X-CRM114-Status: GOOD (  27.24  )
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
Cc: linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, xen-devel@lists.xen.org,
 Linux-MM <linux-mm@kvack.org>, iommu@lists.linux-foundation.org,
 linux1394-devel@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 11, 2019 at 8:33 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Previouly drivers have their own way of mapping range of
> kernel pages/memory into user vma and this was done by
> invoking vm_insert_page() within a loop.
>
> As this pattern is common across different drivers, it can
> be generalized by creating new functions and use it across
> the drivers.
>
> vm_insert_range() is the API which could be used to mapped
> kernel memory/pages in drivers which has considered vm_pgoff
>
> vm_insert_range_buggy() is the API which could be used to map
> range of kernel memory/pages in drivers which has not considered
> vm_pgoff. vm_pgoff is passed default as 0 for those drivers.
>
> We _could_ then at a later "fix" these drivers which are using
> vm_insert_range_buggy() to behave according to the normal vm_pgoff
> offsetting simply by removing the _buggy suffix on the function
> name and if that causes regressions, it gives us an easy way to revert.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Suggested-by: Russell King <linux@armlinux.org.uk>
> Suggested-by: Matthew Wilcox <willy@infradead.org>

Any comment on these APIs ?

> ---
>  include/linux/mm.h |  4 +++
>  mm/memory.c        | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  mm/nommu.c         | 14 ++++++++++
>  3 files changed, 99 insertions(+)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 5411de9..9d1dff6 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2514,6 +2514,10 @@ unsigned long change_prot_numa(struct vm_area_struct *vma,
>  int remap_pfn_range(struct vm_area_struct *, unsigned long addr,
>                         unsigned long pfn, unsigned long size, pgprot_t);
>  int vm_insert_page(struct vm_area_struct *, unsigned long addr, struct page *);
> +int vm_insert_range(struct vm_area_struct *vma, struct page **pages,
> +                               unsigned long num);
> +int vm_insert_range_buggy(struct vm_area_struct *vma, struct page **pages,
> +                               unsigned long num);
>  vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
>                         unsigned long pfn);
>  vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
> diff --git a/mm/memory.c b/mm/memory.c
> index 4ad2d29..00e66df 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1520,6 +1520,87 @@ int vm_insert_page(struct vm_area_struct *vma, unsigned long addr,
>  }
>  EXPORT_SYMBOL(vm_insert_page);
>
> +/**
> + * __vm_insert_range - insert range of kernel pages into user vma
> + * @vma: user vma to map to
> + * @pages: pointer to array of source kernel pages
> + * @num: number of pages in page array
> + * @offset: user's requested vm_pgoff
> + *
> + * This allows drivers to insert range of kernel pages they've allocated
> + * into a user vma.
> + *
> + * If we fail to insert any page into the vma, the function will return
> + * immediately leaving any previously inserted pages present.  Callers
> + * from the mmap handler may immediately return the error as their caller
> + * will destroy the vma, removing any successfully inserted pages. Other
> + * callers should make their own arrangements for calling unmap_region().
> + *
> + * Context: Process context.
> + * Return: 0 on success and error code otherwise.
> + */
> +static int __vm_insert_range(struct vm_area_struct *vma, struct page **pages,
> +                               unsigned long num, unsigned long offset)
> +{
> +       unsigned long count = vma_pages(vma);
> +       unsigned long uaddr = vma->vm_start;
> +       int ret, i;
> +
> +       /* Fail if the user requested offset is beyond the end of the object */
> +       if (offset > num)
> +               return -ENXIO;
> +
> +       /* Fail if the user requested size exceeds available object size */
> +       if (count > num - offset)
> +               return -ENXIO;
> +
> +       for (i = 0; i < count; i++) {
> +               ret = vm_insert_page(vma, uaddr, pages[offset + i]);
> +               if (ret < 0)
> +                       return ret;
> +               uaddr += PAGE_SIZE;
> +       }
> +
> +       return 0;
> +}
> +
> +/**
> + * vm_insert_range - insert range of kernel pages starts with non zero offset
> + * @vma: user vma to map to
> + * @pages: pointer to array of source kernel pages
> + * @num: number of pages in page array
> + *
> + * Maps an object consisting of `num' `pages', catering for the user's
> + * requested vm_pgoff
> + *
> + * Context: Process context. Called by mmap handlers.
> + * Return: 0 on success and error code otherwise.
> + */
> +int vm_insert_range(struct vm_area_struct *vma, struct page **pages,
> +                               unsigned long num)
> +{
> +       return __vm_insert_range(vma, pages, num, vma->vm_pgoff);
> +}
> +EXPORT_SYMBOL(vm_insert_range);
> +
> +/**
> + * vm_insert_range_buggy - insert range of kernel pages starts with zero offset
> + * @vma: user vma to map to
> + * @pages: pointer to array of source kernel pages
> + * @num: number of pages in page array
> + *
> + * Maps a set of pages, always starting at page[0]
> + *
> + * Context: Process context. Called by mmap handlers.
> + * Return: 0 on success and error code otherwise.
> + */
> +int vm_insert_range_buggy(struct vm_area_struct *vma, struct page **pages,
> +                               unsigned long num)
> +{
> +       return __vm_insert_range(vma, pages, num, 0);
> +}
> +EXPORT_SYMBOL(vm_insert_range_buggy);
> +
>  static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
>                         pfn_t pfn, pgprot_t prot, bool mkwrite)
>  {
> diff --git a/mm/nommu.c b/mm/nommu.c
> index 749276b..21d101e 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -473,6 +473,20 @@ int vm_insert_page(struct vm_area_struct *vma, unsigned long addr,
>  }
>  EXPORT_SYMBOL(vm_insert_page);
>
> +int vm_insert_range(struct vm_area_struct *vma, struct page **pages,
> +                       unsigned long num)
> +{
> +       return -EINVAL;
> +}
> +EXPORT_SYMBOL(vm_insert_range);
> +
> +int vm_insert_range_buggy(struct vm_area_struct *vma, struct page **pages,
> +                               unsigned long num)
> +{
> +       return -EINVAL;
> +}
> +EXPORT_SYMBOL(vm_insert_range_buggy);
> +
>  /*
>   *  sys_brk() for the most part doesn't need the global kernel
>   *  lock, except when an application is doing something nasty
> --
> 1.9.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
