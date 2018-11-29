Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112D1C43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:59:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D63E62082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e3IeVJNa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRfd4Tu2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D63E62082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=i/VuaqzUOFWeWvUZUwNtpSpmQeChXDp4VsZRXRKiQ+s=; b=e3IeVJNaJDGLy/
	yP8LIwdmPxjdBAEtYoaz2Jdc/6uYphedVTv4Fm4Q5AB/9zrDh9a6WZ1eC7W1L490xkUuGwB47cKSx
	5YT7K8KmkyGy2UvDmaR7gkCdWxt8DFBiLPGpyR4rot7mPArAEo/mLhP1vbTpMpCF6OuHeLm5qcr2w
	43GbbhoIvkVqJK9gQOE9hOwt92IXHDtgLskehlfz8P4oqvNwMkh6MsO4V975ttZGv3jhDf9SAsgSn
	bVMyp0UVvVnuu4vGb03MeEM8ZZ7dqYesJ12xe2AxNE40nKgaD8u4G17icYs3EGgDd4UCsXv4/6eJ9
	R6CC8TfC+bEPKDpHVz2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSNmg-0001mO-2I; Thu, 29 Nov 2018 14:59:18 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSNmd-0001lz-BO
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 14:59:16 +0000
Received: by mail-wm1-x341.google.com with SMTP id y139so2562379wmc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 06:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6Lv88a6LqVd6a4OpZOUstQv29AsneZZR8f8JATJXgBc=;
 b=ZRfd4Tu23kO4YrMM1wLyLvhQjwZyu64KNDM2smlt31mRYEAy0km+Fbkc72Z7vCnFVj
 mUnRTx88+Gea4LLkerbmp6JeLOjbdc8zR8QUzKSXuyIDORn3XiziB8/vk0vHDXXEwkZX
 /jM4dnxZDi7zMIR6rYyMcKdbLNV+XxtAsacr4stj7keSSNxAxtxkGW1mQcaYdPynkH5p
 qXkvRyNYgo16OHOEBBWNX+J8X1SL32252jj3VbmU6j9DaIq3fTDyy7K2L73M3HEq4ZuO
 nfUoGd73/4dTdBNRGZng8sm/N5VI9FMdwJnoTtKvHCXIWDuaE25VpyCXzHAAPbd0WXcR
 Duzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6Lv88a6LqVd6a4OpZOUstQv29AsneZZR8f8JATJXgBc=;
 b=qGALNhvphgc1UwlQtyqUqtyCk+J1a7K0jz81VhNH0lS7TRo+oe5Vn02x+sG9+e7OLa
 lgqhJchjKTI+lQ618QP1gjBUalA3Gyy6aNfV3C8wCUM0stvQzdC3F7KdXopSn616ywF9
 Te3x52EOvn1WDfui/LzidlId7miP4UfXDWcQKVkj0IRv3gHRu41t7znOcGTKjoR5EykM
 zpa6b+sbJ4xVurX4iEr9PNpQM1AJ2onP7iaR14IZFp35lMP6o0vio4Vf5IDt45YdCMeP
 vi7/FMpeD2yFPVjruFWKP9DpsjmF+/EY2YLseH8WLuKpXdt+YSIfnbA0BdwCJ+nDqwu4
 wO8w==
X-Gm-Message-State: AA+aEWZtPktwdq8WHZ1ImD3mz4gcMSDhLzavZ7VatvBE11qj8OoAXqSH
 pBqnmS+lMW3XKRS7sOMhOhNxfHXTyrXROYw57t4=
X-Google-Smtp-Source: AFSGD/UaNfE4orQLVXI7+1X0xAfpGUXuYNHNbttpxCnCGOaoBP/9N4F9s3Zzoq5SVOtOgyz5xGS8ijRO/Wj5WEw2VVc=
X-Received: by 2002:a1c:96ce:: with SMTP id y197mr2148122wmd.36.1543503543608; 
 Thu, 29 Nov 2018 06:59:03 -0800 (PST)
MIME-Version: 1.0
References: <20181128173929.3050-1-nathanj439@gmail.com>
 <20181128185910.5778-1-nathanj439@gmail.com>
 <401b58b2-fb17-dc83-f898-c10cafdc5413@arm.com>
In-Reply-To: <401b58b2-fb17-dc83-f898-c10cafdc5413@arm.com>
From: Nathan Jones <nathanj439@gmail.com>
Date: Thu, 29 Nov 2018 09:58:46 -0500
Message-ID: <CACTmSTzQeJiR8S57zYcu+YWbnMdo9Eb9Bei4gfmHyFOrzoWiZw@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dma-mapping: fix potential uninitialized return
To: vladimir.murzin@arm.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_065915_416367_1E148D83 
X-CRM114-Status: GOOD (  18.88  )
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
Cc: linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 4:51 AM Vladimir Murzin <vladimir.murzin@arm.com> wrote:
>
> On 11/28/18 6:59 PM, Nathan Jones wrote:
> > If neither of the if() statements fire then the return value is
> > uninitialized. In the worst case it returns 0 which means the caller
> > will think the function succeeded.
>
> "ret" is updated indirectly via:
>
>         if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
>                 return ret;
>
> I assume that it was found with static analyzer or like this, in such case
> please, provide output produced by the tool.

No, I had some bad code which was passing a wrong length and receiving the
strange error code.

>
> >
> > Fixes: 1655cf8829d8 ("ARM: dma-mapping: Remove traces of NOMMU code")
>
> I'll leave it up to Russell.
>
> Cheers
> Vladimir
>
> > Signed-off-by: Nathan Jones <nathanj439@gmail.com>
> > ---
> >  arch/arm/mm/dma-mapping.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> > index 661fe48ab78d..78de138aa66d 100644
> > --- a/arch/arm/mm/dma-mapping.c
> > +++ b/arch/arm/mm/dma-mapping.c
> > @@ -829,7 +829,7 @@ static int __arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
> >                void *cpu_addr, dma_addr_t dma_addr, size_t size,
> >                unsigned long attrs)
> >  {
> > -     int ret;
> > +     int ret = -ENXIO;
> >       unsigned long nr_vma_pages = vma_pages(vma);
> >       unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
> >       unsigned long pfn = dma_to_pfn(dev, dma_addr);
> >
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
