Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C1BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 02:37:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 353BF2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 02:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eGOYmXB+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRDQaL2Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 353BF2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=npN0BkEAQf9MvJq7qa4u4If7Mcwym0ACxjkBSu/H3lw=; b=eGOYmXB+2jVoB0
	HgRECb2sLq0QtMXSknTKL6mpd1gPujiWGl9EWz8DfsvQGuoKlBhpO5C12zYpS6m4lIuGcvAEujCrs
	BZxePYVNVemQvfNDYLzCW3N1QE+/OxeHDPKBFcvPMijb9nQbo6a2ftn3r5o49F3ibP3zwPaV1ZMe7
	HexA2wTXao0P5V9vzQAzFysNCtzNVE6LtNghLRzMOb+LPPaTq/AAqtEFd9x4nQdi50GUItWqPLlBU
	ZgBz0Ns4o0AdAkA+dXz9rXmUzU/57I6HYaatfnkfJHCPtoNsa+QSEkWfLxudYy2yxA5OMo4hj7dPZ
	e8M6zKYNpkRDeGXogh3g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gweEI-0007QG-Vz; Thu, 21 Feb 2019 02:36:54 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gweEF-0007Pk-Ix; Thu, 21 Feb 2019 02:36:53 +0000
Received: by mail-lj1-x244.google.com with SMTP id l5so19224449lje.1;
 Wed, 20 Feb 2019 18:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IhT33+ZuZhnclLJtzrgLTvsh568OJwgxzHtt6EZoeoE=;
 b=RRDQaL2Yr6th/tcc24ot1sRaI12xLnsOT26YVojzv6FLlBcPV4BZH7qKQYvXQRy0Ml
 xgHyh6bj9Xh4TnWOM//4cBWzFemxAhb+kUIo9tDssoivn0Hz/a7DNF7QkegBx20FAGCg
 YrkJeugdrrurdNvVCq5U1ghRK5uazu7WJejHQMyH1vDR0zb8y17em07zw1XqXQITvj8d
 Uf+f//sKtQqL8efMFlzW9j7KhEfvhhELp4ufj6w5q4pFpnciIRQPovl0FYOKzk9JzEti
 ZDqfX/rsuBnEGNqhZ3nCqJTwA7Q1wucr7yMhsychbrwxfUa5c4tLfu9P7jCmXg/ZYdVn
 gtfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IhT33+ZuZhnclLJtzrgLTvsh568OJwgxzHtt6EZoeoE=;
 b=uLuMElvoz9mIqKg2Ze3wizeGtr0ZrTzb7SwMfMILQI/NEp+K6h1vp6vpppLD6xIQOO
 ++ayams2+Gd47KzZm938g85T90LV6xNM3M9KCto3NtX1OZqBSSRSP/MxgPpekRZTPQyT
 50QYkRdd1aJa7Tij3k/G53DEeWU66awZKmgwyJZb+Va/sPJ/j4e+wx7gNBXen9xO5P+Z
 QUSjRENn63Anb57EdKHdDXmW7qSKrSPH4mgHulLeYgTrj9LPmLf7BnTB8n9qwH5oiy+q
 MMg7FQts8uj0Dm4c3lWD+UUuHMZI9XASmDskScppvqQBvcF3zR/JqclWFa81Y6AE7LuA
 9i3Q==
X-Gm-Message-State: AHQUAua7hOwo/YLsc7LSMNpUfkAvbBz9p4uDwOslHcu72et4JWv89/Aj
 x6DlWXBx1r/orvrsE9HyN6M8lbMaYYpMOtsYbsM=
X-Google-Smtp-Source: AHgI3IahDoLmYSzyXftmcGNCvk1lLmWsiwGhF2S+3m4XfLJICiUO5nC5rltmz2rH5SPgMvCWKXFIHyOjBjhd24YBdDM=
X-Received: by 2002:a2e:9b99:: with SMTP id z25mr13905243lji.106.1550716608824; 
 Wed, 20 Feb 2019 18:36:48 -0800 (PST)
