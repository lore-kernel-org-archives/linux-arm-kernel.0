Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A848C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:31:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D5272148E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HsVeXLgM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATzekJRR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D5272148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xXZJXA4og+YE7zNwd/yzHB21PSHcA8ESpPKLHxmZIf8=; b=HsVeXLgMp6uz5f
	+XeFnTeHRXL4Nz9FNYd/Z9vD3ZoXjlEJCHepzSlevgmOxIGf7v86xdXA6Y1uXhC87cMh5UBRjb6R9
	ILGkywWeGwx4ZGM8VwIjhKQdDQlc/UwxobV1xHVaNO8ApGPy0i/qzeuZ/Zzk6ZGrZt0q91SUv8VL3
	F8LpUraZQQZ2UJbaTT55N8mCvAL6LM4NkKoXuMtusEcgFftViWxxHxFm00WSyCOPF8MhXGod/gfbE
	/o3LR2xhrEZzafOFYlxgace1sg13+oHKZd2ztYehExbtifEQGx29l1P+bNQVwxQdh+qxTUnpsKsew
	vYDJzfLEMVcblQGyeV5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go0SA-00025h-K6; Mon, 28 Jan 2019 06:31:30 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go0S7-00025C-7y; Mon, 28 Jan 2019 06:31:28 +0000
Received: by mail-lj1-x243.google.com with SMTP id x85-v6so13207583ljb.2;
 Sun, 27 Jan 2019 22:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=o//iVq3hBTHa9XD8DZInYP3EOrEMWQQBv8sSLizNJeg=;
 b=ATzekJRRvtQGucujNrDFXsV130pA0J7dxJD3Z4UK26nneQ0dIukUNKx6fW2rYIh1S9
 OI7tn4VuC/2xTJjr74eh9f8zZ3WKdMrF0NkG7xH/VwsTPaFKAjVK4Iy6eymY9yz+tTqp
 wPJKJcMtN+1Ih7jQsPN1/4jcZwL+CaCvZGfq97ezVCBPFi6vkjj+HVyy67HvPHfl4+pz
 1cEexzurgJie7Dvbj2YEg4VCl/HGnCyxuE4gHnsSTdLaV+sLCY16cvZgQVhnzAgdr6gI
 TLiTTKA89ErBtmCJeLFhXPkDppx2Zh4Hu4sP57CvbL6xZUsSGbqyDpl4CYRwc0Kupb+x
 csSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=o//iVq3hBTHa9XD8DZInYP3EOrEMWQQBv8sSLizNJeg=;
 b=BcBqOG67TYhoKPbbKTtuluDQ7kN0eoyn/G9Ecqlc5kWw+pBjn0Wr30AqC3kn0LZFO+
 stg9+ZIaX1ky6z2ipckdZTRgawUlFWPpV/I8TuAdvZVUK5xxaG0ERHFOw6B5sjrovQA5
 cyHABssHLjs3w05VINJH5qK3uiBc2RUeg8rvVBczqgPNghb9NYb9xTO3dMNvX1l1Xwvd
 6DwN/PakE+b5hklnNEiIvYq4S/9329nUt4KQOl4Sfx9xaaa2j3ad5kVDxlv35QL4YLS0
 nWqQxz0WaRKymgKPO2pB04Rwla4rUcCdmkWNiXy65RDxtZ7Ve0YtP5VSQ9hfFTfLCaMa
 aNYw==
X-Gm-Message-State: AJcUukdNlALLSpcEFMvTQZE+YPf67nP+DCSfmqJpiPPdZtH1dV4rQ60n
 3onyNgJYgv3bLPdBYPG9Vr1Cq7IJ5MW7bHntjF4=
X-Google-Smtp-Source: AHgI3IbGK5mZK+NnSyULWRlsVeaByjiWok5/YaCNXkrpF86UzHAi5un5qi/64N4ZnNnHC4ujYwvgmDnnWjupdoAOptE=
X-Received: by 2002:a2e:5703:: with SMTP id
 l3-v6mr4691341ljb.106.1548657084389; 
 Sun, 27 Jan 2019 22:31:24 -0800 (PST)
MIME-Version: 1.0
References: <20190111150933.GA2760@jordon-HP-15-Notebook-PC>
In-Reply-To: <20190111150933.GA2760@jordon-HP-15-Notebook-PC>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Mon, 28 Jan 2019 12:01:12 +0530
Message-ID: <CAFqt6zYcd6XgFDz1vGcZpoeDPCpr5sODdUQ=3WF1z8ZKLxUBOQ@mail.gmail.com>
Subject: Re: [PATCH 4/9] drm/rockchip/rockchip_drm_gem.c: Convert to use
 vm_insert_range
To: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, 
 Michal Hocko <mhocko@suse.com>, hjc@rock-chips.com,
 Heiko Stuebner <heiko@sntech.de>, airlied@linux.ie, 
 Russell King - ARM Linux <linux@armlinux.org.uk>, robin.murphy@arm.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190127_223127_310319_B767F597 
X-CRM114-Status: GOOD (  16.99  )
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
Cc: Linux-MM <linux-mm@kvack.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 11, 2019 at 8:35 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Convert to use vm_insert_range() to map range of kernel
> memory to user vma.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Any comment on this patch ?

> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> index a8db758..c9e207f 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> @@ -221,26 +221,13 @@ static int rockchip_drm_gem_object_mmap_iommu(struct drm_gem_object *obj,
>                                               struct vm_area_struct *vma)
>  {
>         struct rockchip_gem_object *rk_obj = to_rockchip_obj(obj);
> -       unsigned int i, count = obj->size >> PAGE_SHIFT;
> +       unsigned int count = obj->size >> PAGE_SHIFT;
>         unsigned long user_count = vma_pages(vma);
> -       unsigned long uaddr = vma->vm_start;
> -       unsigned long offset = vma->vm_pgoff;
> -       unsigned long end = user_count + offset;
> -       int ret;
>
>         if (user_count == 0)
>                 return -ENXIO;
> -       if (end > count)
> -               return -ENXIO;
>
> -       for (i = offset; i < end; i++) {
> -               ret = vm_insert_page(vma, uaddr, rk_obj->pages[i]);
> -               if (ret)
> -                       return ret;
> -               uaddr += PAGE_SIZE;
> -       }
> -
> -       return 0;
> +       return vm_insert_range(vma, rk_obj->pages, count);
>  }
>
>  static int rockchip_drm_gem_object_mmap_dma(struct drm_gem_object *obj,
> --
> 1.9.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
