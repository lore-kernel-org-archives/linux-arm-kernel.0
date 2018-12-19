Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10234C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:47:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D14A3217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IGNGCvP1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMD6pcGP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D14A3217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ckb894OYQo+bzSY7ajpj285f1ekEw/9nw+kOM2aGhMM=; b=IGNGCvP1UY/Yek
	bdH/Kw1n8f2GSeb7N1TS/vMtiprT5Wc0ZZo3KP+WvR8b+1zkorAZxabkfQXmzWSTedW7n4X2EL70Y
	lHUjGn60j3Hnz9bCrX9MbpJeWOg0SzHa6qM5Z+k/jrw2AV9kwg0jhYiNJa1n6OXQBYpu/db+A/aXa
	fPLTOlOTOeh/P2B2stjv/1mFvHxA9DrdaKSUHnhq2SV6PBrYUq2eEGxz61mGx8NHS2t409CMqwqS7
	eYnW6w4GhZcG9GO1YGTR6zgymfudVPccmQT8vHxvc/PlQEVADv6T+Q7B9GQFlUkgMg/YV8m+ON5T6
	2nG0O2UUtd7Rc0j+nyIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZaKD-0002T6-9w; Wed, 19 Dec 2018 11:47:41 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZaJ8-0001TC-KX; Wed, 19 Dec 2018 11:47:01 +0000
Received: by mail-lf1-x141.google.com with SMTP id u18so14793096lff.10;
 Wed, 19 Dec 2018 03:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MmCbkEW++YuRmQ+98HC/KWmVUv+08Nqy0oV8otnoXgY=;
 b=PMD6pcGPvYQfVlimSaQMVPyVS9d+bmeK2YP82iGQ6Q9WEC/vIZUlsdB7Zb5aO+youk
 hPWS/DlKkzVX4wy2WWPon5YsyTgt/SgdBOkmw7yJUbvDihm/AaGuxwH3ZwQuCvGdTdsa
 x1vVWzQRrQTj5uJonK8WHSz3lO/mogdkA2SjPHvFQQPjdgt55QdogVXp85JddezTvb7T
 M7OIkwdOUVO0LQhwng/AiRvMZ4F5RcbbuuRMc2FZic6HkzaVrpVaJCjOoQ9nctatB7Sa
 gK/ZeWqB25pTXvn/9P2rkwkeHnTpemgiz0fR1akMY/aE+kUlql7ui8WRUIxFgF/6Md2B
 JTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MmCbkEW++YuRmQ+98HC/KWmVUv+08Nqy0oV8otnoXgY=;
 b=NrZQWwttki7n45zPgDlqNFLYVZZXpqMDOtXyLYWMvgd083EWxTPOTtpK26Su1gQ3H3
 DJSXeKng5OjnhopaC+JYNOnW8LQD5TGR19OyvMT44RbeNhSA+TUQoFvQst7brJzxcIRe
 wxgudjh5hlU7Zg7o4kM7BvFZIJ4RQtAYIWdqTymFcotBIjsKn1FhHFL3cD/HyEmxVqvA
 PsrKypmkE+BCi7P0L/HjI94vG+qmlrARqBhJ3BOCZinUKO+Qj7xPInJDQvnLV3bRfyWd
 vxh8Era86eLL/rG1zSm1vec+A/7uo1chVxLr5vGYYStCLGPkOdujg7yaxmYhluW0h1yS
 0Rrw==
X-Gm-Message-State: AA+aEWa5fpFzEDS/I6yep0/9+3hj/MSXMTc79voD8CT0P8ZJbD/QL/kZ
 8b3T0dkCYK4KWwfiNBEfAemco9zv0+OLqwwUs30=
X-Google-Smtp-Source: AFSGD/WyJwigOdDbFFtb+6tDtKbqwFdOghf6Jj8C4veAjl5BzlO/G+VG+2Icas71vij5VrzGrNyxFLhq381+E0t8TJU=
X-Received: by 2002:a19:2906:: with SMTP id p6mr4141635lfp.17.1545219982281;
 Wed, 19 Dec 2018 03:46:22 -0800 (PST)
