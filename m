Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBC4C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 19:58:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70FE820700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 19:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZvBXbPOP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rNrDdjIG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70FE820700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8mZb2+s+QbYLBbrG+HKfMunB+Fg+l9x77PdoPUj/8AY=; b=ZvBXbPOPI9lThd
	4XiSP5nynDITedxHm1HR8chx4oEV8H6cYTBBeXz7rAW4e3OXOG8K6jr9OPadHCa9hYCEg4ucomSyM
	wU/pIxZwJYDnaVgo6p/ZJUJXbmoXn8OF0LtqAIHIDDTUDeflWQeSuu0QxYUYtRsPpbiha5pFx4vg0
	tQIojswvn3vJlj7VgOnIKkMTUof5kg2na9C8eGittBL82OvVap4ELoYqzEoC2Yrmsg9zvRkv4ZccK
	mkXbGjUM4k6zHvaaak3jITnmJjk79qHbEDbenzL//nuvJjqEWhSewIm8hINra9T6iQ4diBktkW/KO
	wgp+nNNEE7RiVj2g5BZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVik1-0007yq-BI; Sat, 08 Dec 2018 19:58:21 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVijx-0007xt-HS
 for linux-arm-kernel@lists.infradead.org; Sat, 08 Dec 2018 19:58:19 +0000
Received: by mail-lj1-x244.google.com with SMTP id t9-v6so6340122ljh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 08 Dec 2018 11:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3ETVN4Uk2IiTYy8m37PtiprjZf12dk6GDFSfbVtyXY4=;
 b=rNrDdjIGa/NiPNtdIAsdwuESvirJseUkTZ22pKns7gVXCV4CX30uCyKehOjFsQ9RqO
 gEJ/wYmor7cqPkEKZdOnaREO5YlA/MFbrHDX03bqSNiXthOmhbIppqJfZw2hcqnNIROp
 b84pze7IRAR6coBavag4sV04lODEUVYDCuV99PBbfePBQV4TjLZVstlSM/OTsWFi6vfi
 KFrq/dBHr2KCjBkScUWKuPl2fsySWO03flP+rA5NU7E8oUJF3JBHRcX3MG7/A7XeMEXr
 LKkP75Fie76qVz75iv/bHbww2P+HEnUvEUBv+dlCd0fjFBzoeX9dVa1OndsNNKBGa9UX
 t0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3ETVN4Uk2IiTYy8m37PtiprjZf12dk6GDFSfbVtyXY4=;
 b=F8QWJn8ZmU6EBmFFe1VBOGIgXYyrgTi2YP4DfgWkkhn/Qa1KtHiyZrWyBTGkQTI7KK
 e6L17PC420J/0L/9vQQAvuBudaQixod4T+XOwhds4V2DDMbAPZbJZ1Z1Bj+ti0PmzGTX
 BuLIeRupAehQQHl7OzU1E53KifF3Zv9+QPqHBRkGt6I//dtnQF0JkehgNEJCUE92su8s
 CVr9lQ30uNt0iMeXjJ48Rww51wyMhWDxVWLbh3UoHWNeQDsJjxorvkJyIlJCl2IYGKku
 5TUKCdIYIEBPi+TKa4EF2O9ryqJt+sdOe9z182Yaq1li0dKtsfXZiuiVdDh19yC6bPzq
 0WYQ==
X-Gm-Message-State: AA+aEWbeh5ZD1Hmf45a9srTHuh1D3UigLGHtNtsh0wo5Bl420uDijTem
 eM30Wcnwu7baJWR+9xjmAi6nZEh01V/TYWabIQA=
X-Google-Smtp-Source: AFSGD/WAaZSNVAYyYF+Z/SPNez8lRgKFdzg3nLBroheTV+1L+ROxRcT1Hjmcm3YKx1TTvsmuYRoqeu8fCgBNRtYkvUU=
X-Received: by 2002:a2e:9f0b:: with SMTP id
 u11-v6mr3430976ljk.99.1544299083671; 
 Sat, 08 Dec 2018 11:58:03 -0800 (PST)
MIME-Version: 1.0
References: <20181206184103.GA25872@jordon-HP-15-Notebook-PC>
In-Reply-To: <20181206184103.GA25872@jordon-HP-15-Notebook-PC>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Sun, 9 Dec 2018 01:31:40 +0530
Message-ID: <CAFqt6zY9JjGhedtmhYh-+mxSMrYs6P5vtQDMSzCfL02CbLys=g@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] arch/arm/mm/dma-mapping.c: Convert to use
 vm_insert_range
To: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>, robin.murphy@arm.com, 
 iamjoonsoo.kim@lge.com, treding@nvidia.com, Kees Cook <keescook@chromium.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_115817_605264_6E7C7CC6 
X-CRM114-Status: GOOD (  19.71  )
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

Hi Robin,

On Fri, Dec 7, 2018 at 12:07 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Convert to use vm_insert_range() to map range of kernel
> memory to user vma.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  arch/arm/mm/dma-mapping.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 661fe48..4eec323 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1582,31 +1582,24 @@ static int __arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma
>                     void *cpu_addr, dma_addr_t dma_addr, size_t size,
>                     unsigned long attrs)
>  {
> -       unsigned long uaddr = vma->vm_start;
> -       unsigned long usize = vma->vm_end - vma->vm_start;
> +       unsigned long page_count = vma_pages(vma);
>         struct page **pages = __iommu_get_pages(cpu_addr, attrs);
>         unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
>         unsigned long off = vma->vm_pgoff;
> +       int err;
>
>         if (!pages)
>                 return -ENXIO;
>
> -       if (off >= nr_pages || (usize >> PAGE_SHIFT) > nr_pages - off)
> +       if (off >= nr_pages || page_count > nr_pages - off)
>                 return -ENXIO;
>
>         pages += off;
> +       err = vm_insert_range(vma, vma->vm_start, pages, page_count);

Just to clarify, do we need to adjust page_count with vma->vm_pgoff as
original code
have not consider it and run the loop for entire range irrespective of
vma->vm_pgoff value ?

> +       if (err)
> +               pr_err("Remapping memory failed: %d\n", err);
>
> -       do {
> -               int ret = vm_insert_page(vma, uaddr, *pages++);
> -               if (ret) {
> -                       pr_err("Remapping memory failed: %d\n", ret);
> -                       return ret;
> -               }
> -               uaddr += PAGE_SIZE;
> -               usize -= PAGE_SIZE;
> -       } while (usize > 0);
> -
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
