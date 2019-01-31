Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE6CC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:21:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF8AE20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qltyHATS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF8AE20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IbnBZmuHjI7KtORWbGF/uM5IiM5/45F+emZZHpNVhy0=; b=qltyHATSFjEukr
	da3tKWvksZ7vg4PaQiptvLv9y6BQq0epfte4yLkBN1uDxia2b+tJJJwXe/tHPawkuI7kyfuFfuE1A
	uASWAy+ANkLSZISOUCZoY6WHzi42hiGneNed3ibG9AD4A9WJIVRANNGl56frZVoVHwJY8dh+gVscD
	n54/DqRCxBLyi3kpt8cPHc713C7RZ5zCFLJvGUV5uen6UAG62kZBo6Av+q/nDS8jZ4+ySk9hsZP/N
	6UqpGzUaWZ43f9ugSnoo59kznpFTx1B7LR71JNUlZtTaSj0diQZud6qOL4My5Vm232W3Io4UsO00v
	R3/g80Ot9rFCo7cmR+jw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp2uT-0003HQ-Do; Thu, 31 Jan 2019 03:21:01 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp2uN-0003GY-Jy; Thu, 31 Jan 2019 03:20:58 +0000
X-UUID: 78f4763cd00148a885a0c80bda7c2312-20190130
X-UUID: 78f4763cd00148a885a0c80bda7c2312-20190130
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 370504304; Wed, 30 Jan 2019 19:20:46 -0800
Received: from MTKMBS31N1.mediatek.inc (172.27.4.69) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 30 Jan 2019 19:20:44 -0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Thu, 31 Jan 2019 11:20:42 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 31 Jan 2019 11:20:41 +0800
Message-ID: <1548904841.19710.36.camel@mhfsdcap03>
Subject: Re: [PATCH v5 11/20] iommu/mediatek: Move vld_pa_rng into plat_data
From: Yong Wu <yong.wu@mediatek.com>
To: Evan Green <evgreen@chromium.org>
Date: Thu, 31 Jan 2019 11:20:41 +0800
In-Reply-To: <CAE=gft4=4h_1MAnrC8CosSe3gOWx+DwFJSLvGNtOFNMZN8oZ3w@mail.gmail.com>
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
 <1546314952-15990-12-git-send-email-yong.wu@mediatek.com>
 <CAE=gft4=4h_1MAnrC8CosSe3gOWx+DwFJSLvGNtOFNMZN8oZ3w@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_192055_655992_AC730A5E 
X-CRM114-Status: GOOD (  21.28  )
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
Cc: youlin.pei@mediatek.com, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Nicolas Boichat <drinkcat@chromium.org>,
 Arnd Bergmann <arnd@arndb.de>, srv_heupstream@mediatek.com,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
 LKML <linux-kernel@vger.kernel.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 yingjoe.chen@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 2019-01-30 at 10:30 -0800, Evan Green wrote:
> On Mon, Dec 31, 2018 at 7:58 PM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > Both mt8173 and mt8183 don't have this vld_pa_rng(valid physical address
> > range) register while mt2712 have. Move it into the plat_data.
> >
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/iommu/mtk_iommu.c | 3 ++-
> >  drivers/iommu/mtk_iommu.h | 1 +
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 8d8ab21..2913ddb 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -548,7 +548,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
> >                          upper_32_bits(data->protect_base);
> >         writel_relaxed(regval, data->base + REG_MMU_IVRP_PADDR);
> >
> > -       if (data->enable_4GB && data->plat_data->m4u_plat != M4U_MT8173) {
> > +       if (data->enable_4GB && data->plat_data->vld_pa_rng) {
> >                 /*
> >                  * If 4GB mode is enabled, the validate PA range is from
> >                  * 0x1_0000_0000 to 0x1_ffff_ffff. here record bit[32:30].
> > @@ -741,6 +741,7 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
> >         .m4u_plat     = M4U_MT2712,
> >         .has_4gb_mode = true,
> >         .has_bclk     = true,
> > +       .vld_pa_rng   = true,
> >         .larbid_remap = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9},
> >  };
> >
> > diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> > index b46aeaa..a8c5d1e 100644
> > --- a/drivers/iommu/mtk_iommu.h
> > +++ b/drivers/iommu/mtk_iommu.h
> > @@ -48,6 +48,7 @@ struct mtk_iommu_plat_data {
> >         /* HW will use the EMI clock if there isn't the "bclk". */
> >         bool                has_bclk;
> >         bool                reset_axi;
> > +       bool                vld_pa_rng;
> 
> I agree with Nicolas that valid_pa_range would be much clearer...
> although, even now that I know what it's supposed to mean, I don't get
> what it represents. What is this saying?

This register in the coda is called "vld_pa_rng".

How about I change it to "has_vld_pa_rng"?. In the comment above, I have
explained the meaning(valid physical address range).

> 
> -Evan



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
