Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5638FC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:27:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 193AF2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bH2c47Zv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqQCq+kQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 193AF2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SI47CIh046LFBi+9xaWJnK/GTEziKueh1wv8O+VyNz0=; b=bH2c47ZvVNNna7
	dDDN+/c9Y3uMn7TJfvQnzxkgR69601oMt1+5nX1qIaz2Y8DuRmq8Dsmg4hgnqqA1wCMalA0SJN4zR
	J34YBWB7mMn7g6GV9o0VN2tVATO4CRjBz7ofBhpMN5Sc7qwb1HaZRVzv5mtC5wJCdc49BPXMp2TrN
	da9PBAZkazo1RKJCFue1lNLAI9SDlMf+Ek2YCDLwV7AtEaPyWCanwcVCO4oSuvXou8cUtx4jvt8YA
	zSdA7jyFQ2SIoDHXnW3iIvzV0zZ3k+bar/5YHMR5mbbxlou5gKoXsRJx6l8GOMMgClUkjXxUUyPOt
	PkGBv2HorE+DZ1E/5TSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVMiS-0001bY-9P; Fri, 07 Dec 2018 20:27:16 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVMiP-0001aL-4h; Fri, 07 Dec 2018 20:27:14 +0000
Received: by mail-lj1-x243.google.com with SMTP id k15-v6so4614787ljc.8;
 Fri, 07 Dec 2018 12:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=f1gp9b66p+D5If3HDTrYunFFk8/ZJcoOdKYP4Xl/4es=;
 b=ZqQCq+kQXmi7g0s41wlzMA6mevBI36eUjdQcJ1j4qHF1C+8VY38vwn4L2wXd4sE4gO
 YueKqjACGRacaP9gWD/BK8xFJGApCjvofjC57OfvEqNQQd73PPg4etrZVthsV72UDhxa
 Csh0ed5de6f1ht4uaCS4TGVU1UiQ0OtQgj17XczohbuhP6KPgY+Pldub5h2B8vHtuM2k
 CbF9fQeZe+aDh3kRTXp+u12xEcTv9QgHTCIonfv4U2lZ4v6yGlgSvXZmCen6wUtueoUk
 L9/GGhE6EUaA+V6fdghsP91n9SkogwuKy/s9xGJwvMBDBWH+Kg31K8HXfZsZNmRdffE/
 Adpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=f1gp9b66p+D5If3HDTrYunFFk8/ZJcoOdKYP4Xl/4es=;
 b=NJ0EwnNUWhkAmm39wkqPnpF9c66LNCr23q75Lhs/fFSiMP9NH7lg7Q3P4XNekZYPzy
 sGs2NCg+aNNVMmOhT9xjUgorvbig06DSSg3d5hRJRUWQeQPnceY4Vwrej4QzquOGzbER
 TrYgqmEjk10dMNyVoYNtIZPrWWOd8a/E+MrzcWMbed5WqNL8N+5HwVS5VUh8CLCKsTuB
 2U9ZoOAh5aHXRRuZ2k1i/Rf+ziQgFrAOlWtBnqWkMFBWxZejIC6e9nqJ2qfL6fc9emCK
 +5gDPXUtbO+qvrNYLflbIigmlcmFDZSnq4y2B7/ey7vgsr3HhRw3pmfhobx0ibI5N8Cw
 LzmA==
X-Gm-Message-State: AA+aEWaWTeqw3/KZOSazHhVZvSrQ54rII2ZKAAvH7ZvkYBWeUu6c4Tp4
 xc1IsPX0yzLFExSv0PvJQ8UxkDQDzaut4vD8dfA=
X-Google-Smtp-Source: AFSGD/WiWZ1rxWyUbQM5X7LEj+GUG729CL7ZIKd42DpnOLoWaRi8edYXMTAwfrSuYWaLtpERODE3nz53L066pxDF6AI=
X-Received: by 2002:a2e:9c52:: with SMTP id
 t18-v6mr1847940ljj.149.1544214420838; 
 Fri, 07 Dec 2018 12:27:00 -0800 (PST)
MIME-Version: 1.0
References: <20181206184227.GA28656@jordon-HP-15-Notebook-PC>
 <ca1779ea-7a87-971c-24c4-4a1c77a72e92@arm.com>
In-Reply-To: <ca1779ea-7a87-971c-24c4-4a1c77a72e92@arm.com>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Sat, 8 Dec 2018 02:00:36 +0530
Message-ID: <CAFqt6zbMbvB1ckwhSsBATrq5M-HQ6qk95sCWCoTTFFnwzBAnng@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] drm/rockchip/rockchip_drm_gem.c: Convert to use
 vm_insert_range
To: robin.murphy@arm.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_122713_187991_1DC607B6 
X-CRM114-Status: GOOD (  18.07  )
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
 linux-rockchip@lists.infradead.org, airlied@linux.ie, hjc@rock-chips.com,
 Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
 Linux-MM <linux-mm@kvack.org>, dri-devel@lists.freedesktop.org,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 7, 2018 at 8:20 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 06/12/2018 18:42, Souptick Joarder wrote:
> > Convert to use vm_insert_range() to map range of kernel
> > memory to user vma.
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > Tested-by: Heiko Stuebner <heiko@sntech.de>
> > Acked-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> >   drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 20 ++------------------
> >   1 file changed, 2 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> > index a8db758..2cb83bb 100644
> > --- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> > @@ -221,26 +221,10 @@ static int rockchip_drm_gem_object_mmap_iommu(struct drm_gem_object *obj,
> >                                             struct vm_area_struct *vma)
> >   {
> >       struct rockchip_gem_object *rk_obj = to_rockchip_obj(obj);
> > -     unsigned int i, count = obj->size >> PAGE_SHIFT;
> >       unsigned long user_count = vma_pages(vma);
> > -     unsigned long uaddr = vma->vm_start;
> > -     unsigned long offset = vma->vm_pgoff;
> > -     unsigned long end = user_count + offset;
> > -     int ret;
> > -
> > -     if (user_count == 0)
> > -             return -ENXIO;
> > -     if (end > count)
> > -             return -ENXIO;
> >
> > -     for (i = offset; i < end; i++) {
> > -             ret = vm_insert_page(vma, uaddr, rk_obj->pages[i]);
> > -             if (ret)
> > -                     return ret;
> > -             uaddr += PAGE_SIZE;
> > -     }
> > -
> > -     return 0;
> > +     return vm_insert_range(vma, vma->vm_start, rk_obj->pages,
> > +                             user_count);
>
> We're losing vm_pgoff handling here, which given the implication in
> 57de50af162b, may well be a regression for at least some combination of
> GPU and userspace driver (I assume that commit was in the context of
> some version of the Arm Mali driver, possibly on RK3288).

In commit  57de50af162b, vma->vm_pgoff = 0 for GEM mmap handler context
and removing it from common path which means if call stack looks like
rockchip_gem_mmap_buf() -> rockchip_drm_gem_object_mmap() ->
rockchip_drm_gem_object_mmap_iommu(), then we might have a non zero
vma->vm_pgoff context which is not handled.

This is the problem you are pointing ? right ?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
