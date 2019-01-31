Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC28CC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:22:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEDF7218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lE7fj44a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEDF7218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IRm+i42ddAKRruuA8wJjffqRMD7u8AII0xEYG8RzcFA=; b=lE7fj44aqVRF/E
	wwPkyPfNhqypvdlhsp9WT/Gbgm6LUBKf8CO99ldvALeLU6UlelsQ9ePc88pccegFkD8Aq/8LZDaG9
	ubezVSfDkBQ1Yb6z39gk+70OeKAeyNWU+RFcavY14llSQtzepljTfUtlSIQk1hu+wnCwtgQeFaDWC
	vyJTrNSD4nCadS1lkeH8tq+Ip44I7pbaBPj2HOl9+JFcqMcS8bytdRDVuewxXGMhCCJwEACybCgJy
	gTYdbq9Eyh0hrzbRxDM89PQ5HxgFSbKW3NjqTASuGDB+2w3iXBALDKVnsbovlVuED4wRFnXXgL4J4
	idB4oweEfxcWSWUQu0Qw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp2vp-0003sL-Jb; Thu, 31 Jan 2019 03:22:25 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp2vm-0003rx-Tc; Thu, 31 Jan 2019 03:22:24 +0000
X-UUID: dc15f1870d244c62bdcaf5b868f13bd5-20190130
X-UUID: dc15f1870d244c62bdcaf5b868f13bd5-20190130
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1827413931; Wed, 30 Jan 2019 19:22:22 -0800
Received: from MTKMBS31DR.mediatek.inc (172.27.6.102) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 30 Jan 2019 19:22:20 -0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Thu, 31 Jan 2019 11:22:18 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 31 Jan 2019 11:22:17 +0800
Message-ID: <1548904937.19710.39.camel@mhfsdcap03>
Subject: Re: [PATCH v5 17/20] memory: mtk-smi: Get rid of need_larbid
From: Yong Wu <yong.wu@mediatek.com>
To: Evan Green <evgreen@chromium.org>
Date: Thu, 31 Jan 2019 11:22:17 +0800
In-Reply-To: <CAE=gft4vOxt7G0CqZxvNUxCmuGq_L4wc2Wv6LF4Y62BoJQEUXw@mail.gmail.com>
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
 <1546314952-15990-18-git-send-email-yong.wu@mediatek.com>
 <CAE=gft4vOxt7G0CqZxvNUxCmuGq_L4wc2Wv6LF4Y62BoJQEUXw@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_192222_955218_0CEB15D1 
X-CRM114-Status: GOOD (  21.89  )
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
 srv_heupstream@mediatek.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, yingjoe.chen@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 2019-01-30 at 11:11 -0800, Evan Green wrote:
> On Mon, Dec 31, 2018 at 7:59 PM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > The "mediatek,larb-id" has already been parsed in MTK IOMMU driver.
> > It's no need to parse it again in SMI driver. Only clean some codes.
> > This patch is fit for all the current mt2701, mt2712, mt7623, mt8173
> > and mt8183.
> >
> > After this patch, the "mediatek,larb-id" only be needed for mt2712
> > which have 2 M4Us. In the other SoCs, we can get the larb-id from M4U
> > in which the larbs in the "mediatek,larbs" always are ordered.
> >
> > CC: Matthias Brugger <matthias.bgg@gmail.com>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/memory/mtk-smi.c | 26 ++------------------------
> >  1 file changed, 2 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> > index 08cf40d..10e6493 100644
> > --- a/drivers/memory/mtk-smi.c
> > +++ b/drivers/memory/mtk-smi.c
> > @@ -67,7 +67,6 @@ struct mtk_smi_common_plat {
> >  };
> >
> >  struct mtk_smi_larb_gen {
> > -       bool need_larbid;
> >         int port_in_larb[MTK_LARB_NR_MAX + 1];
> >         void (*config_port)(struct device *);
> >         unsigned int larb_direct_to_common_mask;
> > @@ -153,18 +152,9 @@ void mtk_smi_larb_put(struct device *larbdev)
> >         struct mtk_smi_iommu *smi_iommu = data;
> >         unsigned int         i;
> >
> > -       if (larb->larb_gen->need_larbid) {
> > -               larb->mmu = &smi_iommu->larb_imu[larb->larbid].mmu;
> > -               return 0;
> > -       }
> > -
> > -       /*
> > -        * If there is no larbid property, Loop to find the corresponding
> > -        * iommu information.
> > -        */
> > -       for (i = 0; i < smi_iommu->larb_nr; i++) {
> > +       for (i = 0; i < MTK_LARB_NR_MAX; i++) {
> 
> Looks like this was the only use of mtk_smi_iommu.larb_nr. Should we
> remove that now?

This is necessary since the mt2712 which has two M4U HW.

From its dtsi[1], take iommu1 as a example, its larb_nr only is 3, but
we need scan all the larb.

[1]
http://lists.infradead.org/pipermail/linux-mediatek/2018-December/016119.html

> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
