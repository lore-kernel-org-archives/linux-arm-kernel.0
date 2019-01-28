Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9EDC282CF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:21:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B09382148E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WcETnPVH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Cl1zH2fO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QMc8y1JX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B09382148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BLTVpDZfplfiNpcAhhXcyyDNAVOzqhGCAMJ8TvJ+dvw=; b=WcETnPVH7MWf+r
	6bUPt7qbl8Q9opwBtWtfXq8WoFRXciX4I8doyDmxQfR6UqYc260e2frCcBhea8OE3TNtNNuAqbqmQ
	f5Cs+paomz9ACJhurnpPT/rxXOf/nv9xJePwr1e5EEZlr0//8QMxFmRGQVsdpsCc/bpqYBkYEHVme
	UJvflgSj0MlaVniLptOz57frG85UNUbS++DZ7RYHoYL12+NOsUdUQVDXsNkBrFDZ0Am+Az4HyZ/53
	q35So8nxGMkLrI9ouPXI4ROIc6JFpBBKVhzPSAop8ExPXG2S5nh1zuCQa3g+DkWMA/Sxlt5jhgsxw
	mH3fh0EcxClM1glWWeNg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go5uQ-0001yt-Oi; Mon, 28 Jan 2019 12:21:02 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go5uM-0001yX-FW
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 12:21:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 36262607F4; Mon, 28 Jan 2019 12:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548678057;
 bh=gZw4POZaQMJaz3UpcrYMiOr/WjBkTgI46KYRaGDnDzM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Cl1zH2fONpam5qGbEi5p5zuuVz1jeltE/SJmS3Fdr0lG3Vx4MoXzQJp7+ixAJnrDo
 wWQYWWFvIVpVonVYRN6UX20UiocZH6h+Ynls/f+uPhMTe5ufY6iPEAUr6hRwfM+0sP
 m9eAg/Me1vLHSoWY39eoMr4Tq7aBUwtNPPb3F/BY=
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id B511960265
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 12:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548678056;
 bh=gZw4POZaQMJaz3UpcrYMiOr/WjBkTgI46KYRaGDnDzM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=QMc8y1JXomVeVH+WBXL9GM8tBMobDLIsB59LfQz3so5KiF6VIg9naWTfBrU5NPT4g
 QtJ242rPtvUSJmmL7rQVBJGSXjW7fRkLr6QXl20iTlBPYLt+WAC46W+PnImE7Nk9UD
 K3OGqo/CqdcOMr79+5h4gecROxqSHuJ/73vjhz+I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B511960265
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-ed1-f44.google.com with SMTP id h50so12809888ede.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 04:20:55 -0800 (PST)
X-Gm-Message-State: AJcUukciyXBcBslrgMhxqafSAol9QK8hCdaY4n9CkMASjFBJRPc6R99J
 BkVVQRdV7M8mOQrWU7h+WIRojLUp+/pXQPummEQ=
X-Google-Smtp-Source: ALg8bN537rTof4xEA4qcDKhA7fzBq9lTgSbzgCGv9OCYlk82Zqho7FKkJylD+pCCEGBJtjDQ8/l1ZV/4afq0ocTQmHk=
X-Received: by 2002:a17:906:118c:: with SMTP id
 n12mr14502995eja.228.1548678054360; 
 Mon, 28 Jan 2019 04:20:54 -0800 (PST)
MIME-Version: 1.0
References: <20190117092718.1396-1-vivek.gautam@codeaurora.org>
 <20190117092718.1396-2-vivek.gautam@codeaurora.org>
 <a508a6a5-8e1f-3660-51ef-e65bc382931e@arm.com>
In-Reply-To: <a508a6a5-8e1f-3660-51ef-e65bc382931e@arm.com>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Date: Mon, 28 Jan 2019 17:50:42 +0530
X-Gmail-Original-Message-ID: <CAFp+6iG6ohd0ZGiUne324icvtrfR8FJLG+YkQ0dg20=RwceDCQ@mail.gmail.com>
Message-ID: <CAFp+6iG6ohd0ZGiUne324icvtrfR8FJLG+YkQ0dg20=RwceDCQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] iommu/io-pgtable-arm: Add support for non-coherent
 page tables
To: Robin Murphy <robin.murphy@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_042058_560695_55F2EBDE 
X-CRM114-Status: GOOD (  33.59  )
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
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <joro@8bytes.org>,
 Will Deacon <will.deacon@arm.com>, open list <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 21, 2019 at 6:43 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 17/01/2019 09:27, Vivek Gautam wrote:
> >  From Robin's comment [1] about touching TCR configurations -
> >
> > "TBH if we're going to touch the TCR attributes at all then we should
> > probably correct that sloppiness first - there's an occasional argument
> > for using non-cacheable pagetables even on a coherent SMMU if reducing
> > snoop traffic/latency on walks outweighs the cost of cache maintenance
> > on PTE updates, but anyone thinking they can get that by overriding
> > dma-coherent silently gets the worst of both worlds thanks to this
> > current TCR value."
> >
> > We have IO_PGTABLE_QUIRK_NO_DMA quirk present, but we don't force
> > anybody _not_ using dma-coherent smmu to have non-cacheable page table
> > mappings.
> > Having another quirk flag can help in having non-cacheable memory for
> > page tables once and for all.
> >
> > [1] https://lore.kernel.org/patchwork/patch/1020906/
> >
> > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > ---
> >   drivers/iommu/io-pgtable-arm.c | 17 ++++++++++++-----
> >   drivers/iommu/io-pgtable.h     |  6 ++++++
> >   2 files changed, 18 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> > index 237cacd4a62b..c76919c30f1a 100644
> > --- a/drivers/iommu/io-pgtable-arm.c
> > +++ b/drivers/iommu/io-pgtable-arm.c
> > @@ -780,7 +780,8 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
> >       struct arm_lpae_io_pgtable *data;
> >
> >       if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS | IO_PGTABLE_QUIRK_NO_DMA |
> > -                         IO_PGTABLE_QUIRK_NON_STRICT))
> > +                         IO_PGTABLE_QUIRK_NON_STRICT |
> > +                         IO_PGTABLE_QUIRK_NON_COHERENT))
> >               return NULL;
> >
> >       data = arm_lpae_alloc_pgtable(cfg);
> > @@ -788,9 +789,14 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
> >               return NULL;
> >
> >       /* TCR */
> > -     reg = (ARM_LPAE_TCR_SH_IS << ARM_LPAE_TCR_SH0_SHIFT) |
> > -           (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_IRGN0_SHIFT) |
> > -           (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_ORGN0_SHIFT);
> > +     reg = ARM_LPAE_TCR_SH_IS << ARM_LPAE_TCR_SH0_SHIFT;
> > +
> > +     if (cfg->quirks & IO_PGTABLE_QUIRK_NON_COHERENT)
> > +             reg |= ARM_LPAE_TCR_RGN_NC << ARM_LPAE_TCR_IRGN0_SHIFT |
> > +                    ARM_LPAE_TCR_RGN_NC << ARM_LPAE_TCR_ORGN0_SHIFT;
> > +     else
> > +             reg |= ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_IRGN0_SHIFT |
> > +                    ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_ORGN0_SHIFT;
> >
> >       switch (ARM_LPAE_GRANULE(data)) {
> >       case SZ_4K:
> > @@ -873,7 +879,8 @@ arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
> >
> >       /* The NS quirk doesn't apply at stage 2 */
> >       if (cfg->quirks & ~(IO_PGTABLE_QUIRK_NO_DMA |
> > -                         IO_PGTABLE_QUIRK_NON_STRICT))
> > +                         IO_PGTABLE_QUIRK_NON_STRICT |
> > +                         IO_PGTABLE_QUIRK_NON_COHERENT))
> >               return NULL;
> >
> >       data = arm_lpae_alloc_pgtable(cfg);
> > diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
> > index 47d5ae559329..46604cf7b017 100644
> > --- a/drivers/iommu/io-pgtable.h
> > +++ b/drivers/iommu/io-pgtable.h
> > @@ -75,6 +75,11 @@ struct io_pgtable_cfg {
> >        * IO_PGTABLE_QUIRK_NON_STRICT: Skip issuing synchronous leaf TLBIs
> >        *      on unmap, for DMA domains using the flush queue mechanism for
> >        *      delayed invalidation.
> > +      *
> > +      * IO_PGTABLE_QUIRK_NON_COHERENT: Enforce non-cacheable mappings for
> > +      *      pagetables even on a coherent SMMU for cases where reducing
> > +      *      snoop traffic/latency on walks outweighs the cost of cache
> > +      *      maintenance on PTE updates.
>
> Hmm, we can't actually "enforce" anything with this as-is - all we're
> doing is setting the attributes that the IOMMU will use for pagetable
> walks, and that has no impact on how the CPU actually writes PTEs to
> memory. In particular, in the case of a hardware-coherent IOMMU which is
> described as such, even if we make the dma_map/sync calls they still
> won't do anything since they 'know' that the IOMMU is coherent. Thus if
> we then set up a non-cacheable TCR we would have no proper means of
> making pagetables correctly visible to the walker.

Right, I get this point. With non-cacheable TCR, the PTW will always go to
the main memory rather then snooping in CPU caches for the latest page
tables.

>
> Aw crap, this is turning out to be a microcosm of the PCIe no-snoop
> mess... :(
>
> To start with, at least, what we want is to set a non-cacheable TCR if
> the IOMMU is *not* coherent (as far as Linux is concerned - that
> includes the firmware-lying-about-the-hardware situation I was alluding
> to before), but even that isn't necessarily as straightforward as it
> seems. AFAICS, if QUIRK_NO_DMA is set then we definitely have to use a
> cacheable TCR;

Okay, so for QUIRK_NO_DMA we set IRGN0 and ORGN0 to WBWA in TCR,
But, for SMMUs that omit 'dma-coherent' and thus QUIRK_NO_DMA is not set
do we allow them to have a Non-Cacheable set to IRGN0 and ORGN0, as the
PTW will anyways have to read from memory after the CPU flushes the
PTEs to the memory (which we are already doing).

Regards
Vivek


> we can't strictly rely on the inverse being true, but in
> practice we *might* get away with it since we already disallow most
> cases in which the DMA API calls would actually do anything for a
> known-coherent IOMMU device.
>
> Robin.
>
> >        */
> >       #define IO_PGTABLE_QUIRK_ARM_NS         BIT(0)
> >       #define IO_PGTABLE_QUIRK_NO_PERMS       BIT(1)
> > @@ -82,6 +87,7 @@ struct io_pgtable_cfg {
> >       #define IO_PGTABLE_QUIRK_ARM_MTK_4GB    BIT(3)
> >       #define IO_PGTABLE_QUIRK_NO_DMA         BIT(4)
> >       #define IO_PGTABLE_QUIRK_NON_STRICT     BIT(5)
> > +     #define IO_PGTABLE_QUIRK_NON_COHERENT   BIT(6)
> >       unsigned long                   quirks;
> >       unsigned long                   pgsize_bitmap;
> >       unsigned int                    ias;
> >



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
