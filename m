Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E91C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:06:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D3E120866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VcQgbbDc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SGgWtVDy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="D1LSPVCA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D3E120866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FCke6bCWzVp6nEPXf4/YsvlUZtxL/WNCfyL1//SVE2E=; b=VcQgbbDcxhUPEH
	l14MtnxqjaCVoDF1ZQI1G0xD252H8orfI1IqOLVy9XzBDotbuiErKpBiksACO3av+ojR/uZxwLXub
	eU0eVcZVnsHSLxBQP5aC35GOBTFZnTWEDoR37s9xUCahQOn071d/8hpG3qxK8is+1gAWHqdCmGLlf
	G5rdo8TpgOfFXq57SsS9ZcL6R9BcGjxeTmoK9O2sxsBhopCvGniBkAlL7EPkCpiX1oBK2iIbMqoGu
	co7PDormBeROQv2kdYiSljw9Q3T4NXWzPWzTz+jMlb5G4pU854DNsXgbZ/qxR5hsive2J99WHkJAV
	XD7/ibFEB8LMFwNFxDpw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glzVo-0007au-Bm; Tue, 22 Jan 2019 17:06:56 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glzVk-0007aU-RK
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 17:06:54 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 50AC96024C; Tue, 22 Jan 2019 17:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548176811;
 bh=m9EYD1U6kVRMiotzE6lgXblp3Ir5lCrzPsFy85sYUsQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=SGgWtVDyjJ4EklYW3kC15qlOJD6j8jD9WcVAduVMk42aO6M90GlBog9704vScHjA5
 fU1a92STEon9cEi4tMkJOGr1JAjvLh1E7YZFI3QZbfTmYiqoAYlqEJxt5eYAUQhIqf
 aNAYp0FWk7S4W3TMCggf35qd2Mjzmco2pUH7q8NY=
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 89BBC6081E
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 17:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548176809;
 bh=m9EYD1U6kVRMiotzE6lgXblp3Ir5lCrzPsFy85sYUsQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=D1LSPVCAO2cvp07wHRLPLe7fJAoPsd9HmH4gPrbSQGwhfph8Bfvsqw6WQ1QguCzhk
 FWIYCFzmj00OivrGYyo+8T9cS9LKs3DrHzEHzfdWLkcVVjHsv9hU1ytbPiSnHdbUbO
 YIOWmRHXHlofaRgD6WSMebRfGZ81pmoYNxba6TnU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 89BBC6081E
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-ed1-f41.google.com with SMTP id a20so19897798edc.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 09:06:49 -0800 (PST)
X-Gm-Message-State: AJcUukeX9CRC2wcqLdfw5Gd529MPBwzft5t7pERfIJ2NvsLWJ3UfqSKM
 +kJ29qDkoa/oBrPA9xJChLuHQ0n7BeOImAgHH20=
X-Google-Smtp-Source: ALg8bN6cWW4VzOHbSqQJpW4P5Q/2gR5K1qPiqLCEBvwRyHDg4rRiJ6DM+A3QZZG9yB9lSZDU/km4Rvft7zPeeAoF+eI=
X-Received: by 2002:aa7:c0d0:: with SMTP id j16mr31111179edp.173.1548176808160; 
 Tue, 22 Jan 2019 09:06:48 -0800 (PST)
MIME-Version: 1.0
References: <20190121055335.15430-1-vivek.gautam@codeaurora.org>
 <20190121055335.15430-2-vivek.gautam@codeaurora.org>
 <b0688376-f922-9d17-eb66-f28df6963bcf@arm.com>
In-Reply-To: <b0688376-f922-9d17-eb66-f28df6963bcf@arm.com>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Date: Tue, 22 Jan 2019 22:36:36 +0530
X-Gmail-Original-Message-ID: <CAFp+6iEanKEhLkonZwqBYV1e-=-yKbStj0SoL0x6UNQxaOft=w@mail.gmail.com>
Message-ID: <CAFp+6iEanKEhLkonZwqBYV1e-=-yKbStj0SoL0x6UNQxaOft=w@mail.gmail.com>
Subject: Re: [PATCH 1/3] iommu/arm-smmu: Move to bitmap for arm_smmu_domain
 atrributes
To: Robin Murphy <robin.murphy@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_090652_919296_669359F1 
X-CRM114-Status: GOOD (  21.62  )
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
Cc: pdaly@codeaurora.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <joro@8bytes.org>,
 Will Deacon <will.deacon@arm.com>, open list <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 pratikp@codeaurora.org, Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 21, 2019 at 7:23 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 21/01/2019 05:53, Vivek Gautam wrote:
> > A number of arm_smmu_domain's attributes can be assigned based
> > on the iommu domains's attributes. These local attributes better
> > be managed by a bitmap.
> > So remove boolean flags and move to a 32-bit bitmap, and enable
> > each bits separtely.
> >
> > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > ---
> >   drivers/iommu/arm-smmu.c | 10 ++++++----
> >   1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index 7ebbcf1b2eb3..52b300dfc096 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -257,10 +257,11 @@ struct arm_smmu_domain {
> >       const struct iommu_gather_ops   *tlb_ops;
> >       struct arm_smmu_cfg             cfg;
> >       enum arm_smmu_domain_stage      stage;
> > -     bool                            non_strict;
> >       struct mutex                    init_mutex; /* Protects smmu pointer */
> >       spinlock_t                      cb_lock; /* Serialises ATS1* ops and TLB syncs */
> >       struct iommu_domain             domain;
> > +#define ARM_SMMU_DOMAIN_ATTR_NON_STRICT      BIT(0)
> > +     unsigned int                    attr;
> >   };
> >
> >   struct arm_smmu_option_prop {
> > @@ -901,7 +902,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
> >       if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
> >               pgtbl_cfg.quirks = IO_PGTABLE_QUIRK_NO_DMA;
> >
> > -     if (smmu_domain->non_strict)
> > +     if (smmu_domain->attr & ARM_SMMU_DOMAIN_ATTR_NON_STRICT)
> >               pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
> >
> >       /* Non coherent page table mappings only for Stage-1 */
> > @@ -1598,7 +1599,8 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
> >       case IOMMU_DOMAIN_DMA:
> >               switch (attr) {
> >               case DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE:
> > -                     *(int *)data = smmu_domain->non_strict;
> > +                     *(int *)data = !!(smmu_domain->attr &
> > +                                       ARM_SMMU_DOMAIN_ATTR_NON_STRICT);
> >                       return 0;
> >               default:
> >                       return -ENODEV;
> > @@ -1638,7 +1640,7 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
> >       case IOMMU_DOMAIN_DMA:
> >               switch (attr) {
> >               case DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE:
> > -                     smmu_domain->non_strict = *(int *)data;
> > +                     smmu_domain->attr |= ARM_SMMU_DOMAIN_ATTR_NON_STRICT;
>
> But what if *data == 0?

Right, a check for data here also similar to what we are doing for
QCOM_SYS_CACHE [1].

[1] https://lore.kernel.org/patchwork/patch/1033796/

Regards
Vivek

>
> Robin.
>
> >                       break;
> >               default:
> >                       ret = -ENODEV;
> >
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