MIME-Version: 1.0
References: <20190215024104.GA26331@jordon-HP-15-Notebook-PC>
In-Reply-To: <20190215024104.GA26331@jordon-HP-15-Notebook-PC>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Thu, 21 Feb 2019 08:11:02 +0530
Message-ID: <CAFqt6zbchvoD-MdEF2T52eOPQ2x4gZ4G-72oZkW5f_RiT1nXpA@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] mm: Use vm_map_pages() and vm_map_pages_zero() API
To: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
 Vlastimil Babka <vbabka@suse.cz>, Rik van Riel <riel@surriel.com>, 
 Stephen Rothwell <sfr@canb.auug.org.au>, rppt@linux.vnet.ibm.com, 
 Peter Zijlstra <peterz@infradead.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>, robin.murphy@arm.com, 
 iamjoonsoo.kim@lge.com, treding@nvidia.com, Kees Cook <keescook@chromium.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, stefanr@s5r6.in-berlin.de,
 hjc@rock-chips.com, Heiko Stuebner <heiko@sntech.de>, airlied@linux.ie,
 oleksandr_andrushchenko@epam.com, 
 joro@8bytes.org, pawel@osciak.com, Kyungmin Park <kyungmin.park@samsung.com>, 
 mchehab@kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
 Juergen Gross <jgross@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_183651_652222_E7E0A0FD 
X-CRM114-Status: GOOD (  22.52  )
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

On Fri, Feb 15, 2019 at 8:06 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Previouly drivers have their own way of mapping range of
> kernel pages/memory into user vma and this was done by
> invoking vm_insert_page() within a loop.
>
> As this pattern is common across different drivers, it can
> be generalized by creating new functions and use it across
> the drivers.
>
> vm_map_pages() is the API which could be used to map
> kernel memory/pages in drivers which has considered vm_pgoff.
>
> vm_map_pages_zero() is the API which could be used to map
> range of kernel memory/pages in drivers which has not considered
> vm_pgoff. vm_pgoff is passed default as 0 for those drivers.
>
> We _could_ then at a later "fix" these drivers which are using
> vm_map_pages_zero() to behave according to the normal vm_pgoff
> offsetting simply by removing the _zero suffix on the function
> name and if that causes regressions, it gives us an easy way to revert.
>
> Tested on Rockchip hardware and display is working fine, including talking
> to Lima via prime.
>
> v1 -> v2:
>         Few Reviewed-by.
>
>         Updated the change log in [8/9]
>
>         In [7/9], vm_pgoff is treated in V4L2 API as a 'cookie'
>         to select a buffer, not as a in-buffer offset by design
>         and it always want to mmap a whole buffer from its beginning.
>         Added additional changes after discussing with Marek and
>         vm_map_pages() could be used instead of vm_map_pages_zero().
>
> v2 -> v3:
>         Corrected the documentation as per review comment.
>
>         As suggested in v2, renaming the interfaces to -
>         *vm_insert_range() -> vm_map_pages()* and
>         *vm_insert_range_buggy() -> vm_map_pages_zero()*.
>         As the interface is renamed, modified the code accordingly,
>         updated the change logs and modified the subject lines to use the
>         new interfaces. There is no other change apart from renaming and
>         using the new interface.
>
>         Patch[1/9] & [4/9], Tested on Rockchip hardware.
>
> v3 -> v4:
>         Fixed build warnings on patch [8/9] reported by kbuild test robot.
>
> Souptick Joarder (9):
>   mm: Introduce new vm_map_pages() and vm_map_pages_zero() API
>   arm: mm: dma-mapping: Convert to use vm_map_pages()
>   drivers/firewire/core-iso.c: Convert to use vm_map_pages_zero()
>   drm/rockchip/rockchip_drm_gem.c: Convert to use vm_map_pages()
>   drm/xen/xen_drm_front_gem.c: Convert to use vm_map_pages()
>   iommu/dma-iommu.c: Convert to use vm_map_pages()
>   videobuf2/videobuf2-dma-sg.c: Convert to use vm_map_pages()
>   xen/gntdev.c: Convert to use vm_map_pages()
>   xen/privcmd-buf.c: Convert to use vm_map_pages_zero()

If no further comment, is it fine to take these patches to -mm
tree for regression ?

>
>  arch/arm/mm/dma-mapping.c                          | 22 ++----
>  drivers/firewire/core-iso.c                        | 15 +---
>  drivers/gpu/drm/rockchip/rockchip_drm_gem.c        | 17 +----
>  drivers/gpu/drm/xen/xen_drm_front_gem.c            | 18 ++---
>  drivers/iommu/dma-iommu.c                          | 12 +---
>  drivers/media/common/videobuf2/videobuf2-core.c    |  7 ++
>  .../media/common/videobuf2/videobuf2-dma-contig.c  |  6 --
>  drivers/media/common/videobuf2/videobuf2-dma-sg.c  | 22 ++----
>  drivers/xen/gntdev.c                               | 11 ++-
>  drivers/xen/privcmd-buf.c                          |  8 +--
>  include/linux/mm.h                                 |  4 ++
>  mm/memory.c                                        | 81 ++++++++++++++++++++++
>  mm/nommu.c                                         | 14 ++++
>  13 files changed, 134 insertions(+), 103 deletions(-)
>
> --
> 1.9.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
