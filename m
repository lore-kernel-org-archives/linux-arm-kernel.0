Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02049C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:49:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C889F20838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hap5/BM9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D+PUfioI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C889F20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SH1tCgNX1O5v+KffIDo4Lmcgak0wEPrdSw75fsRnLKk=; b=Hap5/BM9iSVOeX
	bvUUCmwjb9t6jviQXEIiPqfPeLda7B/Nvvpx5c5JtjtRgeJDjkJB10hHv3LyDmZQdLY2nH/u7Aty+
	XyCxe8GeRzJZ4j3P5S3JawAc7CxShwn8mubTeKbyLGXD7jcsOC8IlxzSMj5YOXWKEB/wUtRvctVOm
	Bn+wd+62sFOPM6dQrBd++yEshFip/8TM4OoJ121yPvahRRgbRV9+bJd9KF+w2761ho8zMQmkkZjEb
	0dIws4a5sN5yYUupX21+fS5sJvd1YQZDuoec8qjNj0FTYKLUxQbRhCVNyqDSv7TgSSlw1/EMU0iBf
	EXgly/FQgj45lS9MZsyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVBp2-0008Kk-7D; Fri, 07 Dec 2018 08:49:20 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVBoz-0008JC-7l
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 08:49:18 +0000
Received: by mail-pf1-x441.google.com with SMTP id z9so1628584pfi.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 00:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eJPKq/wqJp6Om5V2krap5TgJ85QivzMatjG9wTpmnJ0=;
 b=D+PUfioInyPnEpDXMsFxc5VegCqW+nr+qkS8uUFRrH6SQwCeWyS8kQKE2ofWvXD88c
 m/LvvcaPYyc+OehALPucz4mRinKCR1oBooqueLUI82waYT154pqFVbHcoqN1LYYCc2Om
 b5ThQLupgp1FxlSjBv1/6ckFDvThn0IdRnDWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eJPKq/wqJp6Om5V2krap5TgJ85QivzMatjG9wTpmnJ0=;
 b=Yb9XwtDpcew3ME/ypWOrlsqhcNkF7ws6HZYXxKmp+VrRjISqAS2bnKQAfHFQ5L+B78
 A9EWUpWvN+lSyUZzskazh10TIBpOiwQnKPazhLAHWVs9DnQSTzBpOWVsx0ixaBJR6gn+
 Wsi9+6Sbpn9Ffg8pBSj2YoW+c6xfy5/pwObJcJql/tcjn+BTmuiSZ/8U9o3OolNzXD/J
 P4MyoGcFBIA+CoIwTS/uzDN+xIZ2tGNA/XosGgDCilIHUO4Qui+HVDg/TEmLhroJUpvf
 eLOB09XW1BmOXEjGmY5Cv0q4aykGGa0xxRkwjNNiZxeDg38pFWlmC6ixEV3ZsNQr/8f4
 P/Zw==
X-Gm-Message-State: AA+aEWbtXUo8awgdsqNTaUqdjtgimR2LE4zlvcsTNlxTdO4ra+h0TNvN
 Hfkd7x5QZcsa/q9stgb/bifbf1/I0LDHElZ9+ERsIQ==
X-Google-Smtp-Source: AFSGD/U//Oe+P+eE9LYX2jIXq1t5N/Fr4Ot5gm80YgOEI8ZtK+adoYc38Dv6jREJtlu+YGAO0GVNpaCJGprC1Tyx2Rk=
X-Received: by 2002:a63:4c04:: with SMTP id z4mr1201926pga.312.1544172546009; 
 Fri, 07 Dec 2018 00:49:06 -0800 (PST)
MIME-Version: 1.0
References: <20181207061620.107881-1-drinkcat@chromium.org>
 <20181207061620.107881-3-drinkcat@chromium.org>
 <20181207080551.GA15120@bombadil.infradead.org>
In-Reply-To: <20181207080551.GA15120@bombadil.infradead.org>
From: Nicolas Boichat <drinkcat@chromium.org>
Date: Fri, 7 Dec 2018 16:48:54 +0800
Message-ID: <CANMq1KABLMgvGcP-KwKhxmZnO-GuRAKJHf0sBtFaYLnCuHMJOQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] iommu/io-pgtable-arm-v7s: Request DMA32 memory,
 and improve debugging
To: Matthew Wilcox <willy@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_004917_276511_CCEA78B3 
X-CRM114-Status: GOOD (  12.02  )
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
Cc: Michal Hocko <mhocko@suse.com>, Will Deacon <will.deacon@arm.com>,
 Levin Alexander <Alexander.Levin@microsoft.com>, linux-mm@kvack.org,
 Christoph Lameter <cl@linux.com>, Huaisheng Ye <yehs1@lenovo.com>,
 Joerg Roedel <joro@8bytes.org>, hch@infradead.org,
 Yong Wu <yong.wu@mediatek.com>, David Rientjes <rientjes@google.com>,
 yingjoe.chen@mediatek.com, Vlastimil Babka <vbabka@suse.cz>,
 Tomasz Figa <tfiga@google.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 Robin Murphy <robin.murphy@arm.com>, lkml <linux-kernel@vger.kernel.org>,
 Pekka Enberg <penberg@kernel.org>, iommu@lists.linux-foundation.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 7, 2018 at 4:05 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Dec 07, 2018 at 02:16:19PM +0800, Nicolas Boichat wrote:
> > +#ifdef CONFIG_ZONE_DMA32
> > +#define ARM_V7S_TABLE_GFP_DMA GFP_DMA32
> > +#define ARM_V7S_TABLE_SLAB_CACHE SLAB_CACHE_DMA32
>
> This name doesn't make any sense.  Why not ARM_V7S_TABLE_SLAB_FLAGS ?

Sure, will fix in v6 then.

> > +#else
> > +#define ARM_V7S_TABLE_GFP_DMA GFP_DMA
> > +#define ARM_V7S_TABLE_SLAB_CACHE SLAB_CACHE_DMA
>
> Can you remind me again why it is, on machines which don't support
> ZONE_DMA32, why we have to allocate from ZONE_DMA?  My understanding
> is that 64-bit machines have ZONE_DMA32 and 32-bit machines don't.
> So shouldn't this rather be GFP_KERNEL?

Sorry I mean to reply on the v4 thread, Christoph raised the same
question (https://patchwork.kernel.org/patch/10713025/).

I don't know, and I don't have all the hardware needed to test this
,-( Robin and Will both didn't seem sure.

I'd rather not introduce a new regression, this patch series tries to
fix a known arm64 regression, where we _need_ tables to be in DMA32.
If we want to change 32-bit hardware to use GFP_KERNEL, and we're sure
it works, that's fine by me, but it should be in another patch set.

Hope this makes sense,

Thanks,

> Actually, maybe we could centralise this in gfp.h:
>
> #ifdef CONFIG_64BIT
> # ifdef CONFIG_ZONE_DMA32
> #define GFP_32BIT       GFP_DMA32
> # else
> #define GFP_32BIT       GFP_DMA
> #else /* 32-bit */
> #define GFP_32BIT       GFP_KERNEL
> #endif
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
