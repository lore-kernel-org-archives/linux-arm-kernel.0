Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63907C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:06:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3418221850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RZ2l8F6X";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPVuLGto"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3418221850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pmd12mFslhWh6jpywK1FyPzH5K5Q6cld4B7dhuevego=; b=RZ2l8F6XA+Y3lH
	D2vI+xmCOmSmdhgUl2hWk1WFrWLmgQGTwSWBJtDupe8SNFTiRInlRMEba/Ua3NBSssvfElflKgTV9
	Cz+32pW3S9q5NI4JyktPSE0ER+jYuvpblBnlUJ+3Wtj01BjJpRTIRN1tj6LSeoqVbNMsNm6XxIHuV
	BMFlgC9gR3e+wCkelOQruINwlj7SSAuJcMxDRCfYXFn9qzecdaZY+Uy9OtpSG+2MebJUlPjjsCVvP
	xJg74nhhQ/UFhLZT0loyxgNwmOpGPMRjcUmDyNxC416U8Cmy4KHrCeKpSkehJJN9j8+woOIbUNxad
	lyUc38kqIVzNSkuCdxnw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZE8v-0007k3-W0; Tue, 18 Dec 2018 12:06:33 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZE8s-0007ik-6U; Tue, 18 Dec 2018 12:06:32 +0000
Received: by mail-lj1-x242.google.com with SMTP id t9-v6so13977022ljh.6;
 Tue, 18 Dec 2018 04:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xgH7tJU86A63ysDva0gHrk1mfC2sisonLET/9h8k1Tc=;
 b=KPVuLGtoqVJTgTNdQBThrlDOpS4QJO1KtfxY8D0rUcWVKcmNNwiYzi7U2M1PhBtshc
 iL/ODWxtvZIEg+D47ChA7mcCGdHLNWNcEaZp7oIadyDNNwlcch9BofU/Rvv89Lig16kw
 HFhEJ8BjQUcqiSnTZL4mN0JmSJY2G25VfhYB09DPLaJvOc5xkJAtSKDrWphtwsmeNfgu
 l4J/z79tVc6NUxjmphjPjBGzwmgCvRdhi9sQKuooGLO11keY3/bMybxovVqtBeKE1Owj
 HhFqdSWrviMpp3oGUww6LbaEBTRK1NDp1Ql+gK2bqBMJum0shPqwPGPtMS2sd8oIY6/n
 3HgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xgH7tJU86A63ysDva0gHrk1mfC2sisonLET/9h8k1Tc=;
 b=h50ZRVnJAu+Ru4Ao15SCwvrSCJl6jVrbrHqCP7832VQ33Ulhk0/E5fn4VRTN44hGyf
 yybx4e1ZXgZkQym5DtNDhTY7zNTHD6lylni/m/IqD+io3pW/LEXSjfvXvXNCZQvznmmS
 +JxpOzyPXQOLtfQMbgwceH3fKjfEXIjh1mU7xKod3aoNh/lPkZPaRwvXNCIKHSvFVq3g
 n2HBYyyeqFgc5GYBZNhFs1pzlvYMBM7Nt/SEL5SqkfeLSVJCkRZ6n9ioKMyvjnvvl2S+
 K4LWMJM1ruAAmpYu6yQ36eqnKpB+hqe2/cZN+D8UF0NTcz7gyPcgkCTwmzvxiVX1/+WV
 ACFQ==
X-Gm-Message-State: AA+aEWbSsvQwUrPXm7kYYHMuXAJWTz5C8m9pWf7aR6nhP06Pslkp+0c3
 gkstElsu096p1u8NRjCw60fW5RyMM45sRKE2Jkk=
X-Google-Smtp-Source: AFSGD/WOgYL2p2sFz4uiELV6e/RpgDqDhwBfTgy+6gM5dCl5ZdB4LS9Gs48e3HBZcMt3eV1g4z05vNSOvyvNHBOQvXw=
X-Received: by 2002:a2e:4601:: with SMTP id
 t1-v6mr10927299lja.111.1545134777792; 
 Tue, 18 Dec 2018 04:06:17 -0800 (PST)
