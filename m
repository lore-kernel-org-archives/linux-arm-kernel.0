Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0500BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:34:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C720C213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GXJTjKgt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C720C213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RXLhY668zCuCUSy5HbYYori3FYglax3sCTWsLbaEec8=; b=GXJTjKgtT0iIkq
	W4ElROBCBzalpesl7dJl1tP4P6uz3rM2vNZvNN3lm7+eTLDAtfmPJQoUIUb8i9hxf2+bIvVHxp7dn
	qXwlLQc0GC79yhaUgB/XXNsI//bqdfqVgkJYWAc5vAkaXcou2PTO+An9SKWnd0971H042xGOTgZ+k
	K5aZQhSVWWHWz5ev6JijduHBnEOekD7ohnoEPt6wIoz18HSH8+uLeIS7DejhkYTx9xunOMskvPpNZ
	UWER7wZHUwU4UfY1SCcgLsCDjq5RxdhJFSPd6+SDPFbP8eSAHMmMyW/Hdr4PLw9ocgOPpG95i2jmg
	i3mtiGg4mVaJk0FRJ3zA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz0HZ-0007xW-Dr; Wed, 27 Feb 2019 14:34:01 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz0HW-0007wy-8C; Wed, 27 Feb 2019 14:33:59 +0000
X-UUID: b0f209ca555f4bf297ea771834766357-20190227
X-UUID: b0f209ca555f4bf297ea771834766357-20190227
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1119818719; Wed, 27 Feb 2019 06:33:37 -0800
Received: from MTKMBS31N1.mediatek.inc (172.27.4.69) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 27 Feb 2019 06:33:35 -0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Wed, 27 Feb 2019 22:33:33 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 27 Feb 2019 22:33:32 +0800
Message-ID: <1551278012.17917.51.camel@mhfsdcap03>
Subject: Re: [PATCH 11/13] iommu/mediatek: Use builtin_platform_driver
From: Yong Wu <yong.wu@mediatek.com>
To: Evan Green <evgreen@chromium.org>
Date: Wed, 27 Feb 2019 22:33:32 +0800
In-Reply-To: <CAE=gft4Z_C0NRmP0A_rnDzvB3txt3cGV=rvZhJOQZk_1qahiQQ@mail.gmail.com>
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
 <1546318276-18993-12-git-send-email-yong.wu@mediatek.com>
 <CAE=gft4Z_C0NRmP0A_rnDzvB3txt3cGV=rvZhJOQZk_1qahiQQ@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_063358_293021_9A2B5A70 
X-CRM114-Status: GOOD (  20.88  )
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

On Mon, 2019-02-25 at 15:56 -0800, Evan Green wrote:
> On Mon, Dec 31, 2018 at 8:53 PM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > MediaTek IOMMU should wait for smi larb which need wait for the
> > power domain(mtk-scpsys.c) and the multimedia ccf who both are
> > module init. Thus, subsys_initcall for MediaTek IOMMU is not helpful.
> > Switch to builtin_platform_driver.
> >
> > Meanwhile, the ".remove" can be removed. Move its content to
> > ".shutdown".
> >
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/iommu/mtk_iommu.c    | 23 ++---------------------
> >  drivers/iommu/mtk_iommu_v1.c | 16 ++--------------
> >  2 files changed, 4 insertions(+), 35 deletions(-)
> >
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 735ae8d..2798b12 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -690,7 +690,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
> >         return component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
> >  }
> >
> > -static int mtk_iommu_remove(struct platform_device *pdev)
> > +static void mtk_iommu_shutdown(struct platform_device *pdev)
> >  {
> >         struct mtk_iommu_data *data = platform_get_drvdata(pdev);
> >
> > @@ -703,12 +703,6 @@ static int mtk_iommu_remove(struct platform_device *pdev)
> >         clk_disable_unprepare(data->bclk);
> >         devm_free_irq(&pdev->dev, data->irq, data);
> >         component_master_del(&pdev->dev, &mtk_iommu_com_ops);
> > -       return 0;
> > -}
> > -
> > -static void mtk_iommu_shutdown(struct platform_device *pdev)
> > -{
> > -       mtk_iommu_remove(pdev);
> 
> Is there a reason all these things are happening in shutdown()? Don't
> we normally just not clean things up and let the machine turn off?
> Normally I'm a big advocate of proper symmetric teardown, so it hurts
> a little to ask.

In this patch I change the driver to builtin driver. I guess the
"_remove" is not helpful now. thus I remove it.

About the shutdown, I don't have a special reason for it. I only want to
mute the m4u log when something go wrong in the shutdown flow.

> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
