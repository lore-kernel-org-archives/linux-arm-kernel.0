Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57343C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:35:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24B6D213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ae+B+Ga0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B6D213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kcpfBIkLgVgbekDbBUOeY2XDhRj1fsKvACJjtYmKHmk=; b=ae+B+Ga0DcI4rg
	RCR9z/Bd6IjSb0bSqKYxeHH1V1hraz2qd+1J6VAyUuxV4RhDFroV7UayiXSDVRcxaqB16Vu4o/y4s
	K1TNFKBYC/qMVJW62CVw57tlz5vOOj4utFdA2Qmyd8Ng8d6kVLXyZX36BD55F+KVEDj1Fw3joYixp
	m/JefVMEOTxWA67ChIpPClLlBniGi/nEqv/ewgx0R6eXBfcbhzUMkgUXH032wWOED+70g6vaD0RHv
	z7DiQrdeNBP5NmrPZOLdR0S3Z0FHL6UOEND2eHkeD4AoNMYzVKfD7p2IPJ2c84hpalbpB+KdkZM72
	POHUAusyg8jyBaB56JNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz0J3-0002Da-Q4; Wed, 27 Feb 2019 14:35:33 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz0Ic-0000wd-1x; Wed, 27 Feb 2019 14:35:25 +0000
X-UUID: d6f8aa18b7ba4db1b05beeee91ef03e4-20190227
X-UUID: d6f8aa18b7ba4db1b05beeee91ef03e4-20190227
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1213705031; Wed, 27 Feb 2019 06:34:48 -0800
Received: from MTKMBS31N2.mediatek.inc (172.27.4.87) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 27 Feb 2019 06:34:46 -0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Wed, 27 Feb 2019 22:34:44 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 27 Feb 2019 22:34:43 +0800
Message-ID: <1551278083.17917.53.camel@mhfsdcap03>
Subject: Re: [PATCH 04/13] iommu/mediatek: Add device_link between the
 consumer and the larb devices
From: Yong Wu <yong.wu@mediatek.com>
To: Evan Green <evgreen@chromium.org>
Date: Wed, 27 Feb 2019 22:34:43 +0800
In-Reply-To: <CAE=gft7R4tkR9hAif4izQi1J1QTcC0rUVyrLAnDdzu_RHV6yHA@mail.gmail.com>
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
 <1546318276-18993-5-git-send-email-yong.wu@mediatek.com>
 <CAE=gft7R4tkR9hAif4izQi1J1QTcC0rUVyrLAnDdzu_RHV6yHA@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_063506_746371_F1C93E36 
X-CRM114-Status: GOOD (  25.54  )
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
Cc: youlin.pei@mediatek.com, "open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS" <devicetree@vger.kernel.org>,
 Nicolas Boichat <drinkcat@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 srv_heupstream@mediatek.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Mon, 2019-02-25 at 15:54 -0800, Evan Green wrote:
> On Mon, Dec 31, 2018 at 8:52 PM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > MediaTek IOMMU don't have its power-domain. all the consumer connect
> > with smi-larb, then connect with smi-common.
> >
> >         M4U
> >          |
> >     smi-common
> >          |
> >   -------------
> >   |         |    ...
> >   |         |
> > larb1     larb2
> >   |         |
> > vdec       venc
> >
> > When the consumer works, it should enable the smi-larb's power which
> > also need enable the smi-common's power firstly.
> >
> > Thus, First of all, use the device link connect the consumer and the
> > smi-larbs. then add device link between the smi-larb and smi-common.
> >
> > This patch adds device_link between the consumer and the larbs.
> >
> > Suggested-by: Tomasz Figa <tfiga@chromium.org>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/iommu/mtk_iommu.c    | 15 +++++++++++++--
> >  drivers/iommu/mtk_iommu_v1.c | 14 ++++++++++++--
> >  2 files changed, 25 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 202e41b..735ae8d 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -247,6 +247,7 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
> >         struct mtk_smi_larb_iommu    *larb_mmu;
> >         unsigned int                 larbid, portid;
> >         struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> > +       struct device_link *link;
> >         int i;
> >
> >         for (i = 0; i < fwspec->num_ids; ++i) {
> > @@ -257,10 +258,20 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
> >                 dev_dbg(dev, "%s iommu port: %d\n",
> >                         enable ? "enable" : "disable", portid);
> >
> > -               if (enable)
> > +               if (enable) {
> >                         larb_mmu->mmu |= MTK_SMI_MMU_EN(portid);
> > -               else
> > +                       /* Link the consumer with the larb device(supplier) */
> > +                       link = device_link_add(dev, larb_mmu->dev,
> > +                                              DL_FLAG_PM_RUNTIME |
> > +                                              DL_FLAG_AUTOREMOVE_CONSUMER);
> > +                       if (!link) {
> > +                               dev_err(dev, "Unable to link %s\n",
> > +                                       dev_name(larb_mmu->dev));
> > +                               return;
> 
> The return is a little odd here, given that you don't return an error
> and this function doesn't do anything else. If it's non-fatal that
> this link didn't get set up, then remove the return. If it is fatal,
> then return an error code.

I will remove the "return". Thanks.

> 
> > +                       }
> > +               } else {
> >                         larb_mmu->mmu &= ~MTK_SMI_MMU_EN(portid);
> > +               }
> >         }
> >  }
> >
> > diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
> > index 9386aee..022bad9 100644
> > --- a/drivers/iommu/mtk_iommu_v1.c
> > +++ b/drivers/iommu/mtk_iommu_v1.c
> > @@ -201,6 +201,7 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
> >         struct mtk_smi_larb_iommu    *larb_mmu;
> >         unsigned int                 larbid, portid;
> >         struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> > +       struct device_link *link;
> >         int i;
> >
> >         for (i = 0; i < fwspec->num_ids; ++i) {
> > @@ -211,10 +212,19 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
> >                 dev_dbg(dev, "%s iommu port: %d\n",
> >                         enable ? "enable" : "disable", portid);
> >
> > -               if (enable)
> > +               if (enable) {
> >                         larb_mmu->mmu |= MTK_SMI_MMU_EN(portid);
> > -               else
> > +                       link = device_link_add(dev, larb_mmu->dev,
> > +                                              DL_FLAG_PM_RUNTIME |
> > +                                              DL_FLAG_AUTOREMOVE_CONSUMER);
> > +                       if (!link) {
> > +                               dev_err(dev, "Unable to link %s\n",
> > +                                       dev_name(larb_mmu->dev));
> > +                               return;
> 
> Same for this one.
> 
> > +                       }
> > +               } else {
> >                         larb_mmu->mmu &= ~MTK_SMI_MMU_EN(portid);
> > +               }
> >         }
> >  }
> >
> > --
> > 1.9.1
> >
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
