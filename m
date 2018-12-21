Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4469C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:04:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9285E21906
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G/4irQ1U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9285E21906
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QqdlK8xISDe6RgQjvW+atrpMwTkHE9oPklH7u71bepE=; b=G/4irQ1ULCar/D
	F0uKu5zSTDCdbdFhdAbRkBDYqI73OrrGeSpKI4tMDukxbd907GxuSdooORPLmAnMKFD/nLq5UnyX/
	l0F1a6akvoDw38yeQvWl4M+LCmI/Y7cXpEa6TYsOk6+70tYgaiTYnfRvqD9avyieE5GhUuJ65d01X
	Nt3BrT21qBFUHIr64+W4Jps8SWeEdMeoQ/Kh3aWgaAjZBPDe5jDpvEr7+rcUPh16PGSEFNW8QiAi7
	qYHxLmYAYEAZci+rTS+WR/RNSVAGRqj81gOWkjMAKqfus8zLJ7iJuRID+xyGTp+7z/QAR3Itya1S/
	7t9vnpypyVhxjdPmwUaA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaFn6-0002KT-HF; Fri, 21 Dec 2018 08:04:16 +0000
Received: from [1.203.163.78] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaFmA-0001cq-AW; Fri, 21 Dec 2018 08:03:20 +0000
X-UUID: 9fe65b3a70c640b19bf2f0a91b128b6e-20181221
X-UUID: 9fe65b3a70c640b19bf2f0a91b128b6e-20181221
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 764756075; Fri, 21 Dec 2018 16:02:46 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Fri, 21 Dec 2018 16:02:44 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 21 Dec 2018 16:02:43 +0800
Message-ID: <1545379363.29587.52.camel@mhfsdcap03>
Subject: Re: [PATCH v4 08/18] iommu/mediatek: Add larb-id remapped support
From: Yong Wu <yong.wu@mediatek.com>
To: Nicolas Boichat <drinkcat@chromium.org>
Date: Fri, 21 Dec 2018 16:02:43 +0800
In-Reply-To: <CANMq1KDHTPbYHXVsf+_=ER3HYjfFPjv6LTTZMvmM7WChiFDyZQ@mail.gmail.com>
References: <1544258371-4600-1-git-send-email-yong.wu@mediatek.com>
 <1544258371-4600-9-git-send-email-yong.wu@mediatek.com>
 <CANMq1KDHTPbYHXVsf+_=ER3HYjfFPjv6LTTZMvmM7WChiFDyZQ@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_000318_783822_4F10B0FA 
X-CRM114-Status: GOOD (  23.84  )
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
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org, arnd@arndb.de,
 srv_heupstream@mediatek.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will.deacon@arm.com>, lkml <linux-kernel@vger.kernel.org>,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Arvind Yadav <arvind.yadav.cs@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, yingjoe.chen@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Nicolas,

Thanks for the review of this patchset.

On Fri, 2018-12-21 at 11:35 +0800, Nicolas Boichat wrote:
> On Sat, Dec 8, 2018 at 4:42 PM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > The larb-id may be remapped in the smi-common, this means the
> > larb-id reported in the mtk_iommu_isr isn't the real larb-id,
> >
> > Take mt8183 as a example:
> >                        M4U
> >                         |
> > ---------------------------------------------
> > |               SMI common                  |
> > -0-----7-----5-----6-----1-----2------3-----4- <- Id remapped
> >  |     |     |     |     |     |      |     |
> > larb0 larb1 IPU0  IPU1 larb4 larb5  larb6  CCU
> > disp  vdec  img   cam   venc  img    cam
> > As above, larb0 connects with the id 0 in smi-common.
> >           larb1 connects with the id 7 in smi-common.
> >           ...
> > If the larb-id reported in the isr is 7, actually it's larb1(vdec).
> > In order to output the right larb-id in the isr, we add a larb-id
> > remapping relationship in this patch.
> >
> > This also is a preparing patch for mt8183.
> >
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/iommu/mtk_iommu.c | 3 +++
> >  drivers/iommu/mtk_iommu.h | 4 ++++
> >  2 files changed, 7 insertions(+)
> >
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index eda062a..8ab3b69 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -220,6 +220,9 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
> >         fault_larb = F_MMU0_INT_ID_LARB_ID(regval);
> >         fault_port = F_MMU0_INT_ID_PORT_ID(regval);
> >
> > +       if (data->plat_data->larbid_remap_enable)
> > +               fault_larb = data->plat_data->larbid_remapped[fault_larb];
> > +
> >         if (report_iommu_fault(&dom->domain, data->dev, fault_iova,
> >                                write ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ)) {
> >                 dev_err_ratelimited(
> > diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> > index b8749ac..3877050 100644
> > --- a/drivers/iommu/mtk_iommu.h
> > +++ b/drivers/iommu/mtk_iommu.h
> > @@ -47,6 +47,10 @@ struct mtk_iommu_plat_data {
> >
> >         /* HW will use the EMI clock if there isn't the "bclk". */
> >         bool                has_bclk;
> > +
> > +       /* The larb-id may be remapped in the smi-common. */
> > +       bool                larbid_remap_enable;
> > +       unsigned int        larbid_remapped[MTK_LARB_NR_MAX];
> 
> Wouldn't it be a little simpler if you just had
> larbid_remap[MTK_LARB_NR_MAX] (no larbid_remap_enable), and just set
> it to {0, 1, 2, 3, 4, 5, 6, 7} in platforms that don't need
> complicated remapping?

Actually I'd like the original way(Print the larb-id from the register
directly if larb-id is not remapped). But this solution is also ok for
me.

> 
> Also, unsigned char/u8 array would be enough.

OK. "unsigned char" is enough.
Originally I think "int" or "long" may be better to access in ARM/ARM64.

> 
> >  };
> >
> >  struct mtk_iommu_domain;
> > --
> > 1.9.1
> >



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
