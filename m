Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AE0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:40:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EC0620856
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Wt+b5TPt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DayZQjEB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EC0620856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7DcjGNMMQp2jMLHWjX/WYYHHXgrtmuHsvuGnPIKih64=; b=Wt+b5TPt5VDFTH
	DEvIcGhyTT7f6uzshfYcp7EUX9pgEuKrpR4/cUKif9Yz+2BfQugs04tsLal6FEN0j10poXS7gyr2Y
	C/MhWp97cKxFAZiKy72c5KOCuxS7dTxRYFM1395aLKxjOtTSLA/IjNGw1xP3W7J4G3cqQO4nNKkSQ
	nTC9vYC0KfSHlxpJE7r97UsJcajQ+G78MPN2qRILTBKNnfg+6d+UV5MLhLgvoJSlciAFShZ1ah1V3
	cm8su7OZIJJJ///aioM17DVheeoW6w2H4rxEoypDjeFlEy8A5YPuP+DLdvmH9JK2oxG+ymT/6MZXO
	dfrC9Jx1KninixZImzHQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk61g-0007UI-K9; Thu, 17 Jan 2019 11:40:00 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk61d-0007To-Vq; Thu, 17 Jan 2019 11:39:59 +0000
Received: by mail-lj1-x244.google.com with SMTP id v1-v6so8335112ljd.0;
 Thu, 17 Jan 2019 03:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RqoIkotrN3l6oMAC+JrcBK/f6kX7mxLOSugmUX8akyw=;
 b=DayZQjEBT5kOQpoGi2VFE+Lz9tTTebqwjWOtbR16+0ebGzGyTuopZskDO46rrePAbK
 BFC5JdciMoAWC9h7PJlZzQQ0ky6VS3J8892IWikOgujLnSbBE6TgeASgyluAhMvzn9D2
 AYZH+Gl/sQpeZAldKkNZ98b2mgEIDv9JueHq6yx86dBIzzP45DzORgxhjZF4+fiRweno
 imcNTDVw0ARgn2BvsyYZg+T/7ACPSpZZ8XovYCZ/Du+R1YTGAjk3caOSZqw9uj8li7fm
 FChxRc6CELYunH8+CjDkMxH72RK/c1lod6sd10VCbMjLbrqxbBpFigRZfKC1GoznVbl6
 K85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RqoIkotrN3l6oMAC+JrcBK/f6kX7mxLOSugmUX8akyw=;
 b=MPywgaeGYF/YEH/YqbRYRSgfh6y3VRQhDdvf4UmASGBwT2NVaHVG3SXWRd9chfHEt3
 M0oHksSIJOkmekRZzJbF5JludGNyNBCRbTG/c3k/IMUhzKYTEyByORU/+EN6kVXXP1KX
 K0DDq4MNLSFzNguMH6Y8dInI4OJ1cMBOYqPZB/PRHYumvGmdTTpQ/+6+Em8QMpIGnGzL
 kawAzEFCTWthLTu703bKj1a96w3iH3wOIN8uaiWapEZt8Jku7zKxVO4N35kvWu96OBvj
 ICxqVArcte4ylI7dUEUOXsJsvHoFNVrJ0jTPBXn4NSnlHqAD7EYl1Ewde6ooPPmwj60H
 rjag==
X-Gm-Message-State: AJcUukfBidafq2jlQIWmCckxKuR9oBPjI6YIUWXfqQ0jT5mX3QE1wJFp
 nrXXxDErDhZU0fISPUPvmTpvhNbk9IPGsz1urHo=
X-Google-Smtp-Source: ALg8bN4WjU3s0OSm/9YpUIQbO/Oo9A2A0MpGOiCgVD3iwev/FuzOnJlIV0vd6Lqn9vdpZcStOiDXH1xYeeYzkvOhrDc=
X-Received: by 2002:a2e:4601:: with SMTP id
 t1-v6mr9974371lja.111.1547725195689; 
 Thu, 17 Jan 2019 03:39:55 -0800 (PST)
MIME-Version: 1.0
References: <20190111150541.GA2670@jordon-HP-15-Notebook-PC>
In-Reply-To: <20190111150541.GA2670@jordon-HP-15-Notebook-PC>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Thu, 17 Jan 2019 17:09:43 +0530
Message-ID: <CAFqt6zYxCxzGjv3ea+dYQHcmt2P849ZgaVSH=b05m9P4=MTBEA@mail.gmail.com>
Subject: Re: [PATCH 0/9] Use vm_insert_range and vm_insert_range_buggy
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
X-CRM114-CacheID: sfid-20190117_033958_048846_5599BCBB 
X-CRM114-Status: GOOD (  17.95  )
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

On Fri, Jan 11, 2019 at 8:31 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
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
> There is an existing bug in [7/9], where user passed length is not
> verified against object_count. For any value of length > object_count
> it will end up overrun page array which could lead to a potential bug.
> This is fixed as part of these conversion.
>
> Souptick Joarder (9):
>   mm: Introduce new vm_insert_range and vm_insert_range_buggy API
>   arch/arm/mm/dma-mapping.c: Convert to use vm_insert_range
>   drivers/firewire/core-iso.c: Convert to use vm_insert_range_buggy
>   drm/rockchip/rockchip_drm_gem.c: Convert to use vm_insert_range
>   drm/xen/xen_drm_front_gem.c: Convert to use vm_insert_range
>   iommu/dma-iommu.c: Convert to use vm_insert_range
>   videobuf2/videobuf2-dma-sg.c: Convert to use vm_insert_range_buggy
>   xen/gntdev.c: Convert to use vm_insert_range
>   xen/privcmd-buf.c: Convert to use vm_insert_range_buggy

Any further comment on these patches ?

>
>  arch/arm/mm/dma-mapping.c                         | 22 ++----
>  drivers/firewire/core-iso.c                       | 15 +----
>  drivers/gpu/drm/rockchip/rockchip_drm_gem.c       | 17 +----
>  drivers/gpu/drm/xen/xen_drm_front_gem.c           | 18 ++---
>  drivers/iommu/dma-iommu.c                         | 12 +---
>  drivers/media/common/videobuf2/videobuf2-dma-sg.c | 22 ++----
>  drivers/xen/gntdev.c                              | 16 ++---
>  drivers/xen/privcmd-buf.c                         |  8 +--
>  include/linux/mm.h                                |  4 ++
>  mm/memory.c                                       | 81 +++++++++++++++++++++++
>  mm/nommu.c                                        | 14 ++++
>  11 files changed, 129 insertions(+), 100 deletions(-)
>
> --
> 1.9.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