MIME-Version: 1.0
References: <20181217202334.GA11758@jordon-HP-15-Notebook-PC>
 <20181218095709.GJ26090@n2100.armlinux.org.uk>
 <CAFqt6zaVU-Fme6fErieBfBKwAm9xHUa7cXTOfqzwUJR__0JysQ@mail.gmail.com>
 <20181218123318.GN26090@n2100.armlinux.org.uk>
 <CAFqt6zbqaS-pFETyjRR2-1V57MiJuX65xoMjgkr-DjUnrJYzSg@mail.gmail.com>
 <20181218130146.GO26090@n2100.armlinux.org.uk>
 <CAFqt6zYnn76OdprSvA2Bj0v=xQqtJ6xJse6+iB+-=u3WsEv3pA@mail.gmail.com>
 <20181219093230.GS26090@n2100.armlinux.org.uk>
In-Reply-To: <20181219093230.GS26090@n2100.armlinux.org.uk>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Wed, 19 Dec 2018 17:16:09 +0530
Message-ID: <CAFqt6zbLrw5HENBiLXxPFqo7kk8uBJd3z-+C9Fnkej7u3W2i1w@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] drm/rockchip/rockchip_drm_gem.c: Convert to use
 vm_insert_range
To: Russell King - ARM Linux <linux@armlinux.org.uk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_034635_155270_967D7AA5 
X-CRM114-Status: GOOD (  35.52  )
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

On Wed, Dec 19, 2018 at 3:02 PM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> On Wed, Dec 19, 2018 at 09:01:09AM +0530, Souptick Joarder wrote:
> > On Tue, Dec 18, 2018 at 6:31 PM Russell King - ARM Linux
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Tue, Dec 18, 2018 at 06:24:29PM +0530, Souptick Joarder wrote:
> > > > On Tue, Dec 18, 2018 at 6:03 PM Russell King - ARM Linux
> > > > <linux@armlinux.org.uk> wrote:
> > > > >
> > > > > On Tue, Dec 18, 2018 at 05:36:04PM +0530, Souptick Joarder wrote:
> > > > > > On Tue, Dec 18, 2018 at 3:27 PM Russell King - ARM Linux
> > > > > > <linux@armlinux.org.uk> wrote:
> > > > > > > This looks like a change in behaviour.
> > > > > > >
> > > > > > > If user_count is zero, and offset is zero, then we pass into
> > > > > > > vm_insert_range() a page_count of zero, and vm_insert_range() does
> > > > > > > nothing and returns zero.
> > > > > > >
> > > > > > > However, as we can see from the above code, the original behaviour
> > > > > > > was to return -ENXIO in that case.
> > > > > >
> > > > > > I think these checks are not necessary. I am not sure if we get into mmap
> > > > > > handlers of driver with user_count = 0.
> > > > >
> > > > > I'm not sure either, I'm just pointing out the change of behaviour.
> > > >
> > > > Ok. I think feedback from Heiko might be helpful here :)
> > > >
> > > > >
> > > > > > > The other thing that I'm wondering is that if (eg) count is 8 (the
> > > > > > > object is 8 pages), offset is 2, and the user requests mapping 6
> > > > > > > pages (user_count = 6), then we call vm_insert_range() with a
> > > > > > > pages of rk_obj->pages + 2, and a pages_count of 6 - 2 = 4. So we
> > > > > > > end up inserting four pages.
> > > > > >
> > > > > > Considering the scenario, user_count will remain 8 (user_count =
> > > > > > vma_pages(vma) ). ? No ?
> > > > > > Then we call vm_insert_range() with a pages of rk_obj->pages + 2, and
> > > > > > a pages_count
> > > > > > of 8 - 2 = 6. So we end up inserting 6 pages.
> > > > > >
> > > > > > Please correct me if I am wrong.
> > > > >
> > > > > vma_pages(vma) is the number of pages that the user requested, it is
> > > > > the difference between vma->vm_end and vma->vm_start in pages.  As I
> > > > > said above, "the user requests mapping 6 pages", so vma_pages() will
> > > > > be 6, and so user_count will also be 6.  You are passing
> > > > > user_count - offset into vm_insert_range(), which will be 6 - 2 = 4
> > > > > in my example.  This is two pages short of what the user requested.
> > > > >
> > > >
> > > > So, this should be the correct behavior.
> > > >
> > > >                  return vm_insert_range(vma, vma->vm_start,
> > > > rk_obj->pages + offset,
> > > >                                                           user_count);
> > >
> > > ... and by doing so, you're introducing another instance of the same
> > > bug I pointed out in patch 2.
> >
> > Sorry but didn't get it ? How it will be similar to the bug pointed
> > out in patch 2 ?
>

