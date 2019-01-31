Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6184EC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:23:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3212320870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="brP3kmxs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3212320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=G0QsySy+Ho1LsEpeH9sIQVjbTfkbU62pGRx8CWBROCk=; b=brP3kmxs9o2A/8
	DgtFlhAcgpMNH8lewB0W0pRr2V9XyuGHc7tUmWAuY+JwsSHiwE7vI+JC7V7dEd3vLlykGdnMv9ss0
	JumZZbI3w4uxDEPunAyy7gwj3EvwdhB7O2Ml0fo0N/zSxTq9sQEHpuQpa/pcJFlP3GQWu4j8NREDj
	N+HEcpJxExXuDw2km82wL8Iv4QJfmNNNhSbkM6pPv4dfWPo1NPZ7FY2Fov6zV5bUjPlhh9xU8YmFr
	AXUE+v7Oxi1rhl3ReDCHajKIhRCQuIYOphhSu0Wu+ebtm9mDQhaB8FV2/qyFQrBR5opHXE2iAZlm0
	fjo39dlncLe0JwDYh0sw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp2wh-0004SU-0o; Thu, 31 Jan 2019 03:23:19 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp2wa-0004Rb-D2; Thu, 31 Jan 2019 03:23:16 +0000
X-UUID: 6e2f39b6484049739a625cf7b7d0b0b8-20190130
X-UUID: 6e2f39b6484049739a625cf7b7d0b0b8-20190130
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 2041655660; Wed, 30 Jan 2019 19:22:35 -0800
Received: from MTKMBS31N1.mediatek.inc (172.27.4.69) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 30 Jan 2019 19:22:34 -0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Thu, 31 Jan 2019 11:22:31 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 31 Jan 2019 11:22:31 +0800
Message-ID: <1548904951.19710.41.camel@mhfsdcap03>
Subject: Re: [PATCH v5 14/20] iommu/mediatek: Add mmu1 support
From: Yong Wu <yong.wu@mediatek.com>
To: Evan Green <evgreen@chromium.org>
Date: Thu, 31 Jan 2019 11:22:31 +0800
In-Reply-To: <CAE=gft58E0p3KEYLtKZBfvGysNq+CfX5LDR38incdM+tjDr-1g@mail.gmail.com>
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
 <1546314952-15990-15-git-send-email-yong.wu@mediatek.com>
 <CAE=gft58E0p3KEYLtKZBfvGysNq+CfX5LDR38incdM+tjDr-1g@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_192312_440820_74DB821B 
X-CRM114-Status: GOOD (  22.09  )
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

On Wed, 2019-01-30 at 10:55 -0800, Evan Green wrote:
> On Mon, Dec 31, 2018 at 7:59 PM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > Normally the M4U HW connect EMI with smi. the diagram is like below:
> >               EMI
> >                |
> >               M4U
> >                |
> >             smi-common
> >                |
> >        -----------------
> >        |    |    |     |    ...
> >     larb0 larb1  larb2 larb3
> >
> > Actually there are 2 mmu cells in the M4U HW, like this diagram:
> >
> >               EMI
> >            ---------
> >             |     |
> >            mmu0  mmu1     <- M4U
> >             |     |
> >            ---------
> >                |
> >             smi-common
> >                |
> >        -----------------
> >        |    |    |     |    ...
> >     larb0 larb1  larb2 larb3
> >
> > This patch add support for mmu1. In order to get better performance,
> > we could adjust some larbs go to mmu1 while the others still go to
> > mmu0. This is controlled by a SMI COMMON register SMI_BUS_SEL(0x220).
> >
> > mt2712, mt8173 and mt8183 M4U HW all have 2 mmu cells. the default
> > value of that register is 0 which means all the larbs go to mmu0
> > defaultly.
> >
> > This is a preparing patch for adjusting SMI_BUS_SEL for mt8183.
> >
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/iommu/mtk_iommu.c | 47 +++++++++++++++++++++++++++++------------------
> >  1 file changed, 29 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 66e3615..7fcef19 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -70,27 +70,32 @@
> >  #define F_MISS_FIFO_ERR_INT_EN                 BIT(6)
> >  #define F_INT_CLR_BIT                          BIT(12)
> >
> > -#define REG_MMU_INT_MAIN_CONTROL               0x124
> > -#define F_INT_TRANSLATION_FAULT                        BIT(0)
> > -#define F_INT_MAIN_MULTI_HIT_FAULT             BIT(1)
> > -#define F_INT_INVALID_PA_FAULT                 BIT(2)
> > -#define F_INT_ENTRY_REPLACEMENT_FAULT          BIT(3)
> > -#define F_INT_TLB_MISS_FAULT                   BIT(4)
> > -#define F_INT_MISS_TRANSACTION_FIFO_FAULT      BIT(5)
> > -#define F_INT_PRETETCH_TRANSATION_FIFO_FAULT   BIT(6)
> > +#define REG_MMU_INT_MAIN_CONTROL               0x124 /* mmu0 | mmu1 */
> 
> The comment being on that line is kind of weird, since the comment
> really applies to the lines below it. Maybe the comment should be on
> its own line, or on the TRANSLATION_FAULT line.

Sharp eye. You are right, this comment applies the lines below.
But If I move it below, then the next line will be over 80 chars.

How about I add a "below:" like this: 
> +#define REG_MMU_INT_MAIN_CONTROL               0x124 /* below: mmu0 |
mmu1 */

> 
> Other than that,
> Reviewed-by: Evan Green <evgreen@chromium.org>



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
