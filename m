Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214A8C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 06:24:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E28232133D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 06:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qS5EFV2i";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ef1pDDYS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E28232133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=meIg2E15Wxdt18A9VoixhU2aLAHMKfJXM5h7EPGNIgI=; b=qS5EFV2i2Zv9V2
	QN6cWRUCtEGwvn/U5Fb61qotspPdAvE7BVKjqgcVuIwdimsC1F5SxADmidXgwnlXDufTbRtbSTGZm
	3WwHrQEHPmnpwAxechISTDsi7NmrN/VJc+4o3Duxy8vT2+unlGiq6CXP24yZc9CUS6Kf/DDlSwMTv
	M86Xe3bhCfHSuoIWN3llXGo1XgWaYjWv5zIiiQ51dnBGKPOnvYWo4sTDG1FzaAwBu0c3KADEj7gB/
	G3bM+3KzZuXTMBlLg1zWX3M6XlXBfB6bvTH00BYWlBrSbzHn6FZZ6qs7+WJMsSxDqSFVTp+H9Adcg
	4xsw1tvpqqncX1V0aYHA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmuul-0007cq-Pb; Fri, 25 Jan 2019 06:24:31 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmuui-0007cL-NX
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 06:24:30 +0000
Received: by mail-lf1-x143.google.com with SMTP id e26so6126465lfc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 22:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=w9H0PZn0OolgP7kJc7bV76uoKOIASZFoEKdhk7G9bBk=;
 b=ef1pDDYSKyrj1erjXfMRwQ4zhAIgmRtb1F9M5tlxxKSVhLW29fgSSAg0cvRjSAt4eq
 ISzDFaYnevqUWJ44Fqp1geuq6YHoKJEiTJFxHeE3UGJ/uRMuP61YgOChbdvFwfRx90z0
 J8mi/RFim70I55KL0tiFI0q657AfRlZfx/ERMWp7ZUlh6DsUY7sKpCN7nImUaWUFmoUB
 aM7mPzJd2AEujN1ivrlfZIwEjFW1vo2BOjqaV6IMV/1rX44n4z7w91vWS6NSaAzwEX54
 X4WDAk+bXaeuyS6aU58BfbGzRmA/d+cChU0BZQEXqGGuqX6Z1y/q8Zg+tlnvgOExryY1
 7yqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=w9H0PZn0OolgP7kJc7bV76uoKOIASZFoEKdhk7G9bBk=;
 b=uaWH7IbiEOM4E2Os2Jzmqzk8BUF1OspWpPgy1QEY5EHmJJ+qJdLODwE8cXCAXSYtiu
 eXLBYT9kRBsl1zBvXEaWPe9rteKlm8v5E0l+fN5dlNTrrU3G4TKbDvoYFng7q/L8Gv2D
 uP0+emZv0sJ8MphIWjigId81d3rC3b+kpVbS+UoOGRHhVKavp4SCe8o0Qmhvnh/sPDSd
 7KVnw9i4fXU2XvLsCoioJxiYaJTawYAVsvyuFlXHwhjpovW7N5pBLvgJclpPkdksAvOL
 VHKqJJLwAU1Mj+HK2OqWgcFe6knNY7PDSiCU1+RqNyc0zJSDqtXgS4OBbl62aeJy+/wi
 5rUQ==
X-Gm-Message-State: AJcUukcS2PVPntfGHZURrbNsdnOIq7iIh69mj7R0lQ1pcb+gL5D+YYkQ
 7KK1ZcnTWrejGuPO5NyQMwHUgRHoUJIog1YKXTA=
X-Google-Smtp-Source: ALg8bN4/c2BufFVRM0EfReatatcnmTcHehlYAGb5rddAFsXXWUnAVKBofZHpJCmih2EhMvrwnV0BKWGHlw6p0Seg/Zw=
X-Received: by 2002:a19:7111:: with SMTP id m17mr7456686lfc.64.1548397465269; 
 Thu, 24 Jan 2019 22:24:25 -0800 (PST)
MIME-Version: 1.0
References: <20190111150801.GA2714@jordon-HP-15-Notebook-PC>
In-Reply-To: <20190111150801.GA2714@jordon-HP-15-Notebook-PC>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Fri, 25 Jan 2019 11:54:13 +0530
Message-ID: <CAFqt6zZx9qxx_Xv=n-PY45OvS7E8ZBq+ZqaeEKfsaCirwaASSg@mail.gmail.com>
Subject: Re: [PATCH 2/9] arch/arm/mm/dma-mapping.c: Convert to use
 vm_insert_range
To: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>, robin.murphy@arm.com, 
 iamjoonsoo.kim@lge.com, treding@nvidia.com, Kees Cook <keescook@chromium.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_222428_792140_F11C9E34 
X-CRM114-Status: GOOD (  18.28  )
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

On Fri, Jan 11, 2019 at 8:33 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Convert to use vm_insert_range() to map range of kernel
> memory to user vma.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Any comment on this patch ?

> ---
>  arch/arm/mm/dma-mapping.c | 22 ++++++----------------
>  1 file changed, 6 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 78de138..5334391 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1582,31 +1582,21 @@ static int __arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma
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
