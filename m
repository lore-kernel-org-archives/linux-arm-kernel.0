Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C99C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 12:16:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F09BB217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 12:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Cnr2C7IL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEFZB7m2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F09BB217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=36nRezepKuNY6jrMYWvT/viPEUH8zyinBbkk1k3PYzE=; b=Cnr2C7ILys7Faa
	Lag4QW8hKw/OuJYk3zJzEvzV/Yn6EkTvwcOnLQAPXDvQS+sPDKusolt6Ee3HXVC7d3pfjKEQhfUzN
	OdejlD+HmyMUOaYMSVylDImvYol1wqDArhidVtwxyYxPfnS5QSjwwqzwrg3HjoMZCNJMAIJgF2wSH
	+z6bV/pggPToZIH5GQBDzWMb9XR1mbAB6VVIqJXAFH7KQMXzTST6YiwOiLM/LVlhiTv7bHawjn+mY
	9bbPxZXjXI6a8AHDdDITaME+BrN0g8JnaqLG3CWSEkRdPYBgXYm20fNsyJ4LOUgroezamHx70LTA9
	eKfJgaINd9WAYtpE4Nog==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqGh5-0002oI-NY; Sun, 03 Feb 2019 12:16:15 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqGh3-0002nx-4t
 for linux-arm-kernel@lists.infradead.org; Sun, 03 Feb 2019 12:16:14 +0000
Received: by mail-lf1-x141.google.com with SMTP id z13so8268942lfe.11
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 03 Feb 2019 04:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bsr2lcuUZ78duCduOrjEIhzTac5FkzmhdngvDyze87g=;
 b=DEFZB7m2x3lEjsSr4Vebj+gVVt7RLH0LzvwCLxLo87w5byYcx/eb6nkp/k5rPLuF39
 mmpb1Mq5bkecyhhJJlhVeKWccLyDB6pbFTcG0XIJojHQ1bHDN6mtm+KoI8VXXSqh4yl8
 ipfUr4T2tWkt0zjGXzc9GQDjaIzV49m5XBPq5fafnpOPUlJkiK438F1eBMpOp9WOD031
 rS4TLTf9kl1YBlwKdOL4uPVoF0bqQVtg2TbM4tLaPL2XM6xJkhQmwMfCYyZNuUDWKGnu
 yXDuK0R70C2y4wvmF0CXFDycc+8qwbZhCbA6fzZGslHQA2fZUVEj6ZEW4WTc5BAZ/kpz
 u8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bsr2lcuUZ78duCduOrjEIhzTac5FkzmhdngvDyze87g=;
 b=HNdSSdEiQ7+SSOoj5reXZAafOTH7unn9zvCWpAfVji2H0UaBSCpekfzfK13zAGzKpO
 DzIHNMCVWCUdCDEh4a4HfomvLigpGWYhDEaBnirLN1ricmJLVgZheiUv7epvdDDSc2O+
 2n2yCq1uSTEbEfYIL0RlkHCxP/OEPC/iW4OsXeMwnQaaY4CUG/pJIhW2A+o+b4SL9aRk
 52nRvXkbOYSqERJxbESNBdx3Ub8CY7Em70j88aLEPeqIhAiAa3QChAZ91dz/Pi10/jAw
 hVxKi5Di+k44Io3kYNwIfwrZtTpLDAMAlTR4V80CAMDMraxKfMq4xzpOcq86qZo0ErTt
 zdnQ==
X-Gm-Message-State: AHQUAuYcV2YhBXgiBoPD2Mf0EvgWJPzEhrb1J/iMOk/ncBmUpKSpRx2I
 iBiP5ljzmgrezYiFJKWTLtWsIKJHTaH+iwokvoE=
X-Google-Smtp-Source: AHgI3IaQ2Z3KDC+FnOhj++jsrTaCbQdTU8++guI2WhAsqUj3GwbfmgS1POV51VcyVAyZUuz4VlciqPBClODpIE97UkE=
X-Received: by 2002:a19:5004:: with SMTP id e4mr3804044lfb.75.1549196171078;
 Sun, 03 Feb 2019 04:16:11 -0800 (PST)
MIME-Version: 1.0
References: <20190131030900.GA2284@jordon-HP-15-Notebook-PC>
In-Reply-To: <20190131030900.GA2284@jordon-HP-15-Notebook-PC>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Sun, 3 Feb 2019 17:46:02 +0530
Message-ID: <CAFqt6zZCmUTf1Pj+i0eYeQJ1x8A5u+26cM0v00TRpiNYDHky8Q@mail.gmail.com>
Subject: Re: [PATCHv2 2/9] arch/arm/mm/dma-mapping.c: Convert to use
 vm_insert_range
To: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>, robin.murphy@arm.com, 
 iamjoonsoo.kim@lge.com, treding@nvidia.com, Kees Cook <keescook@chromium.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_041613_214373_F2F36327 
X-CRM114-Status: GOOD (  17.66  )
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

Hi Russell,

On Thu, Jan 31, 2019 at 8:34 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Convert to use vm_insert_range() to map range of kernel
> memory to user vma.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Does it looks good ?

> ---
>  arch/arm/mm/dma-mapping.c | 22 ++++++----------------
>  1 file changed, 6 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index f1e2922..915f701 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1575,31 +1575,21 @@ static int __arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma
>                     void *cpu_addr, dma_addr_t dma_addr, size_t size,
>                     unsigned long attrs)
>  {
> -       unsigned long uaddr = vma->vm_start;
> -       unsigned long usize = vma->vm_end - vma->vm_start;
>         struct page **pages = __iommu_get_pages(cpu_addr, attrs);
>         unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
> -       unsigned long off = vma->vm_pgoff;
> +       int err;
>
>         if (!pages)
>                 return -ENXIO;
>
> -       if (off >= nr_pages || (usize >> PAGE_SHIFT) > nr_pages - off)
> +       if (vma->vm_pgoff >= nr_pages)
>                 return -ENXIO;
>
> -       pages += off;
> -
> -       do {
> -               int ret = vm_insert_page(vma, uaddr, *pages++);
> -               if (ret) {
> -                       pr_err("Remapping memory failed: %d\n", ret);
> -                       return ret;
> -               }
> -               uaddr += PAGE_SIZE;
> -               usize -= PAGE_SIZE;
> -       } while (usize > 0);
> +       err = vm_insert_range(vma, pages, nr_pages);
> +       if (err)
> +               pr_err("Remapping memory failed: %d\n", err);
>
> -       return 0;
> +       return err;
>  }
>  static int arm_iommu_mmap_attrs(struct device *dev,
>                 struct vm_area_struct *vma, void *cpu_addr,
> --
> 1.9.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
