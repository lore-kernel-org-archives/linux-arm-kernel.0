Return-Path: <SRS0=N/t3=PD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FE3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:38:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1FE1218AD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZlHHc0jk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzYAlMUO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1FE1218AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Q0VFK9oBYUuAz9Nq8CWQgpnNz6rfmm/7h1BHxznKFjw=; b=ZlHHc0jkTOge+7
	vb++IXbdkC1Ta4EkAvChkrR8ryR69lq/jHtc67LUpA7wkgaRuZMEtedx1AEpGHkk5T2woWrY+PEUI
	uCUPzQGRteO1jrLLl3RMpndNOOInZuyw40b/RBCg5MM47clzanXwNaUhAHHI5nk7ysappDZwYlZl8
	g6uUHiCO31BBC8wjjvbLUHTTauBItfwAXD333fSbzC+lhPoURNa7VGq5QD6bcugaa8+53Pq8zmTny
	/wINlPfVMYdHKoOFdUmqqcJfyZdzXu9MvOmLWdSVthqLK3gRXV9lbxkqnCgZnlRWe5P8UGq8iGVyv
	WcXtyakSyjkYRWSqLp6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gc9OF-000837-Fa; Wed, 26 Dec 2018 13:38:27 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gc9OB-00080d-3I; Wed, 26 Dec 2018 13:38:24 +0000
Received: by mail-lf1-x141.google.com with SMTP id e26so10889084lfc.2;
 Wed, 26 Dec 2018 05:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kitNRdDq9qDxhqv/cqY0Zh5BAxoT0axpEmlNVpYcbmE=;
 b=EzYAlMUOklMugVTu4yYZGxXNl4hINns0BIBJ5Nyh+SiXyQZO3k1/YmOAXpsklfPAO9
 iDjpstitfhNRBht1mAjbRylNtGX/qD7buZ6ZeNkLPTTkq+7i3RsoxtRKoxTGkPBVjWvU
 ewhbp9fp+SmSCfmGn6nODKNhk6WX3dvwgudwU6EjHkBWxXVyLzXBNAmnZCB6z35uzkPb
 Yuu3uQxriVsO8cyk40d27EsqUa+WVfd4Nl0ZtFjBqXyXizvXzewwA2Kx7e7/1/OvhDt6
 C8HXTXX4cBfndyrt6+ttMQgPjv4dEhaa9oIj2jWENm1ZqGpTtOP7wRhMtO1SGZvml2dn
 imYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kitNRdDq9qDxhqv/cqY0Zh5BAxoT0axpEmlNVpYcbmE=;
 b=EzZF5Hm6hJDD967JOTx1z5p4fWlp2+x/FUB4mEmVT0Bc19+aSSBzVfuAcKzh+S7xr+
 6jj+SpD4OV510B9GCVa93t5wZpLZmZKu4PZm9uyyUMYJ8KntQc7iVjGe9CdKsnsA48n4
 QBg3sFFlU0EFAc42zQNnsNIVdzPOoM7A1uqUBaZtzbytJX4IVa+WVUqlSvM1mbjsECx5
 Ti4soOpjFILfzIFj4z+OyZ+IsSP1fCgKkTvjE0B2JNXnfeu0+WeEm7b55127AMMp9EX8
 z6yk3USyzKZPlN/5UPvgPaCQbpMd6pOKFWN/dSTHxr4WmYWQwZEub99xVBE6b2FectvR
 2h+Q==
X-Gm-Message-State: AA+aEWbbYIFQM7IHFUeE5QB3izyUllRn07K9PX4CoKcjD9odqOYEAz8Y
 J0KwkZu17NJ13reofQNvISDRlRZjFo8gUE3ftkk=
X-Google-Smtp-Source: AFSGD/XEZnUUKwSUwh3xXDYzi3sA4iQ+mQgXPP42OF+kde+qmR73SafRNdS5zRrl3g5eSHL8MfxiCu4AX/ZyOOBLntQ=
X-Received: by 2002:a19:2906:: with SMTP id p6mr9556966lfp.17.1545831490237;
 Wed, 26 Dec 2018 05:38:10 -0800 (PST)
MIME-Version: 1.0
References: <20181224131841.GA22017@jordon-HP-15-Notebook-PC>
 <20181224152059.GA26090@n2100.armlinux.org.uk>
