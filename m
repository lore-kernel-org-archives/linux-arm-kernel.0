Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF8BC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:00:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E4502184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WJwTBkGL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2ri7Tjm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4502184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QpRERzPP6sit5VxSX1XT4e5YZY7Eg0H+pjSZrMAQ//M=; b=WJwTBkGLSR410q
	dT58p3BUGKqDZz+Qk7CS6ASKO/zVPauYfvVKg6BFU+fJ6HlNQRwetsWMaflZsG1YqoDtKkJitxZOt
	GYue3JUaZBx14i3X2+EMTjw5+J7T8VrFbEKG8kg+jkpZaD3NmhXjoj49usCkZ18ovlTlSKnzC8qg6
	LpwWLanB41RXCX36beoPZqK/LCB0J7dYvPJBEXFhLzYDbV0HhRGUs1ZAG163puL11USdFTFD+WAb/
	TVPL+QEtwISRG1E/SYzwdTioiWblW3kn9FBUZtKFdaoJqqWctWF2nazk7Xwp0CCWV5IhCGqg/Ybx8
	EqGd2kg4aEb7nUknrdNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gomfF-0001Hx-S6; Wed, 30 Jan 2019 10:00:13 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gomfA-0000yu-IB
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 10:00:10 +0000
Received: by mail-lj1-x244.google.com with SMTP id x85-v6so20198103ljb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 02:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/ahPDIIFv/MMPOGpeZxT3pmApwBNz3CD4N0VP4gKld8=;
 b=B2ri7TjmimvAXTVQ6NpGSwysKvPv1hRX+3Oh7rms+F5kl5dzWJHrIFOwJuF4qThTKO
 I04XKp6YookGQQmu5HRlrq8WM8/edqRbmryusF30k9Tmj3RyeHRH1aMeSyc+mATq5BgQ
 Z40SqAe9+PkppudAohfQEIxSSDOoIhBa1tFqVWxK3HgblGGMvyid0d57zye3T4U5GjiD
 3sUbwI3/bkTL+5Nm02NbviKLld0N+TdVirbLuwg+Dmh71heG9+55XVbxGeryWKgXNc5x
 +lferOF3M5QO8an0Kmgzwnfy9oM1GjM2QE8henvXUlnxEA9X8MLoUvsfFTLfaXycLlZ1
 h1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/ahPDIIFv/MMPOGpeZxT3pmApwBNz3CD4N0VP4gKld8=;
 b=q6NndBzAPSK4NxO2wlSWClFdc6+hudpgKwgQEZ/qtPNGyo7OyFcgbqXSHx9RJzL1Gr
 tjBaHxdn69Ht3y8JHieiD4S9mQjzPiE7mynpYDdunphLO9+jA+afpo1VmnoDjtaoDoAX
 ZstdfGYPcVWw/yb1780fNY1G+2WXlCz2jM/xobI9oihykSsa4ajrgTrmR6bwjUMUey4M
 k+oWTDTV4R/gc5qneALgT0TI+VC35vcysL3sYh+MjtYp/0aF/xEWle8tH7sRyDfyToDV
 d2PBE97FUJEpg97eZz/kRBpOHLoCpMwbhRFYlA8Wa5xd16+EYPaELBzpU8Sc2mrf1Kyl
 4k8A==
X-Gm-Message-State: AJcUukdjih/hJXWLAtUg4X32lR6yqSsCuV7Q1epbSYsXvQSQc3cfUuSM
 feMQh7knC+PeWyIL+85gwlWwPVMGs50owEC6rbw=
X-Google-Smtp-Source: ALg8bN5A2L7T88ZjEk542s9LF+gJzDLfcz24saQivM+b0ybEgO7nrHTut38OlFHM6aQVTbEJTgLEJ+q5EvHTEynOpcQ=
X-Received: by 2002:a2e:8643:: with SMTP id
 i3-v6mr25670564ljj.43.1548842406798; 
 Wed, 30 Jan 2019 02:00:06 -0800 (PST)
MIME-Version: 1.0
References: <20190111150801.GA2714@jordon-HP-15-Notebook-PC>
 <CAFqt6zZx9qxx_Xv=n-PY45OvS7E8ZBq+ZqaeEKfsaCirwaASSg@mail.gmail.com>
In-Reply-To: <CAFqt6zZx9qxx_Xv=n-PY45OvS7E8ZBq+ZqaeEKfsaCirwaASSg@mail.gmail.com>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Wed, 30 Jan 2019 15:29:55 +0530
Message-ID: <CAFqt6zboe40Ss6C6h9zhkO71pxKOkA1zV6OrH-+aU3-1yVzeWA@mail.gmail.com>
Subject: Re: [PATCH 2/9] arch/arm/mm/dma-mapping.c: Convert to use
 vm_insert_range
To: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>, robin.murphy@arm.com, 
 iamjoonsoo.kim@lge.com, treding@nvidia.com, Kees Cook <keescook@chromium.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_020008_619934_67B1A57C 
X-CRM114-Status: GOOD (  18.96  )
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
Cc: Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 25, 2019 at 11:54 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> On Fri, Jan 11, 2019 at 8:33 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >
> > Convert to use vm_insert_range() to map range of kernel
> > memory to user vma.
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>
> Any comment on this patch ?

Any comment on this patch ?

>
> > ---
> >  arch/arm/mm/dma-mapping.c | 22 ++++++----------------
> >  1 file changed, 6 insertions(+), 16 deletions(-)
> >
> > diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> > index 78de138..5334391 100644
> > --- a/arch/arm/mm/dma-mapping.c
> > +++ b/arch/arm/mm/dma-mapping.c
> > @@ -1582,31 +1582,21 @@ static int __arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma
> >                     void *cpu_addr, dma_addr_t dma_addr, size_t size,
> >                     unsigned long attrs)
> >  {
> > -       unsigned long uaddr = vma->vm_start;
> > -       unsigned long usize = vma->vm_end - vma->vm_start;
> >         struct page **pages = __iommu_get_pages(cpu_addr, attrs);
> >         unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
> > -       unsigned long off = vma->vm_pgoff;
> > +       int err;
> >
> >         if (!pages)
> >                 return -ENXIO;
> >
> > -       if (off >= nr_pages || (usize >> PAGE_SHIFT) > nr_pages - off)
> > +       if (vma->vm_pgoff >= nr_pages)
> >                 return -ENXIO;
> >
> > -       pages += off;
> > -
> > -       do {
> > -               int ret = vm_insert_page(vma, uaddr, *pages++);
> > -               if (ret) {
> > -                       pr_err("Remapping memory failed: %d\n", ret);
> > -                       return ret;
> > -               }
> > -               uaddr += PAGE_SIZE;
> > -               usize -= PAGE_SIZE;
> > -       } while (usize > 0);
> > +       err = vm_insert_range(vma, pages, nr_pages);
> > +       if (err)
> > +               pr_err("Remapping memory failed: %d\n", err);
> >
> > -       return 0;
> > +       return err;
> >  }
> >  static int arm_iommu_mmap_attrs(struct device *dev,
> >                 struct vm_area_struct *vma, void *cpu_addr,
> > --
> > 1.9.1
> >

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