MIME-Version: 1.0
References: <20181217202334.GA11758@jordon-HP-15-Notebook-PC>
 <20181218095709.GJ26090@n2100.armlinux.org.uk>
In-Reply-To: <20181218095709.GJ26090@n2100.armlinux.org.uk>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Tue, 18 Dec 2018 17:36:04 +0530
Message-ID: <CAFqt6zaVU-Fme6fErieBfBKwAm9xHUa7cXTOfqzwUJR__0JysQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] drm/rockchip/rockchip_drm_gem.c: Convert to use
 vm_insert_range
To: Russell King - ARM Linux <linux@armlinux.org.uk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_040630_243072_3599400C 
X-CRM114-Status: GOOD (  30.88  )
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

On Tue, Dec 18, 2018 at 3:27 PM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> On Tue, Dec 18, 2018 at 01:53:34AM +0530, Souptick Joarder wrote:
> > Convert to use vm_insert_range() to map range of kernel
> > memory to user vma.
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > Tested-by: Heiko Stuebner <heiko@sntech.de>
> > Acked-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> >  drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 19 ++-----------------
> >  1 file changed, 2 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> > index a8db758..8279084 100644
> > --- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> > @@ -221,26 +221,11 @@ static int rockchip_drm_gem_object_mmap_iommu(struct drm_gem_object *obj,
> >                                             struct vm_area_struct *vma)
> >  {
> >       struct rockchip_gem_object *rk_obj = to_rockchip_obj(obj);
> > -     unsigned int i, count = obj->size >> PAGE_SHIFT;
> >       unsigned long user_count = vma_pages(vma);
> > -     unsigned long uaddr = vma->vm_start;
> >       unsigned long offset = vma->vm_pgoff;
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
> > +     return vm_insert_range(vma, vma->vm_start, rk_obj->pages + offset,
> > +                             user_count - offset);
>
> This looks like a change in behaviour.
>
> If user_count is zero, and offset is zero, then we pass into
> vm_insert_range() a page_count of zero, and vm_insert_range() does
> nothing and returns zero.
>
> However, as we can see from the above code, the original behaviour
> was to return -ENXIO in that case.

I think these checks are not necessary. I am not sure if we get into mmap
handlers of driver with user_count = 0.

>
> The other thing that I'm wondering is that if (eg) count is 8 (the
> object is 8 pages), offset is 2, and the user requests mapping 6
> pages (user_count = 6), then we call vm_insert_range() with a
> pages of rk_obj->pages + 2, and a pages_count of 6 - 2 = 4. So we
> end up inserting four pages.

Considering the scenario, user_count will remain 8 (user_count =
vma_pages(vma) ). ? No ?
Then we call vm_insert_range() with a pages of rk_obj->pages + 2, and
a pages_count
of 8 - 2 = 6. So we end up inserting 6 pages.

Please correct me if I am wrong.

>
> The original code would calculate end = 6 + 2 = 8.  i would iterate
> from 2 through 8, inserting six pages.
>
> (I hadn't spotted that second issue until I'd gone through the
> calculations manually - which is worrying.)
>
> I don't have patches 5 through 9 to look at, but I'm concerned that
> similar issues also exist in those patches.

yes, you were not cc'd for 5 - 9. Below are the patchwork links -

https://patchwork.kernel.org/patch/10734269/
https://patchwork.kernel.org/patch/10734271/
https://patchwork.kernel.org/patch/10734273/
https://patchwork.kernel.org/patch/10734277/
https://patchwork.kernel.org/patch/10734279/

>
> I'm concerned that this series seems to be introducing subtle bugs,
> it seems to be unnecessarily difficult to use this function correctly.
> I think your existing proposal for vm_insert_range() provides an
> interface that is way too easy to get wrong, and, therefore, is the
> wrong interface.
>
> I think it would be way better to have vm_insert_range() take the
> object page array without any offset adjustment, and the object
> page_count again without any adjustment, and have vm_insert_range()
> itself handle the offsetting and VMA size validation.  That would
> then give a simple interface and probably give a further reduction
> in code at each call site.
>
> Thanks.
>
> --
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
