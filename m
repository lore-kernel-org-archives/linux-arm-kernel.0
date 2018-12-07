Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B3EC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:45:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D7AF20837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tNNj6sx3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipmNs0vN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D7AF20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=O3hntV0VXKJW1mXQnkWMUSa33emzfSrVgUouIKfnwVU=; b=tNNj6sx3QegYvi
	1yjqYu+G5+lmXvWDYtgGCyV8QXnV5OfW/fkFuKe5bt5R+PdjJNMfeIORIRci1CQo7bQnFj4w/j9Yk
	9pq07fr9ACSibDUtbm8w1xMk+TtCA839csFF0TCZYhlKF4+5RNGDGrzJiORx2tOk+4hYbMv9/zJWb
	Wl/lRmStSTFfKv2qYaxLnExBHWg5+j4bgmzs8oSmHOmUYMhPuVuc3DQOWaLXLzYP414Oei7ofctnD
	V/epw/bHoqHLWkRoaVpQUHlQybwDEuSHKmay/odIW7Cln1lW8FQZUD7wgCOnk+q1BEIKr0ufPJnfV
	SuhurYQUZPbCpx0yBpUg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVNw9-0002I2-6U; Fri, 07 Dec 2018 21:45:29 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVNw5-0002H4-LK; Fri, 07 Dec 2018 21:45:27 +0000
Received: by mail-lj1-x242.google.com with SMTP id k19-v6so4746680lji.11;
 Fri, 07 Dec 2018 13:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=v6KpxNhJmlXUycYQajdCWj2sFrZIkqlDQLw4h1pTRk8=;
 b=ipmNs0vN037Cl5mH4fVf3ttZCVpQb/9Zld0Lkafz8Hbbo90MYs8acI6L5OpSFJxaW3
 NuFIVq89n+RQB95eqVngvZc1bQPEIb77dxGHnJss6F0qQblkGWQKXumuHBQbh8kw+Pfd
 3/K0hNQprlIJGICL+7alaFrZ3Z2v2TlTjVc5In/VXdKgMGqVOfy4DcESgBnfEpfSkD8Q
 CS+/197PnoXgoa+YJq8kvN+LBSGjUpJ0O93FRXM2PTZARwFtFZf8uWXHjIM8xzvXrila
 K5YT5DJoNt48G/JUUvwx4XDAKl38hLSP20n9jY8+hpjApMF8Sg0qHyrGAn5/iI3/ITQ4
 gxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=v6KpxNhJmlXUycYQajdCWj2sFrZIkqlDQLw4h1pTRk8=;
 b=mumu/DN3i67YYX4P10p8wX4udhdLuY8tEjR1mcTk6KfrVkB08rXs2JD/IEeXPi50Tr
 eNOzt31jiNmfv25FPR+SiI7zzB+xPce76H/DE2jfxQ6+5fg8o4ejXvM6Q7kCbTeIaqgK
 hhF7Vv5b8pGTwh2kPqzKmzsxBndC9IvSN4usaiMvgFk/r1cxpbYRBb2gHdtJwsv6n+E+
 M9AblcxOo4bMB04iFsev1BhbQtTCHI9YN9tR5OPbnwRyy5x3ukyHF0Ay4SdvZk4XvAbN
 DjvMNnMU4SLVP47HeQ4FfBWfTX5hH+2Yh0r04Lu9fVllY6mSRvPwq5rkaHf2gYY0G4bN
 ovfw==
X-Gm-Message-State: AA+aEWY4vzJ/oMOOXrtmU1EAxf4780ELHOhD/fym2/q29cxXqRf1ld9G
 0evoQCCxbMLJ00zzJYW8aPQIH7F9l1i+NbDnH4Y=
X-Google-Smtp-Source: AFSGD/UiO69YGGtyeIa+0dEyKTkhClEazQP+Xrjk9iG9Qx2lN8TS6sOEC5U+Cv+TxQru0RaL3krxiwlEDml8OIL6rbE=
X-Received: by 2002:a2e:9f0b:: with SMTP id
 u11-v6mr2011980ljk.99.1544219113588; 
 Fri, 07 Dec 2018 13:45:13 -0800 (PST)
MIME-Version: 1.0
References: <20181206183945.GA20932@jordon-HP-15-Notebook-PC>
 <53bbc095-c9f5-5d6a-6e50-6e060d17eb68@arm.com>
 <20181207171116.GA29923@bombadil.infradead.org>
 <CAFqt6zYCWOK-uS85GqCzcgT=+YKn1nBrRPq+M9y6eJjmXEKH+g@mail.gmail.com>
 <67495f8f-2092-e42d-321e-5216c346513f@arm.com>
In-Reply-To: <67495f8f-2092-e42d-321e-5216c346513f@arm.com>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Sat, 8 Dec 2018 03:18:49 +0530
Message-ID: <CAFqt6zbuT3mhLCSas=EO38NW+M4KAARKeBpMqDz6xwkVbw=FGA@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] mm: Introduce new vm_insert_range API
To: robin.murphy@arm.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_134525_699589_45C9DE84 
X-CRM114-Status: GOOD (  17.68  )
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
 Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Dec 8, 2018 at 2:40 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2018-12-07 7:28 pm, Souptick Joarder wrote:
> > On Fri, Dec 7, 2018 at 10:41 PM Matthew Wilcox <willy@infradead.org> wrote:
> >>
> >> On Fri, Dec 07, 2018 at 03:34:56PM +0000, Robin Murphy wrote:
> >>>> +int vm_insert_range(struct vm_area_struct *vma, unsigned long addr,
> >>>> +                   struct page **pages, unsigned long page_count)
> >>>> +{
> >>>> +   unsigned long uaddr = addr;
> >>>> +   int ret = 0, i;
> >>>
> >>> Some of the sites being replaced were effectively ensuring that vma and
> >>> pages were mutually compatible as an initial condition - would it be worth
> >>> adding something here for robustness, e.g.:
> >>>
> >>> +     if (page_count != vma_pages(vma))
> >>> +             return -ENXIO;
> >>
> >> I think we want to allow this to be used to populate part of a VMA.
> >> So perhaps:
> >>
> >>          if (page_count > vma_pages(vma))
> >>                  return -ENXIO;
> >
> > Ok, This can be added.
> >
> > I think Patch [2/9] is the only leftover place where this
> > check could be removed.
>
> Right, 9/9 could also have relied on my stricter check here, but since
> it's really testing whether it actually managed to allocate vma_pages()
> worth of pages earlier, Matthew's more lenient version won't help for
> that one.


(Why privcmd_buf_mmap() doesn't clean up and return an error
> as soon as that allocation loop fails, without taking the mutex under
> which it still does a bunch more pointless work to only undo it again,
> is a mind-boggling mystery, but that's not our problem here...)

I think some clean up can be done here in a separate patch.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