In-Reply-To: <20181224152059.GA26090@n2100.armlinux.org.uk>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Wed, 26 Dec 2018 19:11:57 +0530
Message-ID: <CAFqt6za-vq4GihKbSJjF1_=_xnWvBbpCQDf8iuhF0e8XJY4JVA@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Use vm_insert_range
To: Russell King - ARM Linux <linux@armlinux.org.uk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181226_053823_148906_68133090 
X-CRM114-Status: GOOD (  23.18  )
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
 joro@8bytes.org, iommu@lists.linux-foundation.org,
 Matthew Wilcox <willy@infradead.org>, airlied@linux.ie,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 treding@nvidia.com, linux-media@vger.kernel.org,
 Kees Cook <keescook@chromium.org>, pawel@osciak.com,
 Rik van Riel <riel@surriel.com>, rppt@linux.vnet.ibm.com,
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

On Mon, Dec 24, 2018 at 8:51 PM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> Having discussed with Matthew offlist, I think we've come to the
> following conclusion - there's a number of drivers that buggily
> ignore vm_pgoff.
>
> So, what I proposed is:
>
> static int __vm_insert_range(struct vm_struct *vma, struct page *pages,
>                              size_t num, unsigned long offset)
> {
>         unsigned long count = vma_pages(vma);
>         unsigned long uaddr = vma->vm_start;
>         int ret;
>
>         /* Fail if the user requested offset is beyond the end of the object */
>         if (offset > num)
>                 return -ENXIO;
>
>         /* Fail if the user requested size exceeds available object size */
>         if (count > num - offset)
>                 return -ENXIO;
>
>         /* Never exceed the number of pages that the user requested */
>         for (i = 0; i < count; i++) {
>                 ret = vm_insert_page(vma, uaddr, pages[offset + i]);
>                 if (ret < 0)
>                         return ret;
>                 uaddr += PAGE_SIZE;
>         }
>
>         return 0;
> }
>
> /*
>  * Maps an object consisting of `num' `pages', catering for the user's
>  * requested vm_pgoff
>  */
> int vm_insert_range(struct vm_struct *vma, struct page *pages, size_t num)
> {
>         return __vm_insert_range(vma, pages, num, vma->vm_pgoff);
> }
>
> /*
>  * Maps a set of pages, always starting at page[0]
>  */
> int vm_insert_range_buggy(struct vm_struct *vma, struct page *pages, size_t num)
> {
>         return __vm_insert_range(vma, pages, num, 0);
> }
>
> With this, drivers such as iommu/dma-iommu.c can be converted thusly:
>
>  int iommu_dma_mmap(struct page **pages, size_t size, struct vm_area_struct *vma+)
>  {
> -       unsigned long uaddr = vma->vm_start;
> -       unsigned int i, count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> -       int ret = -ENXIO;
> -
> -       for (i = vma->vm_pgoff; i < count && uaddr < vma->vm_end; i++) {
> -               ret = vm_insert_page(vma, uaddr, pages[i]);
> -               if (ret)
> -                       break;
> -               uaddr += PAGE_SIZE;
> -       }
> -       return ret;
> +       return vm_insert_range(vma, pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
> }
>
> and drivers such as firewire/core-iso.c:
>
>  int fw_iso_buffer_map_vma(struct fw_iso_buffer *buffer,
>                           struct vm_area_struct *vma)
>  {
> -       unsigned long uaddr;
> -       int i, err;
> -
> -       uaddr = vma->vm_start;
> -       for (i = 0; i < buffer->page_count; i++) {
> -               err = vm_insert_page(vma, uaddr, buffer->pages[i]);
> -               if (err)
> -                       return err;
> -
> -               uaddr += PAGE_SIZE;
> -       }
> -
> -       return 0;
> +       return vm_insert_range_buggy(vma, buffer->pages, buffer->page_count);
> }
>
> and this gives us something to grep for to find these buggy drivers.
>
> Now, this may not look exactly equivalent, but if you look at
> fw_device_op_mmap(), buffer->page_count is basically vma_pages(vma)
> at this point, which means this should be equivalent.
>
> We _could_ then at a later date "fix" these drivers to behave according
> to the normal vm_pgoff offsetting simply by removing the _buggy suffix
> on the function name... and if that causes regressions, it gives us an
> easy way to revert (as long as vm_insert_range_buggy() remains
> available.)
>
> In the case of firewire/core-iso.c, it currently ignores the mmap offset
> entirely, so making the above suggested change would be tantamount to
> causing it to return -ENXIO for any non-zero mmap offset.
>
> IMHO, this approach is way simpler, and easier to get it correct at
> each call site, rather than the current approach which seems to be
> error-prone.

Thanks Russell.
I will drop this patch series and rework on it as suggested.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
