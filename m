Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14883C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:22:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCBE220870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gYRgT5z6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCBE220870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=X+MmbVAZUVgenDwaQm8sBJvb296I2a1VEwdQEjZR/sQ=; b=gYRgT5z60dQ7N6
	7NSnAuywWfULV1Rb+kNWXPBDpl9WQ6rP7AyioFGSe+YnCuwFi1Ph0j+Xl1piYlLaQqo/ZjTUR1Krz
	+Q0bZlTVX5k+CMDG3eMtceD8D2fAJYyC8O82JMR2+WgfDK6jfl8rWMJ9uytEH+fqjIv5lbrSt5RkN
	Cn3U+NBlKNsiRuFZ7o2E3xPWFEPQYYcOe6SVUkHW0aH+RleRxdoulUIzpVYWAona6XYnShMORDhQw
	nnF4Njp0Ff6NFyhbPpTYGhnhipgSej+5kIGzm29DO8sCeiNZS8Q030AvetgTi5EVJUsrBUiRtvdy6
	3t4uG4eb81pN5oVIms5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp2wC-0004BV-Fw; Thu, 31 Jan 2019 03:22:48 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp2vz-00042y-4I; Thu, 31 Jan 2019 03:22:39 +0000
X-UUID: e603ff95ab844e6f8e5cc3a1b5ec09ea-20190130
X-UUID: e603ff95ab844e6f8e5cc3a1b5ec09ea-20190130
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1889367135; Wed, 30 Jan 2019 19:22:30 -0800
Received: from MTKMBS31N2.mediatek.inc (172.27.4.87) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 30 Jan 2019 19:22:29 -0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Thu, 31 Jan 2019 11:22:26 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 31 Jan 2019 11:22:26 +0800
Message-ID: <1548904946.19710.40.camel@mhfsdcap03>
Subject: Re: [PATCH v5 10/20] iommu/mediatek: Move reset_axi into plat_data
From: Yong Wu <yong.wu@mediatek.com>
To: Evan Green <evgreen@chromium.org>
Date: Thu, 31 Jan 2019 11:22:26 +0800
In-Reply-To: <CAE=gft72KfZ9RdDTJeEpQJ7h3_cOXzm1YRQG-U47s64QVOhabA@mail.gmail.com>
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
 <1546314952-15990-11-git-send-email-yong.wu@mediatek.com>
 <CAE=gft72KfZ9RdDTJeEpQJ7h3_cOXzm1YRQG-U47s64QVOhabA@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_192235_909683_AF172B67 
X-CRM114-Status: GOOD (  21.67  )
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
> > In mt8173 and mt8183, 0x48 is REG_MMU_STANDARD_AXI_MODE while
> > it is extended to REG_MMU_CTRL which contains _STANDARD_AXI_MODE in
> > the other SoCs. I move this property to plat_data since both mt8173
> > and mt8183 use this property.
> >
> > It is a preparing patch for mt8183.
> >
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/iommu/mtk_iommu.c | 4 ++--
> >  drivers/iommu/mtk_iommu.h | 2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 35a1263..8d8ab21 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -558,8 +558,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
> >         }
> >         writel_relaxed(0, data->base + REG_MMU_DCM_DIS);
> >
> > -       /* It's MISC control register whose default value is ok except mt8173.*/
> > -       if (data->plat_data->m4u_plat == M4U_MT8173)
> > +       if (data->plat_data->reset_axi)
> >                 writel_relaxed(0, data->base + REG_MMU_STANDARD_AXI_MODE);
> 
> The commit description makes it sound like the overall format of the
> register is the same, but the "other SoCs" have some extra bits they'd
> like to leave alone. Would it be easier to do a read-modify-write to
> always clear some bits in the register, instead of doing something
> based on the SoC? Or do the bits mean completely different things in
> the different versions (in which case what you've got makes sense to
> me)?

The bits mean completely is different.(the axi bit position also is
different. I will add this in the comment of this patch.)

> -Evan



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