Thanks for the detail explanation.

> Towards the top of this function, you have:
>
>         unsigned long user_count = vma_pages(vma);
>
> So what you are proposing does:
>
>         return vm_insert_range(vma, vma->vm_start, rk_obj->pages + offset,
>                                vma_pages(vma));
>
> Now if we look inside vm_insert_range():
>
> +int vm_insert_range(struct vm_area_struct *vma, unsigned long addr,
> +                       struct page **pages, unsigned long page_count)
> +{
> +       unsigned long uaddr = addr;
> +       int ret = 0, i;
> +
> +       if (page_count > vma_pages(vma))
> +               return -ENXIO;
> +
> +       for (i = 0; i < page_count; i++) {
> +               ret = vm_insert_page(vma, uaddr, pages[i]);
> +               if (ret < 0)
> +                       return ret;
> +               uaddr += PAGE_SIZE;
> +       }
>
> So, page_count _is_ vma_pages(vma).  So this code does these operations:
>
>         if (vma_pages(vma) > vma_pages(vma))
>                 return -ENXIO;
>
> This will always be false.  I've already stated in my reply to patch 2
> in paragraph 3 about the uselessness of this test.

Agree, this will be always false for this particular/ similar instances.
But there are places [3/9], [6/9], [9/9] where page_count is already set
and it might be good to just cross check page_count > vma_pages(vma).

This was discussed during review of v3 [1/9].
https://patchwork.kernel.org/patch/10716601/

We can discuss again and if not needed it can be removed in v5.

>
>         for (i = 0; i < vma_pages(vma); i++) {
>                 ret = vm_insert_page(vma, uaddr, pages[i]);
>
> So the loop will iterate over the number of pages that the user requested.
>
> Now, taking another example.  The object is again 8 pages long, so
> indexes 0 through 7 in its page array are valid.  The user requests
> 8 pages at offset 2 into the object.  Also as already stated in
> paragraph 3 of my reply to patch 2.
>
> vma_pages(vma) is 8.  offset = 2.
>
> So we end up _inside_ vm_insert_range() with:
>
>         if (8 > 8)
>                 return -ENXIO;
>
> As stated, always false.
>
>         for (i = 0; i < 8; i++) {
>                 ret = vm_insert_page(vma, vaddr, rk_obj->pages[2 + i]);
>
> Which means we iterate over rk_obj->pages indicies from 2 through 9
> inclusive.
>
> Since only 0 through 7 are valid, we have walked off the end of the
> array, and attempted to map an invalid struct page pointer - we could
> be lucky, and it could point at some struct page (potentially causing
> us to map some sensitive page - maybe containing your bank details or
> root password... Or it could oops the kernel.

Consider the 2nd example.
The object is again 8 pages long, so indexes 0 through 7 in
its page array are valid.  The user requests 8 pages at offset 2
into the object.

The original code look like -

             unsigned long user_count = vma_pages(vma); // 8
             unsigned long end = user_count + offset // 8 + 2 = 10
              ...
              for (i = offset (2) ; i < end ( 10) ; i++) {
                  ret = vm_insert_page(vma, uaddr, rk_obj->pages[i]);
                  if (ret)
                     return ret;
                  uaddr += PAGE_SIZE;
              }

we iterate over rk_obj->pages indices from 2 through 9.
Does it indicates the actual code have a bug when *offset != 0*.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
